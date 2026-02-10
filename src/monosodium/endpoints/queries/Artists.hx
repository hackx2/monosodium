package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Artists = #if (haxe_ver >= 4.0) Query & #end
{
	#if (haxe_ver < 4.0)
	> Query
	#end
	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var name:Null<String>;
		@:optional var group_name:Null<String>;
		@:optional var any_other_name_like:Null<String>;
		@:optional var any_name_matches:Null<String>;
		@:optional var any_name_or_url_matches:Null<String>;
		@:optional var url_matches:Null<String>;
		@:optional var creator_name:Null<String>;
		@:optional var creator_id:Null<String>;
		@:optional var has_tag:Null<String>;
		@:optional var is_linked:Null<String>;
	};
}
