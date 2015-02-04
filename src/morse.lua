--- morse, a Lua module for translating text to Morse code.
--
-- This module provides a text to Morse code function. The one
-- interesting bit is that the implemetation is designed to allow you
-- to easily override the way the symbols are generated so that you could, for example,
-- have it beep, rather than print dots and dashes.
--
-- @usage 
-- morse = require 'morse'
-- morse.send 'a patient waiter is no loser'
--
-- @module morse
-- @author Matthew M. Burke
-- @copyright 2014
-- @license MIT (see LICENSE file)
--


local _M = {}




local defaultDot = function() io.write "." end
local defaultDash = function() io.write "-" end
local defaultBlank = function() io.write " " end
local defaultCleanup = function() io.write "\n" end

local eventHandlers


-- See README.md for a discussion of standard timing of Morse Code.
local dot = function() eventHandlers.dot() end
local dash = function() eventHandlers.dash() end
local blank = function() eventHandlers.blank() end
local interword = function() for i = 1,7 do blank() end end
local interletter = function() for i = 1,3 do blank() end end
local intersymbol = function() blank() end




local letters = {
   a = {dot, dash},
   b = {dash, dot, dot, dot},
   c = {dash, dot, dash, dot},
   d = {dash, dot, dot},
   e = {dot},
   f = {dot, dot, dash, dot},
   g = {dash, dash, dot},
   h = {dot, dot, dot, dot},
   i = {dot, dot},
   j = {dot, dash, dash, dash},
   k = {dash, dot, dash},
   l = {dot, dash, dot, dot},
   m = {dash, dash},
   n = {dash, dot},
   o = {dash, dash, dash},
   p = {dot, dash, dash, dot},
   q = {dash, dash, dot, dash},
   r = {dot, dash, dot},
   s = {dot, dot, dot},
   t = {dash},
   u = {dot, dot, dash},
   v = {dot, dot, dot, dash},
   w = {dot, dash, dash},
   x = {dash, dot, dot, dash},
   y = {dash, dot, dash, dash},
   z = {dash, dash, dot, dot},
   ['0'] = {dash, dash, dash, dash, dash},
   ['1'] = {dot, dash, dash, dash, dash},
   ['2'] = {dot, dot, dash, dash, dash},
   ['3'] = {dot, dot, dot, dash, dash},
   ['4'] = {dot, dot, dot, dot, dash},
   ['5'] = {dot, dot, dot, dot, dot},
   ['6'] = {dash, dot, dot, dot, dot},
   ['7'] = {dash, dash, dot, dot, dot},
   ['8'] = {dash, dash, dash, dot, dot},
   ['9'] = {dash, dash, dash, dash, dot},
   ['.'] = {dot, dash, dot, dash, dot, dash},
   [','] = {dash, dash, dot, dot, dash, dash},
   ['?'] = {dot, dot, dash, dash, dot, dot},
   ["'"] = {dot, dash, dash, dash, dash, dot},
   ['!'] = {dash, dot, dash, dot, dash, dash},
   ['/'] = {dash, dot, dot, dash, dot},
   ['('] = {dash, dot, dash, dash, dot},
   [')'] = {dash, dot, dash, dash, dot, dash},
   [':'] = {dash, dash, dash, dot, dot, dot},
   [';'] = {dash, dot, dash, dot, dash, dot},
   ['='] = {dash, dot, dot, dot, dash},
   ['+'] = {dot, dash, dot, dash, dot},
   ['-'] = {dash, dot, dot, dot, dot, dash},
   ['"'] = {dot, dash, dot, dot, dash, dot},
   ['@'] = {dot, dash, dash, dot, dash, dot},
}




local transmit = function(c)
   local symbols = letters[c]
   if not symbols then return end

   symbols[1]()
   for i = 2, #symbols do
      intersymbol()
      symbols[i]()
   end
end




local spell = function(word)
   local firstCharacter = true

   for c in word:gmatch('.') do
      if not firstCharacter then
         interletter()
      else
         firstCharacter = false
      end
      transmit(c)
   end
end



--- Translates message to Morse code.
--
-- This message is called for its side effects which vary depending
-- on the implemenation of the signal handlers. The default implementation
-- prints dots and dashes to standard out.
--
-- @tparam string msg the text to translate
--
_M.send = function(msg) 
   msg = msg:lower()
   local firstWord = true

   for word in msg:gmatch('%S+') do
      if not firstWord then
         interword()
      else
         firstWord = false
      end
      spell(word)
   end
   eventHandlers.cleanup()
end




--- Sets the given function as the dot generator.
-- @tparam function f the new dot generator
_M.setDotGenerator = function(f) eventHandlers.dot = f end


--- Sets the given function as the dash generator.
-- @tparam function f the new dash generator
_M.setDashGenerator = function(f) eventHandlers.dash = f end


--- Sets the given function as the blank generator.
-- @tparam function f the new blank generator
_M.setBlankGenerator = function(f) eventHandlers.blank = f end


--- Sets the given function as the cleanup function.
-- @tparam function f the new cleanup function
_M.setCleanupFunction = function(f) eventHandlers.cleanup = f end


--- Restores the dot, dash and blank generators and the cleanup function
-- to their default implementations.
_M.restoreDefaults = function()
   eventHandlers = {
      dot = defaultDot,
      dash = defaultDash,
      blank = defaultBlank,
      cleanup = defaultCleanup,
   }
end

_M.restoreDefaults()




return _M

