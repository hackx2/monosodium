package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef ArtistVersions = {
	> Query,

	@:optional var search:{
		@:optional var id:Null<Int>;
		@:optional var order:Null<String>;
		@:optional var name:Null<String>;
		@:optional var artist_id:Null<Int>;
		@:optional var updater_name:Null<String>;
		@:optional var updater_id:Null<Int>;
	};
}
