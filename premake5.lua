-- default global settings

BUILD_LUA = true
BUILD_EVENT = os.istarget("windows")
BUILD_FREETYPE = os.istarget("windows")
BUILD_SQLITE = os.istarget("windows")
BUILD_IRRLICHT = not os.istarget("macosx")
LUA_LIB_NAME = "lua"

-- read settings from command line or environment variables

newoption { trigger = "build-lua", category = "YGOPro - lua", description = "" }
newoption { trigger = "no-build-lua", category = "YGOPro - lua", description = "" }
newoption { trigger = "lua-include-dir", category = "YGOPro - lua", description = "", value = "PATH" }
newoption { trigger = "lua-lib-dir", category = "YGOPro - lua", description = "", value = "PATH" }
newoption { trigger = "lua-lib-name", category = "YGOPro - lua", description = "", value = "NAME", default = "lua" }
newoption { trigger = "lua-deb", category = "YGOPro - lua", description = "" }

newoption { trigger = "build-event", category = "YGOPro - event", description = "" }
newoption { trigger = "no-build-event", category = "YGOPro - event", description = "" }
newoption { trigger = "event-include-dir", category = "YGOPro - event", description = "", value = "PATH" }
newoption { trigger = "event-lib-dir", category = "YGOPro - event", description = "", value = "PATH" }

newoption { trigger = "build-freetype", category = "YGOPro - freetype", description = "" }
newoption { trigger = "no-build-freetype", category = "YGOPro - freetype", description = "" }
newoption { trigger = "freetype-include-dir", category = "YGOPro - freetype", description = "", value = "PATH" }
newoption { trigger = "freetype-lib-dir", category = "YGOPro - freetype", description = "", value = "PATH" }

newoption { trigger = "build-sqlite", category = "YGOPro - sqlite", description = "" }
newoption { trigger = "no-build-sqlite", category = "YGOPro - sqlite", description = "" }
newoption { trigger = "sqlite-include-dir", category = "YGOPro - sqlite", description = "", value = "PATH" }
newoption { trigger = "sqlite-lib-dir", category = "YGOPro - sqlite", description = "", value = "PATH" }

newoption { trigger = "build-irrlicht", category = "YGOPro - irrlicht", description = "" }
newoption { trigger = "no-build-irrlicht", category = "YGOPro - irrlicht", description = "" }
newoption { trigger = "irrlicht-include-dir", category = "YGOPro - irrlicht", description = "", value = "PATH" }
newoption { trigger = "irrlicht-lib-dir", category = "YGOPro - irrlicht", description = "", value = "PATH" }

newoption { trigger = "winxp-support", category = "YGOPro", description = "" }
newoption { trigger = "mac-arm", category = "YGOPro", description = "Cross compile for Apple Silicon" }

-- koishipro specific

boolOptions = {
    "compat-mycard",
    "no-lua-safe",
    "message-debug",
    "no-side-check",
}

for _, boolOption in ipairs(boolOptions) do
    newoption { trigger = boolOption, category = "YGOPro - options", description = "" }
end

numberOptions = {
    "default-duel-rule",
    "max-deck",
    "min-deck",
    "max-extra",
    "max-side",
}

for _, numberOption in ipairs(numberOptions) do
    newoption { trigger = numberOption, category = "YGOPro - options", description = "", value = "NUMBER" }
end

function GetParam(param)
    return _OPTIONS[param] or os.getenv(string.upper(string.gsub(param,"-","_")))
end

function ApplyBoolean(param)
    if GetParam(param) then
        defines { "YGOPRO_" .. string.upper(string.gsub(param,"-","_")) }
    end
end

function ApplyNumber(param)
    local value = GetParam(param)
    if not value then return end
    local numberValue = tonumber(value)
    if numberValue then
        defines { "YGOPRO_" .. string.upper(string.gsub(param,"-","_")) .. "=" .. numberValue }
    end
end

if GetParam("build-lua") then
    BUILD_LUA = true
elseif GetParam("no-build-lua") then
    BUILD_LUA = false
end
if not BUILD_LUA then
    -- at most times you need to change this if you change BUILD_LUA to false
    -- make sure your lua lib is built with C++ and version >= 5.3
    LUA_LIB_NAME = GetParam("lua-lib-name")
    LUA_INCLUDE_DIR = GetParam("lua-include-dir") or os.findheader(LUA_LIB_NAME)
    LUA_LIB_DIR = GetParam("lua-lib-dir") or os.findlib(LUA_LIB_NAME)
end

if GetParam("lua-deb") then
    BUILD_LUA = false
    LUA_LIB_DIR = "/usr/lib/x86_64-linux-gnu"
    LUA_LIB_NAME = "lua5.3-c++"
    LUA_INCLUDE_DIR = "/usr/include/lua5.3"
