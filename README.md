
# Morse

Morse lets you turn text into Morse code. It provides one main function, `send`, for encoding text
and several auxiliary functions that change how the code is generated.

I wrote the library not because I was interested in Morse code, but because I wanted something to exercise
[luablink](http://github.com/profburke/FILL-THIS-IN). If you happen to have a [blink(1)](http://thingm.com/blink-1.html), you should take
a look at [luablink](http://github.com/profburke/FILL-THIS-IN).


## Usage

If you're not changing the signalling mechanism, there's not much to it:

    morse = require 'morse'
    morse.send 'a patient waiter is no loser'


Take a look at [Smiley Morse](https://github.com/profburke/morse/blob/master/examples/smiley-morse.lua) or this [gist](https://gist.github.com/profburke/1aa10b0fd6a2422e1843) for details on changing the signalling mechanism.


This project uses semantic versioning. See <a href="http://semver.org">semver.org</a> for more information.


## Requirements and Installation

The library was developed and tested using [Lua](http://lua.org) 5.2.3. However it should run on other versions of Lua with little or no modification.

If you have downloaded the github repository, you can install the library by copying the files in the `src` subdirectory to
your Lua library (`/usr/local/share/lua/5.2` or similar). Alternatively, you can install it via [luarocks](http://luarocks.org/)

    luarocks install morse



## Conventional Timing of Morse Code

`Morse` is based on the conventional timing of Morse Code (*or, rather, my understanding of it*). There are five durations that are important:

1. a short mark, *dot*, is one time unit long
1. a long mark, *dash*, is three time units long
1. between dots and dashes, but with a character, there should be one time unit
1. between letters there should be three time units
1. between words there should be seven time units

`Morse` enforces this timing by means of the blank generator function. Whatever this function does should be considered the equivalent of 'one time unit'. (For example,
the default implementation prints a space.) The `send` function calls the blank generator seven times between words, three times between letters, etc.



## Documentation and Contact Information

More documentation (than this dirt simple library requires) can be found in the `doc` subdirectory.

The best way to contact me regarding this library is to post an issue at the [github repository](https://github.com/profburke/morse/issues).


## License

Morse is free software distributed under the terms of the MIT license. It may be used for any purpose, including commercial purposes, at absolutely no cost without having to ask. The only requirement is that if you do use Morse, then you should give me credit by including the appropriate copyright notice somewhere in your product or its documentation. For details, see `LICENSE`.




