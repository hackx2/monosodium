import monosodium.Monosodium;
import haxe.Resource;
import mini.Parser;
import mini.Ini;

class Main {
	static function main():Void {
		Monosodium.defaultVerboseMode = true;

		// Parse config file data
		// !!! MINI IS NOT BUNDLED WITH MONOSODIUM (https://github.com/hackx2/hxmini/) !!!
		final config:Ini = Parser.parse(Resource.getString('CONFIG'));

		// Create a new instance of the api wrapper
		final api:Monosodium = new Monosodium();

		// Change the site mirror
		api.mirror(monosodium.Mirror.E926);

		// Authorize (depends on what you're doing ^w^)
		api.authorize(config.get('USERNAME'), config.get('API_TOKEN'));

		// Get the first 4 bans, then trace their ban id
		api.bans.search({limit: 4}, e -> {
			for (i in e) {
				trace('#${i.id}');
			}
		}, error -> trace(error));

		// Get the ban #36366, then trace their user id
		api.bans.get(36366, e -> {
			trace(e.user_id);
		}, error -> trace(error));

		// Get post #12345, then return it's id and rating
		api.posts.get(12345, p -> {
			trace('Post #${p.id} has rating ${p.rating}');
		}, error -> trace(error));

		// Get a random post using the tags "gay" and "-female", then turn it's file url
		api.posts.random(["gay", "-female"], post -> {
			trace(post.preview.url);
		}, error -> trace(error));

		// Get 5 pools from the first page, then return its names
		api.pools.search({limit: 5, page: 1}, pools -> {
			for (p in pools) {
				trace(p.name);
			}
		}, error -> trace(error));

		// Get pool #12, then return it's name + post count
		api.pools.get(12, pool -> {
			trace('${pool.name} (${pool.post_count} posts)');
		}, error -> trace(error));

		// Get artist #123, then return their name
		api.artists.get(123, artist -> {
			trace(artist.name);
		}, error -> trace(error));
	}
}
