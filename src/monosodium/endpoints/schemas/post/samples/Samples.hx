package monosodium.endpoints.schemas.post.samples;

@:structInit
@:publicFields
final class Samples {
	var _480p:VideoVariants; // 480p
	var _720p:VideoVariants; // 720p

	static function sterilize(d:Dynamic):Samples {
		if (d == null) return null;

		return untyped {
			_480p: (d.__field__("480p") != null) ? VideoVariants.sterilize(d.__field__("480p")) : null,
			_720p: (d.__field__("720p") != null) ? VideoVariants.sterilize(d.__field__("720p")) : null
		};
	}
}
