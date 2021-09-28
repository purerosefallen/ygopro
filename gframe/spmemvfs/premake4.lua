project "cspmemvfs"
    kind "StaticLib"
    files { "**.c", "**.h" }

    configuration "windows"
        includedirs { "../../sqlite3" }

    configuration "not windows"
        if BUILD_SQLITE then
            includedirs { "../../sqlite3" }
        end
