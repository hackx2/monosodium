package monosodium.endpoints.queries;

import monosodium.endpoints.types.PoolCategory;
import monosodium.endpoints.base.Query;

typedef Pools = {
	> Query,

	@:optional var search:{
		@:optional var id:Int;
		@:optional var order:String;
		@:optional var name:String;
		@:optional var description:String;
		@:optional var creator_name:String;
		@:optional var creator_id:Int;
		@:optional var category:PoolCategory;
		@:optional var is_active:Bool;
	};
}