# https://www.gnu.org/software/autoconf-archive/ax_prog_apache.html#ax_prog_apache
AC_DEFUN([FIND_LIBMOD],[
AC_MSG_NOTICE(looking for libceleowaf)
# Check if the user provided --with-libceleowaf
AC_ARG_WITH(libceleowaf,
            [AS_HELP_STRING([[--with-libceleowaf=FILE]],
                            [FILE is the path to libceleowaf install dir; defaults to "/usr/local/celeowaf/".])],
[
  if test "$withval" = "yes"; then
    AC_SUBST(CPPFLAGS, "$CPPFLAGS -I/usr/local/celeowaf/include/ -L/usr/local/celeowaf/lib/")
    V3INCLUDE="/usr/local/celeowaf/include/"
    V3LIB="/usr/local/celeowaf/lib/"
  else
    AC_SUBST(CPPFLAGS, "$CPPFLAGS -I${withval}/include/ -L${withval}/lib/")
    V3INCLUDE="${withval}/include/"
    V3LIB="${withval}/lib/"
  fi
])

dnl Check the CeleoWAF libraries (celeowaf)

AC_CHECK_LIB([celeowaf], [msc_init], [
        AC_DEFINE([HAVE_CELEOWAFLIB], [1],
                [Define to 1 if you have the `libceleowaf' library (-lceleowaf).])], [
        AC_MSG_ERROR([CeleoWAF libraries not found!])])

AC_CHECK_HEADERS([celeowaf/celeowaf.h], [], [
        AC_MSG_ERROR([CeleoWAF headers not found...])])
])

