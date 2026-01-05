package monosodium.net;

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

@:access(monosodium.Monosodium)
class RequestClient {
	public var statusCode:Int = 0;

	var _http:Null<Http>;

	@:dox(hide) var monosodium:Monosodium;
	public function new(monosodium:Monosodium):Void {
		this.monosodium = monosodium;
	}

	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic):Void {
		Monosodium.limiter.enqueue(() -> performRequest(url, post, method, onSuccess, onError, onStatus, params));
	}

	@:dox(hide)
	private function performRequest(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, params:Dynamic):Void {
		this.statusCode = 0;

		_http = new Http(Path.join([monosodium._mirror.url, url]));

		#if js if(!StringTools.contains(js.Browser.navigator.userAgent, 'Chrome')) #end // fuck chromium
			_http.addHeader("User-Agent", Http.USER_AGENT);

		var auth:Null<String> = null;
		if (monosodium.verbose) {
			Utility.verboseTrace('Request : [$method] $url');
			Utility.verboseTrace('User-Agent : ${Http.USER_AGENT}');
			if (monosodium.api_token != null && monosodium.username != null) {
				auth = Base64.encode(Bytes.ofString(monosodium.username + ":" + monosodium.api_token));
				Utility.verboseTrace('Authorization : Basic ${Utility.censorString(auth)}');
			}
			params != null ? Utility.verboseTrace('Request Parameters : ${Json.stringify(params)}') : null;
		}
		
		if (auth != null) {
			_http.addHeader("Authorization", auth);
		}

		if (params != null) {
			setParams(params, null, _http);
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
		Monosodium.limiter.enqueue(() -> {});
	}

	function onStatus(status:Int, onStatus:Int->Void):Void {
		this.statusCode = status;

		monosodium.verbose ? Utility.verboseTrace('Status Code : $status') : null;
		onStatus != null ? onStatus(status) : null;
		Monosodium.limiter.enqueue(() -> {});
	}

	// find an alternative that doesn't use reflect... :3
	function setParams(obj:Dynamic, ?k:String = "", http:Http):Void {
		for (field in Reflect.fields(obj)) {
			final value:Dynamic = Reflect.field(obj, field);
			if (value == null)
				continue;
			final key:String = k != "" ? k + '[$field]' : field;
			if (Reflect.isObject(value) && !Std.isOfType(value, String)) {
				setParams(value, key, http);
			} else {
				http.setParameter(key, Std.string(value));
			}
		}
	}
}
