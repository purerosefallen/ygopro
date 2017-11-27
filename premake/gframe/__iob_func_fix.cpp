// fix irrklang static lib don't support VS2015
// http://blog.csdn.net/10km/article/details/50528908

#if _MSC_VER >= 1900
#include "stdio.h" 
_ACRTIMP_ALT FILE* __cdecl __acrt_iob_func(unsigned);
#ifdef __cplusplus 
extern "C"
#endif 
FILE* __cdecl __iob_func(unsigned i) {
	return __acrt_iob_func(i);
}
#endif // _MSC_VER >= 1900
