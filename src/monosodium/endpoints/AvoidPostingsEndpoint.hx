package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.schemas.AvoidPosting;
import monosodium.endpoints.queries.AvoidPostings;
import monosodium.endpoints.base.Endpoint;

/**
 * Endpoint for interacting with the `/avoid_posting` API route.
 * This endpoint class provides methods to `search`, and `get`.
 */
@:route('/avoid_posting')
final class AvoidPostingsEndpoint extends Endpoint {
	/**
	 * Search for avoid posting entries based on query parameters.
	 * 
	 * @param params Search query parameters for filtering (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `AvoidPosting` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(params:AvoidPostings, callback:Array<AvoidPosting>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			callback((cast data : Array<AvoidPosting>));
		}, onError, null, params);
	}

	/**
	 * Retrieve a avoid posting entry by its ID.
	 * 
	 * @param id The unique ID of the entry to retrieve
	 * @param callback Callback to handle the `AvoidPosting` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function get(id:ID, callback:AvoidPosting->Void, ?onError:String->Void):Void {
		api.request('$route/${id}.json', false, HttpMethod.Get, data -> {
			callback(data);
		}, onError);
	}
}
