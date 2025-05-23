project "sqlite3"
    kind "StaticLib"

    files { "sqlite3.c", "sqlite3.h" }

if SERVER_PRO3_SUPPORT then
    filter "system:windows"
        defines { "SQLITE_API=__declspec(dllexport)" }
end
