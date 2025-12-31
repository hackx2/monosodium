package monosodium.endpoints.schemas.post.samples;

@:structInit
@:publicFields
final class VideoVariants {
	var webm:VideoVariants;
	var mp4:VideoVariants;

	static function sterilize(d:Dynamic):VideoVariants {
		return {
			webm: d.webm != null ? VideoVariants.sterilize(d.webm) : null,
			mp4: d.mp4 != null ? VideoVariants.sterilize(d.mp4) : null
		};
	}
}
