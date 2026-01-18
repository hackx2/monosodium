package monosodium.endpoints;

import monosodium.endpoints.schemas.pools.Element;
import monosodium.endpoints.schemas.pools.Create;
import monosodium.endpoints.queries.Pools;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.schemas.Pool;
import monosodium.endpoints.schemas.pools.Recent;
import monosodium.Monosodium;
import haxe.http.HttpMethod;

/**
 * Endpoint for interacting with the `/pools` & '/pool_element' API route.
 * This endpoint class provides methods to `search`, `create`, `get`, and `edit` artists.
 * Additionally provides methods for `addPost`, `removePost`, and `recent`.
 * 
 * Janitor+/Admin+ endpoints are excluded from this class.
 */
@:route('/pools')
final class PoolsEndpoint extends Endpoint {
	/**
	 * Search for pools based on query parameters.
	 * 
	 * @param params Search query parameters for filtering pools (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Artist` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(params:Pools, callback:Array<Pool>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Pool>));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed mapping pools : ${e}');
				}
			}
		}, onError, null, params);
	}

	/**
	 * Create a new pool.
	 * 
	 * @param params Pool creation parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the newly created `Pool` object returned from the API
	 * @param onError (Optional) callback to handle errors that occur during the request
	 */
	public function create(data:Create, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${route}.json', true, HttpMethod.Post, callback, onError, null, null, {pool: data});
	}

	/**
	 * Retrieve a pool by its ID.
	 * 
	 * @param id The unique ID of the pool to retrieve
	 * @param callback Callback to handle the `Pool` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function get(id:Int, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> callback((cast data : Pool)), onError);
	}

	/**
	 * Edit an existing pool.
	 * 
	 * @param id The unique ID of the pool to edit
	 * @param params Updated pool parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the updated `Pool` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function edit(id:Int, data:Create, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, callback, onError, null, null, {pool: data});
	}

	@:dox(hide) static inline final elementRoute:String = '/pool_element';

	/**
	 * Add a post to the given pool.
	 * 
	 * @param params Add post parameters (e.g pool_id, pool_name, post_id, etc.)
	 * @param callback Callback to handle the `Pool` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function addPost(params:Element, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${elementRoute}.json', true, HttpMethod.Post, callback, onError, null, null, params);
	}

	/**
	 * Removes a post from a pool.
	 * 
	 * @param params parameters
	 * @param callback Callback
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function removePost(params:Element, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${elementRoute}.json', true, HttpMethod.Delete, d -> callback(), onError, null, null, params);
	}

	/**
	 * Get recent pools.
	 * 
	 * @param params parameters
	 * @param callback Callback to handle the post object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function recent(params:Element, callback:Array<Recent>->Void, ?onError:String->Void):Void {
		api.request('${elementRoute}/recent.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Recent>));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed mapping recents : ${e}');
				}
			}
		}, onError, null, null, params);
	}
}
