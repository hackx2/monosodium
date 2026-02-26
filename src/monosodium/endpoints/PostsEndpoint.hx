package monosodium.endpoints;

import haxe.io.Error;
import haxe.extern.EitherType;

import monosodium.endpoints.types.ID;
import monosodium.endpoints.base.Query;
import monosodium.endpoints.queries.Posts;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.schemas.post.Upload;
import monosodium.endpoints.schemas.post.Response;
import monosodium.endpoints.schemas.post.UpdatePost;
import monosodium.endpoints.schemas.post.PostSequence;
import monosodium.endpoints.schemas.post.FavoriteUser;
import monosodium.endpoints.schemas.post.Post as PostSchema;

using StringTools;

/**
 * Endpoint for interacting with the `/posts` & '/uploads.json' API routes.
 * This endpoint class provides methods to `search`, `upload`, `random`, `get`, and `edit` posts.
 * Additionally provides methods for `markAsTranslated`, `copyNotes`, `revert`, `showSequence`, and `favorites`.
 * 
 * Janitor+/Admin+ endpoints are excluded from this class.
 */
@:route('/posts')
final class PostsEndpoint implements Endpoint {
	/**
	 * Search for post based on query parameters.
	 * 
	 * @param options Search query parameters for filtering post (e.g., id, order, name, etc)
	 * @param callback Callback to handle an array of `Post` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function search(options:Posts, callback:Array<PostSchema>->Void, ?onError:String->Void):Void {
		url:'${route}.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((data.posts : Array<PostSchema>));
				} catch (error:Error) {
					if (onError != null) {
						onError('Post search failed: ${error}');
					}
				}
			},
			error:onError
		},
		params:options
	}

	/**
	 * Get a random post.
	 * 
	 * @param tags Search tags
	 * @param callback Callback to handle an array of `Post` object(s) returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function random(?tags:EitherType<Array<String>, String>, callback:PostSchema->Void, ?onError:String->Void):Void {
		url:'${route}/random.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((data.post : PostSchema));
				} catch (error:Error) {
					if (onError != null) {
						onError('Failed to get a random post: ${error}');
					}
				}
			},
			error:onError
		},
		params:{
			tags:Std.isOfType(tags, String) ? (tags : String) : (tags : Array<String>).join(" ")
		}
	}

	/**
	 * Retrieve a post by its ID.
	 * 
	 * @param id The unique ID of the post to retrieve
	 * @param callback Callback to handle the `Post` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:GET function get(id:ID, callback:PostSchema->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((data.post : PostSchema));
				} catch (error:Error) {
					if (onError != null) {
						onError('Failed to get post:${id}: ${error}');
					}
				}
			},
			error:onError
		}
	}

	/**
	 * Edit an existing post.
	 * 
	 * @param id The unique ID of the Post to edit
	 * @param params Updated Post upload parameters (e.g., tag_string, source, description, etc.)
	 * @param callback Callback to handle the updated `Post` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:PATCH function edit(id:ID, postEdit:UpdatePost, callback:PostSchema->Void, ?onError:String->Void):Void {
		url:'${route}/${id}.json',
		callbacks:{
			success:data -> {
				try {
					callback((data.post : PostSchema));
				} catch (error:Error) {
					if (onError != null) {
						onError('An error occurred while trying to edit post: ${error}');
					}
				}
			},
			error:onError
		},
		body:{
			post:postEdit
		}
	}

	/**
	 * Mark a post as translated.
	 * 
	 * @param id The unique ID of the Post
	 * @param translationCheck 
	 * @param partiallyTranslated 
	 * @param callback Callback to handle the updated `Post` object returned from the API
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:POST function markAsTranslated(id:ID, translationCheck:Bool, partiallyTranslated:Bool, callback:PostSchema->Void, ?onError:String->Void):Void {
		url:'${route}/$id/mark_as_translated.json',
		callbacks:{
			success:data -> {
				try {
					callback((data.post : PostSchema));
				} catch (error:Error) {
					if (onError != null) {
						onError('Failed to mark as translated: ${error}');
					}
				}
			},
			error:onError
		},
		body:{
			translation_check:translationCheck,
			partially_translated:partiallyTranslated
		}
	}

	/**
	 * Copy notes to another post.
	 * 
	 * @param id The unique ID of the Post
	 * @param otherPostId The unique ID of the other Post
	 * @param callback
	 * @param onError (Optional) Callback to handle errors that occur during the request
	 */
	@:PUT function copyNotes(id:ID, otherPostId:Int, callback:Void->Void, ?onError:String->Void):Void {
		url:'${route}/$id/copy_notes.json',
		callbacks:{
			success:_ -> callback(),
			error:onError
		},
		body:{
			other_post_id:otherPostId
		}
	}

	/**
	 * Revert a post.
	 * 
	 * @param id The unique ID of the Post.
	 * @param versionId 
	 * @param callback 
	 * @param onError (Optional) Callback to handle errors that occur during the request.
	 */
	@:POST function revert(id:ID, versionId:Int, callback:Void->Void, ?onError:String->Void):Void {
		url:'${route}/${id}/revert.json?version_id=${versionId}',
		callbacks:{
			success:_ -> callback(),
			error:onError
		},
		params:{
			version_id:versionId
		}
	}

	/**
	 * Get a post in sequence.
	 * 
	 * @param id The unique ID of the Post.
	 * @param seq Either `NEXT` or `PREVIOUS`.
	 * @param callback 
	 * @param onError (Optional) Callback to handle errors that occur during the request.
	 */
	@:GET function showSequence(id:ID, seq:PostSequence, callback:PostSchema->Void, ?onError:String->Void):Void {
		url:'${route}/${id}/show_seq.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((data.post : PostSchema));
				} catch (error:Error) {
					if (onError != null) {
						onError('Failed getting sequenced post: $error');
					}
				}
			},
			error:onError
		},
		params:{
			seq:seq
		}
	}

	/**
	 * Get a list of users who favorited a post.
	 * 
	 * @param options Filter options
	 * @param callback Callback to handle the newly created `Pool` object returned from the API
	 * @param onError (Optional) callback to handle errors that occur during the request
	 */
	@:GET function favorites(id:ID, filterOptions:Query, callback:Array<FavoriteUser>->Void, ?onError:String->Void):Void {
		url:'/posts/${id}/favorites.json',
		callbacks:{
			success:(data) -> {
				try {
					callback((data : Array<FavoriteUser>));
				} catch (error:Dynamic) {
					if (onError != null) {
						onError('Failed to get users who favorited this post: ${error}');
					}
				}
			},
			error:onError,
		},
		params:filterOptions
	}

	/**
	 * Upload a post.
	 * 
	 * @param params Post upload parameters (e.g., name, notes, URLs, etc.)
	 * @param callback Callback to handle the newly created `Pool` object returned from the API
	 * @param onError (Optional) callback to handle errors that occur during the request
	 */
	@:POST function upload(upload_options:Upload, callback:Response->Void, ?onError:String->Void):Void {
		url:'/uploads.json',
		callbacks:{
			success:(response) -> {
				callback((response : Response));
			},
			error:onError
		},
		body:upload_options
	}
}
