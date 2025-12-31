package monosodium;

import haxe.PosInfos;

class Utility {
	@:allow(monosodium)
	@:noPrivateAccess
	inline static function verboseTrace(wa:Dynamic, ?posInfos:PosInfos):Void {
		final str:String = '[  monosodium  |    VERBOSE    ] ' + wa;
		#if js
		if (js.Syntax.typeof(untyped console) != "undefined" && (untyped console).log != null)
			(untyped console).log(str);
		#elseif lua
		untyped __define_feature__("use._hx_print", _hx_print(str));
		#elseif sys
		Sys.println(str);
		#else
		throw new haxe.exceptions.NotImplementedException()
		#end
	}

	@:allow(monosodium)
	@:noPrivateAccess
	inline static function censorString(name:String):String {
		if (name.length <= 1)
			return "*";

		final buf:StringBuf = new StringBuf();
		buf.add(name.charAt(0));
		for (i in 1...name.length)
			buf.add("*");

		return buf.toString();
	}
}
