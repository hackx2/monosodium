package monosodium.endpoints.schemas;

@:structInit
@:publicFields
final class ArtistVersion {
	var id:Int;
	var artist_id:Int;
	var name:String;
	var updater_id:Int;
	var created_at:String;
	var updated_at:String;
	var is_active:Bool;
	var other_names:Array<String>;
	var notes_changed:Bool;
	var urls:Array<String>;

	static function sterilize(data:Dynamic):ArtistVersion {
		return {
			id: data.id,
			artist_id: data.artist_id,
			name: data.name,
			updater_id: data.updater_id,
			created_at: data.created_at,
			updated_at: data.updated_at,
			is_active: data.is_active,
			other_names: data.other_names != null ? cast data.other_names : [],
			notes_changed: data.notes_changed,
			urls: data.urls != null ? cast data.urls : []
		};
	}
}
