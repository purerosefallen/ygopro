#include "config.h"
#include "game.h"
#include "data_manager.h"
#include <event2/thread.h>
#include <memory>
#ifdef __APPLE__
#import <CoreFoundation/CoreFoundation.h>
#endif

#ifdef YGOPRO_SERVER_MODE
#ifdef _WIN32
#define YGOPRO_SERVER_INTERNAL
#else
#define YGOPRO_SERVER_INTERNAL __attribute__((visibility("hidden")))
#endif

namespace ygo {
	YGOPRO_SERVER_INTERNAL int RunServer(int argc, const char* const argv[]);
}

#undef YGOPRO_SERVER_INTERNAL
#endif // YGOPRO_SERVER_MODE
