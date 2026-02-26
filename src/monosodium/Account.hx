package monosodium;

final class Account {
	public var username(default, null):String;
	@:unreflective public var token(default, null):String;

	inline public function setUsername(username:String):String {
		return this.username = username;
	}

	inline public function setToken(token:String):String {
		return this.token = token;
	}

	public function new(username:String, token:String):Void {
		this.username = username;
		this.token = token;
	}
}
