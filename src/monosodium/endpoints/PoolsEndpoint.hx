package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.Pools;
import monosodium.endpoints.schemas.Pool;
import monosodium.Monosodium;
import haxe.http.HttpMethod;
import monosodium.endpoints.base.Endpoint;

@:route('/pools')
class PoolsEndpoint extends Endpoint {
	public static inline final pool_element:String = '/pool_element';

	public function search(params:Pools, callback:Array<Pool>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Pools>).map(d -> return Pool.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed mapping pools : ${e}');
				}
			}
		}, onError, null, params);
	}

	public function get(id:Int, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> callback(Pool.sterilize(data)), onError);
	}

	public function create(data:Dynamic, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${route}.json', true, HttpMethod.Post, callback, onError);
	}

	public function update(id:Int, data:Dynamic, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, callback, onError);
	}

	public function delete(id:Int, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Delete, d -> callback(), onError);
	}

	public function revert(id:Int, version_id:Int, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}/revert.json', true, HttpMethod.Put, d -> callback(), onError, null, {version_id: version_id});
	}

	public function addPost(pool_id:Int, post_id:Int, callback:Pool->Void, ?onError:String->Void):Void {
		api.request('${pool_element}.json', true, HttpMethod.Post, callback, onError, null, {pool_id: pool_id, post_id: post_id});
	}

	public function removePost(pool_id:Int, post_id:Int, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${pool_element}.json', true, HttpMethod.Delete, d -> callback(), onError, null, {pool_id: pool_id, post_id: post_id});
	}

	public function recent(callback:Array<Dynamic>->Void, ?onError:String->Void):Void {
		api.request('${pool_element}/recent.json', false, HttpMethod.Get, callback, onError, null);
	}
}
