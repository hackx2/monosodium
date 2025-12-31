package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Bans = {
	> Query,

	@:optional var search_id:Int;
	@:optional var search_order:String;
	@:optional var search_banner_id:String;
	@:optional var search_banner_name:String;
	@:optional var search_user_id:String;
	@:optional var search_user_name:String;
	@:optional var search_reason_matches:String;
	@:optional var search_expired:String;
}
