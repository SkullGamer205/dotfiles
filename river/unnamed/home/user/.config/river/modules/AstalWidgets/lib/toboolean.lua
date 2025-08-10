--[[

  Copyright (C) 2018 Masatoshi Teruya

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

  toboolean.lua
  Created by Masatoshi Teruya on 18/04/25.

--]]
--- asign to local
local type = type;
local assert = assert;
local strformat = string.format;
--- constants
local TRUE = {
    ['1'] = true,
    ['t'] = true,
    ['T'] = true,
    ['true'] = true,
    ['TRUE'] = true,
    ['True'] = true,
};
local FALSE = {
    ['0'] = false,
    ['f'] = false,
    ['F'] = false,
    ['false'] = false,
    ['FALSE'] = false,
    ['False'] = false,
};


--- toboolean
-- @param str
-- @return bool
-- @return err
local function toboolean( str )
    assert( type( str ) == 'string', 'str must be string' )

    if TRUE[str] == true then
        return true;
    elseif FALSE[str] == false then
        return false;
    else
        return false, strformat( 'cannot convert %q to boolean', str );
    end
end


return toboolean;
