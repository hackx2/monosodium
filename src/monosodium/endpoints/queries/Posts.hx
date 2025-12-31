package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Posts = {
	> Query,
	@:optional var tags:String;
	@:optional var md5:String;
	@:optional var random:String;
}
