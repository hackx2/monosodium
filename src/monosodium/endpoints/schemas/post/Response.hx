package monosodium.endpoints.schemas.post;

typedef Response = 
{
    success:Bool,
    ?location:String,
    ?post_id:Int,
    ?reason:String,
    ?code:String
}