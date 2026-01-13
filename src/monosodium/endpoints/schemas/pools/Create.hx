package monosodium.endpoints.schemas.pools;

import monosodium.endpoints.types.PoolCategory;

typedef Create = {
    var pool:{
        var name:String;
        @:optional var description:String;
        @:optional var category:PoolCategory;
        @:optional var post_ids_string:String;
        @:optional var post_ids:Array<Int>;
    };

    var ipool:{ // e621.wiki // u sure this is correct???
        @:optional var is_active:Bool;
    };
}
