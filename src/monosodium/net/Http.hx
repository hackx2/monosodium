package monosodium.net;

import monosodium.net.Header;

import haxe.Json;
import haxe.io.Bytes;
import haxe.io.BytesOutput;
import haxe.crypto.Base64;
import haxe.http.HttpMethod;
import haxe.extern.EitherType;
import haxe.exceptions.NotImplementedException;

#if nodejs
import haxe.DynamicAccess;
import js.html.URLSearchParams;
import js.node.buffer.Buffer;
#elseif sys
import sys.net.Socket;
#end

using StringTools;

class Http {
	public static inline final USER_AGENT:String = 'hackx2@monosodium/1.0';

	public var url:Null<String> = null;
	public var method:HttpMethod = Get;
	public var headers:Array<Header> = [];
	public var parameters:Array<Parameter> = [];

	#if (sys && !nodejs)
	public var socket:Null<Socket>;
	#end

	var postData:Null<String>;
	var postBytes:Null<Bytes>;

	public function new(url:String):Void this.url = url;

	public function request(?post:Bool):Void {
		#if nodejs
		var fullUrl = url;
		if (parameters != null && (method == Get || method == Head || method == Delete)) {
			final searchParams = new URLSearchParams(untyped Utility.buildRequestBody(parameters));
			fullUrl += (fullUrl.contains("?") ? "&" : "?") + Std.string(searchParams);
		}

		final h:DynamicAccess<String> = {
			"User-Agent": Http.USER_AGENT,
			"Accept": "application/json"
		};
		for (i in headers) h.set(i.name, i.value);

		final options:Dynamic = {
			method: Std.string(method).toUpperCase(),
			headers: h
		};

		if (postData != null) {
			options.body = (untyped JSON).stringify(Utility.buildRequestBody(postData));
			h.set("Content-Type", "application/json");
		} else if (parameters != null) {
			switch (method) {
				case Post | Put | Patch | Delete:
					options.body = (untyped JSON).stringify(untyped Utility.buildRequestBody(parameters));
					h.set("Content-Type", "application/json");
				default:
			}
		}

		final p = untyped fetch(fullUrl, options);
		p.then((res:Dynamic) -> {
			@:nullSafety(Off) this.onStatus(res.status);
			return res.text();
		}).then((data:String) -> {
			this.onData(data);
		});

		// Reflect (field / callMethod) causes an overhead, while this doesn't
		untyped p["catch"]((err:Dynamic) -> {
			@:nullSafety(Off) this.onError(Std.string(err));
		});

		#else
		final http = new haxe.Http(url);
		for (i in headers) http.addHeader(i.name, i.value);
		for (i in parameters) http.setParameter(i.name, i.value);
		
		if (postData != null) http.setPostData(postData);
		if (postBytes != null) http.setPostBytes(postBytes);

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
		#if (sys && !js)
		http.customRequest(post, output, socket, method);
		#else
		http.request(post);
		#end
		if (!err) {
			@:privateAccess http.success(output.getBytes());
		}
		#end
	}

	public function send() {
		throw NotImplementedException;
	}

	// HELPER FUNCTIONS
	public function addHeader(name:String, value:Dynamic):Void headers.push(new Header(name, value));
	public function setParameter(name:String, value:Dynamic):Void parameters.push(new Parameter(name, value));
	
	public function setPostData(postData:String):Void this.postData = postData;
	public function setPostBytes(postBytes:Bytes):Void this.postBytes = postBytes;

	// EVENT HOOKS
	dynamic public function onData(_:String):Void {}
	dynamic public function onError(_:String):Void {}
	dynamic public function onStatus(_:Int):Void {}
}
