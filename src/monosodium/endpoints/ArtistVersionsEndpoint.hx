package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.ArtistVersions;
import monosodium.endpoints.schemas.ArtistVersion;
import monosodium.endpoints.base.Endpoint;

@:route('/artist_versions')
final class ArtistVersionsEndpoint extends Endpoint {
	public function search(params:ArtistVersions, callback:Array<ArtistVersion>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> return ArtistVersion.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed mapping artist version ${e}');
				}
			}
		}, onError, null, params);
	}
}
