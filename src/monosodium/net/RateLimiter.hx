package monosodium.net;

import haxe.Timer;
import Sys;

class RateLimiter {
	@:dox(hide) var _intervalMs:Int;

	public function new(rps:Int = 2):Void {
		_intervalMs = Std.int(1000 / rps); // requests-per-second :3c
	}

	@:dox(hide) var _running:Bool = false;

	// request queue >:3
	public var queue:Array<Void->Void> = [];

	public function enqueue(task:Void->Void):Void {
		queue.push(() -> {
			try {
				task();
			} catch (e:Dynamic) {
				trace('failed :(');
			}
			execNext();
		});
		if (!_running) {
			execNext();
		}
	}

	@:dox(hide) var _lastTime:Float = 0;

	@:noCompletion function execNext():Void {
		if (queue.length == 0) {
			_running = false;
			return;
		}

		_running = true;

		final now:Float = Sys.time() * 1000;
		final wait:Float = _intervalMs - (now - _lastTime);

		if (wait <= 0) {
			_lastTime = now;
			queue.shift()();
		} else {
			Timer.delay(() -> {
				_lastTime = Sys.time() * 1000;
				queue.shift()();
			}, Std.int(wait));
		}
	}
}
