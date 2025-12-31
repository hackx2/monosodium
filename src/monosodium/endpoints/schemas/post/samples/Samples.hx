package monosodium.endpoints.schemas.post.samples;

@:structInit
@:publicFields
final class Samples {
	var _480p:VideoVariants; // 480p
	var _720p:VideoVariants; // 720p

	static function sterilize(d:Dynamic):Samples {
		return {
			_480p: Reflect.hasField(d, "480p") ? VideoVariants.sterilize(Reflect.field(d, "480p")) : null,
			_720p: Reflect.hasField(d, "720p") ? VideoVariants.sterilize(Reflect.field(d, "720p")) : null
		};
	}
}
