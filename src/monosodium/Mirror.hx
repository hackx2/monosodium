package monosodium;

// Despite everything, it's still you...
#if (haxe_ver >= 4.0) enum #else @:enum #end abstract Mirror(String) from String to String {
	final E621:Mirror = "e621"; // nsfw, sfw & questionable
	final E926:Mirror = "e926"; // sfw

	/// find an alternative 
	public var url(get,never):String; // https://<mirror>.net
	@:noCompletion inline function get_url():String {
		return untyped "https://" + this + ".net";
	};
}
