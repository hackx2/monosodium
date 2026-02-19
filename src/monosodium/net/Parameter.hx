package monosodium.net;

@:structInit @:publicFields 
class Parameter {
	var name:String;
	var value:Dynamic;

    inline function new(name:String, value:Dynamic):Void {
        this.name = name;
        this.value = value;
    }

    public inline function toString():String {
        return '{name: $name, value: $value}';
    }
}
