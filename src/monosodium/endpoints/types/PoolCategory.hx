package monosodium.endpoints.types;

enum abstract PoolCategory(String) from String to String {
	final COLLECTION:PoolCategory = 'collection';
	final SERIES:PoolCategory = 'series';
}
