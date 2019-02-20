solution "ygo"
    location "build"
    language "C++"
    objdir "obj"
    if (os.ishost("windows") or os.getenv("USE_IRRKLANG")) and not os.getenv("NO_IRRKLANG") then
        USE_IRRKLANG = true
        if os.getenv("irrklang_pro") then
            IRRKLANG_PRO = true
        end
    end

    configurations { "Release", "Debug" }
if os.getenv("YGOPRO_LUA_SAVE") then
    defines { "LUA_COMPAT_5_2", "YGOPRO_LUA_SAFE" }
else
    defines { "LUA_COMPAT_5_2" }
end
    configuration "windows"
        defines { "WIN32", "_WIN32", "WINVER=0x0501" }
        libdirs { "$(DXSDK_DIR)Lib/x86" }
        entrypoint "mainCRTStartup"
        --toolset "v141_xp"
        systemversion "latest"
        startproject "ygopro"

if not os.getenv("YGOPRO_NO_XP_TOOLSET") then
    configuration { "windows", "vs2017" }
        toolset "v141_xp"

    configuration { "windows", "not vs2017" }
        toolset "v140_xp"
end

    configuration "bsd"
        defines { "LUA_USE_POSIX" }
        includedirs { "/usr/local/include" }
        libdirs { "/usr/local/lib" }

    configuration "macosx"
        defines { "LUA_USE_MACOSX", "DBL_MAX_10_EXP=+308", "DBL_MANT_DIG=53" }
        includedirs { "/usr/local/include", "/usr/local/include/*" }
        libdirs { "/usr/local/lib", "/usr/X11/lib" }
        buildoptions { "-stdlib=libc++" }
        links { "OpenGL.framework", "Cocoa.framework", "IOKit.framework" }

    configuration "linux"
        defines { "LUA_USE_LINUX" }
        buildoptions { "-U_FORTIFY_SOURCE" }

    configuration "Release"
        optimize "Speed"
        targetdir "bin/release"

    configuration "Debug"
        symbols "On"
        defines "_DEBUG"
        targetdir "bin/debug"

    configuration { "Release", "vs*" }
        flags { "LinkTimeOptimization" }
if not os.ishost("macosx") then
        staticruntime "On"
end
        disablewarnings { "4244", "4267", "4838", "4577", "4819", "4018", "4996", "4477", "4091", "4305", "4828", "4800" }

    configuration { "Release", "not vs*" }
        symbols "On"
        defines "NDEBUG"
        buildoptions "-march=native"

    configuration { "Debug", "vs*" }
        defines { "_ITERATOR_DEBUG_LEVEL=0" }
        disablewarnings { "4819", "4828" }

    configuration "vs*"
        vectorextensions "SSE2"
        buildoptions { "/utf-8" }
        defines { "_CRT_SECURE_NO_WARNINGS" }
    
    configuration "not vs*"
        buildoptions { "-fno-strict-aliasing", "-Wno-format-security" }

    configuration {"not vs*", "windows"}
        buildoptions { "-static-libgcc" }

    include "lua"
    include "ocgcore"
    include "gframe"
	if os.ishost("windows") then
		include "event"
		include "freetype"
		include "irrlicht"
		include "sqlite3"
	end
	if os.ishost("linux") then
		include "irrlicht_linux"
	end
	if USE_IRRKLANG then
		include "ikpmp3"
	end
