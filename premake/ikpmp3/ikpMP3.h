#include <irrKlang.h>

namespace irrklang
{
#ifdef WIN32
	// Windows version
	extern "C" __declspec(dllexport) void ikpMP3Init(ISoundEngine* engine);
#else
	// Linux version
	extern "C" void ikpMP3Init(ISoundEngine* engine);
#endif
}