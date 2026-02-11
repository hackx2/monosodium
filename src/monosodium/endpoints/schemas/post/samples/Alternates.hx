package monosodium.endpoints.schemas.post.samples;

@:structInit
@:publicFields
final class Alternates {
	var has:Bool;
	var original:VideoVariant;
	var variants:VideoVariants;
	var samples:Samples;

	static function sterilize(d:Dynamic):Alternates {
		return {
			has: d.has,
			original: d.original != null ? d.original : null,
			variants: d.variants != null ? d.variants : null,
			samples: d.samples != null ? Samples.sterilize(d.samples) : null
		};
	}

	static function empty():Alternates {
		return {
			has: false,
			original: null,
			variants: null,
			samples: null
		};
	}
}
