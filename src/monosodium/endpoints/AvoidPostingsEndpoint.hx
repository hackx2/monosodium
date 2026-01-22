package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.Monosodium;
import monosodium.endpoints.schemas.AvoidPosting;
import monosodium.endpoints.queries.AvoidPostings;
import monosodium.endpoints.base.Endpoint;

@:route('/avoid_posting')
final class AvoidPostingsEndpoint extends Endpoint {
	public function search(params:AvoidPostings, callback:Array<AvoidPosting>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			callback([for (v in (cast data : Array<Dynamic>)) AvoidPosting.sterilize(v)]);
		}, onError, null, params);
	}

	public function get(id:String, callback:AvoidPosting->Void, ?onError:String->Void):Void {
		api.request('$route/${id}.json', false, HttpMethod.Get, data -> {
			callback(AvoidPosting.sterilize(data));
		}, onError);
	}

	public function create(body:Dynamic, callback:AvoidPosting->Void, ?onError:String->Void):Void {
		api.request('${route}.json', true, HttpMethod.Post, data -> {
			callback(AvoidPosting.sterilize(data));
		}, onError);
	}

	public function update(id:String, body:Dynamic, callback:AvoidPosting->Void, ?onError:String->Void):Void {
		api.request('$route/${id}.json', true, HttpMethod.Patch, data -> callback(AvoidPosting.sterilize(data)), onError);
	}

	public function destroy(id:String, callback:Void->Void, ?onError:String->Void):Void {
		api.request('$route/${id}.json', true, HttpMethod.Delete, _ -> callback(), onError);
	}

	public function delete(id:String, callback:Void->Void, ?onError:String->Void):Void {
		api.request('$route/${id}/delete.json', true, HttpMethod.Put, _ -> callback(), onError);
	}

	public function undelete(id:String, callback:Void->Void, ?onError:String->Void):Void {
		api.request('$route/${id}/undelete.json', true, HttpMethod.Put, _ -> callback(), onError);
	}
}
