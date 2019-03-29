include "lzma/."
include "spmemvfs/."

project "ygopro"
    kind "WindowedApp"

    files { "**.cpp", "**.cc", "**.c", "**.h" }
    excludes { "lzma/**", "spmemvfs/**" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "cspmemvfs", "Irrlicht", "freetype", "sqlite3", "lua" , "event" }
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
    local mr=os.getenv("YGOPRO_DEFAULT_DUEL_RULE")
    if mr and tonumber(mr) then defines { "DEFAULT_DUEL_RULE="..tonumber(mr) } end

    configuration "windows"
        files "ygopro.rc"
        excludes "CGUIButton.cpp"
        includedirs { "../irrlicht/include", "../freetype/include", "../event/include", "../sqlite3" }
        if USE_IRRKLANG then
            links { "irrKlang" }
            if not IRRKLANG_PRO then
                libdirs { "../irrklang/lib/Win32-visualStudio" }
            end
        end
        links { "opengl32", "ws2_32", "winmm", "gdi32", "kernel32", "user32", "imm32" }
    if IRRKLANG_PRO then
        configuration { "windows", "not vs2017" }
            libdirs { "../irrklang/lib/Win32-visualStudio" }
        configuration { "windows", "vs2017" }
            libdirs { "../irrklang/lib/Win32-vs2017" }
    end
    configuration {"windows", "not vs*"}
        includedirs { "/mingw/include/irrlicht", "/mingw/include/freetype2" }
    configuration "not vs*"
        buildoptions { "-std=c++14", "-fno-rtti" }
    configuration "not windows"
        includedirs { "/usr/include/freetype2" }
        excludes { "COSOperator.*" }
        links { "event_pthreads", "GL", "dl", "pthread" }
    configuration "linux"
        includedirs { "../irrlicht_linux/include" }
        links { "X11", "Xxf86vm" }
        if USE_IRRKLANG then
            links { "IrrKlang" }
            linkoptions{ "-Wl,-rpath=./" }
            libdirs { "../irrklang/bin/linux-gcc-64" }
        end
    configuration "macosx"
        includedirs { "/usr/include/irrlicht" }
        if USE_IRRKLANG then
            links { "irrklang" }
            libdirs { "../irrklang/bin/macosx-gcc" }
        end
