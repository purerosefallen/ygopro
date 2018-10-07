
#include <irrKlang.h>
#include <stdio.h>
#include <string.h>
#include "CIrrKlangAudioStreamLoaderMP3.h"

using namespace irrklang;

#ifdef WIN32
// Windows version
extern "C" __declspec(dllexport) void ikpMP3Init(ISoundEngine* engine)
#else
// Linux version
extern "C" void ikpMP3Init(ISoundEngine* engine)
#endif
{
	// create and register the loader

	CIrrKlangAudioStreamLoaderMP3* loader = new CIrrKlangAudioStreamLoaderMP3();
	engine->registerAudioStreamLoader(loader);
	loader->drop();

	// that's it, that's all.
}

