project "ikpmp3"
    kind "StaticLib"

    files { "*.cpp", "*.h", "decoder/*.c", "decoder/*.h" }
    includedirs { "../irrklang/include" }
