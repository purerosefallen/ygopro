#ifndef SERVERAPI_H
#define SERVERAPI_H

#include "game.h"
#include "netserver.h"
#include "network.h"
#include "config.h"
#include "data_manager.h"
#include "gframe.h"
#include <event2/thread.h>
#include <memory>

#ifdef WIN32
#define DECL_DLLEXPORT __declspec(dllexport)
#else
#define DECL_DLLEXPORT
#endif
namespace ygo {
	extern "C" DECL_DLLEXPORT int start_server(const char* args);
	extern "C" DECL_DLLEXPORT void stop_server();
}

#endif // !SERVERAPI_H
