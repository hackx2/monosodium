package monosodium.endpoints.queries;

import monosodium.endpoints.schemas.pools.Category;
import monosodium.endpoints.base.Query;

typedef Pools = #if (haxe_ver >= 4.0) Query & #end
{
	#if (haxe_ver < 4.0)
	> Query
	#end
	@:optional var search:{
		@:optional var id:Int;
		@:optional var order:String;
		@:optional var name:String;
		@:optional var description:String;
		@:optional var creator_name:String;
		@:optional var creator_id:Int;
		@:optional var category:Category;
		@:optional var is_active:Bool;
	};
}
