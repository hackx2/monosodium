package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class Flags {
	var pending:Bool;
	var flagged:Bool;
	var note_locked:Bool;
	var status_locked:Bool;
	var rating_locked:Bool;
	var deleted:Bool;

	static function sterilize(d:Dynamic):Flags {
		return {
			pending: d.pending,
			flagged: d.flagged,
			note_locked: d.note_locked,
			status_locked: d.status_locked,
			rating_locked: d.rating_locked,
			deleted: d.deleted
		};
	}
}
