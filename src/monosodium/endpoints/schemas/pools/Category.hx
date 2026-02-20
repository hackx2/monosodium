package monosodium.endpoints.schemas.pools;

#if (haxe_ver >= 4.0) enum #else @:enum #end abstract Category(String) from String to String {
	final COLLECTION:Category = 'collection';
	final SERIES:Category = 'series';
}
