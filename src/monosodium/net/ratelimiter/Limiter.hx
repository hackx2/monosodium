package monosodium.net.ratelimiter;

import monosodium.net.ratelimiter.Request;
import haxe.Timer;

/**
 * lacks a few features, but eh.. who cares?
 */

@:nullSafety
class Limiter {
	public var rate:Float;
	public var burst:Int;

	var tokens:Float;
	@:dox(hide) var lastStamp:Float;

	var running:Bool = false; // mrrp.

	public var queue:Array<Request> = new Array<Request>();

	public function new(rps:Int = 2, burst:Int = 1):Void {
		this.rate = rps; this.burst = burst; this.tokens = burst; // mrow~
		lastStamp = now();
	}

	public function enqueue(req:Request):Void {
		queue.push(req);
		if (!running) schedule();
	}

	function schedule():Void {
		running = true;
		Timer.delay(tick, 0);
	}

	function tick():Void {
		refillTokens();

		while (tokens >= 1) {
			final task:Null<Request> = nextTask();
			if (task == null) break;

			execute(task);
			tokens--;
		}

		// if (head > 1024) {
		// 	queue = queue.slice(head, queue.length);
		// 	head = 0;
		// }

		if (hasPending()) {
			final delayMs:Int = Std.int((1 / rate) * 1000);
			#if nodejs
			js.Lib.global.setTimeout(tick, delayMs);
			#else
			Timer.delay(tick, delayMs);
			#end
		} else
			running = false;
	}

	inline function execute(req:Request):Void {
		try {
			switch (req) {
				case CALL(x): x();
				case PASS: // meow
			}
		} catch (e:Dynamic) {
			trace(e);
		}
	}

	inline function refillTokens():Void {
		final t:Float = now();
		final delta:Float = t - lastStamp;
		lastStamp = t;

		tokens = Math.min(burst, tokens + delta * rate);
	}

    var head:Int = 0; // 0(1)

	inline function nextTask():Null<Request> {
		if (head >= queue.length) return null;
		return queue[head++];
	}

	inline function hasPending():Bool return head < queue.length;
	@:dox(hide) inline function now():Float return Timer.stamp();
}
