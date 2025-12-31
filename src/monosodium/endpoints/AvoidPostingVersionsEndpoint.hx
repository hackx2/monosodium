package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.AvoidPostingVersions;
import monosodium.endpoints.schemas.AvoidPostingVersion;
import monosodium.endpoints.base.Endpoint;

@:route('/avoid_posting_versions')
class AvoidPostingVersionsEndpoint extends Endpoint {
	public function search(params:AvoidPostingVersions, callback:Array<AvoidPostingVersion>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> return AvoidPostingVersion.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed ${e}');
				}
			};
		}, onError, null, params);
	}
}
