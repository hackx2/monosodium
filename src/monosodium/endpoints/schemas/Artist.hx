package monosodium.endpoints.schemas;

typedef Artist = {
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
} 