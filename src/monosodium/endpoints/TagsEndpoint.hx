package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.queries.Tags;
import monosodium.endpoints.schemas.tag.Tag;
import monosodium.endpoints.schemas.tag.Correction;
import monosodium.endpoints.schemas.tag.Preview;
import monosodium.endpoints.base.Endpoint;

@:route('/tags')
final class TagsEndpoint extends Endpoint {
	public function search(params:Tags, callback:Array<Tag>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> Tag.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError, null, params);
	}

	public function get(id:ID, callback:Tag->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> {
			try {
				callback(Tag.sterilize(data));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError);
	}

	public function tags(callback:Array<Tag>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> Tag.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('failed mapping tag preview : $e');
				}
			}
		}, onError);
	}

	public function edit(id:ID, category:Null<Int>, is_locked:Null<Bool>, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, _ -> callback(), onError, null, {
			tag: {category: category, is_locked: is_locked}
		});
	}

	public function delete(id:ID, callback:Void->Void, ?onError:String->Void):Void {
		api.request('$route/${id}.json', false, HttpMethod.Delete, _ -> callback(), onError);
	}

	public function getCorrection(id:ID, callback:Correction->Void, ?onError:String->Void):Void {
		api.request('${route}/$id/correction.json', false, HttpMethod.Get, data -> {
			try {
				callback(Correction.sterilize(data));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError);
	}

	public function correct(id:ID, commit:String, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/$id/correction.json', true, HttpMethod.Post, _ -> callback(), onError, null, {commit: commit});
	}

	public function preview(tags:String, callback:Array<Preview>->Void, ?onError:String->Void):Void {
		api.request('$route/preview.json', true, HttpMethod.Post, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> Preview.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('failed mapping tag preview : $e');
				}
			}
		}, onError, null, {tags: tags});
	}
}
