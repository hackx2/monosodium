package monosodium.net;

import haxe.http.HttpMethod;
import sys.net.Socket;
import haxe.io.BytesOutput;

// But nobody came
class Http extends haxe.Http {
	public var method:HttpMethod = Get;
	public var socket:Null<Socket>;

	public override function request(?post:Bool):Void {
		final output:BytesOutput = new BytesOutput();
		final old:(msg:String) -> Void = onError;
		var err:Bool = false;

		onError = (msg:String) -> {
			responseBytes = output.getBytes();
			err = true;
			onError = old;
			onError(msg);
		}

		post = post || postBytes != null || postData != null;
		customRequest(post, output, socket, method);
		if (!err)
			success(output.getBytes());
	}
}
