package monosodium.net;

import haxe.Json;

final class StatusResolver {
    public static function handle(statusCode:Int, data:String, onSuccess:Dynamic->Void, onError:String->Void):Void {
        switch statusCode {
            // client-based errors...
			case 200: // OK, successful request...
				try {
					onSuccess(Json.parse(data));
				} catch (e:Dynamic) {
					onError("Invalid JSON response");
				}
			case 204: onSuccess(null); // notfound... aka blank
            case 400: onError("Bad Request: Feature not available.");
            case 401: onError("Unauthorized: Check username and API key.");
            case 403: onError("Forbidden: Access denied (check User-Agent).");
            case 404: onError("Not Found");
            case 405: onError("Method Not Allowed: Try changing POST/PATCH/PUT.");
            case 406: onError("Not Acceptable: Format not allowed.");
            case 410: onError("Gone: Invalid pagination.");
            case 412: onError("Precondition Failed: Upload invalid or duplicate.");
            case 422: onError("Unprocessable Content: Invalid request body.");
            case 429: onError("Ratelimited: Slow down your requests.");

            // server-based Errors
            case 500: onError("Internal Server Error: Unknown e621 error.");
            case 502: onError("Bad Gateway: Cannot reach e621.");
            case 503: onError("Service Unavailable: Server busy or limit exceeded.");
            case 520: onError("Unknown Error: Protocol violation.");
            case 522: onError("Connection Timeout (CloudFlare).");
            case 524: onError("Response Timeout (CloudFlare).");
            case 525: onError("SSL Handshake Failed.");

            default:
                try {
                    // attempt to extract custom error reason
                    final err = Json.parse(data);
                    onError(err.reason != null ? err.reason : "HTTP " + statusCode);
                } catch (_) {
                    onError("HTTP " + statusCode);
                }
        }
    }
}
