package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Pools = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var name:Null<String>;
		@:optional var description:Null<String>;
		@:optional var creator_name:Null<String>;
		@:optional var creator_id:Null<Int>;
		@:optional var category:Null<Category>;
		@:optional var is_active:Null<Bool>;
	};
}

enum abstract Category(String) from String to String {
	final COLLECTION:Category = 'collection';
	final SERIES:Category = 'series';
}
