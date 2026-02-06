package monosodium.endpoints.schemas;

typedef Ban = {
	var id:Int;
	var user_id:Int;
	var reason:String;
	var expires_at:Null<String>;
	var banner_id:Int;
	var created_at:String;
	var updated_at:String;
}
