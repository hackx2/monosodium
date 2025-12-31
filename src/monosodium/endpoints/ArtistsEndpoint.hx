package monosodium.endpoints;

import haxe.extern.EitherType;
import haxe.http.HttpMethod;
import monosodium.endpoints.schemas.Artist;
import monosodium.endpoints.queries.Artists;
import monosodium.endpoints.base.Endpoint;

@:route('/artists')
class ArtistsEndpoint extends Endpoint {
	public function search(params:Artists, callback:Array<Artist>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> return Artist.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed mapping pools : ${e}');
				}
			}
		}, onError, null, params);
	}

	public function get(id:EitherType<Int, String>, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> callback(Artist.sterilize(data)), onError);
	}

	public function create(data:Dynamic, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}.json', true, HttpMethod.Post, data -> callback(Artist.sterilize(data)), onError);
	}

	public function update(id:Int, data:Dynamic, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, data -> callback(Artist.sterilize(data)), onError);
	}

	public function delete(id:Int, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Delete, _ -> callback(), onError);
	}

	public function revert(id:Int, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}/revert.json', true, HttpMethod.Put, data -> callback(Artist.sterilize(data)), onError);
	}
}
