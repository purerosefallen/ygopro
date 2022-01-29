include "lzma/."
include "spmemvfs/."

project "ygopro"
    kind "WindowedApp"

    files { "**.cpp", "**.cc", "**.c", "**.h" }
    excludes { "lzma/**", "spmemvfs/**" }
    includedirs { "../ocgcore", "../irrlicht/include" }
    links { "ocgcore", "clzma", "cspmemvfs", "Irrlicht", "sqlite3", "freetype", "event" }
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
    end
    local mr=os.getenv("YGOPRO_DEFAULT_DUEL_RULE")
    if mr and tonumber(mr) then defines { "DEFAULT_DUEL_RULE="..tonumber(mr) } end

    configuration "windows"
        files "ygopro.rc"
        excludes "CGUIButton.cpp"
        includedirs { "../freetype/include", "../event/include", "../sqlite3" }
        links { "lua" }
        defines { "_IRR_WCHAR_FILESYSTEM" }
        if USE_IRRKLANG then
            links { "irrKlang" }
            if not IRRKLANG_PRO then
                libdirs { "../irrklang/lib/Win32-visualStudio" }
            end
        end
        links { "opengl32", "ws2_32", "winmm", "gdi32", "kernel32", "user32", "imm32" }
    if IRRKLANG_PRO then
        configuration { "windows", "not vs2017", "not vs2019" }
            libdirs { "../irrklang/lib/Win32-visualStudio" }
        configuration { "windows", "vs2017" }
            libdirs { "../irrklang/lib/Win32-vs2017" }
        configuration { "windows", "vs2019" }
            libdirs { "../irrklang/lib/Win32-vs2019" }
    end
    configuration {"windows", "not vs*"}
        includedirs { "/mingw/include/irrlicht", "/mingw/include/freetype2" }
    configuration "not vs*"
        buildoptions { "-std=c++14", "-fno-rtti" }
    configuration "not windows"
        excludes { "COSOperator.*" }
        links { "dl", "pthread" }
        if LIBEVENT_ROOT then
            includedirs { LIBEVENT_ROOT.."/include" }
            libdirs { LIBEVENT_ROOT.."/lib/" }
        end
        links { "event_pthreads" }
        if BUILD_SQLITE then
            includedirs { "../sqlite3" }
        end
        if BUILD_FREETYPE then
            includedirs {"../freetype/include" }
        else
            includedirs { "/usr/include/freetype2" }
        end
    configuration { "not windows", "not macosx" }
        links "GL"
    configuration "linux"
        linkoptions { "-static-libstdc++", "-static-libgcc", "-Wl,-rpath=./lib/" }
        if BUILD_LUA then
            links { "lua" }
        else
            links { "lua5.3-c++" }
        end
        links { "X11", "Xxf86vm" }
        if USE_IRRKLANG then
            links { "IrrKlang" }
            libdirs { "../irrklang/bin/linux-gcc-64" }
        end
    configuration "macosx"
        links { "lua", "z" }
        libdirs { "../irrlicht" }
        if MAC_ARM then
            buildoptions { "--target=arm64-apple-macos11" }
            linkoptions { "-arch arm64" }
        end
        if USE_IRRKLANG then
            links { "irrklang" }
            libdirs { "../irrklang/bin/macosx-gcc" }
        end
