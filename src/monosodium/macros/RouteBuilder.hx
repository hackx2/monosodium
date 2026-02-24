package monosodium.macros;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Compiler;

// :3
// this is so overkill :pensive:
final class RouteBuilder {
	public static macro function build():Array<Field> {
		final fields:Array<Field> = Context.getBuildFields();
		final cls:ClassType = Context.getLocalClass().get();

		var val:Null<String> = null;

		for (m in cls.meta.get()) {
			if (m.name == ":route" && m.params.length > 0) {
				switch m.params[0].expr {
					case EConst(CString(s, _)):
						val = s;
					default:
						Context.error("@:route must be a string", m.pos); // freakk
				}
			}
		}

		if (val != null) {
			fields.push({
				name: "route",
				access: [APublic, AInline, AStatic], // should we inline this? maybe...
				kind: FVar(macro :String, macro $v{val}),
				pos: Context.currentPos()
			});
		}

		return fields;
	}
}
#end
