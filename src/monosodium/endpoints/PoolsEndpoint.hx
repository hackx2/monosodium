package monosodium.endpoints;

import monosodium.Monosodium;
import monosodium.endpoints.types.ID;
import monosodium.endpoints.schemas.Pool;
import monosodium.endpoints.queries.Pools;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.schemas.pools.Create;
import monosodium.endpoints.schemas.pools.Recent;
import monosodium.endpoints.schemas.pools.Element;

/**
 * Endpoint for interacting with the `/pools` & '/pool_element' API routes.
 * This endpoint class provides methods to `search`, `create`, `get`, and `edit` artists.
 * Additionally provides methods for `addPost`, `removePost`, and `recent`.
 * 
 * Janitor+/Admin+ endpoints are excluded from this class.
 */
@:route('/pools')
final class PoolsEndpoint implements Endpoint {
	/**
	 * Search for pools based on query parameters.
	 * 
	 * @param params Search query parameters for filtering pools (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Artist` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function search(params:Pools, callback:Array<Pool>->Void, ?onError:String->Void):Void {
		url:'${route}.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((cast data : Array<Pool>));
				} catch (e:Dynamic) {
					if (onError != null) {
						onError('Failed pool search: ${e}');
					}
				}
			},
			error:onError
		},
		params:params
	}

	/**
	 * Create a new pool.
	 * 
	 * @param params Pool creation parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the newly created `Pool` object returned from the API
	 * @param onError (Optional) callback to handle errors that occur during the request
	 */
	@:POST function create(data:Create, callback:Pool->Void, ?onError:String->Void):Void {
		url: '${route}.json',
		callbacks: {
			success: callback,
			error: onError
		},
		body: {pool: data}
	}

	/**
	 * Retrieve a pool by its ID.
	 * 
	 * @param id The unique ID of the pool to retrieve
	 * @param callback Callback to handle the `Pool` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function get(id:ID, callback:Pool->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:(data) -> callback((cast data : Pool)),
			error:onError
		}
	}

	/**
	 * Edit an existing pool.
	 * 
	 * @param id The unique ID of the pool to edit
	 * @param params Updated pool parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the updated `Pool` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:PATCH function edit(id:ID, data:Create, callback:Pool->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:callback,
			error:onError
		},
		body:{
			pool:data
		}
	}

	@:dox(hide) static inline final poolElement:String = '/pool_element';

	/**
	 * Add a post to the given pool.
	 * 
	 * @param params Add post parameters (e.g pool_id, pool_name, post_id, etc.)
	 * @param callback Callback to handle the `Pool` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:POST function addPost(params:Element, callback:Pool->Void, ?onError:String->Void):Void {
		url:'${poolElement}.json',
		callbacks:{
			success:callback,
			error:onError
		},
		body:params
	}

	/**
	 * Removes a post from a pool.
	 * 
	 * @param params parameters
	 * @param callback Callback
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:DELETE function removePost(params:Element, callback:Void->Void, ?onError:String->Void):Void {
		url:'${poolElement}.json',
		callbacks:{
			success:_ -> callback(),
			error:onError
		},
		body:params
	}

	/**
	 * Get recent pools.
	 * 
	 * @param params parameters
	 * @param callback Callback to handle the post object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function recent(params:Element, callback:Array<Recent>->Void, ?onError:String->Void):Void {
		url:'${poolElement}/recent.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((cast data : Array<Recent>));
				} catch (e:Dynamic) {
					if (onError != null) {
						onError('Failed to get recent pools: ${e}');
					}
				}
			},
			error:onError
		},
		body:params
	}
}
