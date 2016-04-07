/* This file provides some non-standard functions that are considered
 * standard by the portable Tads code and thus aren't in the OS-layer.
 * None of these funtions will be implemented if the system happens to
 * provide them; in that case, the configure script will generate an
 * appropriate HAVE_[NAME OF FUNCTION] macro.
 */
#ifndef MISSING_H
#define MISSING_H

#include "common.h"

#include <stddef.h> /* For size_t. */

#ifdef __cplusplus
extern "C" {
#endif

/* Counted-length case-insensitive string comparison.
 *
 * This function always compares 'len' characters, regardless if a '\0'
 * character has been detected.
 */
#if !HAVE_MEMICMP
int
memicmp( const void* s1, const void* s2, size_t len );
#endif

/* Case-insensitive string comparison.
 */
#if !HAVE_STRICMP
int
stricmp( const char* s1, const char* s2 );
#endif

/* Length-limited case-insensitive string comparison.
 *
 * This function compares at most `n' characters, or until a '\0'
 * character has been detected.
 */
#if !HAVE_STRNICMP
int
strnicmp( const char* s1, const char* s2, size_t n );
#endif

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* MISSING_H */
