package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.ArtistUrls;
import monosodium.endpoints.schemas.ArtistUrl;
import monosodium.endpoints.base.Endpoint;

@:route("/artist_urls")
class ArtistUrlsEndpoint extends Endpoint {
	public function search(params:ArtistUrls, callback:Array<ArtistUrl>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			callback([for (v in (cast data : Array<Dynamic>)) ArtistUrl.sterilize(v)]);
		}, onError, null, params);
	}
}
