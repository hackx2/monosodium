package monosodium.endpoints.schemas.post;

typedef UpdatePost = {
    @:optional var tag_string:String;
    @:optional var old_tag_string:String;
    @:optional var tag_string_diff:String;
    @:optional var source_diff:String;
    @:optional var source:String;
    @:optional var old_source:String;
    @:optional var parent_id:Int;
    @:optional var old_parent_id:Int;
    @:optional var description:String;
    @:optional var old_description:String;
    @:optional var rating:String;
    @:optional var old_rating:String;
    @:optional var edit_reason:String;
}