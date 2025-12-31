package monosodium.endpoints.schemas.post.samples;

@:structInit
@:publicFields
final class Sample {
	var has:Bool;
	var height:Int;
	var width:Int;
	var url:String;
	var alternates:Alternates;

	static function sterilize(d:Dynamic):Sample {
		return {
			has: d.has,
			height: d.height,
			width: d.width,
			url: d.url,
			alternates: d.alternates != null ? Alternates.sterilize(d.alternates) : Alternates.empty()
		};
	}
}
