# Acronyms
Tech Abbreviations

Draft app written using Flutter to browse acronyms based on categories.


###Flutter advantages

* Native UI
* One codebase deployed on web and mobile.
* Smooth UI, loads fast (high FPS).
* Although for most cross-platform SDK it is common to provide APIs that work on all their target platforms, Flutter avoids this. Flutter's ability to be used cross-platform is secondary to the ability to be used on each platform. For ex: TextInputAction widget has values that only make sense on some platforms.

###Functionality:

- Parse data from Local data set in json format.
- Browse by category.
- Open each category in different screen.
- Search acronym by name.


##Implementation details:


###Dart code style based on guidelines

- Uses trailing commas to get good automatic formatting.
- Avoid the lowest common denominator. Does not use APIs that work on all platforms, but rather leverage the ability to be used on each platform.


###Android equivalents:
- An Activity is a Route. Navigate to a new route using the Navigator. (push/pop)
- IPS is done with Settings arguments, similar to intents, POJOs will be serialized automatically.
- 


###Testing in Flutter

