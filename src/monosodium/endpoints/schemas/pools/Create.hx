package monosodium.endpoints.schemas.pools;

typedef Create = {
	var name:String;
	@:optional var description:String;
	@:optional var category:Category;
	@:optional var post_ids_string:String;
	@:optional var post_ids:Array<Int>;
	@:optional var is_active:Bool;
}
