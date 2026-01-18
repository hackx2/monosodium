package monosodium.endpoints.schemas;

typedef ArtistVersion = {
	@:optional var id:Int;
	@:optional var artist_id:Int;
	@:optional var name:String;
	@:optional var updater_id:Int;
	@:optional var created_at:String;
	@:optional var updated_at:String;
	@:optional var is_active:Bool;
	@:optional var other_names:Array<String>;
	@:optional var notes_changed:Bool;
	@:optional var urls:Array<String>;
}
