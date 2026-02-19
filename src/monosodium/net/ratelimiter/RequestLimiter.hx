package monosodium.net.ratelimiter;

import monosodium.net.ratelimiter.RequestType;
import haxe.Timer;

/**
 * lacks a few features, but eh.. who cares?
 */
@:nullSafety
@:keep
class RequestLimiter {
	public var rate:Float;
	public var burst:Int;

	@:noCompletion
	var tokens:Float;

	@:dox(hide) 
	var lastStamp:Float;

	var alive:Bool = false;
	var queue:Array<RequestType> = [];

	public function new(rps:Int = 2, burst:Int = 1):Void {
		this.rate = rps;
		this.tokens = this.burst = burst;
		this.lastStamp = now();
	}

	public function enqueue(req:RequestType):Void {
		queue.push(req);
		if (!alive)
			schedule();
	}

	function schedule():Void {
		alive = true;
		Timer.delay(tick, 0);
	}

	function tick():Void {
		refillTokens();

		// process tasks while tokens are available and the queue is not empty
		while (tokens >= 1 && queue.length > 0) {
			final task = queue.shift(); // reclaim memory
			if (task != null) {
				execute(task);
				tokens--;
			}
		}

		// if (head > 1024) {
		// 	queue = queue.slice(head, queue.length);
		// 	head = 0;
		// }
		if (queue.length > 0) {
			final delayMs:Int = Std.int(Math.max(1, (1 / rate) * 1000));

			#if nodejs
			js.Lib.global.setTimeout(tick, delayMs);
			#else
			Timer.delay(tick, delayMs);
			#end
		} else {
			alive = false;
		}
	}

	inline function execute(req:RequestType):Void {
		try {
			switch req {
				case CALL(x):
					x();
				case PASS: // meow
			}
		} catch (e:Dynamic) {
			trace('Request Execution Error: $e');
		}
	}

	inline function refillTokens():Void {
		final t:Float = now();
		final delta:Float = t - lastStamp;

		lastStamp = t;
		tokens = Math.min(burst, tokens + delta * rate);
	}

	@:pure @:dox(hide) 
	inline function now():Float
		return Timer.stamp();
}
