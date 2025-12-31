package monosodium.endpoints.base;

@:route('/') // isn't needed but eh
class Endpoint {
	// find a better alternative.. maybe using the mirror abstract and adding "https://" & ".net"??
	public inline static final e6:String = 'https://e621.net';
	public inline static final e9:String = 'https://e926.net';

	@:dox(hide) var api:Monosodium;

	public function new(api:Monosodium):Void
		this.api = api;
}
