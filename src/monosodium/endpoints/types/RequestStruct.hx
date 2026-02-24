package monosodium.endpoints.types;

typedef RequestStruct = {
	url:String,
	?callbacks:{
		?success:Dynamic->Void,
		?error:String->Void,
		?status:Int->Void,
	},
	?params:Dynamic,
	?body:Dynamic,
}
