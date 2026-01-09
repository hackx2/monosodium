package monosodium.net;

import sys.Http;
import monosodium.Utility;
import haxe.Json;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.http.HttpMethod;
import monosodium.endpoints.responses.Result;
import monosodium.Monosodium;
import monosodium.Utility;
import haxe.io.Path;
import monosodium.net.Http;
import monosodium.endpoints.base.Endpoint;
import monosodium.net.ratelimiter.Limiter;

@:access(monosodium.Monosodium)
class RequestClient {
	public var statusCode:Int = 0;
	public var rate:Limiter = Monosodium.defaultLimiter; // 

	@:dox(hide) var monosodium:Monosodium;
	public function new(monosodium:Monosodium):Void {
		this.monosodium = monosodium;
	}

	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic, ?body:Dynamic):Void {
		rate.enqueue(CALL(()->performRequest(url, post, method, onSuccess, onError, onStatus, params, body)));
	}

	@:dox(hide)
	private function performRequest(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic, ?body:Dynamic):Void {
		this.statusCode = 0;

		var _http:Http = new Http(Path.join([monosodium._mirror.url, url]));

		#if js if(!StringTools.contains(js.Browser.navigator.userAgent, 'Chrome')) #end // fuck chromium
			_http.addHeader("User-Agent", Http.USER_AGENT);

		var auth:Null<String> = null;
		if (monosodium.api_token != null && monosodium.username != null) {
			auth = Base64.encode(Bytes.ofString(monosodium.username + ":" + monosodium.api_token));
		}

		// Verbose Trces
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
			this.onData(data, onSuccess, onError);
		};

		_http.onError = function(error:String):Void {
			this.onError(error, onError);
		};

		_http.onStatus = function(status:Int):Void {
			this.onStatus(status, onStatus);
		};

		_http.method = method;
		_http.request(post);
	}

	function onData(data:String, onSuccess:Dynamic->Void, onError:String->Void):Void {
		onError ??= (s)->trace(s);
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
		onError ??= (s) -> trace(s);
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
