package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class Tags {
	var general:Array<String>;
	var artist:Array<String>;
	var copyright:Array<String>;
	var character:Array<String>;
	var species:Array<String>;
	var invalid:Array<String>;
	var meta:Array<String>;
	var lore:Array<String>;
	var contributor:Array<String>;

	static function sterilize(d:Dynamic):Tags {
		return {
			general: cast d.general,
			artist: cast d.artist,
			copyright: cast d.copyright,
			character: cast d.character,
			species: cast d.species,
			invalid: cast d.invalid,
			meta: cast d.meta,
			lore: cast d.lore,
			contributor: cast d.contributor
		};
	}
}
