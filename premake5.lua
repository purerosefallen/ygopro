----- YGOPro build configuration script using Premake5

--- Supported systems: Windows, Linux, macOS

-- Windows (Visual Studio) build supports x86, x86_64, and ARM64, with cross-compilation support.
-- Linux build supports x86_64 and ARM64.
-- macOS build supports x86_64 and ARM64, with cross-compilation support.

---- Global settings

--- Use global variables to share settings across different scripts.

USE_DXSDK = true

USE_AUDIO = true
AUDIO_LIB = "miniaudio" -- only miniaudio is supported for now
OCGCORE_DYNAMIC = false
USE_DYNAMIC = false

SERVER_MODE = true
SERVER_ZIP_SUPPORT = false
SERVER_PRO2_SUPPORT = false
SERVER_TAG_SURRENDER_CONFIRM = false
SERVER_PRO3_SUPPORT = false

DISPLAY_BACKEND = "auto"
IRR_BUILD_X11 = false
IRR_BUILD_WAYLAND = false
IRR_WAYLAND_DIRECT_LINK = false

BUILD_LZMA = os.istarget("windows")

-- Available: none, server, sse2, avx2, neon, best
-- "server" means SSE2 on x86/x64 and NEON on ARM/AArch64.
-- "best" means AVX2 on x86/x64 and NEON on ARM/AArch64.
USE_SIMD = "best"
if os.istarget("linux") then
    local arch = os.hostarch()
    local is_arm = arch == "ARM64" or arch == "AARCH64" or arch == "arm64" or arch == "aarch64" or arch == "ARM" or arch == "arm"
    if not is_arm then
        USE_SIMD = "sse2"
        local cpuinfo = io.popen("grep -m1 '^flags' /proc/cpuinfo 2>/dev/null")
        local flags = ""
        local ok = false
        if cpuinfo then
            flags = cpuinfo:read("*a") or ""
            local result = cpuinfo:close()
            ok = result == true or result == 0
        end
        if ok and flags:find("%f[%w_]avx2%f[^%w_]") then
            USE_SIMD = "best"
        end
    end
end


-- os.hostarch() actually returns the architecture of Premake5, and the official Windows build of Premake5 is 32-bit,
-- so we can only distinguish between AARCH64 and x86, and must use the ARM build of Premake5 on ARM platforms.
PREMAKE_ARCH = os.hostarch()

-- Return val if it's not nil; otherwise, return default.
local function ifnil(val, default)
    if val ~= nil then
        return val
    else
        return default
    end
end

---- Dependency settings

--- When building dependencies from source, the corresponding source code must be placed in the corresponding location
--- in the project folder (local), with the folder name fixed as the dependency name and the folder structure fixed as
--- the official source package extraction.
---
--- Some dependencies need extra configuration (run configure scripts, copy or rename files), see the documentation or
--- the CI workflow script for details.

-- On Windows, build all dependencies from source by default.
-- On Linux/macOS, most dependencies should be installed via the package manager.
BUILD_ALL_FROM_SOURCE = os.istarget("windows")

-- Build Lua from source by default:
-- Most package managers provide Lua compiled as C, but ocgcore requires Lua compiled as C++.
-- Some package managers do provide lua-c++ variants (e.g. liblua5.4-c++.so), which can be specified manually.
BUILD_LUA = true
LUA_LIB_NAME = "lua"

-- Modified Irrlicht is required; the official version from package managers lacks proper CJK support
-- (clipboard and IME). Also, Irrlicht's bundled jpeglib/libpng/zlib/lzma are not used here.
BUILD_IRRLICHT = true

-- miniaudio is always built from source (originally a header-only library, now an independent subproject).
-- When building Opus/Vorbis from source, they are integrated directly into the miniaudio subproject.
-- To simplify the build process, support for Ogg format audio (Opus/Vorbis) is optional.
MINIAUDIO_SUPPORT_OPUS_VORBIS = true
MINIAUDIO_INCLUDE_DIR = path.getabsolute("./miniaudio")
MINIAUDIO_OPUS_INCLUDE_DIR = path.getabsolute("./miniaudio/extras/decoders/libopus")
MINIAUDIO_VORBIS_INCLUDE_DIR = path.getabsolute("./miniaudio/extras/decoders/libvorbis")

-- When building freetype, a custom include dir is prepended to prioritize custom header files.
FREETYPE_CUSTOM_INCLUDE_DIR = path.getabsolute("./freetype/custom")

-- When building libevent from source, event_pthreads is integrated into the event subproject.
-- When not building from source, both "event" and "event_pthreads" need to be linked.
EVENT_PTHREADS_LIB_NAME = "event_pthreads"

