package monosodium.net;

import haxe.Json;
import haxe.http.HttpMethod;
import haxe.io.Path;

import monosodium.Utility;
import monosodium.net.Http;
import monosodium.Monosodium;
import monosodium.net.ratelimiter.Limiter;
import monosodium.endpoints.responses.Result;

#if nodejs
import haxe.DynamicAccess;
import js.node.buffer.Buffer;
import js.node.url.URLSearchParams;
#else
import haxe.io.Bytes;
import haxe.crypto.Base64;
#end

@:nullSafety(Strict)
@:access(monosodium.Monosodium)
class RequestClient {
	public var statusCode:Int = 0;
	public var rate:Limiter = Monosodium.defaultLimiter; // 

	@:dox(hide) var monosodium:Monosodium;
	public function new(monosodium:Monosodium):Void {
		this.monosodium = monosodium;
	}

	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic,
			?body:Dynamic):Void {
		rate.enqueue(CALL(() -> performRequest(url, post, method, onSuccess, onError, onStatus, params, body)));
	}

	@:dox(hide)
	private function performRequest(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void,
			?params:Dynamic, ?body:Dynamic):Void {
		this.statusCode = 0;

		@:nullSafety(Off) var fullUrl:String = Path.join([monosodium._mirror.url, url]);

		#if nodejs
		if (params != null && (method == Get || method == Head || method == Delete)) {
			final searchParams = new URLSearchParams(Utility.buildRequestBody(params));
			fullUrl += "?" + searchParams.toString();
		}

		final headers:DynamicAccess<String> = {
			"User-Agent": Http.USER_AGENT,
			"Accept": "application/json"
		};

		var authCensored:Null<String> = null;
		if (monosodium.api_token != null && monosodium.username != null) {
			final authRaw:String = '${monosodium.username}:${monosodium.api_token}';
			final b64:String = Buffer.from(authRaw).toString('base64');
			headers.set("Authorization", 'Basic ${b64}');
			authCensored = "Basic " + Utility.censorString(b64);
		}

		if (monosodium.verbose) {
			Utility.verboseTrace('Request : [$method] $url');
			Utility.verboseTrace('User-Agent : ${Http.USER_AGENT}');
			authCensored != null ? Utility.verboseTrace('Authorization : $authCensored') : null;
			params != null ? Utility.verboseTrace('Request Parameters : ${Json.stringify(params)}') : null;
		}

		final options:Dynamic = {
			method: Std.string(method).toUpperCase(),
			headers: headers
		};

		if (body != null) {
			options.body = Json.stringify(Utility.buildRequestBody(body));
			headers.set("Content-Type", "application/json");
		} else if (params != null) {
			switch (method) {
				case Post | Put | Patch | Delete:
					options.body = Json.stringify(Utility.buildRequestBody(params));
					headers.set("Content-Type", "application/json");
				default:
			}
		}

		final p = untyped fetch(fullUrl, options);
		p.then((res:Dynamic) -> {
			@:nullSafety(Off) this.onStatus(res.status, onStatus);
			return res.text();
		}).then((data:String) -> {
			this.onData(data, onSuccess, onError ?? (s->trace(s)));
		});

		// Reflect (field / callMethod) causes an overhead, while this doesn't
		untyped p["catch"]((err:Dynamic) -> {
			@:nullSafety(Off) this.onError(Std.string(err), onError ?? (s->trace(s)));
		});
		#else
		@:nullSafety(Off) var _http:Http = new Http(fullUrl);

		#if js if (!StringTools.contains(js.Browser.navigator.userAgent, 'Chrome')) #end // fuck chromium
		_http.addHeader("User-Agent", Http.USER_AGENT);

		var auth:Null<String> = null;
		if (monosodium.api_token != null && monosodium.username != null) {
			auth = Base64.encode(Bytes.ofString(monosodium.username + ":" + monosodium.api_token));
		}

		// Verbose Traces
		if (monosodium.verbose) {
			Utility.verboseTrace('Request : [$method] $url');
			Utility.verboseTrace('User-Agent : ${Http.USER_AGENT}');
			auth != null ? Utility.verboseTrace('Authorization : Basic ${Utility.censorString(auth)}') : null;
			params != null ? Utility.verboseTrace('Request Parameters : ${Json.stringify(params)}') : null;
		}
		
		if(body != null)
			_http.setPostData(Json.stringify(Utility.buildRequestBody(body)));

		if (auth != null) {
			_http.addHeader("Authorization", auth);
		}

		// if (params != null) {
		// 	setParams(params, null, _http);
		// }

		if (params != null) {
			final body:Dynamic = Utility.buildRequestBody(params);
			for (field in Reflect.fields(body)) {
				_http.setParameter(field, Std.string(Reflect.field(body, field)));
			}
		}

		_http.onData = function(data:String):Void {
			this.onData(data, onSuccess, onError ?? s -> trace(s));
		};

		_http.onError = function(error:String):Void {
			this.onError(error, onError ?? s -> trace(s));
		};

		_http.onStatus = function(status:Int):Void {
			this.onStatus(status, onStatus ?? s -> {} /* trace(s) */);
		};

		_http.method = method;
		_http.request(post);
		#end
	}

	function onData(data:String, onSuccess:Dynamic->Void, onError:String->Void):Void {
		switch (statusCode) {
			case 200:
				try {
					onSuccess(Json.parse(data));
				} catch (e:Dynamic) {
					onError("Invalid JSON response");
				}
			case 204: // not found... aka blank 
				onSuccess(null);
			default:
				try {
					final err:Result = Json.parse(data);
					onError(err.reason != null ? err.reason : "HTTP " + statusCode);
				} catch (_) {
					onError("HTTP " + statusCode);
				}
		}
	}

	function onError(error:String, onError:String->Void):Void {
		monosodium.verbose ? Utility.verboseTrace('Error : $error') : null;
		onError(error);
		rate.enqueue(PASS);
	}

	function onStatus(status:Int, onStatus:Int->Void):Void {
		this.statusCode = status;

		monosodium.verbose ? Utility.verboseTrace('Status Code : $status') : null;
		onStatus != null ? onStatus(status) : null;
		#if !nodejs rate.enqueue(PASS); #end // maybe??...
	}
}
