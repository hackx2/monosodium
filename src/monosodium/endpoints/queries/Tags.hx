package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Tags = #if (haxe_ver >= 4.0) Query & #end
{
	#if (haxe_ver < 4.0)
	> Query
	#end
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
