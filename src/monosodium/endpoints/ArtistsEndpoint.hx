package monosodium.endpoints;

import haxe.http.HttpMethod;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.schemas.Artist;
import monosodium.endpoints.queries.Artists;
import monosodium.endpoints.queries.artist.Create;

/**
 * Endpoint for interacting with the `/artists` API route.
 * This endpoint class provides  methods to **search**, **create**, **get**, and **edit** artists.
 * 
 * Janitor+/Admin+ endpoints are excluded from this class.
 */
@:route('/artists')
final class ArtistsEndpoint implements Endpoint {
	/**
	 * Search for artists based on query parameters.
	 * 
	 * @param params Search query parameters for filtering artists (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Artist` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function search(params:Artists, callback:Array<Artist>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((cast data : Array<Dynamic>).map(d -> return Artist.sterilize(d)));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('Failed to process artist search response: ${e}');
				}
			}
		}, onError, null, params);
	}

	/**
	 * Create a new artist.
	 * 
	 * @param params Artist creation parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the newly created Artist object returned from the API
	 * @param onError (Optional) callback to handle errors that occur during the request
	 */
	public function create(params:Create, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}.json', true, HttpMethod.Post, data -> callback(Artist.sterilize(data)), onError, null, {artist: params});
	}

	/**
	 * Retrieve an artist by its ID.
	 * 
	 * @param id The unique ID of the artist to retrieve
	 * @param callback Callback to handle the Artist object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function get(id:ID, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> callback(Artist.sterilize(data)), onError);
	}

	/**
	 * Edit an existing artist.
	 * 
	 * @param id The unique ID of the artist to edit
	 * @param params Updated artist parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the updated Artist object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	public function edit(id:ID, params:Create, callback:Artist->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, data -> callback(Artist.sterilize(data)), onError, null, {artist: params});
	}
}
