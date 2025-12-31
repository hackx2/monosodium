package monosodium.endpoints.schemas.tag;

@:structInit
@:publicFields
final class Correction {
	var post:Dynamic;
	var tag:Tag;

	static function sterilize(data:Dynamic):Correction {
		return {
			post: data.post,
			tag: Tag.sterilize(data.post.tag)
		};
	}
}
