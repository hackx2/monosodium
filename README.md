<img src="https://raw.githubusercontent.com/hackx2/monosodium/refs/heads/main/docs/monosodium.png" alt="monosodium logo" align="left" width="150"/>
<br>

### monosodium

A lightweight, easy-to-use synchronous e621 / e926 API wrapper written natively in Haxe.

<br clear="left"/>

## Installation

1. Install the library

Haxelib:
```sh
haxelib install monosodium
```

Git:
```sh
haxelib git monosodium https://github.com/hackx2/monosodium.git
```

2. Adding the library to your project

HXML :
```hxml
-lib monosodium
```

Lime/OpenFL :
```xml
<haxelib name="monosodium"/>
```

## Basic Usage

```haxe
final api:Monosodium = new monosodium.Monosodium(); // Create a new wrapper instance 
api.mirror(monosodium.Mirror.E926); // Change the mirror target (E926 / E621)
api.verbose = true; // Enable verbose mode (optional)
api.authorize('USERNAME', 'TOKEN'); // authorization

// Get a post using an id:
api.posts.get(
    12345, // Post id
    post -> trace('Post #${post.id} has rating ${post.rating}'), // success callback by tracing "Post #12345 has rating s"
    error -> trace(error) // error callback
);

// Get a random post:
api.posts.random(
    ["gay", "-female"], // tags
    post -> trace(post.file_url), // success callback by tracing the file url 
    error -> trace(error) // error callback
);
```

_For more examples, please refer to [Main](./tests/Main.hx)_

---

## Resources used
- [e926.net/help/api/](https://e926.net/help/api)
- [e621.wiki/](https://e621.wiki/)

---
