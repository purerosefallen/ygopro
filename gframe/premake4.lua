include "lzma/."

project "ygopro"
    kind "ConsoleApp"

    local params={
        "DEFAULT_DUEL_RULE",
        "DECKCOUNT_MAIN_MIN",
        "DECKCOUNT_MAIN_MAX",
        "DECKCOUNT_SIDE",
        "DECKCOUNT_EXTRA",
        "NO_SIDE_CHECK"
    }

    for _,param in ipairs(params) do
        local val=os.getenv("YGOPRO_"..param)
        if val and tonumber(val) then defines { param.."="..tonumber(val) } end
    end

    files { "gframe.cpp", "config.h",
            "game.cpp", "game.h", "myfilesystem.h",
            "deck_manager.cpp", "deck_manager.h",
            "data_manager.cpp", "data_manager.h",
            "replay.cpp", "replay.h",
            "netserver.cpp", "netserver.h",
            "single_duel.cpp", "single_duel.h",
            "tag_duel.cpp", "tag_duel.h" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "sqlite3", "event" }

    configuration "windows"
        files "ygopro.rc"
        includedirs { "../event/include", "../sqlite3" }
        links { "ws2_32", "event", "lua" }
    configuration "not vs*"
        buildoptions { "-std=c++14", "-fno-rtti" }
    configuration "not windows"
        links { "dl", "pthread" }
        if LIBEVENT_ROOT then
            includedirs { LIBEVENT_ROOT.."/include" }
            libdirs { LIBEVENT_ROOT.."/lib/" }
        end
        links { "event_pthreads" }
        if BUILD_SQLITE then
            includedirs { "../sqlite3" }
        end
        if BUILD_LUA then
            links { "lua" }
        else
            links { "lua5.3-c++" }
        end
    configuration "linux"
        linkoptions { "-static-libstdc++", "-static-libgcc", "-Wl,-rpath=./lib/" }
    configuration "macosx"
        if MAC_ARM then
            buildoptions { "--target=arm64-apple-macos11" }
            linkoptions { "-arch arm64" }
        end
