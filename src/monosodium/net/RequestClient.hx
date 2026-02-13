package monosodium.net;

import haxe.io.Path;
import haxe.http.HttpMethod;

import monosodium.Utility;
import monosodium.net.Http;
import monosodium.Monosodium;
import monosodium.net.ratelimiter.Limiter as RateLimiter;
import monosodium.endpoints.responses.Result;

#if !nodejs
import haxe.Json;
import haxe.io.Bytes;
import haxe.crypto.Base64;
#end

@:nullSafety(Strict)
@:access(monosodium.Monosodium)
class RequestClient {
	public var statusCode:Int = 0;
	public var rate:RateLimiter = Monosodium.defaultLimiter; //

	@:dox(hide) var monosodium:Monosodium;
	public function new(monosodium:Monosodium):Void { this.monosodium = monosodium; }

	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic, ?body:Dynamic):Void {
		rate.enqueue(CALL(() -> performRequest(url, post, method, onSuccess, onError, onStatus, params, body)));
	}

	@:dox(hide)
	private function performRequest(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic, ?body:Dynamic):Void {
		this.statusCode = 0;

		@:nullSafety(Off) final fullUrl:String = Path.join([monosodium._mirror.url, url]);

		var rawAuth:Null<String> = null;
		if ((monosodium.api_token != null && monosodium.username != null)) {
			rawAuth = '${monosodium.username}:${monosodium.api_token}';
		}

		@:nullSafety(Off) var _http:Http = new Http(fullUrl);

		#if js if (!StringTools.contains(js.Browser.navigator.userAgent, 'Chrome')) #end // fuck chromium
		_http.addHeader("User-Agent", Http.USER_AGENT);

		var auth:Null<String> = null;
		if (rawAuth != null) {
			auth = #if (js || nodejs) untyped btoa(rawAuth) #else Base64.encode(Bytes.ofString(rawAuth)) #end;
		}

		fetchVerboseTrace(method, params, url);

		if (body != null)
			_http.setPostData((#if (js || nodejs) untyped JSON #else Json #end).stringify(Utility.buildRequestBody(body)));

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
			this.onStatus(status, onStatus ?? s -> {});
		};

		_http.method = method;
		_http.request(post);
	}

	@:noCompletion 
	inline function fetchVerboseTrace(?method, ?params, ?url):Void if (monosodium.verbose) {
		Utility.verboseTrace('Request : [$method] $url');
		Utility.verboseTrace('User-Agent : ${Http.USER_AGENT}');
		params != null ? Utility.verboseTrace('Request Parameters : ${(#if nodejs (untyped JSON) #else Json #end).stringify(params)}') : null;
	}

	function onData(data:String, onSuccess:Dynamic->Void, onError:String->Void):Void {
		StatusResolver.handle(statusCode, data, onSuccess, onError);
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
		rate.enqueue(PASS);
	}
}
