-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = (os_getenv("XDG_DATA_HOME") or (home .. '.local/share') ) .. "/luarocks" };
   { name = "system", root = "/usr" };
}
variables = {
   LUA_DIR = "/usr";
   LUA_INCDIR = "/usr/include/lua5.3";
   LUA_BINDIR = "/usr/bin";
   LUA_VERSION = "5.3";
   LUA = "/usr/bin/lua5.3";
}
