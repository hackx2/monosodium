package monosodium.endpoints.schemas.post;

import monosodium.endpoints.schemas.post.samples.Sample;

@:structInit
@:publicFields
final class Post {
	var id:Int;
	var created_at:String;
	var updated_at:String;

	var file:File;
	var preview:Preview;
	var sample:Sample;
	var score:Score;
	var tags:Tags;

	var locked_tags:Array<String>;
	var change_seq:Int;
	var flags:Flags;
	var rating:String;
	var fav_count:Int;
	var sources:Array<String>;
	var pools:Array<Int>;
	var relationships:Relationships;

	var approver_id:Null<Int>;
	var uploader_id:Int;
	var description:String;
	var comment_count:Int;
	var is_favorited:Bool;
	var has_notes:Bool;
	var duration:Null<Int>;
	var uploader_name:String;

	static function sterilize(d:Dynamic):Post {
		return {
			id: d.id,
			created_at: d.created_at,
			updated_at: d.updated_at,

			file: File.sterilize(d.file),
			preview: Preview.sterilize(d.preview),
			sample: Sample.sterilize(d.sample),
			score: Score.sterilize(d.score),
			tags: Tags.sterilize(d.tags),

			locked_tags: d.locked_tags != null ? cast d.locked_tags : [],
			change_seq: d.change_seq,
			flags: Flags.sterilize(d.flags),
			rating: d.rating,
			fav_count: d.fav_count,
			sources: d.sources != null ? cast d.sources : [],
			pools: d.pools != null ? cast d.pools : [],
			relationships: Relationships.sterilize(d.relationships),

			approver_id: d.approver_id,
			uploader_id: d.uploader_id,
			description: d.description,
			comment_count: d.comment_count,
			is_favorited: d.is_favorited,
			has_notes: d.has_notes,
			duration: d.duration,
			uploader_name: d.uploader_name
		};
	}
}
