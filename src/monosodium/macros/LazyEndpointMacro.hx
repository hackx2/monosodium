package monosodium.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

/**
 * This class serves as a way to _hopefully_ reduce memory usage when using this library. \
 * This is done by only creating the class instance when, for example, the `post` endpoint variable has been referenced.
 * 
 * e.g. `api.bans.get(...);` which automatically initializes the bans endpoint.
 */
class LazyEndpointMacro {
    public macro static function build():Array<Field> {
        final fields:Array<Field> = Context.getBuildFields();
        final newFields:Array<Field> = [];

        for (field in fields) {
            var lazyMeta = null;
            for (m in field.meta) if (m.name == ":lazy") { lazyMeta = m; break; }

            if (lazyMeta != null) {
                switch field.kind {
                    case FVar(type, _):
                        final name:String = field.name;
                        final privName:String = "_" + name;

                        newFields.push({
                            name: privName,
                            access: [APrivate],
                            kind: FVar(type, null),
                            pos: field.pos
                        });

                        field.kind = FProp("get", "never", type);
                        
                        // force :isVar and :keep so the compiler doesn't skip / kill the getter method
                        field.meta.push({name: ":isVar", pos: field.pos});
                        field.meta.push({name: ":keep", pos: field.pos});

                        final typePath:TypePath = switch type {
                            case TPath(p): p;
                            default: Context.error("@:lazy requires an explicit type", field.pos);
                        };

                        // create the getter for the lazy endpoint loading..
                        newFields.push({
                            name: "get_" + name,
                            access: [APublic, AInline],
                            kind: FFun({
                                args: [],
                                ret: type,
                                expr: macro {
                                    if (this.$privName == null) {
                                        this.$privName = new $typePath(this);
                                    }
                                    return this.$privName;
                                }
                            }),
                            pos: field.pos
                        });

                    default:
                }
            }
        }
        return fields.concat(newFields);
    }
}
#end