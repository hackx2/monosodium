package monosodium.endpoints.schemas.post;

import haxe.io.Bytes;

typedef Upload = {
	var file:Null<Bytes>;
	var direct_url:Null<String>;
	var tag_string:String;
	var rating:String;
	var source:Null<String>;
	var parent_id:Null<Int>;
	var description:Null<String>;
	var as_pending:Bool;
	var locked_rating:Bool;
	var locked_tags:Null<String>;
}
