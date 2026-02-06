package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.Bans;
import monosodium.endpoints.schemas.Ban;
import monosodium.endpoints.base.Endpoint;

/**
 * Endpoint for interacting with the `/bans` API route.
 * This endpoint class provides methods to `search`, and `get`.
 */
@:route('/bans')
final class BansEndpoint extends Endpoint {
	/**
	 * Search for user ban entries based on query parameters.
	 * 
	 * @param params Search query parameters for filtering (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Ban` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(params:Bans, callback:Array<Ban>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> callback((cast data : Array<Ban>)), onError, null, params);
	}

	/**
	 * Retrieve a ban entry by its ID.
	 * 
	 * @param id The unique ID of the ban entry to retrieve
	 * @param callback Callback to handle the `Ban` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function get(id:ID, callback:Ban->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> callback(data), onError);
	}
}
