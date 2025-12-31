package monosodium.endpoints.schemas.post;

// /random.json killed me :pensive:
@:structInit
@:publicFields
final class Flat {
	var id:Int;
	var created_at:String;
	var updated_at:String;
	var uploader_id:Int;
	var approver_id:Null<Int>;
	var score:Int;
	var up_score:Int;
	var down_score:Int;
	var fav_count:Int;
	var rating:String;
	var md5:String;
	var source:String;
	var description:String;
	var file_ext:String;
	var file_size:Int;
	var file_url:String;
	var image_width:Int;
	var image_height:Int;
	var sample_url:String;
	var preview_file_url:String;
	var has_sample:Bool;
	var duration:Null<Int>;
	var tag_string:String;
	var tag_count:Int;
	var tag_count_general:Int;
	var tag_count_artist:Int;
	var tag_count_character:Int;
	var tag_count_copyright:Int;
	var tag_count_species:Int;
	var tag_count_meta:Int;
	var tag_count_invalid:Int;
	var tag_count_lore:Int;
	var tag_count_contributor:Int;
	var parent_id:Null<Int>;
	var has_children:Bool;
	var has_active_children:Bool;
	var has_visible_children:Bool;
	var children_ids:Null<Array<Null<Int>>>;
	var pool_ids:Array<Int>;
	var change_seq:Int;
	var bit_flags:Int;
	var is_pending:Bool;
	var is_flagged:Bool;
	var is_deleted:Bool;
	var is_favorited:Bool;
	var is_note_locked:Bool;
	var is_status_locked:Bool;
	var is_rating_locked:Bool;
	var is_comment_locked:Bool;
	var is_comment_disabled:Bool;
	var locked_tags:Null<Array<String>>;
	var comment_count:Int;
	var last_commented_at:Null<String>;
	var last_comment_bumped_at:Null<String>;
	var last_noted_at:Null<String>;
	var bg_color:Null<String>;
	var video_samples:Dynamic;

	static function sterilize(d:Dynamic):Flat {
		return {
			id: d.id,
			created_at: d.created_at,
			updated_at: d.updated_at,
			uploader_id: d.uploader_id,
			approver_id: d.approver_id,
			score: d.score,
			up_score: d.up_score,
			down_score: d.down_score,
			fav_count: d.fav_count,
			rating: d.rating,
			md5: d.md5,
			source: d.source,
			description: d.description,
			file_ext: d.file_ext,
			file_size: d.file_size,
			file_url: d.file_url,
			image_width: d.image_width,
			image_height: d.image_height,
			sample_url: d.sample_url,
			preview_file_url: d.preview_file_url,
			has_sample: d.has_sample,
			duration: switch (Type.typeof(d.duration)) {
				case TNull: null;
				case TInt: d.duration;
				case TFloat: Std.int(d.duration);
				default: null;
			},
			tag_string: d.tag_string,
			tag_count: d.tag_count,
			tag_count_general: d.tag_count_general,
			tag_count_artist: d.tag_count_artist,
			tag_count_character: d.tag_count_character,
			tag_count_copyright: d.tag_count_copyright,
			tag_count_species: d.tag_count_species,
			tag_count_meta: d.tag_count_meta,
			tag_count_invalid: d.tag_count_invalid,
			tag_count_lore: d.tag_count_lore,
			tag_count_contributor: d.tag_count_contributor,
			parent_id: d.parent_id,
			has_children: d.has_children,
			has_active_children: d.has_active_children,
			has_visible_children: d.has_visible_children,
			children_ids: switch (Type.typeof(d.children_ids)) {
				case TInt: [d.children_ids];
				case TFloat: [Std.int(d.children_ids)];
				case TClass(Array): cast d.children_ids;
				default: [];
			},
			pool_ids: d.pool_ids,
			change_seq: d.change_seq,
			bit_flags: d.bit_flags,
			is_pending: d.is_pending,
			is_flagged: d.is_flagged,
			is_deleted: d.is_deleted,
			is_favorited: d.is_favorited,
			is_note_locked: d.is_note_locked,
			is_status_locked: d.is_status_locked,
			is_rating_locked: d.is_rating_locked,
			is_comment_locked: d.is_comment_locked,
			is_comment_disabled: d.is_comment_disabled,
			locked_tags: switch (Type.typeof(d.locked_tags)) {
				case TNull: null;
				case TClass(Array): [for (x in (d.locked_tags : Array<Dynamic>)) Std.string(x)];
				case TClass(String): [d.locked_tags];
				default: null;
			},
			comment_count: d.comment_count,
			last_commented_at: d.last_commented_at,
			last_comment_bumped_at: d.last_comment_bumped_at,
			last_noted_at: d.last_noted_at,
			bg_color: d.bg_color,
			video_samples: d.video_samples
		};
	}
}
