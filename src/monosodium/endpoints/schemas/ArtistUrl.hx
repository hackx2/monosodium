package monosodium.endpoints.schemas;

import monosodium.endpoints.schemas.Artist;

typedef ArtistUrl = #if (haxe_ver >= 4.0) Url & #end
{
	#if (haxe_ver < 4.0)
	> Url
	#end
	var artist:Artist;
} 