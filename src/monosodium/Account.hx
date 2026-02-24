package monosodium;

@:keep
final class Account {
	public var username:String;
	@:unreflective public var token:String;

	public function new(username:String, token:String):Void {
		this.username = username;
		this.token = token;
	}
}
