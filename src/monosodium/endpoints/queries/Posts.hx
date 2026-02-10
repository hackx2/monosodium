package monosodium.endpoints.queries;

import monosodium.endpoints.base.Query;

typedef Posts = #if (haxe_ver >= 4.0) Query & #end
{
	#if (haxe_ver < 4.0)
	> Query
	#end
	@:optional var tags:String;
	@:optional var md5:String;
	@:optional var random:String;
}
