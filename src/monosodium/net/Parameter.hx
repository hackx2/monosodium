package monosodium.net;

@:structInit
@:publicFields
class Parameter {
	var name:String;
	var value:Dynamic;

    function new(name:String, value:Dynamic):Void {
        this.name = name;
        this.value = value;
    }

    @:to
    function toString():String {
        return '{name: $name, value: $value}';
    }
}
