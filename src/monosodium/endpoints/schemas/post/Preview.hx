package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class Preview {
	var width:Int;
	var height:Int;
	var url:String;

	static function sterilize(d:Dynamic):Preview {
		return {
			width: d.width,
			height: d.height,
			url: d.url
		};
	}
}
