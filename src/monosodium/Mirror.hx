package monosodium;

// Despite everything, it's still you...
enum abstract Mirror(String) from String to String {
	final E621:Mirror = "e621"; // nsfw, sfw & questionable
	final E926:Mirror = "e926"; // sfw & questionable

	/// find an alternative 
	public var url(get,never):String; // https://<mirror>.net
	@:noCompletion function get_url():String return 'https://$this.net';
}
