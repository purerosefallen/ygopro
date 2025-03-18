project "lua"
    kind "StaticLib"
    compileas "C++"

    files { "src/*.c", "src/*.h" }
    removefiles { "src/lua.c", "src/luac.c", "src/onelua.c" }

    if not GetParam("no-lua-safe") then
        removefiles { "src/linit.c" }
    end

    filter "configurations:Debug"
        defines { "LUA_USE_APICHECK" }

    filter "system:bsd"
        defines { "LUA_USE_POSIX" }

    filter "system:macosx"
        defines { "LUA_USE_MACOSX" }

    filter "system:linux"
        defines { "LUA_USE_LINUX" }
