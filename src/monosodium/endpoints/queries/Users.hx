package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Users = {
	> Query,
	@:optional var search_id:Int;
	@:optional var search_ip_addr:String;
	@:optional var search_order:String;
	@:optional var search_name_matches:String;
	@:optional var search_about_me:String;
	@:optional var search_avatar_id:Int;
	@:optional var search_level:Int;
	@:optional var search_min_level:Int;
	@:optional var search_max_level:Int;
	@:optional var search_can_upload_free:Bool;
	@:optional var search_can_approve_posts:Bool;
	@:optional var search_email_matches:String;
}
