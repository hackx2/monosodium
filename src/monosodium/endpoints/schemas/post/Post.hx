package monosodium.endpoints.schemas.post;

import monosodium.endpoints.schemas.post.samples.Sample;

typedef Post = {
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
}
