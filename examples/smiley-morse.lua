#!/usr/bin/env lua

morse = require 'morse'

morse.setDotGenerator(function()
                         io.write ':)'
                      end)

morse.setDashGenerator(function()
                          io.write ':('
                       end)


morse.send "This is smiley Morse."
