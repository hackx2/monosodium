package monosodium.endpoints.base;

@:route('/') // isn't needed but eh
@:autoBuild(monosodium.macros.RouteBuilder.build())
abstract class Endpoint {
	@:dox(hide) var api:Monosodium;
	public function new(api:Monosodium):Void this.api = api;
}
