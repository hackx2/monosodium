package monosodium.endpoints.schemas.tag;

@:structInit
@:publicFields
final class Preview {
	var id:Int;
	var name:String;
	var resolved:String;
	var category:Int;
	var post_count:Int;
	var alias:String;
	var implies:Array<String>;

	static function sterilize(data:Dynamic):Preview {
		return {
			id: data.id,
			name: data.name,
			resolved: data.resolved,
			category: data.category,
			post_count: data.post_count,
			alias: data.alias,
			implies: data.implies != null ? cast data.implies : []
		};
	}
}
