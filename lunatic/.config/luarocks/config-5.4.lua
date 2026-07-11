-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = (os_getenv("XDG_DATA_HOME") or (home .. '.local/share')) .. "/luarocks/" };
   { name = "system", root = "/usr" };
}
variables = {
   LUA_DIR = "/usr";
   LUA_INCDIR = "/usr/include/lua5.4";
   LUA_BINDIR = "/usr/bin";
   LUA_LIBDIR = (os_getenv("XDG_DATA_HOME") or (home .. '.local/share')) .. "/luarocks/lib/lua";
   LUA_VERSION = "5.4";
   LUA = "/usr/bin/lua5.4";
}
