package monosodium.macros;

import haxe.macro.Context;
import haxe.macro.Expr;

class EndpointBuilder {
	public static function build():Array<Field> {
		final fields = Context.getBuildFields();

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
				meta: [{name: ":dox", params: [macro hide], pos: Context.currentPos()}],
				pos: Context.currentPos()
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
				pos: Context.currentPos()
			});
		}

		return fields;
	}
}
