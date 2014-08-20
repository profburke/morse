local _M = {}




local defaultDot = function() io.write "." end
local defaultDash = function() io.write "-" end
local defaultBlank = function() io.write " " end
local defaultCleanup = function() io.write "\n" end


local eventHandlers = {
   dot = defaultDot,
   dash = defaultDash,
   blank = defaultBlank,
   cleanup = defaultCleanup,
}


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
}




local prepare = function(msg)
   msg = msg:gsub('[^%w%s]', '')
   msg = msg:lower()
   return msg
end




local transmit = function(c)
   local symbols = letters[c]
   if not symbols then return end

   for i = 1, #symbols do
      if i ~= 1 then
         intersymbol()
      end
      symbols[i]()
   end
end




local spell = function(word)
   local firstCharacter = true

   for c in word:gmatch('%w') do
      if not firstCharacter then
         interletter()
      else
         firstCharacter = false
      end
      transmit(c)
   end
end




_M.send = function(msg) 
   msg = prepare(msg)
   local firstWord = true

   for word in msg:gmatch('%w+') do
      if not firstWord then
         interword()
      else
         firstWord = false
      end
      spell(word)
   end
   eventHandlers.cleanup()
end




_M.setDotHandler = function(f) eventHandlers.dot = f end
_M.setDashHandler = function(f) eventHandlers.dash = f end
_M.setBlankHandler = function(f) eventHandlers.blank = f end
_M.setCleanupHandler = function(f) eventHandlers.cleanup = f end




return _M

