package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class AvoidPosting {
	var id:Int;
	var creator_id:Int;
	var updater_id:Int;
	var artist_id:Int;
	var staff_notes:String;
	var details:String;
	var is_active:Bool;
	var created_at:String;
	var updated_at:String;

	static function sterilize(data:Dynamic):AvoidPosting {
		return {
			id: data.id,
			creator_id: data.creator_id,
			updater_id: data.updater_id,
			artist_id: data.artist_id,
			staff_notes: data.staff_notes,
			details: data.details,
			is_active: data.is_active,
			created_at: data.created_at,
			updated_at: data.updated_at
		};
	}
}
