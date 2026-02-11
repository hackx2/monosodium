package monosodium.endpoints.schemas;

typedef PostDisapproval = {
	var id:Int;
	var user_id:Int;
	var post_id:Int;
	var reason:String;
	var message:String;
	var created_at:String;
	var updated_at:String;
}
