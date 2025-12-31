package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class PostDisapproval {
	var id:Int;
	var user_id:Int;
	var post_id:Int;
	var reason:String;
	var message:String;
	var created_at:String;
	var updated_at:String;

	static function sterilize(data:Dynamic):PostDisapproval {
		return {
			id: data.id,
			user_id: data.user_id,
			post_id: data.post_id,
			reason: data.reason,
			message: data.message,
			created_at: data.created_at,
			updated_at: data.updated_at
		};
	}
}
