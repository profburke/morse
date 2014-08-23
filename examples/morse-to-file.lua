#!/usr/bin/env lua

morse = require 'morse'

io.output 'morse.out'

morse.send 'This Morse text got sent to a file'

io.write "\n"

morse.send 'As did this'


