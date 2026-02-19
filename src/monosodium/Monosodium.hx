package monosodium;

import haxe.PosInfos;
import haxe.Json;
import monosodium.endpoints.*;
import haxe.io.Path;
import monosodium.net.Http;
import haxe.crypto.Base64;
import haxe.io.Bytes;
import haxe.http.HttpMethod;
import monosodium.net.ratelimiter.RequestLimiter;
import monosodium.net.RequestClient;

// You are filled with determination
@:build(monosodium.macros.LazyEndpointMacro.build())
class Monosodium {
	public static var defaultLimiter:RequestLimiter = new RequestLimiter(2, 1);
	public static var defaultVerboseMode:Bool = false;

	public var verbose:Bool = Monosodium.defaultVerboseMode;
	public var username:Null<String>;

	@:unreflective
	private var api_token:Null<String>;

	private var _mirror:Null<Mirror>;

	@:noCompletion
	private var requestAPI:RequestClient;

	// Endpoints
	@:lazy public var posts:PostsEndpoint;
	@:lazy public var pools:PoolsEndpoint;
	@:lazy public var tags:TagsEndpoint;
	@:lazy public var users:UsersEndpoint;
	@:lazy public var bans:BansEndpoint;
	@:lazy public var artists:ArtistsEndpoint;
	@:lazy public var artistVersions:ArtistVersionsEndpoint;
	@:lazy public var artistUrls:ArtistUrlsEndpoint;
	@:lazy public var avoidPostings:AvoidPostingsEndpoint;
	@:lazy public var avoidPostingVersions:AvoidPostingVersionsEndpoint;

	public inline function authorize(username:String, api_token:String, ?censor:Bool = true):Monosodium {
		this.api_token = api_token;
		this.username = username;

		final name:String = censor ? Utility.censorString(username) : username;
		final token:String = censor ? Utility.censorString(api_token) : api_token;
		
		this.verbose ? Utility.verboseTrace('Credentials : ${name}:${token}@${_mirror}') : null;

		return this;
	}

	public function new():Void {
		this.requestAPI = new RequestClient(this);
	}

	public inline function mirror(mirror:Mirror = E621):Monosodium {
		this._mirror = mirror;
		return this;
	}

	@:allow(monosodium.endpoints)
	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic, ?body:Dynamic):Void {
		requestAPI.request(url, post, method, onSuccess, onError, onStatus, params, body);
	}
}
