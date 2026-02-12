package monosodium.net;

#if !nodejs

import haxe.io.Bytes;
import haxe.DynamicAccess;
import haxe.io.BytesOutput;
import haxe.http.HttpMethod;
import monosodium.net.Header;
import haxe.extern.EitherType;
import monosodium.net.Parameter;
import haxe.exceptions.NotImplementedException;
import haxe.Http as HttpSource;
#if sys
import sys.net.Socket;
#end

using StringTools;

#end

// SUPPORTS: sys, nodejs
// SYS: YES
// NODEJS: No
// But nobody came
class Http {
	public static inline final USER_AGENT:String = 'hackx2@monosodium/1.0';
#if !nodejs
	public var url:Null<String> = null;
	public var method:HttpMethod = Get;
	public var headers:Array<Header> = [];
	public var parameters:Array<Parameter> = [];

	#if (!js)
	public var socket:Null<Socket>;
	#end

	var postData:Null<String>;
	var postBytes:Null<Bytes>;

	public function new(url:String):Void this.url = url;

	public function request(?post:Bool):Void {
		final http = new HttpSource(url);
		for (i in headers) {
			http.addHeader(i.name, i.value);
		}
		for (i in parameters) {
			http.setParameter(i.name, i.value);
		}
		if (postData != null) {
			http.setPostData(postData);
		}
		if (postBytes != null) {
			http.setPostBytes(postBytes);
		}

		http.onData = onData;
		http.onError = onError;
		http.onStatus = onStatus;

		final output:BytesOutput = new BytesOutput();
		var err:Bool = false;
		http.onError = (error:String) -> {
			@:privateAccess http.responseBytes = output.getBytes();
			err = true;
			http.onError = onError;
			onError(error);
		}
		post = post || postBytes != null || postData != null;
		#if (!js)
		http.customRequest(post, output, socket, method);
		#else
		http.request(post);
		#end
		if (!err) {
			@:privateAccess http.success(output.getBytes());
		}
	}

	public function send() {
		throw NotImplementedException;
	}

	// HELPER FUNCTIONS
	public function addHeader(name:String, value:Dynamic):Void {
		headers.push(new Header(name, value));
	}

	public function setParameter(name:String, value:Dynamic):Void {
		parameters.push(new Parameter(name, value));
	}

	public function setPostData(postData:String):Void {
		this.postData = postData;
	}

	public function setPostBytes(postBytes:Bytes):Void {
		this.postBytes = postBytes;
	}

	// EVENT HOOKS
	dynamic public function onData(_:String):Void {}
	dynamic public function onError(_:String):Void {}
	dynamic public function onStatus(_:Int):Void {}
	#end
}