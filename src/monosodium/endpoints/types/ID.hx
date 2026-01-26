package monosodium.endpoints.types;

import haxe.extern.EitherType;

abstract ID(String) from String {
	@:from public static inline function fromInt(value:Int):ID
		return new ID(Std.string(value));

	@:to public inline function toString():String
		return this;

	inline function new(value:String):ID
		this = value;
}
