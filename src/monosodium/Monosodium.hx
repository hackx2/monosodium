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
import monosodium.net.RequestDispatcher;

// You are filled with determination
class Monosodium {
	private static var limiter = new RateLimiter(2);
	public static var defaultVerboseMode:Bool = false;

	public var verbose:Bool = Monosodium.defaultVerboseMode;
	public var username:Null<String>;

	@:unreflective
	private var api_token:Null<String>;
	private var _mirror:Null<Mirror>;
	private var requestAPI:RequestDispatcher;

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
		(this.verbose ? Utility.verboseTrace('Credentials : ${name}:${token}@${_mirror}') : null);

		return this;
	}

	public function new():Void {
		this.requestAPI = new RequestDispatcher(this);
		initializeEndpoints();
	}

	private function initializeEndpoints() {
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

	public function request(url:String, post:Bool, method:HttpMethod, onSuccess:Dynamic->Void, ?onError:String->Void, ?onStatus:Int->Void, ?params:Dynamic):Void {
		requestAPI.request(url, post, method, onSuccess, onError, onStatus, params);
	}
}
