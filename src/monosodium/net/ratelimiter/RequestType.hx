package monosodium.net.ratelimiter;

@:pure
enum RequestType {
	PASS;
	CALL(fun:Void->Void);
}
