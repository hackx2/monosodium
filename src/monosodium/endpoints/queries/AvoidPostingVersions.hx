package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef AvoidPostingVersions = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var ip_addr:Null<String>;
		@:optional var order:Null<String>;
		@:optional var updater_name:Null<String>;
		@:optional var updater_id:Null<String>;
		@:optional var any_name_matches:Null<String>;
		@:optional var artist_name:Null<String>;
		@:optional var artist_id:Null<Int>;
		@:optional var any_other_name_matches:Null<String>;
		@:optional var group_name:Null<String>;
		@:optional var is_active:Null<Bool>;
	};
}
