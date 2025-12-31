package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef PostDisapprovals = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var creator_id:Null<Int>;
		@:optional var creator_name:Null<String>;
		@:optional var post_id:Null<Int>;
		@:optional var message:Null<String>;
		@:optional var post_tags_match:Null<String>;
		@:optional var reason:Null<String>;
		@:optional var has_message:Null<Bool>;
	};
}
