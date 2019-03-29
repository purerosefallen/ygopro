include "lzma/."

project "ygopro"
    kind "ConsoleApp"

    local mr=os.getenv("YGOPRO_DEFAULT_DUEL_RULE")
    if mr and tonumber(mr) then defines { "DEFAULT_DUEL_RULE="..tonumber(mr) } end

    files { "gframe.cpp", "config.h",
            "game.cpp", "game.h", "myfilesystem.h",
            "deck_manager.cpp", "deck_manager.h",
            "data_manager.cpp", "data_manager.h",
            "replay.cpp", "replay.h",
            "netserver.cpp", "netserver.h",
            "single_duel.cpp", "single_duel.h",
            "tag_duel.cpp", "tag_duel.h" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "sqlite3", "lua" , "event"}

    configuration "windows"
        files "ygopro.rc"
        includedirs { "../event/include", "../sqlite3" }
        links { "ws2_32" }

    configuration "not vs*"
        buildoptions { "-std=c++1y", "-fno-rtti" }
    configuration "not windows"
        links { "event_pthreads", "dl", "pthread" }
