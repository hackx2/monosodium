package monosodium.endpoints.schemas.post;

@:structInit
@:publicFields
final class Relationships {
	var parent_id:Null<Int>;
	var has_children:Bool;
	var has_active_children:Bool;
	var children:Array<Int>;

	static function sterilize(d:Dynamic):Relationships {
		return {
			parent_id: d.parent_id,
			has_children: d.has_children,
			has_active_children: d.has_active_children,
			children: d.children != null ? cast d.children : []
		};
	}
}
