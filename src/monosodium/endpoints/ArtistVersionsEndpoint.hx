package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.ArtistVersions;
import monosodium.endpoints.schemas.ArtistVersion;
import monosodium.endpoints.base.Endpoint;

/**
 * Endpoint for interacting with the `/artist_versions` API route.
 * This endpoint class provides methods to **search** for artist URLs.
 */
@:route('/artist_versions')
final class ArtistVersionsEndpoint implements Endpoint {
	/**
	 * Search for artist versions based on query parameters.
	 * 
	 * @param params Search query parameters for filtering artist url(s) (e.g., id, order, name, etc.)
	 * @param callback Callback to handle an array of `ArtistVersion` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(params:ArtistVersions, callback:Array<ArtistVersion>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<ArtistVersion>));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed mapping artist version ${e}');
				}
			}
		}, onError, null, params);
	}
}
