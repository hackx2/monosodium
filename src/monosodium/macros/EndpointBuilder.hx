package monosodium.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

final class EndpointBuilder {
	public static function build():Array<Field> {
		final fields:Array<Field> = Context.getBuildFields();
		final currentPosition:Position = Context.currentPos();

		var hasApi:Bool = false, hasNew:Bool = false;
		for (f in fields) {
			if (f.name == "api")
				hasApi = true;
			if (f.name == "new")
				hasNew = true;
		}

		if (!hasApi) {
			fields.push({
				name: "api",
				access: [APublic],
				kind: FVar(macro :monosodium.Monosodium),
				meta: [{name: ":dox", params: [macro hide], pos: currentPosition}],
				pos: currentPosition,
				doc: 'parent monosodium class reference'
			});
		}

		if (!hasNew) {
			fields.push({
				name: "new",
				access: [APublic],
				kind: FFun({
					args: [{name: "api", type: macro :monosodium.Monosodium}],
					ret: macro :Void,
					expr: macro {
						untyped this.api = api;
					}
				}),
				meta: [{name: ":dox", params: [macro hide], pos: currentPosition}],
				pos: currentPosition
			});
		}

		return fields;
	}
}
#end