if SERVER_MODE then
    if SERVER_PRO3_SUPPORT then
        project "ygoserver"
            kind "SharedLib"
    else
        project "ygopro"
            kind "ConsoleApp"
    end

    cppdialect "C++14"
    defines { "YGOPRO_SERVER_MODE" }

    files {
        "gframe.cpp", "config.h",
        "game.cpp", "game.h", "myfilesystem.h",
        "deck_manager.cpp", "deck_manager.h",
        "data_manager.cpp", "data_manager.h",
        "replay.cpp", "replay.h",
        "netserver.cpp", "netserver.h",
        "single_duel.cpp", "single_duel.h",
        "tag_duel.cpp", "tag_duel.h"
    }

    if SERVER_PRO3_SUPPORT then
        files { "gframe.h", "serverapi.cpp", "serverapi.h" }
        defines { "SERVER_PRO3_SUPPORT" }
    end

    includedirs { "../ocgcore", EVENT_INCLUDE_DIR, LZMA_INCLUDE_DIR, SQLITE_INCLUDE_DIR }
    links { "ocgcore", "lzma", "sqlite3", "event" }

    if SERVER_ZIP_SUPPORT then
        defines { "SERVER_ZIP_SUPPORT" }
        links { "irrlicht" }
        if BUILD_IRRLICHT then
            includedirs { IRRLICHT_INCLUDE_DIR, "../irrlicht/source/Irrlicht", ZLIB_INCLUDE_DIR }
        end
        if BUILD_ZLIB then
            links { "zlib" }
        else
            links { ZLIB_LIB_NAME }
            libdirs { ZLIB_LIB_DIR }
        end
    end

    if SERVER_PRO2_SUPPORT then
        defines { "SERVER_PRO2_SUPPORT" }
    end
    if SERVER_TAG_SURRENDER_CONFIRM then
        defines { "SERVER_TAG_SURRENDER_CONFIRM" }
    end
else
project "YGOPro"
    kind "WindowedApp"
    rtti "Off"
    if USE_OPENMP then
        openmp "On"
    end

    defines { "_IRR_STATIC_LIB_" }
    files { "*.cpp", "*.h", "CGUISkinSystem/*.cpp", "CGUISkinSystem/*.h", "CXMLRegistry/*.cpp", "CXMLRegistry/*.h" }
    includedirs { "../ocgcore", EVENT_INCLUDE_DIR, IRRLICHT_INCLUDE_DIR, JPEG_INCLUDE_DIR, ZLIB_INCLUDE_DIR, LZMA_INCLUDE_DIR, SQLITE_INCLUDE_DIR }
    links { "ocgcore", "lzma", "sqlite3", "irrlicht", "png", "freetype", "event" }
end
    if not OCGCORE_DYNAMIC then
        if BUILD_LUA then
            links { "lua" }
        else
            links { LUA_LIB_NAME }
            libdirs { LUA_LIB_DIR }
        end
    end

    if not BUILD_EVENT then
        libdirs { EVENT_LIB_DIR }
        links { "event_pthreads" }
    end

if not SERVER_MODE then
    if not BUILD_IRRLICHT then
        libdirs { IRRLICHT_LIB_DIR }
    end
end

if not SERVER_MODE then
    if BUILD_JPEG then
        links { "jpeg" }
    else
        links { JPEG_LIB_NAME }
        libdirs { JPEG_LIB_DIR }
    end

    if not BUILD_PNG then
        libdirs { PNG_LIB_DIR }
    end

    if BUILD_ZLIB then
        links { "zlib" }
    else
        links { ZLIB_LIB_NAME }
        libdirs { ZLIB_LIB_DIR }
    end
end

if not SERVER_MODE then
    if BUILD_FREETYPE then
        includedirs { FREETYPE_CUSTOM_INCLUDE_DIR, FREETYPE_INCLUDE_DIR }
    else
        includedirs { FREETYPE_INCLUDE_DIR }
        libdirs { FREETYPE_LIB_DIR }
    end
end

    if not BUILD_SQLITE then
        libdirs { SQLITE_LIB_DIR }
    end

    if not BUILD_LZMA then
        libdirs { LZMA_LIB_DIR }
    end

if not SERVER_MODE then
    if USE_SIMD == "none" then
        defines { "STBIR_NO_SIMD" }
    end
end

if not SERVER_MODE then
    if USE_AUDIO then
        defines { "YGOPRO_USE_AUDIO" }
        if AUDIO_LIB == "miniaudio" then
            defines { "YGOPRO_USE_MINIAUDIO" }
            includedirs { MINIAUDIO_INCLUDE_DIR }
            links { "miniaudio" }
            if MINIAUDIO_SUPPORT_OPUS_VORBIS then
                defines { "YGOPRO_MINIAUDIO_SUPPORT_OPUS_VORBIS" }
                includedirs { MINIAUDIO_OPUS_INCLUDE_DIR, MINIAUDIO_VORBIS_INCLUDE_DIR }
                if not MINIAUDIO_BUILD_OPUS_VORBIS then
                    links { "opusfile", "vorbisfile", "opus", "vorbis", "ogg" }
                    libdirs { OPUS_LIB_DIR, OPUSFILE_LIB_DIR, VORBIS_LIB_DIR, OGG_LIB_DIR }
                end
            end
        end
    end
end

    filter "system:windows"
        if not SERVER_PRO3_SUPPORT then
            entrypoint "mainCRTStartup"
        end
        files "ygopro.rc"
        if SERVER_PRO2_SUPPORT and not SERVER_PRO3_SUPPORT then
            targetname "AI.Server"
        end
        if SERVER_MODE then
            links { "ws2_32", "iphlpapi" }
        else
            links { "ws2_32", "Dnsapi", "iphlpapi", "winmm" }
        end

if not SERVER_MODE then
    filter "not system:windows"
        links { "resolv" }
end

    filter "not action:vs*"
        cppdialect "C++14"

    filter "system:macosx"
if not SERVER_MODE then
        links { "OpenGL.framework", "Cocoa.framework", "IOKit.framework", "Carbon.framework" }
        defines { "GL_SILENCE_DEPRECATION" }
end

    filter "system:linux"
        links { "dl", "pthread" }
if not SERVER_MODE then
        links { "GL", "X11" }
        if USE_OPENMP then
            linkoptions { "-fopenmp" }
        end
end
        if USE_DYNAMIC then
            linkoptions { "-Wl,-rpath=./" }
        else
            linkoptions { "-static-libstdc++", "-static-libgcc" }
        end
