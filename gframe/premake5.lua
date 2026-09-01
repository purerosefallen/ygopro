if SERVER_MODE then
    if SERVER_PRO3_SUPPORT then
        project "ygoserver"
            kind "SharedLib"
    else
        project "ygopro"
            filter "system:windows"
                kind "WindowedApp"
            filter "system:not windows"
                kind "ConsoleApp"
            filter {}
    end

    cppdialect "C++14"
    defines { "YGOPRO_SERVER_MODE" }

    files {
        "gframe.cpp", "config.h",
        "game.cpp", "game.h", "file_system.cpp", "file_system.h",
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

    if SERVER_ZIP_SUPPORT then
        defines { "SERVER_ZIP_SUPPORT", "_IRR_STATIC_LIB_" }
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
    project "YGOPro"
        kind "WindowedApp"
        rtti "Off"
        if USE_OPENMP then
            openmp "On"
        end

        dofile("../irrlicht/defines.lua")
        files {
            "*.cpp", "*.h",
            "CGUISkinSystem/*.cpp", "CGUISkinSystem/*.h",
            "CXMLRegistry/*.cpp", "CXMLRegistry/*.h"
        }
end

    includedirs { "../ocgcore" }
    links { "ocgcore" }

    for _, dep in ipairs(DEPENDENCIES_METADATA) do
        if DependencyEnabled(dep) and (dep.name ~= "lua" or not OCGCORE_DYNAMIC) then
            local upper = string.upper(dep.name)
            if dep.name == "freetype" and BUILD_FREETYPE then
                -- Add custom include directory for FreeType before the default include directory.
                includedirs { FREETYPE_CUSTOM_INCLUDE_DIR }
            end
            includedirs { _G[upper .. "_INCLUDE_DIR"] }
            if _G["BUILD_" .. upper] then
                -- Source-built dependencies are linked by their Premake project names.
                links { dep.name }
            else
                links { _G[upper .. "_LIB_NAME"] }
                libdirs { _G[upper .. "_LIB_DIR"] }
            end
        end
    end

    if not BUILD_EVENT and not os.istarget("windows") then
        links { EVENT_PTHREADS_LIB_NAME }
    end

if not SERVER_MODE then
    if USE_SIMD == "none" then
        defines { "STBIR_NO_SIMD" }
    end

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
                    links { OPUSFILE_LIB_NAME, VORBISFILE_LIB_NAME, OPUS_LIB_NAME, VORBIS_LIB_NAME, OGG_LIB_NAME }
                    libdirs { OPUSFILE_LIB_DIR, OPUS_LIB_DIR, VORBIS_LIB_DIR, OGG_LIB_DIR }
                end
            end
        end
    end
end

    filter "system:windows"
        files "ygopro.rc"
        defines { "NOMINMAX=1", "WIN32_LEAN_AND_MEAN" }
        if SERVER_PRO2_SUPPORT and not SERVER_PRO3_SUPPORT then
            targetname "AI.Server"
        end
        if SERVER_MODE then
            links { "ws2_32", "iphlpapi" }
        else
            links { "ws2_32", "Dnsapi", "iphlpapi", "winmm" }
            if USE_DXSDK then
                defines { "IRR_COMPILE_WITH_DX9_DEV_PACK" }
            else
                defines { "NO_IRR_COMPILE_WITH_DIRECT3D_9_" }
            end
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
        defines { "YGOPRO_FONT_WINDOW_SCALED" }
        links { "GL" }
        if IRR_BUILD_X11 then
            links { "X11" }
        end
        if IRR_WAYLAND_DIRECT_LINK then
            links { "wayland-client", "wayland-egl", "wayland-cursor", "xkbcommon", "EGL", "decor-0" }
        end
        if USE_OPENMP then
            linkoptions { "-fopenmp" }
        end
end
        if USE_DYNAMIC then
            linkoptions { "-Wl,-rpath=./" }
        else
            linkoptions { "-static-libstdc++", "-static-libgcc" }
        end
