package monosodium.endpoints.schemas.pools;

import monosodium.endpoints.types.PoolCategory;

typedef Create = {
	var name:String;
	@:optional var description:String;
	@:optional var category:PoolCategory;
	@:optional var post_ids_string:String;
	@:optional var post_ids:Array<Int>;
	@:optional var is_active:Bool;
}
