# Acronyms
Tech Abbreviations

Draft app written using Flutter to browse acronyms based on categories.
Flutter uses Dart, an object-oriented language, class-based, garbage collected language with C-style syntax.

### Setup & install


### Flutter advantages

* Native UI
* One codebase deployed on web and mobile.
* Smooth UI, loads fast (high FPS).
* Although for most cross-platform SDK it is common to provide APIs that work on all their target platforms, Flutter avoids this. Flutter's ability to be used cross-platform is secondary to the ability to be used on each platform. For ex: TextInputAction widget has values that only make sense on some platforms.

### Functionality:

- Parse data from Local data set in json format.
- Browse by category.
- Open each category in different screen.
- Search acronym by name.


## Implementation details:


### Design & user stories 
https://www.figma.com/file/fihPfODpkticU4brhVmFf8/Acronyms?node-id=1%3A2


### Dart code style based on guidelines

- Uses trailing commas to get good automatic formatting.
- Avoid the lowest common denominator. Flutter does not use APIs that work on all platforms, but rather leverage the ability to be used on each platform.


### Android equivalents:
- An Activity is a Route. Navigate to a new route using the Navigator. (push/pop)
- IPS is done with Settings arguments, similar to intents, POJOs will be serialized automatically.
- Layouts are not written in XML, but with a widget tree.
- Flutter is single threaded and run an event loop (like Node.js). For I/O work, async/await methods are all you need.
- There is no GSON/Jackson/Mochi equivalent in Flutter because reflection is not supported, but instead it has a built-in dart:convert library.
- Manual JSON decoding is enough for smaller projects, but unfortunately errors will be only caught at runtime.
- This project uses json_serializable library, an automated source code generator to minimize the risk of having JSON serialization exceptions at runtime.


### Testing & linter in Flutter


### Known issues

- TextCapitalization on the search text does not work on all devices, mostly non-flaghip ones. (https://github.com/flutter/flutter/issues/38876)











