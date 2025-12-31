package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class Score {
	var up:Int;
	var down:Int;
	var total:Int;

	static function sterilize(d:Dynamic):Score {
		return {
			up: d.up,
			down: d.down,
			total: d.total
		};
	}
}
