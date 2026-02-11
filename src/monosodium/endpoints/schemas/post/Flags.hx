package monosodium.endpoints.schemas.post;

typedef Flags = {
	var pending:Bool;
	var flagged:Bool;
	var note_locked:Bool;
	var status_locked:Bool;
	var rating_locked:Bool;
	var deleted:Bool;
}
