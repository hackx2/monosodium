package monosodium.net.ratelimiter;

@:keep
enum RequestType {
	PASS;
	CALL(fun:Void->Void);
}
