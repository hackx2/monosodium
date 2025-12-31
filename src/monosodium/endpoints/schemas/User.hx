package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class User {
	var id:Int;
	var created_at:String;
	var name:String;
	var level:Int;
	var base_upload_limit:Int;
	var post_upload_count:Int;
	var post_update_count:Int;
	var note_update_count:Int;
	var is_banned:Bool;
	var can_approve_posts:Bool;
	var can_upload_free:Bool;
	var level_string:String;
	var avatar_id:Int;
	var is_verified:Bool;
	var wiki_page_version_count:Int;
	var artist_version_count:Int;
	var pool_version_count:Int;
	var forum_post_count:Int;
	var comment_count:Int;
	var flag_count:Int;
	var favorite_count:Int;
	var positive_feedback_count:Int;
	var neutral_feedback_count:Int;
	var negative_feedback_count:Int;
	var upload_limit:Int;
	var profile_about:String;
	var profile_artinfo:String;

	static function sterilize(d:Dynamic):User {
		return {
			id: d.id,
			created_at: d.created_at,
			name: d.name,
			level: d.level,
			base_upload_limit: d.base_upload_limit,
			post_upload_count: d.post_upload_count,
			post_update_count: d.post_update_count,
			note_update_count: d.note_update_count,
			is_banned: d.is_banned,
			can_approve_posts: d.can_approve_posts,
			can_upload_free: d.can_upload_free,
			level_string: d.level_string,
			avatar_id: d.avatar_id,
			is_verified: d.is_verified,
			wiki_page_version_count: d.wiki_page_version_count != null ? d.wiki_page_version_count : 0,
			artist_version_count: d.artist_version_count != null ? d.artist_version_count : 0,
			pool_version_count: d.pool_version_count != null ? d.pool_version_count : 0,
			forum_post_count: d.forum_post_count != null ? d.forum_post_count : 0,
			comment_count: d.comment_count != null ? d.comment_count : 0,
			flag_count: d.flag_count != null ? d.flag_count : 0,
			favorite_count: d.favorite_count != null ? d.favorite_count : 0,
			positive_feedback_count: d.positive_feedback_count != null ? d.positive_feedback_count : 0,
			neutral_feedback_count: d.neutral_feedback_count != null ? d.neutral_feedback_count : 0,
			negative_feedback_count: d.negative_feedback_count != null ? d.negative_feedback_count : 0,
			upload_limit: d.upload_limit != null ? d.upload_limit : 0,
			profile_about: d.profile_about != null ? d.profile_about : "",
			profile_artinfo: d.profile_artinfo != null ? d.profile_artinfo : ""
		};
	}
}
