#!/usr/bin/env lua


-- In case we want to run tests when library is not installed.
local LUA_PATH_SEP = package.config:sub(3, 3)
package.path = package.path .. LUA_PATH_SEP .. '../src/?.lua'




local CORRECT_OUTPUT = [[-   . . . .   .       - - . -   . . -   . .   - . - .   - . -       - . . .   . - .   - - -   . - -   - .       . . - .   - - -   - . . -       . - - -   . . -   - -   . - - .   . . .       - - -   . . . -   .   . - .       -   . . . .   .       . - . .   . -   - - . .   - . - -       - . .   - - -   - - .   . - . - . -
]]
local morse = require 'morse'


local morsefile = io.open('morse.out', 'w+')
io.output(morsefile)

morse.send 'The quick brown fox jumps over the lazy dog.'

io.output(io.stdout)
morsefile:close()


local morsefile = io.open 'morse.out'
local morsetext = morsefile:read '*a'


assert(morsetext == CORRECT_OUTPUT, string.format('Test Failed\nExpected <%s>\n\nReceived <%s>', CORRECT_OUTPUT, morsetext))

print "Success"
