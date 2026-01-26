package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.schemas.User;
import monosodium.endpoints.queries.Users;
import monosodium.endpoints.base.Endpoint;

@:route('/users')
final class UsersEndpoint extends Endpoint {
	public function search(query:Users, callback:Array<User>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((data : Array<Dynamic>).map(User.sterilize));
			} catch (error:Dynamic) {
				if (onError != null) {
					onError('Failed mapping sterilized data : $error');
				}
			}
		}, onError, null, query);
	}

	public function get(id:ID, callback:User->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> {
			try {
				callback(User.sterilize(data));
			} catch (error:Dynamic) {
				if (onError != null) {
					onError('Failed sterilizing data : $error');
				}
			}
		}, onError);
	}

	public function edit(id:ID, userEdit:Dynamic, callback:User->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, data -> {
			try {
				callback(User.sterilize(data));
			} catch (error:Dynamic) {
				if (onError != null) {
					onError('Failed sterilizing data : $error');
				}
			}
		}, onError, null, {user: userEdit});
	}

	public function uploadLimit(id:ID, callback:User->Void, ?onError:String->Void):Void {
		api.request('${route}/$id/upload_limit.json', false, HttpMethod.Get, data -> {
			try {
				callback(User.sterilize(data));
			} catch (error:Dynamic) {
				if (onError != null) {
					onError('Failed sterilizing data : $error');
				}
			}
		}, onError);
	}
}