end

if GetParam("build-event") then
    BUILD_EVENT = os.istarget("windows") -- only on windows for now
elseif GetParam("no-build-event") then
    BUILD_EVENT = false
end
if not BUILD_EVENT then
    EVENT_INCLUDE_DIR = GetParam("event-include-dir") or os.findheader("event")
    EVENT_LIB_DIR = GetParam("event-lib-dir") or os.findlib("event")
end

if GetParam("build-freetype") then
    BUILD_FREETYPE = true
elseif GetParam("no-build-freetype") then
    BUILD_FREETYPE = false
end
if not BUILD_FREETYPE then
    FREETYPE_INCLUDE_DIR = GetParam("freetype-include-dir") or os.findheader("freetype")
    FREETYPE_LIB_DIR = GetParam("freetype-lib-dir") or os.findlib("freetype")
end

if GetParam("build-sqlite") then
    BUILD_SQLITE = true
elseif GetParam("no-build-sqlite") then
    BUILD_SQLITE = false
end
if not BUILD_SQLITE then
    SQLITE_INCLUDE_DIR = GetParam("sqlite-include-dir") or os.findheader("sqlite3")
    SQLITE_LIB_DIR = GetParam("sqlite-lib-dir") or os.findlib("sqlite3")
end

if GetParam("build-irrlicht") then
    BUILD_IRRLICHT = true
elseif GetParam("no-build-irrlicht") then
    BUILD_IRRLICHT = false
end
if not BUILD_IRRLICHT then
    IRRLICHT_INCLUDE_DIR = GetParam("irrlicht-include-dir") or os.findheader("irrlicht")
    IRRLICHT_LIB_DIR = GetParam("irrlicht-lib-dir") or os.findlib("irrlicht")
end

USE_AUDIO = not GetParam("no-audio")

if GetParam("winxp-support") and os.istarget("windows") then
    WINXP_SUPPORT = true
end
if os.istarget("macosx") then
    MAC_ARM = false
    if GetParam("mac-arm") then
        MAC_ARM = true
    end
end

workspace "YGOPro"
    location "build"
    language "C++"
    objdir "obj"    

    configurations { "Release", "Debug" }


    for _, numberOption in ipairs(numberOptions) do
        ApplyNumber(numberOption)
    end

    for _, boolOption in ipairs(boolOptions) do
        ApplyBoolean(boolOption)
    end


    filter "system:windows"
        defines { "WIN32", "_WIN32" }
        entrypoint "mainCRTStartup"
        systemversion "latest"
        startproject "YGOPro"
        if WINXP_SUPPORT then
            defines { "WINVER=0x0501" }
            toolset "v141_xp"
        else
            defines { "WINVER=0x0601" } -- WIN7
        end

    filter "system:macosx"
        libdirs { "/usr/local/lib" }
        buildoptions { "-stdlib=libc++" }
        if MAC_ARM then
            buildoptions { "--target=arm64-apple-macos12" }
        end
        links { "OpenGL.framework", "Cocoa.framework", "IOKit.framework" }

    filter "system:linux"
        buildoptions { "-U_FORTIFY_SOURCE" }

    filter "configurations:Release"
        optimize "Speed"
        targetdir "bin/release"

    filter "configurations:Debug"
        symbols "On"
        defines "_DEBUG"
        targetdir "bin/debug"

    filter { "configurations:Release", "action:vs*" }
        if linktimeoptimization then
            linktimeoptimization "On"
        else
            flags { "LinkTimeOptimization" }
        end
        staticruntime "On"
        disablewarnings { "4244", "4267", "4838", "4577", "4018", "4996", "4477", "4091", "4800", "6011", "6031", "6054", "6262" }

    filter { "configurations:Release", "not action:vs*" }
        symbols "On"
        defines "NDEBUG"
        if not MAC_ARM then
            buildoptions "-march=native"
        end

    filter { "configurations:Debug", "action:vs*" }
        disablewarnings { "6011", "6031", "6054", "6262" }

    filter "action:vs*"
        vectorextensions "SSE2"
        buildoptions { "/utf-8" }
        defines { "_CRT_SECURE_NO_WARNINGS" }

    filter "not action:vs*"
        buildoptions { "-fno-strict-aliasing", "-Wno-multichar", "-Wno-format-security" }

    filter {}

    include "ocgcore"
    include "gframe"
    if BUILD_LUA then
        include "lua"
    end
    if BUILD_EVENT then
        include "event"
    end
    if BUILD_FREETYPE then
        include "freetype"
    end
    if BUILD_IRRLICHT then
        include "irrlicht"
    end
    if BUILD_SQLITE then
        include "sqlite3"
    end
