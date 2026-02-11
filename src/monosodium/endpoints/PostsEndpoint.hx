package monosodium.endpoints;

import monosodium.endpoints.types.ID;
import haxe.extern.EitherType;
import haxe.http.HttpMethod;
import monosodium.endpoints.schemas.post.Post as PostSchema;
import monosodium.endpoints.queries.Posts;
import monosodium.endpoints.schemas.post.Upload;
import monosodium.endpoints.base.Endpoint;
import monosodium.endpoints.types.ID;

using StringTools;

// we're upto here ^w^
@:route('/posts')
final class PostsEndpoint implements Endpoint {
	public function upload(post:Upload, callback:Dynamic->Void, ?onError:String->Void):Void {
		api.request('/uploads.json', true, HttpMethod.Post, response -> {
			callback(response);
		}, onError, null, post);
	}

	public function search(query:Posts, callback:Array<PostSchema>->Void, ?onError:String->Void):Void {
		api.request('${route}.json', false, HttpMethod.Get, data -> {
			try {
				callback((data.posts : Array<PostSchema>));
			} catch (e) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError, null, query);
	}

	public function get(id:ID, callback:PostSchema->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', false, HttpMethod.Get, data -> {
			try
				callback((data.post : PostSchema))
			catch (e)
				if (onError != null)
					onError('failed sterilizing : $e');
		}, onError);
	}

	public function random(?tags:EitherType<Array<String>, String>, callback:PostSchema->Void, ?onError:String->Void):Void {
		api.request('${route}/random.json', false, HttpMethod.Get, data -> {
			try {
				callback((data.post : PostSchema));
			} catch (e)
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
		}, onError, null, {
			tags: Std.isOfType(tags, String) ? (tags : String) : (tags : Array<String>).join(" ")
		});
	}

	public function edit(id:ID, postEdit:Dynamic, callback:PostSchema->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}.json', true, HttpMethod.Patch, data -> {
			try {
				callback((data.post : PostSchema));
			} catch (e) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError, null, {post: postEdit});
	}

	public function editIqdb(id:ID, callback:PostSchema->Void, ?onError:String->Void):Void {
		api.request('${route}/$id/update_iqdb.json', true, HttpMethod.Get, data -> {
			try {
				callback((data.post : PostSchema));
			} catch (e:Dynamic) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError);
	}

	public function markAsTranslated(id:ID, translationCheck:Bool, partiallyTranslated:Bool, callback:PostSchema->Void, ?onError:String->Void):Void {
		api.request('${route}/$id/mark_as_translated.json', true, HttpMethod.Post, data -> {
			try {
				callback((data.post : PostSchema));
			} catch (e) {
				if (onError != null) {
					onError('failed sterilizing : $e');
				}
			}
		}, onError, null, {
			translation_check: translationCheck,
			partially_translated: partiallyTranslated
		});
	}

	public function copyNotes(id:ID, otherPostId:Int, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/$id/copy_notes.json', true, HttpMethod.Put, _ -> callback(), onError, null, {other_post_id: otherPostId});
	}

	public function revert(id:ID, versionId:Int, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}/revert.json?version_id=${versionId}', true, HttpMethod.Post, _ -> callback(), onError);
	}

	public function showSeq(id:ID, dir:String, callback:PostSchema->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}/show_seq.json?seq=$dir', false, HttpMethod.Get, data -> {
			try {
				callback((data.post : PostSchema));
			} catch (error:Dynamic) {
				if (onError != null) {
					onError('failed sterilizing post seq : $error');
				}
			}
		}, onError);
	}

	public function unflag(id:ID, callback:Void->Void, ?onError:String->Void):Void {
		api.request('${route}/${id}/flags.json', true, HttpMethod.Delete, _ -> callback(), onError, null, {approval: "approve"});
	}
}
