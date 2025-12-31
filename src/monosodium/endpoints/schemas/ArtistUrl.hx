package monosodium.endpoints.schemas;

import monosodium.endpoints.schemas.Artist;

@:structInit
@:publicFields
final class ArtistUrl extends Url {
	var artist:Artist;

	static function sterilize(data:Dynamic):ArtistUrl {
		return {
			id: data.id,
			artist_id: data.artist_id,
			url: data.url,
			normalized_url: data.normalized_url,
			created_at: data.created_at,
			updated_at: data.updated_at,
			is_active: data.is_active,
			artist: Artist.sterilize(data.artist)
		};
	}
}
