package monosodium.endpoints.schemas.tag;

@:structInit
@:publicFields
final class Tag {
	var id:Int;
	var name:String;
	var post_count:Int;
	var related_tags:Array<String>;
	var related_tags_updated_at:String;
	var category:Int;
	var is_locked:Bool;
	var created_at:String;
	var updated_at:String;

	static function sterilize(data:Dynamic):Tag {
		return {
			id: data.id,
			name: data.name,
			post_count: data.post_count,
			related_tags: data.related_tags != null ? (Std.isOfType(data.related_tags,
				String) ? (cast data.related_tags : String).split(" ") : cast data.related_tags) : [],
			related_tags_updated_at: data.related_tags_updated_at,
			category: data.category,
			is_locked: data.is_locked,
			created_at: data.created_at,
			updated_at: data.updated_at
		};
	}
}
