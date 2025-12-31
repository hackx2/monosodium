package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class Pool {
	var id:Int;
	var name:String;
	var updated_at:String;
	var creator_id:Int;
	var description:String;
	var is_active:Bool;
	var category:String;
	var post_ids:Array<Int>;
	var created_at:String;
	var creator_name:String;
	var post_count:Int;

	static function sterilize(data:Dynamic):Pool {
		return {
			id: data.id,
			name: data.name,
			description: data.description,
			is_active: data.is_active,
			category: data.category,
			post_ids: cast data.post_ids,
			creator_id: data.creator_id,
			creator_name: data.creator_name,
			created_at: data.created_at,
			updated_at: data.updated_at,
			post_count: data.post_count
		}
	}
}
