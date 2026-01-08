package monosodium;

import haxe.PosInfos;

class Utility {
	@:allow(monosodium)
	@:noPrivateAccess
	inline static function verboseTrace(message:Dynamic, ?posInfos:PosInfos):Void {
		final str:String = '[  monosodium  |    VERBOSE    ] $message';
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
	inline static function censorString(input:String):String { // fast but lacks accuracy
		if(input == null) return '';
		if (input.length <= 1) return "*";

		final buf:StringBuf = new StringBuf();

		// append the first character
		buf.add(input.charAt(0));

		// iteratate thru the input's length, and append an asterix
		for (i in 1...input.length) buf.add("*");

		return buf.toString();
	}
}
