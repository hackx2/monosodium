package monosodium.endpoints.base;

@:autoBuild(monosodium.macros.RouteBuilder.build())
@:autoBuild(monosodium.macros.EndpointBuilder.build())
@:autoBuild(monosodium.macros.RequestBuilder.build())
interface Endpoint {}