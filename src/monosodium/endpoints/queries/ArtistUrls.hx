package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef ArtistUrls = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var artist_name:Null<String>;
		@:optional var artist_id:Null<String>;
		@:optional var is_active:Null<Bool>;
		@:optional var url:Null<String>;
		@:optional var normalized_url:Null<String>;
	};
}
