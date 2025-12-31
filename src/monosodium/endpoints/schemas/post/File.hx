package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class File {
	var width:Int;
	var height:Int;
	var ext:String;
	var size:Int;
	var md5:String;
	var url:String;

	static function sterilize(d:Dynamic):File {
		return {
			width: d.width,
			height: d.height,
			ext: d.ext,
			size: d.size,
			md5: d.md5,
			url: d.url
		};
	}
}
