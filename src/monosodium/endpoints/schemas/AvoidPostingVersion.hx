package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class AvoidPostingVersion {
	var id:Int;
	var updater_id:Int;
	var avoid_posting_id:Int;
	var details:String;
	var staff_notes:String;
	var is_active:Bool;
	var updated_at:String;

	static function sterilize(data:Dynamic):AvoidPostingVersion {
		return {
			id: data.id,
			updater_id: data.updater_id,
			avoid_posting_id: data.avoid_posting_id,
			details: data.details,
			staff_notes: data.staff_notes,
			is_active: data.is_active,
			updated_at: data.updated_at
		};
	}
}
