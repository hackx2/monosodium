package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Tags = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var fuzzy_name_matches:Null<String>;
		@:optional var name_matches:Null<String>;
		@:optional var name:Null<String>;
		@:optional var category:Null<Int>;
		@:optional var hide_empty:Null<Bool>;
		@:optional var has_wiki:Null<Bool>;
		@:optional var has_artist:Null<Bool>;
	};
}
