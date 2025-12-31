package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef AvoidPostings = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var creator_name:Null<String>;
		@:optional var creator_id:Null<String>;
		@:optional var any_name_matches:Null<String>;
		@:optional var artist_name:Null<String>;
		@:optional var artist_id:Null<String>;
		@:optional var any_other_name_matches:Null<String>;
		@:optional var details:Null<String>;
		@:optional var staff_notes:Null<String>;
		@:optional var is_active:Null<Bool>;
	};
}
