package monosodium.net.ratelimiter;

enum Request {
	PASS;
	CALL(fun:Void->Void);
}
