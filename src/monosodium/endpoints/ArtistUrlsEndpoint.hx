package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.ArtistUrls;
import monosodium.endpoints.schemas.ArtistUrl;
import monosodium.endpoints.base.Endpoint;

/**
 * Endpoint for interacting with the `/artist_urls` API route.
 * This endpoint class provides methods to **search** for artist URLs.
 */
@:route("/artist_urls")
final class ArtistUrlsEndpoint extends Endpoint {
	/**
	 * Search for artist URL(s) based on query parameters.
	 * 
	 * @param params Search query parameters for filtering artist url(s) (e.g., id, order, name, etc.)
	 * @param callback Callback to handle an array of `ArtistUrl` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(query:ArtistUrls, callback:Array<ArtistUrl>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			callback((data : Array<ArtistUrl>));
		}, onError, null, query);
	}
}
