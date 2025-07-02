#ifndef SERVERAPI_H
#define SERVERAPI_H

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

#ifndef YGOSERVER_API
#if defined(__EMSCRIPTEN__)
  #include <emscripten/emscripten.h>
  #define YGOSERVER_API EXTERN_C EMSCRIPTEN_KEEPALIVE
#elif defined(_WIN32)
#define YGOSERVER_API EXTERN_C __declspec(dllexport)
#else
#define YGOSERVER_API EXTERN_C __attribute__ ((visibility ("default")))
#endif
#endif

namespace ygo {
	YGOSERVER_API int start_server(const char* args);
	YGOSERVER_API void stop_server();
}

#endif // !SERVERAPI_H
