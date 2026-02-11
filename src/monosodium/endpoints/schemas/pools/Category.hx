package monosodium.endpoints.schemas.pools;

enum abstract Category(String) from String to String {
	final COLLECTION:Category = 'collection';
	final SERIES:Category = 'series';
}
