package monosodium.endpoints.schemas;

import monosodium.endpoints.types.PoolCategory;

typedef Pool = {
    var id:Int;
    var name:String;
    var updated_at:String;
    var creator_id:Int;
    var description:String;
    var is_active:Bool;
    var category:PoolCategory;
    var post_ids:Array<Int>;
    var created_at:String;
    var creator_name:String;
    var post_count:Int;
}
