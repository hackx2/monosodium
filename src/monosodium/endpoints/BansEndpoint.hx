package monosodium.endpoints;

import monosodium.endpoints.queries.Bans;
import monosodium.endpoints.schemas.Ban;
import haxe.http.HttpMethod;
import monosodium.endpoints.base.Endpoint;

@:route('/bans')
class BansEndpoint extends Endpoint {
	public function search(params:Bans, callback:Array<Bans>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> callback(cast data), onError, null, params);
	}

	public function get(id:Int, callback:Ban->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> callback(data), onError);
	}
}
