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
    links { "ocgcore", "clzma" }

    configuration "windows"
        links { "sqlite3", "event" }
        files "ygopro.rc"
        includedirs { "../event/include", "../sqlite3" }
        links { "ws2_32", "lua" }
    configuration "not vs*"
        buildoptions { "-std=c++14", "-fno-rtti" }
    configuration "not windows"
        links { "dl", "pthread" }
        if not LINUX_ALL_STATIC then
            links { "event_pthreads" }
        end
        if BUILD_LUA then
            links { "lua" }
        else
            links { "lua5.3-c++" }
        end
        if LINUX_ALL_STATIC then
            linkoptions { LIB_ROOT.."libsqlite3.a", "-static-libstdc++", "-static-libgcc" }
            local libeventRootPrefix=LIB_ROOT
            if LIBEVENT_ROOT then
                includedirs { LIBEVENT_ROOT.."/include" }
                libeventRootPrefix=LIBEVENT_ROOT.."/lib/"
            end
            linkoptions { libeventRootPrefix.."libevent.a", libeventRootPrefix.."libevent_pthreads.a" }
        else
            links { "sqlite3", "event" }
        end
