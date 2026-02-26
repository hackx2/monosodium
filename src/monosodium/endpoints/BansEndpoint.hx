package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.Bans;
import monosodium.endpoints.schemas.Ban;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.types.ID;

/**
 * Endpoint for interacting with the `/bans` API route.
 * This endpoint class provides methods to `search`, and `get`.
 */
@:route('/bans')
final class BansEndpoint implements Endpoint {
	/**
	 * Search for user ban entries based on query parameters.
	 * 
	 * @param params Search query parameters for filtering (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Ban` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function search(params:Bans, callback:Array<Ban>->Void, ?onError:String->Void):Void {
		url:'${route}.json',
		callbacks:{
			success:(data) -> callback((cast data : Array<Ban>)),
			error:onError
		},
		params:params
	}

	/**
	 * Retrieve a ban entry by its ID.
	 * 
	 * @param id The unique ID of the ban entry to retrieve
	 * @param callback Callback to handle the `Ban` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function get(id:ID, callback:Ban->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:(data) -> callback(data),
			error:onError
		}
	}
}
