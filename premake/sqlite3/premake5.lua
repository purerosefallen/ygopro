project "sqlite3"
    kind "StaticLib"

    files { "sqlite3.c", "sqlite3.h" }

if not SERVER_PRO3_SUPPORT then
    defines {
        "SQLITE_DQS=0",
        "SQLITE_DEFAULT_MEMSTATUS=0",
        "SQLITE_MAX_EXPR_DEPTH=0",
        "SQLITE_OMIT_DECLTYPE",
        "SQLITE_OMIT_DEPRECATED",
        "SQLITE_OMIT_PROGRESS_CALLBACK",
        "SQLITE_OMIT_SHARED_CACHE",
        "SQLITE_TRUSTED_SCHEMA=0",
    }
end

if SERVER_PRO3_SUPPORT then
    filter "system:windows"
        defines { "SQLITE_API=__declspec(dllexport)" }
end
