include "lzma/."
if (SERVER_ZIP_SUPPORT or not SERVER_MODE) then
include "spmemvfs/."
end
if USE_AUDIO then
include "miniaudio/."
end

if SERVER_PRO3_SUPPORT then
project "ygoserver"
    kind "SharedLib"
end
if SERVER_MODE then
if not SERVER_PRO3_SUPPORT then
project "ygopro"
    kind "ConsoleApp"
end
    cppdialect "C++14"

    defines { "YGOPRO_SERVER_MODE" }

    files { "gframe.cpp", "config.h",
            "game.cpp", "game.h", "myfilesystem.h",
            "deck_manager.cpp", "deck_manager.h",
            "data_manager.cpp", "data_manager.h",
            "replay.cpp", "replay.h",
            "netserver.cpp", "netserver.h",
            "single_duel.cpp", "single_duel.h",
            "tag_duel.cpp", "tag_duel.h" }
    if SERVER_PRO3_SUPPORT then
        files { "gframe.h", "serverapi.cpp", "serverapi.h" }
        defines { "SERVER_PRO3_SUPPORT" }
    end
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", LUA_LIB_NAME, "sqlite3", "event" }
    if SERVER_ZIP_SUPPORT then
        defines { "SERVER_ZIP_SUPPORT" }
        links { "irrlicht", "cspmemvfs" }
        if BUILD_IRRLICHT then
            includedirs { "../irrlicht/source/Irrlicht" }
        end
    end
    if SERVER_PRO2_SUPPORT then
        defines { "SERVER_PRO2_SUPPORT" }
    end
    if SERVER_TAG_SURRENDER_CONFIRM then
        defines { "SERVER_TAG_SURRENDER_CONFIRM" }
    end
else
project "ygopro"
    kind "WindowedApp"
    cppdialect "C++14"
    rtti "Off"

    files { "*.cpp", "*.h" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "cspmemvfs", LUA_LIB_NAME, "sqlite3", "irrlicht", "freetype", "event" }
end

    if BUILD_EVENT then
        includedirs { "../event/include" }
    else
        includedirs { EVENT_INCLUDE_DIR }
        libdirs { EVENT_LIB_DIR }
    end

    if BUILD_IRRLICHT then
        includedirs { "../irrlicht/include" }
    else
        includedirs { IRRLICHT_INCLUDE_DIR }
        libdirs { IRRLICHT_LIB_DIR }
    end

    if BUILD_FREETYPE then
        includedirs { "../freetype/include" }
    else
        includedirs { FREETYPE_INCLUDE_DIR }
        libdirs { FREETYPE_LIB_DIR }
    end

    if BUILD_SQLITE then
        includedirs { "../sqlite3" }
    else
        includedirs { SQLITE_INCLUDE_DIR }
        libdirs { SQLITE_LIB_DIR }
    end

    if USE_AUDIO then
        defines { "YGOPRO_USE_AUDIO" }
        links { "cminiaudio" }
    end

    filter "system:windows"
        defines { "_IRR_WCHAR_FILESYSTEM" }
        files "ygopro.rc"
if not SERVER_MODE then
        libdirs { "$(DXSDK_DIR)Lib/x86" }
end
if SERVER_PRO2_SUPPORT then
        targetname ("AI.Server")
end
if SERVER_MODE then
        links { "ws2_32" }
else
        links { "opengl32", "ws2_32", "winmm", "gdi32", "kernel32", "user32", "imm32", "Dnsapi" }
end
    filter "not system:windows"
        links { "event_pthreads", "dl", "pthread", "resolv" }
    filter "system:macosx"
if not SERVER_MODE then
        links { "z" }
        defines { "GL_SILENCE_DEPRECATION" }
end
        if MAC_ARM then
            buildoptions { "--target=arm64-apple-macos12" }
            linkoptions { "-arch arm64" }
        end
    filter "system:linux"
        linkoptions { "-static-libstdc++", "-static-libgcc" }
if not SERVER_MODE then
        links { "GL", "X11", "Xxf86vm" }
end