-- When building Vorbis from source, vorbisfile is integrated into the miniaudio subproject.
-- When not building from source, both "vorbis" and "vorbisfile" need to be linked.
VORBISFILE_LIB_NAME = "vorbisfile"

--- Dependency metadata entries are used to generate global variables such as LUA_INCLUDE_DIR, LUA_LIB_NAME, LUA_LIB_DIR, etc. during processing.

-- Fields:
--   name (will resolve to global variable prefix)
--   prebuilt_header (for finding directory)
--   prebuilt_header_subdir (for FindHeaderWithSubDir)
--   prebuilt_libname (for prebuilt dependencies only; default: same as name)
--   source_dir (when building dependency from source, its code should be in this directory relative to the project root; default: ./name)
--   source_header_subdir (dependency's header subdirectory relative to source_dir; default: .)
--   no_server_mode (disable this dependency in server builds)
--   server_zip_only (enable this dependency in server builds only when ZIP support is enabled)
--   premake5_lua_path (Premake script file name relative to source_dir; default: premake5.lua)
DEPENDENCIES_METADATA = {
    {
        name = "lua",
        prebuilt_header = "lua.h",
        source_header_subdir = "src",
    },
    {
        name = "event",
        prebuilt_header = "event2/event.h",
        source_header_subdir = "include",
    },
    {
        name = "freetype",
        prebuilt_header = "freetype2/ft2build.h",
        prebuilt_header_subdir = "freetype2",
        source_header_subdir = "include",
        no_server_mode = true,
    },
    {
        name = "sqlite",
        prebuilt_header = "sqlite3.h",
        prebuilt_libname = "sqlite3",
        source_dir = "sqlite3",
    },
    {
        name = "irrlicht",
        prebuilt_header = "irrlicht.h",
        source_header_subdir = "include",
        server_zip_only = true,
        premake5_lua_path = "premake5-only-zipreader.lua",
    },
    {
        name = "jpeg",
        prebuilt_header = "jpeglib.h",
        source_header_subdir = "src",
        no_server_mode = true,
    },
    {
        name = "png",
        prebuilt_header = "png.h",
        no_server_mode = true,
    },
    {
        name = "lzma",
        prebuilt_header = "lzma.h",
        source_header_subdir = "src/liblzma/api",
    },
    {
        name = "zlib",
        prebuilt_header = "zlib.h",
        prebuilt_libname = "z",
        server_zip_only = true,
    },
}

-- These dependencies do not have separate [no-]build-* options; instead, they use [no-]build-opus-vorbis as general build option.
-- When building from source, they are integrated into the miniaudio subproject instead of being maintained as separate subprojects,
-- and their locations are predefined in the miniaudio subproject (./miniaudio/external/*), so those options are ignored in this case.
MINIAUDIO_DEPENDENCIES_METADATA = {
    {
        name = "opus",
        prebuilt_header = "opus/opus.h",
        prebuilt_header_subdir = "opus",
    },
    {
        name = "opusfile",
        prebuilt_header = "opus/opusfile.h",
        prebuilt_header_subdir = "opus",
    },
    {
        name = "vorbis",
        prebuilt_header = "vorbis/vorbisfile.h",
    },
    {
        name = "ogg",
        prebuilt_header = "ogg/ogg.h",
    },
}

---- Register options

--- The *-include-dir, *-lib-dir, and *-lib-name options are only used for prebuilt dependencies.
--- These options are ignored when building from source.
---
--- For *-lib-name option: Most users don't need to set it, as the script already provides conventional values.
--- The only known case where setting it is necessary is when using prebuilt lua-c++, where the lib name must be specified.

--- Platform-specific notes:
---
--- Windows: Prebuilt support is incomplete (static lib, dynamic lib, debug-specific lib to be refined).
---
--- Linux: The script already attempts to automatically locate include and lib paths for prebuilt dependencies.
--- In most cases, you should not need to manually specify parameters.
--- If a package is not found, please specify it manually. In this case, if you installed it from a well-known package manager,
--- please consider reporting the issue.
---
--- macOS: When using Homebrew, use `DYLD_LIBRARY_PATH=$(brew --prefix)/lib` to ensure Homebrew installation paths are found.
--- Note: macOS/Xcode already provides "system" versions of sqlite and zlib; Homebrew treats those packages as "keg-only"
--- and won't install them to common directories. You must manually specify paths to use Homebrew-installed versions.

--- Parameters are read from premake options (priority) and environment variables.
--- Environment variable names are uppercase versions with hyphens replaced by underscores.
---
--- Note on default values: Default values should be defined at the top of the script, not as premake option defaults;
--- otherwise, the premake option default will always take priority over environment variables.

for _, dep in ipairs(DEPENDENCIES_METADATA) do
    local name  = dep.name
    local cat   = "YGOPro - " .. name
    local build = ifnil(_G["BUILD_" .. string.upper(name)], BUILD_ALL_FROM_SOURCE)
    newoption { trigger = "build-"    .. name,    category = cat, description = "Build " .. name .. " from source; default: " .. tostring(build) }
    newoption { trigger = "no-build-" .. name,    category = cat, description = "" }
    newoption { trigger = name .. "-include-dir", category = cat, description = "", value = "PATH" }
    newoption { trigger = name .. "-lib-dir",     category = cat, description = "", value = "PATH" }
    newoption { trigger = name .. "-lib-name",    category = cat, description = "", value = "NAME" }
end
for _, dep in ipairs(MINIAUDIO_DEPENDENCIES_METADATA) do
    local name = dep.name
    local cat  = "YGOPro - miniaudio"
    newoption { trigger = name .. "-include-dir", category = cat, description = "", value = "PATH" }
    newoption { trigger = name .. "-lib-dir",     category = cat, description = "", value = "PATH" }
    newoption { trigger = name .. "-lib-name",    category = cat, description = "", value = "NAME" }
end

newoption { trigger = "build-all", category = "YGOPro", description = "Build all dependencies from source" }
newoption { trigger = "lua-deb", category = "YGOPro - lua", description = "Use the system lua-c++ package" }

newoption { trigger = "no-dxsdk", category = "YGOPro - irrlicht", description = "Do not use DirectX SDK, disable D3D9 support" }
newoption { trigger = "display-backend", category = "YGOPro - Wayland", description = "Linux display backend(s); default: auto", value = "BACKEND", allowed = {
    { "x11", "Build the X11 device" },
    { "wayland", "Build the Wayland device" },
    { "x11,wayland", "Build both Linux display devices" },
    { "auto", "Build every Linux display device whose headers are available" },
}}
newoption { trigger = "wayland-direct-link", category = "YGOPro - Wayland", description = "Directly link all six Wayland runtime libraries" }

newoption { trigger = "no-audio", category = "YGOPro", description = "Disable audio support" }
newoption { trigger = "audio-lib", category = "YGOPro", description = "Specify audio library (only miniaudio is supported for now)", value = "NAME" }

newoption { trigger = "miniaudio-support-opus-vorbis", category = "YGOPro - miniaudio", description = "Enable support for OGG format (Opus and Vorbis) in miniaudio" }
newoption { trigger = "no-miniaudio-support-opus-vorbis", category = "YGOPro - miniaudio", description = "" }
do
    local build_opus_vorbis = ifnil(_G["BUILD_OPUS_VORBIS"], BUILD_ALL_FROM_SOURCE)
    newoption { trigger = "build-opus-vorbis", category = "YGOPro - miniaudio", description = "Build Opus and Vorbis libraries from source; default: " .. tostring(build_opus_vorbis) }
    newoption { trigger = "no-build-opus-vorbis", category = "YGOPro - miniaudio", description = "" }
end

newoption { trigger = "vs2026-win7-support", category = "YGOPro", description = "Enable Windows 7 support (toolset v143) for Visual Studio 2026" }

newoption { trigger = "mac-arm", category = "YGOPro", description = "Cross Compile for Apple Silicon Mac" }
newoption { trigger = "mac-intel", category = "YGOPro", description = "Cross Compile for Intel Mac" }
newoption { trigger = "ocgcore-dynamic", category = "YGOPro - ocgcore", description = "Build ocgcore as dynamic library" }
newoption { trigger = "ndk-dir", category = "YGOPro - android", description = "", value = "PATH" }
newoption { trigger = "android-api-level", category = "YGOPro - android", description = "", value = "LEVEL" }

newoption { trigger = "server-mode", category = "YGOPro - server", description = "" }
newoption { trigger = "server-zip-support", category = "YGOPro - server", description = "" }
newoption { trigger = "server-pro2-support", category = "YGOPro - server", description = "" }
newoption { trigger = "server-pro3-support", category = "YGOPro - server", description = "" }
newoption { trigger = "server-tag-surrender-confirm", category = "YGOPro - server", description = "" }

-- koishipro specific

boolOptions = {
    "compat-mycard",
    "no-lua-safe",
    "message-debug",
    "no-side-check",
    "enable-debug-func",
    "log-lua-memory-size",
    "log-in-chat",
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
    "lua-memory-size",
}

for _, numberOption in ipairs(numberOptions) do
    newoption { trigger = numberOption, category = "YGOPro - options", description = "", value = "NUMBER" }
end

newoption { trigger = "use-openmp", category = "YGOPro", description = "Enable OpenMP support for card picture resizing (only for benchmarking)" }

newoption { trigger = "use-simd", category = "YGOPro", description = "Specify SIMD instruction set", allowed = {
    { "none", "Turn off extra SIMD support" },
    { "server", "Use SSE2 on x86/x64 and NEON on ARM/AArch64" },
    { "sse2", "Use SSE2 instructions" },
    { "avx2", "Use AVX2 instructions" },
    { "neon", "Use NEON instructions" },
    { "best", "Default, use the best SIMD instructions (AVX2 on x86-*, NEON on ARM)" },
}}

---- Process options

-- Read settings from command line or environment variables.
-- Command-line options take priority over environment variables.
function GetParam(param)
    return ifnil(_OPTIONS[param], os.getenv(string.upper(string.gsub(param,"-","_"))))
end

function GetBooleanParam(param)
    if _OPTIONS[param] ~= nil then
        return true
    end
    local value = os.getenv(string.upper(string.gsub(param,"-","_")))
    if value == nil then
        return false
    end
    value = string.lower(value)
    return value ~= "" and value ~= "0" and value ~= "false" and value ~= "no" and value ~= "off"
end

local function ApplyBoolean(param)
    if GetBooleanParam(param) then
        defines { "YGOPRO_" .. string.upper(string.gsub(param,"-","_")) }
    end
end

local function ApplyNumber(param)
    local value = GetParam(param)
    if not value then return end
    local numberValue = tonumber(value)
    if numberValue then
        defines { "YGOPRO_" .. string.upper(string.gsub(param,"-","_")) .. "=" .. numberValue }
    end
end

local function FindHeaderWithSubDir(header, subdir)
    local result = os.findheader(header)
    if result and subdir then
        result = path.join(result, subdir)
    end
    return result
end

function QuoteIfNeeded(value)
    if string.find(value, " ", 1, true) then
        return "\"" .. value .. "\""
    end
    return value
end

function FindAndroidToolchainBin(ndkDir)
    local prebuiltDir = path.join(ndkDir, "toolchains/llvm/prebuilt")
    local prebuilts = os.matchdirs(path.join(prebuiltDir, "*"))
    table.sort(prebuilts)
    if #prebuilts == 0 then
        error("Android NDK toolchain not found under " .. prebuiltDir)
    end
    return path.join(prebuilts[1], "bin")
end

ANDROID_ENABLED = false
ANDROID_NDK_DIR = GetParam("ndk-dir")
ANDROID_API_LEVEL_TEXT = GetParam("android-api-level") or "26"
ANDROID_API_LEVEL = tonumber(ANDROID_API_LEVEL_TEXT)
if not ANDROID_API_LEVEL then
    error("Invalid android api level: " .. ANDROID_API_LEVEL_TEXT)
end
if ANDROID_NDK_DIR then
    ANDROID_NDK_DIR = path.getabsolute(ANDROID_NDK_DIR)
    if not os.isdir(ANDROID_NDK_DIR) then
        error("Android NDK directory not found: " .. ANDROID_NDK_DIR)
    end
    ANDROID_ENABLED = true
    ANDROID_TOOLCHAIN_BIN = FindAndroidToolchainBin(ANDROID_NDK_DIR)
    ANDROID_TARGET = "aarch64-linux-android" .. ANDROID_API_LEVEL
    premake.override(premake.tools.clang, "gettoolname", function(base, cfg, tool)
        if cfg.system == premake.ANDROID then
            if tool == "cc" then
                return QuoteIfNeeded(path.join(ANDROID_TOOLCHAIN_BIN, "clang")) .. " --target=" .. ANDROID_TARGET
            elseif tool == "cxx" then
                return QuoteIfNeeded(path.join(ANDROID_TOOLCHAIN_BIN, "clang++")) .. " --target=" .. ANDROID_TARGET
            elseif tool == "ar" then
                return QuoteIfNeeded(path.join(ANDROID_TOOLCHAIN_BIN, "llvm-ar"))
            end
        end
        return base(cfg, tool)
    end)
end

if GetBooleanParam("server-mode") then
    SERVER_MODE = true
end
if GetBooleanParam("server-zip-support") then
    SERVER_ZIP_SUPPORT = true
end
if GetBooleanParam("server-pro2-support") then
    SERVER_PRO2_SUPPORT = true
    SERVER_ZIP_SUPPORT = true
    SERVER_TAG_SURRENDER_CONFIRM = true
end
if GetBooleanParam("server-pro3-support") then
    SERVER_PRO3_SUPPORT = true
    SERVER_ZIP_SUPPORT = true
    SERVER_TAG_SURRENDER_CONFIRM = true
end
if GetBooleanParam("server-tag-surrender-confirm") then
    SERVER_TAG_SURRENDER_CONFIRM = true
end

local function ResolveDirectoryVariableToFullPath(varname)
    local dir = _G[varname]
    if not dir or dir == "" then
        print("::warning:: " .. varname .. " is not set")
        return
    elseif not os.isdir(dir) then
        print("::warning:: " .. varname .. " is not a valid directory: " .. dir)
        return
    end
    _G[varname] = path.getabsolute(dir)
end

function DependencyEnabled(dep)
    if SERVER_MODE and dep.no_server_mode then
        return false
    end
    if SERVER_MODE and dep.server_zip_only and not SERVER_ZIP_SUPPORT then
        return false
    end
    return true
end

-- Set dependency directories from command line or environment variables, and check their validity.
local function ResolvePreBuiltDependencyDirectory(dep)
    local upper = string.upper(dep.name)
    local include_dir_var = upper .. "_INCLUDE_DIR"
    local lib_name_var = upper .. "_LIB_NAME"
    local lib_dir_var = upper .. "_LIB_DIR"
    _G[include_dir_var] = GetParam(dep.name .. "-include-dir") or FindHeaderWithSubDir(dep.prebuilt_header, dep.prebuilt_header_subdir)
    _G[lib_name_var] = GetParam(dep.name .. "-lib-name") or dep.prebuilt_libname or dep.name
    _G[lib_dir_var] = GetParam(dep.name .. "-lib-dir") or os.findlib(_G[lib_name_var])
    ResolveDirectoryVariableToFullPath(include_dir_var)
    ResolveDirectoryVariableToFullPath(lib_dir_var)
end

-- Set the include directory for a dependency being built from source, and validate its path.
local function ResolveBuildFromSourceDependencyDirectory(dep)
    local upper = string.upper(dep.name)
    local include_dir_var = upper .. "_INCLUDE_DIR"
    local source_dir = dep.source_dir or ("./" .. dep.name)
    local source_header_subdir = dep.source_header_subdir or "."
    _G[include_dir_var] = path.join(source_dir, source_header_subdir)
    ResolveDirectoryVariableToFullPath(include_dir_var)
end

local build_all = GetBooleanParam("build-all")
if build_all then
    BUILD_ALL_FROM_SOURCE = true
end

-- Process build flags and external directory settings for all library dependencies.
for _, dep in ipairs(DEPENDENCIES_METADATA) do
    local name  = dep.name
    local upper = string.upper(name)
    local flag  = "BUILD_" .. upper
    local build = build_all or ifnil(_G[flag], BUILD_ALL_FROM_SOURCE)
    if GetBooleanParam("no-build-" .. name) then
        build = false
    elseif GetBooleanParam("build-" .. name) then
        build = true
    end
    if not DependencyEnabled(dep) then
        build = false
    end
    _G[flag] = build
    if build then
        ResolveBuildFromSourceDependencyDirectory(dep)
    elseif DependencyEnabled(dep) then
        ResolvePreBuiltDependencyDirectory(dep)
    end
end

if GetBooleanParam("lua-deb") then
    BUILD_LUA = false
    local lua_versions = { "5.4", "5.3" }
    local lua_version = nil
    for _, version in ipairs(lua_versions) do
        local lua_lib_dir = os.findlib("lua" .. version .. "-c++")
        if lua_lib_dir then
            print("Found lua " .. version .. " at " .. lua_lib_dir)
            lua_version = version
            LUA_LIB_DIR = lua_lib_dir
            break
        end
    end
    if not lua_version then
        error("Lua library not found. Please install liblua5.4-c++ or liblua5.3-c++.")
    end
    LUA_LIB_NAME = "lua" .. lua_version .. "-c++"
    LUA_INCLUDE_DIR = path.getabsolute(path.join("/usr/include", "lua" .. lua_version))
    ResolveDirectoryVariableToFullPath("LUA_LIB_DIR")
end

if GetBooleanParam("no-dxsdk") then
    USE_DXSDK = false
end

if not SERVER_MODE then
    local requested = GetParam("display-backend")
    DISPLAY_BACKEND = requested or DISPLAY_BACKEND

    if not os.istarget("linux") then
        if requested and requested ~= "auto" then
            error("--display-backend is only supported for Linux targets")
        end
        if GetParam("wayland-direct-link") ~= nil then
            error("--wayland-direct-link is only supported for Linux targets")
        end
    else
        local valid = DISPLAY_BACKEND == "x11" or DISPLAY_BACKEND == "wayland" or
            DISPLAY_BACKEND == "x11,wayland" or DISPLAY_BACKEND == "auto"
        if not valid then
            error("Unknown display backend: " .. tostring(DISPLAY_BACKEND))
        end

        local x11_header = os.findheader("X11/Xlib.h")
        local wayland_client_header = os.findheader("wayland-client.h")
        local wayland_egl_header = os.findheader("wayland-egl.h")
        local wayland_cursor_header = os.findheader("wayland-cursor.h")
        local xkb_header = os.findheader("xkbcommon/xkbcommon.h")
        local egl_header = os.findheader("EGL/egl.h")
        local x11_library = os.findlib("X11")
        local wayland_client_library = os.findlib("wayland-client")
        local wayland_egl_library = os.findlib("wayland-egl")
        local wayland_cursor_library = os.findlib("wayland-cursor")
        local xkb_library = os.findlib("xkbcommon")
        local egl_library = os.findlib("EGL")
        local x11_available = x11_header ~= nil and x11_library ~= nil
        local decor_library = os.findlib("decor-0")
        local wayland_available = wayland_client_header ~= nil and wayland_egl_header ~= nil and
            wayland_cursor_header ~= nil and xkb_header ~= nil and egl_header ~= nil

        if DISPLAY_BACKEND == "auto" then
            IRR_BUILD_X11 = x11_available
            IRR_BUILD_WAYLAND = wayland_available
            print("display-backend auto: X11 " .. (IRR_BUILD_X11 and "enabled" or "disabled (missing X11 headers or library)"))
            if IRR_BUILD_WAYLAND then
                print("display-backend auto: Wayland enabled")
            else
                local missing = {}
                if not wayland_client_header then table.insert(missing, "wayland-client.h") end
                if not wayland_egl_header then table.insert(missing, "wayland-egl.h") end
                if not wayland_cursor_header then table.insert(missing, "wayland-cursor.h") end
                if not xkb_header then table.insert(missing, "xkbcommon/xkbcommon.h") end
                if not egl_header then table.insert(missing, "EGL/egl.h") end
                print("display-backend auto: Wayland disabled (missing " .. table.concat(missing, ", ") .. ")")
            end
        else
            IRR_BUILD_X11 = DISPLAY_BACKEND == "x11" or DISPLAY_BACKEND == "x11,wayland"
            IRR_BUILD_WAYLAND = DISPLAY_BACKEND == "wayland" or DISPLAY_BACKEND == "x11,wayland"
            if IRR_BUILD_X11 and not x11_available then
                error("X11 display backend requested, but its headers or library were not found")
            end
            if IRR_BUILD_WAYLAND and not wayland_available then
                error("Wayland display backend requested, but required headers were not found")
            end
            print("display-backend " .. DISPLAY_BACKEND .. ": X11 " .. (IRR_BUILD_X11 and "enabled" or "disabled") ..
                ", Wayland " .. (IRR_BUILD_WAYLAND and "enabled" or "disabled"))
        end

        if not IRR_BUILD_X11 and not IRR_BUILD_WAYLAND then
            error("No usable Linux display backend was found")
        end

        local direct_link_requested = GetParam("wayland-direct-link") ~= nil
        if direct_link_requested and not IRR_BUILD_WAYLAND then
            error("--wayland-direct-link requires a Wayland display backend")
        end
        IRR_WAYLAND_DIRECT_LINK = IRR_BUILD_WAYLAND and direct_link_requested
        if IRR_WAYLAND_DIRECT_LINK then
            local missing = {}
            if not wayland_client_library then table.insert(missing, "libwayland-client") end
            if not wayland_egl_library then table.insert(missing, "libwayland-egl") end
            if not wayland_cursor_library then table.insert(missing, "libwayland-cursor") end
            if not xkb_library then table.insert(missing, "libxkbcommon") end
            if not egl_library then table.insert(missing, "libEGL") end
            if not decor_library then table.insert(missing, "libdecor-0") end
            if #missing > 0 then
                error("Direct-linked Wayland requested, but required libraries were not found: " .. table.concat(missing, ", "))
            end
        end
        print("Wayland libraries: " .. (IRR_WAYLAND_DIRECT_LINK and
            "all six directly linked" or
            (IRR_BUILD_WAYLAND and "all six loaded at runtime" or "not used")))
    end
end
if USE_DXSDK and os.istarget("windows") then
    if not os.getenv("DXSDK_DIR") then
        print("::warning:: DXSDK_DIR environment variable not set, it seems you don't have the DirectX SDK installed. DirectX mode will be disabled.")
        USE_DXSDK = false
    end
end

if GetBooleanParam("no-audio") then
    USE_AUDIO = false
end
if SERVER_MODE then
    USE_AUDIO = false
end

if USE_AUDIO and not SERVER_MODE then
    AUDIO_LIB = GetParam("audio-lib") or AUDIO_LIB
    if AUDIO_LIB == "miniaudio" then
        if GetBooleanParam("no-miniaudio-support-opus-vorbis") then
            MINIAUDIO_SUPPORT_OPUS_VORBIS = false
        elseif GetBooleanParam("miniaudio-support-opus-vorbis") then
            MINIAUDIO_SUPPORT_OPUS_VORBIS = true
        end
        if MINIAUDIO_SUPPORT_OPUS_VORBIS then
            MINIAUDIO_BUILD_OPUS_VORBIS = BUILD_ALL_FROM_SOURCE
            if GetBooleanParam("no-build-opus-vorbis") then
                MINIAUDIO_BUILD_OPUS_VORBIS = false
            elseif GetBooleanParam("build-opus-vorbis") then
                MINIAUDIO_BUILD_OPUS_VORBIS = true
            end
            if MINIAUDIO_BUILD_OPUS_VORBIS then
                -- Opus, Vorbis and Ogg dependencies are integrated into the miniaudio subproject instead of being maintained as separate subprojects.
                -- Since their locations are predefined in the miniaudio subproject, nothing needs to be done here.
            else
                for _, dep in ipairs(MINIAUDIO_DEPENDENCIES_METADATA) do
                    ResolvePreBuiltDependencyDirectory(dep)
                end
            end
        end
    else
        error("Unknown audio library: " .. AUDIO_LIB)
    end
end

USE_SIMD = GetParam("use-simd") or USE_SIMD

if table.indexof({ "none", "server", "sse2", "avx2", "neon", "best" }, USE_SIMD) == nil then
    error("Unknown SIMD setting: " .. USE_SIMD)
end

-- Variables indicating the target Mac architecture for cross-compilation; automatically detected based on Premake's
-- host architecture if neither --mac-arm nor --mac-intel is specified.
local mac_arm = false
local mac_intel = false

if os.istarget("macosx") then
    if GetBooleanParam("mac-arm") then
        mac_arm = true
    end
    if GetBooleanParam("mac-intel") then
        mac_intel = true
    end
end

if not mac_arm and not mac_intel and table.indexof({ "x86", "x86_64", "ARM", "ARM64", "AARCH64", "arm64", "aarch64" }, PREMAKE_ARCH) == nil then
    print("::warning:: Detected architecture '" .. PREMAKE_ARCH .. "' is not recognized. Proceeding with the build; SIMD will be disabled.")
    USE_SIMD = "none"
end

-- Normalize "avx2" and "neon" to "best": downstream code only checks "best",
-- which already maps to AVX2 on x86-* and NEON on ARM.
if USE_SIMD == "avx2" or USE_SIMD == "neon" then
    USE_SIMD = "best"
end

if os.istarget("windows") and GetBooleanParam("vs2026-win7-support") then
    WIN7_SUPPORT = true
end

if GetBooleanParam("ocgcore-dynamic") then
    OCGCORE_DYNAMIC = true
end

if GetBooleanParam("use-openmp") then
    USE_OPENMP = true
    if os.istarget("macosx") then
        print("::warning:: OpenMP is not supported on Clang provided by Xcode.")
    end
end

if OCGCORE_DYNAMIC then
    USE_DYNAMIC = true
end

---- Premake workspace and project configuration

workspace "YGOPro"
    location "build"
    language "C++"
    objdir "obj"

    configurations { "Release", "Debug" }

    if ANDROID_ENABLED then
        platforms { "android_arm64" }
    end

    for _, numberOption in ipairs(numberOptions) do
        ApplyNumber(numberOption)
    end

    for _, boolOption in ipairs(boolOptions) do
        ApplyBoolean(boolOption)
    end

    if SERVER_PRO3_SUPPORT then
        defines { "LUA_USE_LONGJMP" }
    end

    filter "system:windows"
        systemversion "latest"
        startproject "YGOPro"
        -- Target Windows 7 or later. (Building requires Windows 10 SDK 1803 or newer.)
        defines { "WINVER=0x0601", "_WIN32_WINNT=0x0601" }

    if WIN7_SUPPORT then
        filter { "system:windows", "action:vs2026" }
            toolset "v143"
    end

    filter { "system:windows", "action:vs*" }
        platforms { "Win32", "x64", "ARM64" }
        defaultplatform "x64"

    filter { "system:windows", "action:vs*", "platforms:Win32" }
        architecture "x86"
        if USE_SIMD == "none" then
            vectorextensions "IA32"
        end
        if USE_SIMD == "server" or USE_SIMD == "sse2" then
            vectorextensions "SSE2"
        end
        if USE_SIMD == "best" then
            vectorextensions "AVX2"
        end

    filter { "system:windows", "action:vs*", "platforms:x64" }
        architecture "x86_64"
        -- x86_64 must have SSE2, so we shouldn't check USE_SIMD for SSE2
        if USE_SIMD == "best" then
            vectorextensions "AVX2"
        end

    filter { "system:windows", "action:vs*", "platforms:ARM64" }
        architecture "AARCH64"

    filter "platforms:android_arm64"
        architecture "ARM64"
        system "android"
        toolset "clang"
        pic "On"

    filter "system:macosx"
        systemversion "11"
        if mac_arm and mac_intel then
            print("::warning:: Universal binary is no longer supported. Please choose either --mac-arm or --mac-intel and combine the binaries with lipo manually.")
            mac_arm = false
            mac_intel = false
        end
        if not mac_arm and not mac_intel then
            if PREMAKE_ARCH == "ARM64" then
                mac_arm = true
            else
                mac_intel = true
            end
        end
        -- We need to specify architecture on macOS to make the premake filters work correctly.
        if mac_arm then
            architecture "AARCH64"
        end
        if mac_intel then
            architecture "x86_64"
        end

    -- We need to specify architecture on Linux to make the premake filters work correctly.
    filter "system:linux"
        if PREMAKE_ARCH == "ARM64" or PREMAKE_ARCH == "arm64" or PREMAKE_ARCH == "aarch64" then
            architecture "AARCH64"
        else
            architecture "x86_64"
        end

    filter "configurations:Release"
        optimize "Speed"
        targetdir "bin/release"

    filter { "platforms:android_arm64", "configurations:Release" }
        targetdir "bin/android_arm64/release"

    filter "configurations:Debug"
        symbols "On"
        defines "_DEBUG"
        targetdir "bin/debug"

    filter { "platforms:android_arm64", "configurations:Debug" }
        targetdir "bin/android_arm64/debug"

    filter { "system:windows", "platforms:Win32", "configurations:Release" }
        targetdir "bin/release/x86"

    filter { "system:windows", "platforms:Win32", "configurations:Debug" }
        targetdir "bin/debug/x86"

    filter { "system:windows", "platforms:x64", "configurations:Release" }
        targetdir "bin/release/x64"

    filter { "system:windows", "platforms:x64", "configurations:Debug" }
        targetdir "bin/debug/x64"

    filter { "system:windows", "platforms:ARM64", "configurations:Release" }
        targetdir "bin/release/arm64"

    filter { "system:windows", "platforms:ARM64", "configurations:Debug" }
        targetdir "bin/debug/arm64"

    filter { "configurations:Release", "action:vs*" }
        linktimeoptimization "On"
        staticruntime "On"
        disablewarnings {
            "4996", -- Currently only some dependencies use deprecated functions.
        }

    filter { "configurations:Release", "not action:vs*" }
        defines "NDEBUG"

    filter "action:vs*"
        cdialect "C11"
        conformancemode "On"
        buildoptions { "/utf-8" }
        defines { "_CRT_SECURE_NO_WARNINGS" }
        disablewarnings {
            "4244", -- Intentional narrowing conversions are pervasive in the program and dependencies.
            "4267", -- The 32-bit APIs frequently consume container sizes represented by size_t on 64-bit builds.
        }

    filter "action:gmake"
        buildoptions { "-fno-strict-aliasing", "-Wno-multichar", "-Wno-format-security" }

    filter { "action:gmake", "architecture:x86_64" }
        if USE_SIMD == "best" then
            vectorextensions "AVX2"
            isaextensions { "FMA" }
        end

    filter { "action:gmake", "architecture:AARCH64" }
        buildoptions { "-Wno-psabi" }
        pic "On"

    filter { "system:android", "language:C++" }
        linkoptions { "-static-libstdc++" }

if SERVER_PRO3_SUPPORT then
    filter "not action:vs*"
        pic "On"
end

    filter {}

    include "ocgcore"
    include "gframe"
    for _, dep in ipairs(DEPENDENCIES_METADATA) do
        if DependencyEnabled(dep) and _G["BUILD_" .. string.upper(dep.name)] then
            -- Build dependency as subproject, using our pre-provided premake script (copy from the premake directory of the project before running premake)
            local source_dir = dep.source_dir or dep.name
            local premake5_lua_path = dep.premake5_lua_path or "premake5.lua"
            include(path.join(source_dir, premake5_lua_path))
        end
    end
    if USE_AUDIO then
        if AUDIO_LIB == "miniaudio" then
            include "miniaudio/."
        end
    end
