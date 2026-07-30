#ifndef YGOPRO_CONFIG_H
#define YGOPRO_CONFIG_H

#define IRR_COMPILE_WITH_DX9_DEV_PACK

#include <cerrno>
#include <cstdio>
#include <string>
#include <vector>
#include "bufferio.h"
#include "../ocgcore/ocgapi.h"

#ifdef _WIN32

#if defined(_MSC_VER) || defined(__MINGW32__)
#define mywcsncasecmp _wcsnicmp
#define mystrncasecmp _strnicmp
#else
#define mywcsncasecmp wcsncasecmp
#define mystrncasecmp strncasecmp
#endif

#else //_WIN32

#define mywcsncasecmp wcsncasecmp
#define mystrncasecmp strncasecmp

#include <wchar.h>
inline int _wtoi(const wchar_t * str){
	return (int)wcstol(str, 0, 10);
}
#endif // _WIN32

template<size_t N, typename... TR>
inline int myswprintf(wchar_t(&buf)[N], const wchar_t* fmt, TR... args) {
	return std::swprintf(buf, N, fmt, args...);
}
template<size_t N, typename... TR>
inline int mysnprintf(char(&buf)[N], const char* fmt, TR... args) {
	return std::snprintf(buf, N, fmt, args...);
}
template<typename T>
inline T myclamp(T v, T lo, T hi) {
	return (v < lo) ? lo : (hi < v) ? hi : v;
}

#if !defined(YGOPRO_SERVER_MODE) || defined(SERVER_ZIP_SUPPORT)
#include <irrlicht.h>
#endif

#ifdef YGOPRO_SERVER_MODE
#define SHARE_VERSION constexpr
#else
#if defined(_MSC_VER)
#  define SHARE_VERSION __declspec(selectany)
#else
#  define SHARE_VERSION __attribute__((weak))
#endif
#endif

extern "C" {
	SHARE_VERSION uint16_t PRO_VERSION = 0x1362;
}

extern unsigned int enable_log;
extern bool exit_on_return;
extern bool auto_watch_mode;
extern bool open_file;
extern wchar_t open_file_name[256];
extern bool bot_mode;
extern std::vector<std::wstring> expansions_list;
extern std::vector<std::wstring> extra_script_list;

#endif // YGOPRO_CONFIG_H
