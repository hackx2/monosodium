package monosodium.endpoints.queries.artist;

typedef Create = {
	/**
	 * The artist's name.
	 */
	var name:String; // required

	/**
	 * Artist aliases. \
	 * Silently truncated to 25 entries and 100 characters.
	 */
	@:optional var other_names:Null<Array<String>>; 
	
	/**
	 * Separate names with spaces, not commas. Use underscores for spaces inside names. \
	 * Silently truncated to 25 entries. 
	 */
	@:optional var other_names_string:Null<String>;


	/**
	 * The artist's URLs \
	 * You can prefix a URL with `-` to mark it as dead. \
	 * Silently truncated to 25 entries. 
	 */
	@:optional var url_string:Null<String>;

	/**
	 * Artist description/notes. \
	 * Silently truncated to the wiki page limit (**250,000**)
	 */
	@:optional var notes:Null<String>;

	
	@:optional var group_name:Null<String>;

	/**
	 * This parameter requires you to be **Janitor+**
	 */
	@:optional var linked_user_id:Null<Int>;

	/**
	 * Whether the artist is locked or not. \
	 * This parameter requires you to be **Janitor+**
	 */
	@:optional var is_locked:Null<Bool>;
}
