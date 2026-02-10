package monosodium.endpoints.queries;

import monosodium.endpoints.schemas.Artist;
import monosodium.endpoints.base.Query;

typedef ArtistUrls = #if (haxe_ver >= 4.0) Query & #end
{
	#if (haxe_ver < 4.0)
	> Query
	#end
	@:optional var search:{
		@:optional var id:Int;
		@:optional var order:String;
		@:optional var artist_name:String;
		@:optional var artist_id:String;
		@:optional var is_active:Bool;
		@:optional var url:String;
		@:optional var normalized_url:String;
		// Legacy nested search for artist. Supports the same parameters as /artists.json
		@:deprecated @:optional var artist:Null<Artist>;
		// Legacy name for search[url]
		@:deprecated @:optional var url_matches:Null<String>;
		// Legacy name for search[normalized_url]
		@:deprecated @:optional var normalized_url_matches:Null<String>;
	};
}
