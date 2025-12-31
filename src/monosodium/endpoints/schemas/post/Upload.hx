package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class Upload {
	var file:Null<String>;
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
