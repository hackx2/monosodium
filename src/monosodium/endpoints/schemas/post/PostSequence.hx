package monosodium.endpoints.schemas.post;

#if (haxe_ver >= 4.0) enum #else @:enum #end abstract PostSequence(String) from String to String {
	final NEXT:PostSequence = 'next';
	final PREVIOUS:PostSequence = 'prev';
}
