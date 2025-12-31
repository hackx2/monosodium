package monosodium.endpoints.schemas;

@:structInit
@:publicFields
class Url {
	var id:Int;
	var artist_id:Int;
	var url:String;
	var normalized_url:String;
	var created_at:String;
	var updated_at:String;
	var is_active:Bool;
}
