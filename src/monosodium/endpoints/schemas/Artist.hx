package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class Artist {
	var id:Int;
	var name:String;
	var updated_at:String;
	var is_active:Bool;
	var other_names:Array<String>;
	var group_name:String;
	var linked_user_id:Int;
	var created_at:String;
	var creator_id:Int;
	var is_locked:Bool;
	var notes:String;
	var domains:Array<Array<Dynamic>>; // str, int
	var urls:Array<Url>;

	static function sterilize(data:Dynamic):Artist {
		return {
			id: data.id,
			name: data.name,
			updated_at: data.updated_at,
			is_active: data.is_active,
			other_names: (data.other_names == null ? [] : cast data.other_names),
			group_name: data.group_name,
			linked_user_id: data.linked_user_id,
			created_at: data.created_at,
			creator_id: data.creator_id,
			is_locked: data.is_locked,
			notes: data.notes,
			domains: (data.domains == null ? [] : cast data.domains),
			urls: data.urls == null ? [] : cast data.urls
		};
	}
}
