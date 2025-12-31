package monosodium.endpoints.schemas.post.samples;

@:structInit
@:publicFields
final class VideoVariant {
	var fps:Int;
	var codec:String;
	var size:Int;
	var width:Int;
	var height:Int;
	var url:String;

	static function sterilize(d:Dynamic):VideoVariant {
		return {
			fps: d.fps,
			codec: d.codec,
			size: d.size,
			width: d.width,
			height: d.height,
			url: d.url
		};
	}
}
