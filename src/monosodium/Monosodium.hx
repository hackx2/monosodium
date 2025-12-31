package monosodium;

import haxe.PosInfos;
import haxe.Json;
import monosodium.endpoints.*;
import haxe.io.Path;
import monosodium.net.Http;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.http.HttpMethod;
import monosodium.net.RateLimiter;
import monosodium.endpoints.responses.Result;
import monosodium.endpoints.base.Endpoint;

// You are filled with determination
class Monosodium {
	private static var limiter = new RateLimiter(2);
	public static var defaultVerboseMode:Bool = false;

	public var verbose:Bool = Monosodium.defaultVerboseMode;
	public var username:Null<String>;

	@:unreflective
	private var api_token:Null<String>;
	private var _mirror:Null<Mirror>;
	private var _http:Null<Http>;

	public var posts:PostsEndpoint;
	public var pools:PoolsEndpoint;
	public var tags:TagsEndpoint;
	public var users:UsersEndpoint;
	public var bans:BansEndpoint;
	public var artists:ArtistsEndpoint;
	public var artistVersions:ArtistVersionsEndpoint;
	public var artistUrls:ArtistUrlsEndpoint;
	public var avoidPostings:AvoidPostingsEndpoint;
	public var avoidPostingVersions:AvoidPostingVersionsEndpoint;

	public function authorize(username:String, api_token:String, ?censor:Bool = true):Monosodium {
		this.api_token = api_token;
		this.username = username;

		final name:String = censor ? Utility.censorString(username) : username;
		final token:String = censor ? Utility.censorString(api_token) : api_token;
		this.verbose ? Utility.verboseTrace('Credentials : ${name}:${token}@$_mirror') : null;
		return this;
	}

	public function new():Void {
		// init endpoints
		this.posts = new PostsEndpoint(this);
		this.pools = new PoolsEndpoint(this);
		this.tags = new TagsEndpoint(this);
		this.artists = new ArtistsEndpoint(this);
		this.users = new UsersEndpoint(this);
		this.bans = new BansEndpoint(this);

		this.artistVersions = new ArtistVersionsEndpoint(this);
		this.artistUrls = new ArtistUrlsEndpoint(this);
		this.avoidPostings = new AvoidPostingsEndpoint(this);
		this.avoidPostingVersions = new AvoidPostingVersionsEndpoint(this);
	}

	public function mirror(mirror:Mirror = E621):Monosodium {
		this._mirror = mirror;
		return this;
	}

	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void,
			?params:Dynamic):Void {
		limiter.enqueue(() -> performRequest(url, post, method, onSuccess, onError, onStatus, params));
	}

	@:dox(hide) var _statusCode:Int = 0;

	@:dox(hide)
	private function performRequest(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void,
			?params:Dynamic):Void {
		_statusCode = 0;
		_http = new Http(Path.join([(_mirror == E621) ? Endpoint.e6 : Endpoint.e9, url]));
		_http.addHeader("User-Agent", "hackx2@monosodium/1.0");

		(this.verbose ? Utility.verboseTrace('Fetching : $url') : null);

		if (api_token != null && username != null)
			_http.addHeader("Authorization", Base64.encode(Bytes.ofString(username + ":" + api_token)));
		//	if (body != null)
		//	_http.setPostData(Json.stringify(body));

		function setParams(obj:Dynamic, ?k:String = ""):Void { // find an alternative that doesn't use reflect... :3
			for (field in Reflect.fields(obj)) {
				final value:Dynamic = Reflect.field(obj, field);
				if (value == null)
					continue;
				final key:String = k != "" ? k + '[$field]' : field;
				if (Reflect.isObject(value) && !Std.isOfType(value, String)) {
					setParams(value, key);
				} else {
					_http.setParameter(key, Std.string(value));
				}
			}
		}

		if (params != null)
			setParams(params);

		function onErr(error:String):Void {
			(this.verbose ? Utility.verboseTrace('Error : $error') : null);

			if (onError != null)
				onError(error);
			limiter.enqueue(() -> {});
		}

		_http.onData = function(data:String) {
			switch (_statusCode) {
				case 200, 204:
					try {
						onSuccess(haxe.Json.parse(data));
					} catch (e:Dynamic) {
						onErr("Invalid JSON response");
					}
				default: // bad???
					try {
						final err:Result = Json.parse(data);
						onErr(err.reason != null ? err.reason : "HTTP " + _statusCode);
					} catch (_) {
						onErr("HTTP " + _statusCode);
					}
			}
			limiter.enqueue(() -> {});
		};
		_http.onError = onErr;
		_http.onStatus = function(status:Int) {
			(this.verbose ? Utility.verboseTrace('Status Code : $status') : null);

			_statusCode = status;
			if (onStatus != null)
				onStatus(status);
			limiter.enqueue(() -> {});
		}
		_http.method = method;
		_http.request(post);
	}
}
