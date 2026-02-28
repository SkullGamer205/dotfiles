-- See https://gist.github.com/FreeBirdLjj/6303864

-- If the default case does not have to be handled, we can use the following auxiliary function:
local function switch(value)
	-- Handing `cases` to the returned function allows the `switch()` function to be used with a syntax closer to c code (see the example below).
	-- This is because lua allows the parentheses around a table type argument to be omitted if it is the only argument.
	return function(cases)
		
		-- The default case is achieved through the metatable mechanism of lua tables (the `__index` operation).
		setmetatable(cases, cases)
		
		local f = cases[value]
		if f then
			f()
		end
	end
end

-- Suppose we want to write the equivalent lua code of the following c code:
-- switch (a) {
-- case 1:
--   printf("Case 1.\n");
--   break;
-- case 2:
--   printf("Case 2.\n");
--   break;
-- case 3:
--   printf("Case 3.\n");
--   break;
-- default:
--   printf("Case default.\n");
-- }
