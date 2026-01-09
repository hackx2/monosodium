package monosodium.endpoints.queries.artist;

typedef Create = {
	var name:String; // required

	/**
	 * Each entry is limited to 100 character.
	 * Max 25 entries.
	 */
	@:optional var other_names:Null<Array<String>>;  
	@:optional var other_names_string:Null<String>;
	@:optional var url_string:Null<String>;

	/**
	 * 250,000 character limit
	 */
	@:optional var notes:Null<String>;
	@:optional var group_name:Null<String>;

	/**
	 * Janitor+
	 */
	@:optional var linked_user_id:Null<Int>;

	/**
	 * Janitor+
	 */
	@:optional var is_locked:Null<Bool>;
}
