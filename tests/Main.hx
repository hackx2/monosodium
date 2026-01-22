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

		// Get post #12345, then return it's id and rating
		api.posts.get(12345, p -> {
			trace('Post #${p.id} has rating ${p.rating}');
		});

		// Get a random post using the tags "gay" and "-female", then turn it's file url
		api.posts.random(["gay", "-female"], post -> {
			trace(post.preview.url);
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
