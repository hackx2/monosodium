package monosodium.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.http.HttpMethod;

using StringTools;

final class RequestBuilder {
	static final validMethods:Array<String> = ["GET", "POST", "PUT", "PATCH", "DELETE"];

	public static function build():Array<Field> {
		final fields:Array<Field> = Context.getBuildFields();

		for (field in fields) {
			for (m in validMethods) {
				for (meta in field.meta) {
					if (meta.name.replace(":", "") != m) continue;

					field.access = field.access.filter(access -> return !access.match(APrivate));
                    if (!field.access.contains(APublic)) {
                        field.access.push(APublic);
                    }

					final isPost:Bool = (m == "POST" || m == "PUT" || m == "PATCH"); // || (meta.params.length > 0 && meta.params[0].expr.match(EConst(CIdent("true"))));

					switch (field.kind) {
						case FFun(f):
							final _exprThingy:Null<Expr> = f.expr;
							f.expr = macro {
								final _struct:monosodium.endpoints.types.RequestStruct = $_exprThingy;
								api.request(_struct.url, $v{isPost}, (cast $v{(m : String)} : haxe.http.HttpMethod), _struct.callbacks.success, _struct.callbacks.error, _struct.callbacks.status, _struct.params, _struct.body);
							};
						default:
                            Context.error('@:${m} can only be used on methods', field.pos);
					}
				}
			}
		}
		return fields;
	}
}
#end
