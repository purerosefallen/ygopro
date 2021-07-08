include "lzma/."

project "ygopro"
    kind "ConsoleApp"

<<<<<<< HEAD
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
=======
    files { "**.cpp", "**.cc", "**.c", "**.h" }
    excludes { "lzma/**", "spmemvfs/**" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "cspmemvfs", "Irrlicht", "sqlite3", "freetype" }
    if not LINUX_ALL_STATIC then
        links { "event" }
    end
    if USE_IRRKLANG then
        defines { "YGOPRO_USE_IRRKLANG" }
        links { "ikpmp3" }
        includedirs { "../irrklang/include" }
        if IRRKLANG_PRO then
            defines { "IRRKLANG_STATIC" }
        end
    end
    if os.getenv("YGOPRO_COMPAT_MYCARD") then
        defines { "YGOPRO_COMPAT_MYCARD" }
    end
    if os.getenv("YGOPRO_MESSAGE_DEBUG") then
        defines { "YGOPRO_MESSAGE_DEBUG" }
>>>>>>> master
    end

<<<<<<< HEAD
    files { "gframe.cpp", "config.h",
            "game.cpp", "game.h", "myfilesystem.h",
            "deck_manager.cpp", "deck_manager.h",
            "data_manager.cpp", "data_manager.h",
            "replay.cpp", "replay.h",
            "netserver.cpp", "netserver.h",
            "single_duel.cpp", "single_duel.h",
            "tag_duel.cpp", "tag_duel.h" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "sqlite3" }

=======
    configuration "not linux"
        if LINUX_ALL_STATIC then
            links { "event" }
        end
>>>>>>> master
    configuration "windows"
        files "ygopro.rc"
        includedirs { "../event/include", "../sqlite3" }
        links { "ws2_32", "event", "lua" }
    configuration "not vs*"
        buildoptions { "-std=c++14", "-fno-rtti" }
    configuration "not windows"
        links { "dl", "pthread" }
        if not LINUX_ALL_STATIC then
            links { "event_pthreads" }
        end
        if BUILD_SQLITE then
            includedirs { "../sqlite3" }
        end
<<<<<<< HEAD
=======
        if BUILD_FREETYPE then
            includedirs {"../freetype/include" }
        end
    configuration { "not windows", "not macosx" }
        links "GL"
    configuration "linux"
        linkoptions { "-static-libstdc++", "-static-libgcc", "-Wl,-rpath=./lib/" }
        includedirs { "../irrlicht_linux/include" }
>>>>>>> master
        if BUILD_LUA then
            links { "lua" }
        else
            links { "lua5.3-c++" }
        end
        if LINUX_ALL_STATIC then
            local libeventRootPrefix=LIB_ROOT
            if LIBEVENT_ROOT then
                includedirs { LIBEVENT_ROOT.."/include" }
                libeventRootPrefix=LIBEVENT_ROOT.."/lib/"
            end
            linkoptions { libeventRootPrefix.."libevent.a", libeventRootPrefix.."libevent_pthreads.a" }
        else
            links { "event" }
        end
    configuration "linux"
        linkoptions { "-static-libstdc++", "-static-libgcc", "-Wl,-rpath=./lib/" }
