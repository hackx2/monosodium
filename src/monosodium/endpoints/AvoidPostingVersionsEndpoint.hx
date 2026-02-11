package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.AvoidPostingVersions;
import monosodium.endpoints.schemas.AvoidPostingVersion;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.types.ID;

/**
 * Endpoint for interacting with the `/avoid_posting_versions` API route.
 * This endpoint class provides a method to `search`.
 */
@:route('/avoid_posting_versions')
final class AvoidPostingVersionsEndpoint implements Endpoint {
	/**
	 * Search for avoid posting versions entries based on query parameters.
	 * 
	 * @param params Search query parameters for filtering (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `AvoidPostingVersion` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(params:AvoidPostingVersions, callback:Array<AvoidPostingVersion>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<AvoidPostingVersion>));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed ${e}');
				}
			};
		}, onError, null, params);
	}
}
