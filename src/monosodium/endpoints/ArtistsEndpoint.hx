package monosodium.endpoints;

import haxe.io.Error;
import monosodium.endpoints.types.ID;
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
	 * @param options Search query parameters for filtering artists (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Artist` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function search(options:Artists, callback:Array<Artist>->Void, ?onError:String->Void):Void {
		url:'${route}.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((data : Array<Artist>));
				} catch (error:Error) {
					if (onError != null) {
						onError('Artist search failed: ${error}');
					}
				}
			},
			error:onError
		},
		params:options
	}

	/**
	 * Create a new artist.
	 * 
	 * @param params Artist creation parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the newly created Artist object returned from the API
	 * @param onError (Optional) callback to handle errors that occur during the request
	 */
	@:POST function create(params:Create, callback:Artist->Void, ?onError:String->Void):Void {
		url:'${route}.json',
		callbacks:{
			success:(data) -> callback((data : Artist)),
			error:onError
		},
		body:{
			artist:params
		}
	}

	/**
	 * Retrieve an artist by its ID.
	 * 
	 * @param id The unique ID of the artist to retrieve
	 * @param callback Callback to handle the Artist object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function get(id:ID, callback:Artist->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:(data) -> callback((data : Artist)),
			error:onError
		}
	}

	/**
	 * Edit an existing artist.
	 * 
	 * @param id The unique ID of the artist to edit
	 * @param params Updated artist parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the updated Artist object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:PATCH function edit(id:ID, params:Create, callback:Artist->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:(data) -> callback((data : Artist)),
			error:onError
		},
		body:{
			artist:params
		}
	}
}
