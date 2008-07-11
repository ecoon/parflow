# generated automatically by aclocal 1.9.6 -*- Autoconf -*-

# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
# 2005  Free Software Foundation, Inc.
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# ===========================================================================
#            http://autoconf-archive.cryp.to/ax_c_check_flag.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_C_CHECK_FLAG(FLAG-TO-CHECK,[PROLOGUE],[BODY],[ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   This macro tests if the C compiler supports the flag FLAG-TO-CHECK. If
#   successfull execute ACTION-IF-SUCCESS otherwise ACTION-IF-FAILURE.
#   PROLOGUE and BODY are optional and should be used as in AC_LANG_PROGRAM
#   macro.
#
#   This code is inspired from KDE_CHECK_COMPILER_FLAG macro. Thanks to
#   Bogdan Drozdowski <bogdandr@op.pl> for testing and bug fixes.
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Macro Archive. When you make and
#   distribute a modified version of the Autoconf Macro, you may extend this
#   special exception to the GPL to apply to your modified version as well.

AC_DEFUN([AX_C_CHECK_FLAG],[
  AC_PREREQ([2.61])
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_PROG_SED])

  flag=`echo "$1" | $SED 'y% .=/+-(){}<>:*,%_______________%'`

  AC_CACHE_CHECK([whether the C compiler accepts the $1 flag],
    [ax_cv_c_check_flag_$flag],[

    AC_LANG_PUSH([C])

    save_CFLAGS="$CFLAGS"
    CFLAGS="$CFLAGS $1"
    AC_COMPILE_IFELSE([
      AC_LANG_PROGRAM([$2],[$3])
    ],[
      eval "ax_cv_c_check_flag_$flag=yes"
    ],[
      eval "ax_cv_c_check_flag_$flag=no"
    ])

    CFLAGS="$save_CFLAGS"

    AC_LANG_POP

  ])

  AS_IF([eval "test \"`echo '$ax_cv_c_check_flag_'$flag`\" = yes"],[
    :
    $4
  ],[
    :
    $5
  ])
])

dnl Define a macro for supporting AMPS

AC_DEFUN([CASC_SUPPORT_AMPS],[

# Begin CASC_SUPPORT_AMPS
# Determine which AMPS layer to support.
# Defines AMPS and AMPS_SPLIT_FILE
AC_ARG_WITH(amps,
[ --with-amps=AMPS_TYPE  Set the version of AMPS to use: seq, mpi1, smpi, win32],
, with_amps=seq)

case "$with_amps" in
  no)
    AMPS=seq
  ;;
  seq)
    AMPS=seq
  ;;
  mpi1)
    AMPS=mpi1
  ;;
  smpi)
    AMPS=smpi
  ;;
  win32)
    AMPS=win32
  ;;
  *)
    AC_MSG_ERROR([Invalid AMPS version specified, use seq, mpi1, smpi, win32])
  ;;    
esac

case $AMPS in
  seq)
    AMPS_LIBS="-lamps_common"
  ;;
  *) 
  # This is horrifically bad design but there are all kinds of 
  # dependencies between amps and amps_common
    AMPS_LIBS="-lamps -lamps_common -lamps -lamps_common"
  ;;
esac
AC_MSG_RESULT([configuring AMPS $AMPS support])
AC_SUBST(AMPS)
AC_SUBST(AMPS_LIBS)
AC_DEFINE_UNQUOTED(AMPS,$AMPS,AMPS porting layer)

AC_ARG_WITH(amps,
[ --with-amps-sequential-io  Use AMPS sequentail I/O],
  AC_DEFINE(AMPS_SPLIT_FILE),
)

# END CASC_SUPPORT_AMPS

])dnl End definition of CASC_SUPPORT_AMPS

AC_DEFUN([CASC_CHECK_BIGENDIAN],[
  AC_CACHE_VAL([casc_cv_bigendian],[
  AC_C_BIGENDIAN ([casc_cv_bigendian=yes],[casc_cv_bigendian=no],[casc_cv_bigendian=no]
  ) ])
  AC_MSG_RESULT([$casc_cv_bigendian])
  if test x$casc_cv_bigendian = xyes
  then
    AC_DEFINE(CASC_HAVE_BIGENDIAN, 1,
       [Define this if words are stored with the most significant byte first])
  fi
]) # end of AC_DEFUN of CASC_CHECK_GETTIMEOFDAY




dnl ******************************************************************
dnl * CASC_PROG_F77 searches the PATH for an available Fortran 77
dnl * compiler. It assigns the name of the compiler to F77.
dnl ******************************************************************

AC_DEFUN([CASC_PROG_F77],
[
   if test -z "$F77"; then
      AC_CHECK_PROGS(F77, f77 g77 xlf cf77 if77 nf77)
      test -z "$F77" && AC_MSG_ERROR([no acceptable f77 found in \$PATH])
      FFLAGS="-g -O"
      AC_SUBST(FFLAGS)
   fi
])dnl


dnl **********************************************************************
dnl * CASC_PROG_FPP searches the PATH for a preprocessor for Fortran files
dnl * with preprocessor directives
dnl **********************************************************************

AC_DEFUN([CASC_PROG_FPP],
[
   AC_CHECK_PROGS(FPP, fpp cpp "$CC -E" "cc -E" "gcc -E")
   test -z "$FPP" && AC_MSG_ERROR([no acceptable fpp found in \$PATH])
])dnl


dnl **********************************************************************
dnl * CASC_CHECK_F77_PP checks whether the preprocessor needs to
dnl * be called before calling the compiler for Fortran files with
dnl * preprocessor directives.  If the preprocessor is necessary,
dnl * F77NEEDSPP is set to "yes", otherwise it is set to "no"
dnl **********************************************************************

AC_DEFUN([CASC_CHECK_F77_PP],
[
   AC_REQUIRE([CASC_PROG_F77])

   rm -f testpp.o

   AC_MSG_CHECKING(whether $FPP needs to be called before $F77)

   # This is a dumb little fortran program with C preprocessor calls
   # It will compile only if $F77 has a built-in preprocessor

   cat > testpp.F << EOF
#define FOO 3
	program testpp
	integer num
        integer sum
        num = FOO
#ifdef FOO
        sum = num + num
#else
        sum = num + num + num
#endif
        end 
EOF

   # Compile the program and set $F77NEEDSPP appropriately
   $F77 -DBAR -c testpp.F  > /dev/null 2>&1
   if test -f testpp.o; then 
      F77NEEDSPP=no 
   else 
      F77NEEDSPP=yes 
   fi

   AC_MSG_RESULT($F77NEEDSPP)
   rm -f testpp.o testpp.F

   AC_SUBST(F77NEEDSPP)
])dnl



dnl **********************************************************************
dnl * CASC_CHECK_LIB_FORTRAN(LIBRARY, [, ACTION-IF-FOUND [,
dnl *                        ACTION-IF-NOT-FOUND [, OTHER-LIBRARIEs]]])
dnl * 
dnl * Checks whether LIBRARY can be used to link a sample C function
dnl * that contains a call to a sample Fortran 77 function. If linking
dnl * is successful, ACTION-IF-FOUND is executed, otherwise
dnl * ACTION-IF-NOT-FOUND is executed.  The default for ACTION-IF-FOUND is
dnl * to add -lLIBRARY to $LIBS.  The default for ACTION-IF-NOT-FOUND is
dnl * nothing.  OTHER-LIBRARIES can include the full names of libraries in
dnl * the current directory, -l flags specifying other libraries, -L tags
dnl * specifying the location of libraries (This macro may not check the
dnl * same lib directories as would be checked by the linker by default on
dnl * the command line.), and/or the names of object files, all separated
dnl * by a space, whatever might be necessary for successful linkage.
dnl **********************************************************************

AC_DEFUN([CASC_CHECK_LIB_FORTRAN],
[
   # This macro needs a f77 compiler and knowledge of the name-mangling scheme
   AC_REQUIRE([CASC_PROG_F77])
   AC_REQUIRE([PAC_GET_FORTNAMES])

   if test -z "$FORTRANNAMES" ; then
      NAMESTYLE="FORTRANNOUNDERSCORE"
   else
      NAMESTYLE=$FORTRANNAMES
   fi

   # This is a little subroutine to be called later by a C main function
   cat > testflib_.f << EOF
        subroutine testflib(i)
        integer i
        print *, "This tests which libraries work"
        return
        end
EOF

   $F77 -c testflib_.f > /dev/null 2>&1

   # Mangle testflib's name appropriatiately
   case $NAMESTYLE in
      FORTRANDOUBLEUNDERSCORE)
         THIS_FUNCTION=testflib_;;

      FORTRANUNDERSCORE)
         THIS_FUNCTION=testflib_;;

      FORTRANCAPS)
         THIS_FUNCTION=TESTFLIB;;

      FORTRANNOUNDERSCORE)
         THIS_FUNCTION=testflib;;

   esac

   # Checks if the LIBRARY from the argument list can be used to link
   # a C test program with testflib
   AC_CHECK_LIB($1, $THIS_FUNCTION, $2, $3, testflib_.o $4)

   rm -f testflib_.o testflib_.f

])dnl


dnl ********************************************************************* 
dnl * CASC_SET_F77LIBS sets the necessary library flags for linking C and
dnl * Fortran 77 codes with the C linker.  The necessary -l flags are put 
dnl * into the variable F77LIBS, and the necessary -L flags are put into  
dnl * the variable F77LIBDIRS.  This macro first checks to see if the
dnl * shell variable $F77LIBS is already set.  If so, the preset value is
dnl * used.  Otherwise this macro only works for known architectures.
dnl *********************************************************************

AC_DEFUN([CASC_SET_F77LIBS],
[
   AC_REQUIRE([CASC_GUESS_ARCH])
   AC_REQUIRE([CASC_PROG_F77])

   if test -z "$casc_f77_libs"; then
      case $ARCH in 
         sun4 | solaris)
            case $F77 in
               *g77)
                   CASC_CHECK_LIB_FORTRAN(f2c,
                                          F77LIBDIRS="-L/home/casc/g77/lib"
                                          F77LIBS="-lf2c"
                                          , ,
                                          -L/home/casc/g77/lib -lf2c);;
               *)
                  CASC_CHECK_LIB_FORTRAN(sunmath,
                                   F77LIBDIRS="-L/opt/SUNWspro/SC5.0/lib"
                                   F77LIBS="-lF77 -lsunmath"
                                   , ,
                                   -L/opt/SUNWspro/SC5.0/lib -lF77 -lsunmath);;
               esac
         ;;
         alpha)
            CASC_CHECK_LIB_FORTRAN(for, F77LIBS="-lfor", , );;

         rs6000)
            CASC_CHECK_LIB_FORTRAN(xlf90, F77LIBS="-lxlf90", , );;

         IRIX64 | iris4d)
            CASC_CHECK_LIB_FORTRAN(I77, 
                                  F77LIBS="-lF77 -lU77 -lI77 -lisam", ,
                                  -lF77 -lU77 -lI77 -lisam);;

         *)
            AC_MSG_WARN(
[unable to set F77LIBFLAGS.  They must be set as a shell variable or
 with a command-line option])
         ;;             

      esac

   else
      if test -n "$casc_f77_lib_dirs"; then
         for casc_lib_dir in $casc_f77_lib_dirs; do
            F77LIBDIRS="-L$casc_lib_dir $F77LIBDIRS"       
         done
      fi

      for casc_lib in $casc_f77_libs; do
         F77LIBS="$F77LIBS -l$casc_lib"
      done
   fi

   F77LIBFLAGS="$F77LIBDIRS $F77LIBS"
])dnl


dnl *********************************************************************
dnl * CASC_FIND_F77LIBS may be a replacement for CASC_SET_F77LIBS.  This
dnl * macro automatically finds the flags necessary to located the 
dnl * libraries needed for a Fortran/C interface.  It is more robust than
dnl * CASC_SET_F77LIBS, because it is not based on the architecture name.
dnl * The test is performed directly on the Fortran compiler using the
dnl * macro LF_FLIBS. When CASC_FIND_F77LIBS is included in configure.in,
dnl * it will set the variable F77LIBFLAGS to be a list of flags, which 
dnl * will probably be a set of -L, -R, -l, and -u flags, as well as
dnl * perhaps the absolute paths of some libraries.  The drawback to this
dnl * macro is that it will usually insert some flags (mostly -L flags) 
dnl * that aren't needed, but hopefully they will be harmless.  I haven't
dnl * seen the extra flags that are included by this macro break anything
dnl * yet.  Hopefully more testing on more machines will give confidence
dnl * that this really works and will be able to set up the Fortran links
dnl * on an unknown system.  If this macro sets up nothing, then
dnl * CASC_SET_F77LIBS is called as a backup
dnl *********************************************************************

AC_DEFUN([CASC_FIND_F77LIBS],
[
   AC_CACHE_CHECK([for Fortran libraries], casc_cv_f77flags,
   [
      if test -z "$F77LIBFLAGS"; then
         dnl * LF_FLIBS creates variable $flibs_result containing a list of 
         dnl * flags related to the Fortran compiler
         LF_FLIBS
         for casc_flag in $flibs_result; do

            dnl * Here we sort the flags in $flibs_result
            case $casc_flag in
            [-l* | /*)]
               casc_f77_libs="$casc_f77_libs $casc_flag"
            ;;
            [-L*)]
               casc_f77_dirs="$casc_flag $casc_f77_dirs"
            ;;
            [*)]
               casc_other_flags="$casc_other_flags $casc_flag"
            ;;
            esac
         done

         F77LIBFLAGS="$casc_other_flags $casc_f77_dirs"

         if test -n "`echo $F77LIBFLAGS | grep '\-R/'`"; then
            F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-R\//-R \//'`
         fi

         dnl * each -l flag is checked using CASC_CHECK_LIB_FORTRAN, until
         dnl * successful linking of a test program is accomplished, at which
         dnl * time the loop is broken.  If successful linking does not occur,
         dnl * CASC_CHECK_LIB will check for the library's existence and add
         dnl * to F77LIBFLAGS if it exists.  All libraries listed by explicit
         dnl * path are added to F77LIBFLAGS
         for casc_flag in $casc_f77_libs; do

            case $casc_flag in

            [/*)]
               if test -f "$casc_flag"; then
                  F77LIBFLAGS="$F77LIBFLAGS $casc_flag"
               fi
            ;;

            [-l*)]

               casc_lib_name=`echo "$casc_flag" | sed 's/-l//g'`
               CASC_CHECK_LIB_FORTRAN($casc_lib_name,
                  F77LIBFLAGS="$F77LIBFLAGS $casc_flag"
                  casc_result=yes,
                  F77LIBFLAGS="$F77LIBFLAGS $casc_flag",
                  $F77LIBFLAGS)
 
            if test "$casc_result" = yes; then 
               casc_result=
               break
            fi
            ;;
         esac
         done
 
         # if this macro didn't work call CASC_SET_F77LIBS
         if test -z "$F77LIBFLAGS"; then
            CASC_SET_F77LIBS

         fi        

         dnl if PGI remove the include of the gcc libs, 
         dnl causes problem with Intel compilers
         if test -n "`echo $F77 | grep pgf77`"; then
            F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-lgcc//g'`
         fi

         dnl * On IBM don't use the links to poe library directories coming
         dnl * out of the fortran compiler
         if test -n "`echo $F77LIBFLAGS | grep xlf`"; then
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-L\/lib\/threads//g'`
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-L\/usr\/lpp\/ppe.poe\/lib\/threads//g'`
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-L\/usr\/lpp\/ppe.poe\/lib\/ip//g'`
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-L\/usr\/lpp\/ppe.poe\/lib//g'`
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-L\/usr\/lpp\/ppe.poe\/lib//g'`
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-lmpi_r//g'`
             F77LIBFLAGS=`echo $F77LIBFLAGS | sed 's/-lvtd_r//g'`
         fi
      fi

      casc_cv_f77flags=$F77LIBFLAGS
   ])

   dnl in case we are getting library flags from cached values
   F77LIBFLAGS=$casc_cv_f77flags

   AC_SUBST(F77LIBFLAGS)

])dnl


dnl * The following are macros copied from outside sources


dnl ********************************************************************
dnl * CASC_GET_FORTNAMES is a wrapper for the macro PAC_GET_FORTNAMES.
dnl * The two can be used interchangeably.
dnl *
dnl * PAC_GET_FORTNAMES is distributed with mpich.  It checks what format
dnl * is used to call Fortran subroutines in C functions.  This macro
dnl * defines the shell variable $FORTRANNAMES and creates -D  
dnl * preprocessor flags that tell what the Fortran name-mangling is.  The
dnl * preprocessor macros defined are FORTRAN_DOUBLE_UNDERSCORE,
dnl * FORTRAN_UNDERSCORE, FORTRAN_CAPS, and FORTRAN_NO_UNDERSCORE.  The
dnl * possible values for FORTRANNAMES are the same words without
dnl * underscores.
dnl * 
dnl * Changes:
dnl *    AC_DEFINE lines to define preprocessor macros that are assigned
dnl *    to DEFS added by Noah Elliott May 18, 1998
dnl ********************************************************************

AC_DEFUN([CASC_GET_FORTNAMES],
[
   PAC_GET_FORTNAMES
])dnl

AC_DEFUN([PAC_GET_FORTNAMES],[
   # Check for strange behavior of Fortran.  For example, some FreeBSD
   # systems use f2c to implement f77, and the version of f2c that they
   # use generates TWO (!!!) trailing underscores 
   # Currently, WDEF is not used but could be...
   #
   # Eventually, we want to be able to override the choices here and
   # force a particular form.  This is particularly useful in systems
   # where a Fortran compiler option is used to force a particular
   # external name format (rs6000 xlf, for example).
   cat > confftest.f <<EOF
       subroutine mpir_init_fop( a )
       integer a
       a = 1
       return
       end
EOF
   $F77 $FFLAGS -c confftest.f > /dev/null 2>&1
   if test ! -s confftest.o ; then
        AC_MSG_ERROR([Unable to compile a Fortran test program])
        NOF77=1
        HAS_FORTRAN=0
   elif test -z "$FORTRANNAMES" ; then
    # We have to be careful here, since the name may occur in several  
    # forms.  We try to handle this by testing for several forms
    # directly.
    if test $arch_CRAY ; then
     # Cray doesn't accept -a ...
     nameform1=`strings confftest.o | grep mpir_init_fop_  | head -1`
     nameform2=`strings confftest.o | grep MPIR_INIT_FOP   | head -1`
     nameform3=`strings confftest.o | grep mpir_init_fop   | head -1`
     nameform4=`strings confftest.o | grep mpir_init_fop__ | head -1`
    else
     nameform1=`strings -a confftest.o | grep mpir_init_fop_  | head -1`
     nameform2=`strings -a confftest.o | grep MPIR_INIT_FOP   | head -1`
     nameform3=`strings -a confftest.o | grep mpir_init_fop   | head -1`
     nameform4=`strings -a confftest.o | grep mpir_init_fop__ | head -1`
    fi
    /bin/rm -f confftest.f confftest.o
    AC_MSG_CHECKING(Fortran external names)
    if test -n "$nameform4" ; then
        AC_DEFINE(FORTRAN_DOUBLE_UNDERSCORE)
        AC_MSG_RESULT(lowercase with one or two trailing underscores)
        FORTRANNAMES="FORTRANDOUBLEUNDERSCORE"
    elif test -n "$nameform1" ; then
        # We don't set this in CFLAGS; it is a default case
        AC_DEFINE(FORTRAN_UNDERSCORE)
        AC_MSG_RESULT(lowercase with a trailing underscore)
        FORTRANNAMES="FORTRANUNDERSCORE"
    elif test -n "$nameform2" ; then
        AC_DEFINE(FORTRAN_CAPS)
        AC_MSG_RESULT(uppercase)
        FORTRANNAMES="FORTRANCAPS"
    elif test -n "$nameform3" ; then
        AC_DEFINE(FORTRAN_NO_UNDERSCORE)
        AC_MSG_RESULT(lowercase)
        FORTRANNAMES="FORTRANNOUNDERSCORE"
    else
        AC_MSG_RESULT(unknown)
#       print_error "If you have problems linking, try using the -nof77 option"
#        print_error "to configure and rebuild MPICH."
        NOF77=1
        HAS_FORTRAN=0
    fi
    fi
    rm -f confftest.f confftest.o
    if test -n "$FORTRANNAMES" ; then
        WDEF="-D$FORTRANNAMES"
    fi  
    ])dnl


dnl ****************************************************************
dnl * LF_FLIBS was copied from E. Gkioulekas' autotools package for use in
dnl * CASC_FIND_F77LIBS.  It's probably not good to be used all by itself.
dnl * It uses the output the Fortran compiler gives when given a -v flag
dnl * to produce a list of flags that the Fortran compiler uses.  From
dnl * this list CASC_FIND_F77LIBS sets up the Fortran/C interface flags.
dnl *
dnl * Changes:
dnl * AC_SUBST(FLIBS) suppressed by N. Elliott 7-10-98
dnl *****************************************************************
   
AC_DEFUN([LF_FLIBS],[
  dnl AC_MSG_CHECKING(for Fortran libraries)
  dnl
  dnl Write a minimal program and compile it with -v. I don't know
  dnl what to do if your compiler doesn't have -v
  dnl
  dnl changequote(, )dnl
  echo "      END" > conftest.f
  foutput=`${F77-f77} -v -o conftest conftest.f 2>&1`
  dnl
  dnl The easiest thing to do for xlf output is to replace all the commas
  dnl with spaces.  Try to only do that if the output is really from xlf,
  dnl since doing that causes problems on other systems.
  dnl
  xlf_p=`echo $foutput | grep xlfentry`
  if test -n "$xlf_p"; then
    foutput=`echo $foutput | sed 's/,/ /g'`
  fi
  ifc_p=`echo $foutput | grep ifc`
  ifort_p=`echo $foutput | grep ifort`
  if test -n "$ifort_p" -o -n "$ifc_p"; then
    foutput=`echo $foutput | sed 's/\\\/ \-u\/ \___get\/ /g'`
  fi
  dnl
  ld_run_path=`echo $foutput | \

    [sed -n -e 's/^.*LD_RUN_PATH *= *\([^ ]*\).*/\1/p'`]
  dnl
  dnl We are only supposed to find this on Solaris systems...
  dnl Uh, the run path should be absolute, shouldn't it?
  dnl
  case "$ld_run_path" in

    /*)

      if test "$ac_cv_prog_gcc" = yes; then

        ld_run_path="-Xlinker -R -Xlinker $ld_run_path"
      else
        ld_run_path="-R $ld_run_path"
      fi
    ;;

    *)
      ld_run_path=
    ;;
  esac

  dnl
  flibs=
  lflags=
  dnl
  dnl If want_arg is set, we know we want the arg to be added to the list,
  dnl so we don't have to examine it.
  dnl
  want_arg=
  dnl
  for arg in $foutput; do
    old_want_arg=$want_arg
    want_arg=
  dnl
  dnl None of the options that take arguments expect the argument to
  dnl start with a -, so pretend we didn't see anything special.
  dnl
    if test -n "$old_want_arg"; then
      case "$arg" in
        -*)
        old_want_arg=
        ;;
      esac
    fi

    case "$old_want_arg" in
      '')
        case $arg in
        /*.a)
          exists=false
          for f in $lflags; do
            if test x$arg = x$f; then
              exists=true
            fi
          done
          if $exists; then
            arg=
          else
            lflags="$lflags $arg"
          fi
        ;;
        -bI:*)
          exists=false
          for f in $lflags; do
            if test x$arg = x$f; then
              exists=true
            fi
          done
          if $exists; then
            arg=
          else
            if test "$ac_cv_prog_gcc" = yes; then
              lflags="$lflags -Xlinker $arg"
            else
              lflags="$lflags $arg"
            fi
          fi
        ;;
        -lang* | -lcrt0.o | -lc )
          arg=
        ;;
        [-[lLR])]
          want_arg=$arg
          arg=
        ;;
        [-[lLR]*)]
          exists=false
          for f in $lflags; do
            if test x$arg = x$f; then
              exists=true
            fi
          done
          if $exists; then
            arg=
          else
            case "$arg" in
              -lkernel32)
                case "$canonical_host_type" in
                  *-*-cygwin32)
                  ;;
                  *)
                    lflags="$lflags $arg"
                  ;;
                esac
              ;;
              -lm)
              ;;
              *)
                lflags="$lflags $arg"
              ;;
            esac
          fi
        ;;
        -u)
          want_arg=$arg
          arg=
        ;;
        -Y)
          want_arg=$arg
          arg=
        ;;
        *)
          arg=
        ;;
        esac
      ;;
      [-[lLR])]
        arg="$old_want_arg $arg"
      ;;
      -u)
        arg="-u $arg"
      ;;
      -Y)

  dnl
  dnl Should probably try to ensure unique directory options here too.
  dnl This probably only applies to Solaris systems, and then will only
  dnl work with gcc...
  dnl
        arg=`echo $arg | sed -e 's%^P,%%'`
        SAVE_IFS=$IFS
        IFS=:
        list=
        for elt in $arg; do
        list="$list -L$elt"
        done
        IFS=$SAVE_IFS
        arg="$list"
      ;;
    esac
  dnl

    if test -n "$arg"; then
      flibs="$flibs $arg"
    fi
  done
  if test -n "$ld_run_path"; then
    flibs_result="$ld_run_path $flibs"
  else
    flibs_result="$flibs"
  fi
  dnl changequote([, ])dnl
  rm -f conftest.f conftest.o conftest
  dnl
  dnl Phew! Done! Now, output the result
  dnl

  FLIBS="$flibs_result"
  dnl AC_MSG_RESULT([$FLIBS])
dnl  AC_SUBST(FLIBS)
])dnl



dnl **********************************************************************
dnl * CASC_CONFIG_OUTPUT_LIST(DIR-LIST[, OUTPUT-FILE])
dnl *
dnl * The intent of this macro is to make configure handle the possibility
dnl * that a portion of the directory tree of a project may not be
dnl * present.  This will modify the argument list of AC_OUTPUT to contain
dnl * only output file names for which corresponding input files exist.
dnl * If you are not concerned about the possible absence of the necessary
dnl * input (.in) files, it is better to not use this macro and to
dnl * explicitly list all of the output files in a call to AC_OUTPUT.
dnl * Also, If you wish to create a file Foo from a file with a name
dnl * other than Foo.in, this macro will not work, and you must use
dnl * AC_OUTPUT.
dnl *
dnl * This macro checks for the existence of the file OUTPUT-FILE.in in
dnl * each directory specified in the whitespace-separated DIR-LIST.  
dnl * (Directories should be specified by relative path from the directory 
dnl * containing configure.in.) If OUTPUT-FILE is not specified, the
dnl * default is 'Makefile'.  For each directory that contains 
dnl * OUTPUT-FILE.in, the relative path of OUTPUT-FILE is added to the 
dnl * shell variable OUTPUT-FILE_list.  When AC_OUTPUT is called,
dnl * '$OUTPUT-FILE_list' should be included in the argument list.  So if
dnl * you have a directory tree and each subdirectory contains a 
dnl * Makefile.in, DIR-LIST should be a list of every subdirectory and
dnl * OUTPUT-FILE can be omitted, because 'Makefile' is the default.  When
dnl * configure runs, it will check for the existence of a Makefile.in in
dnl * each directory in DIR-LIST, and if so, the relative path of each
dnl * intended Makefile will be added to the variable Makefile_list.
dnl *
dnl * This macro can be called multiple times, if there are files other
dnl * than Makefile.in with a .in suffix other that are intended to be 
dnl * processed by configure. 
dnl *
dnl * Example
dnl *     If directories dir1 and dir2 both contain a file named Foo.in, 
dnl *     and you wish to use configure to create a file named Foo in each
dnl *     directory, then call 
dnl *     CASC_CONFIG_OUTPUT_LIST(dir1 dir2, Foo)
dnl *     If you also called this macro for Makefile as described above,
dnl *     you should call
dnl *     AC_OUTPUT($Makefile_list $Foo_list)
dnl *     at the end of configure.in .
dnl *********************************************************************


AC_DEFUN([CASC_CONFIG_OUTPUT_LIST],
[
   dnl * m_OUTPUT_LIST is a macro to store the name of the variable
   dnl * which will contain the list of output files
   define([m_OUTPUT_LIST], ifelse([$2], , Makefile_list, [$2_list]))

   if test -z "$srcdir"; then
      srcdir=.
   fi

   dnl * use "Makefile" if second argument not given
   if test -n "$2"; then
      casc_output_file=$2
   else   
      casc_output_file=Makefile
   fi   
      
   dnl * Add a file to the output list if its ".in" file exists.
   for casc_dir in $1; do
      if test -f $srcdir/$casc_dir/$casc_output_file.in; then
         m_OUTPUT_LIST="$m_OUTPUT_LIST $casc_dir/$casc_output_file"
      fi
   done
])dnl


dnl **********************************************************************
dnl * CASC_GUESS_ARCH
dnl * Guesses a one-word name for the current architecture, unless ARCH
dnl * has been preset.  This is an alternative to the built-in macro
dnl * AC_CANONICAL_HOST, which gives a three-word name.  Uses the utility
dnl * 'tarch', which is a Bourne shell script that should be in the same  
dnl * directory as the configure script.  If tarch is not present or if it
dnl * fails, ARCH is set to the value, if any, of shell variable HOSTTYPE,
dnl * otherwise ARCH is set to "unknown".
dnl **********************************************************************

AC_DEFUN([CASC_GUESS_ARCH],
[
   AC_MSG_CHECKING(the architecture)

   dnl * $ARCH could already be set in the environment or earlier in configure
   dnl * Use the preset value if it exists, otherwise go throug the procedure
   if test -z "$ARCH"; then

      dnl * configure searches for the tool "tarch".  It should be in the
      dnl * same directory as configure.in, but a couple of other places
      dnl * will be checked.  casc_tarch stores a relative path for "tarch".
      casc_tarch_dir=
      for casc_dir in $srcdir $srcdir/.. $srcdir/../.. $srcdir/config; do
         if test -f $casc_dir/tarch; then
            casc_tarch_dir=$casc_dir
            casc_tarch=$casc_tarch_dir/tarch
            break
         fi
      done

      dnl * if tarch was not found or doesn't work, try using env variable
      dnl * $HOSTTYPE
      if test -z "$casc_tarch_dir"; then
         AC_MSG_WARN(cannot find tarch, using \$HOSTTYPE as the architecture)
         ARCH=$HOSTTYPE
      else
         ARCH="`$casc_tarch`"

         if test -z "$ARCH" || test "$ARCH" = "unknown"; then
            ARCH=$HOSTTYPE
         fi
      fi

      dnl * if $ARCH is still empty, give it the value "unknown".
      if test -z "$ARCH"; then
         ARCH=unknown
         AC_MSG_WARN(architecture is unknown)
      else
         AC_MSG_RESULT($ARCH)
      fi    
   else
      AC_MSG_RESULT($ARCH)
   fi

   AC_SUBST(ARCH)

])dnl


dnl **********************************************************************
dnl * CASC_SET_SUFFIX_RULES is not like the other macros in aclocal.m4
dnl * because it does not run any kind of test on the system on which it
dnl * is running.  All it does is create several variables which contain
dnl * the text of some simple implicit suffix rules that can be
dnl * substituted into Makefile.in.  The suffix rules that come from the
dnl * macro all deal with compiling a source file into an object file.  If
dnl * this macro is called in configure.in, then if `@CRULE@' is placed in
dnl * Makefile.in, the following will appear in the generated Makefile:
dnl *
dnl * .c.o:
dnl *         @echo "Making (c) " $@ 
dnl *         @${CC} -o $@ -c ${CFLAGS} $<	
dnl *
dnl * The following is a list of the variables created by this macro and
dnl * the corresponding suffixes of the files that each implicit rule 
dnl * deals with.
dnl *
dnl * CRULE       --   .c
dnl * CXXRULE     --   .cxx
dnl * CPPRULE     --   .cpp
dnl * CCRULE      --   .cc
dnl * CAPCRULE    --   .C
dnl * F77RULE     --   .f
dnl *
dnl * There are four suffix rules for C++ files because of the different
dnl * suffixes that can be used for C++.  Only use the one which
dnl * corresponds to the suffix you use for your C++ files.
dnl *
dnl * The rules created by this macro require you to use the following
dnl * conventions for Makefile variables:
dnl *
dnl * CC        = C compiler
dnl * CXX       = C++ compiler
dnl * F77       = Fortran 77 compiler
dnl * CFLAGS    = C compiler flags
dnl * CXXFLAGS  = C++ compiler flags
dnl * FFLAGS    = Fortran 77 compiler flags
dnl **********************************************************************

AC_DEFUN([CASC_SET_SUFFIX_RULES],
[
   dnl * Things weren't working whenever "$@" showed up in the script, so
   dnl * I made the symbol $at_sign to signify '@'
   at_sign=@

   dnl * All of the backslashes are used to handle the $'s and the
   dnl * newlines which get passed through echo and sed.

   CRULE=`echo ".c.o:\\\\
\t@echo \"Making (c) \" \\$$at_sign \\\\
\t@\\${CC} -o \\$$at_sign -c \\${CFLAGS} \$<"`

   AC_SUBST(CRULE)

   CXXRULE=`echo ".cxx.o:\\\\
\t@echo \"Making (c++) \" \\$$at_sign \\\\
\t@\\${CXX} -o \\$$at_sign -c \\${CXXFLAGS} \$<"`

   AC_SUBST(CXXRULE)

   CPPRULE=`echo ".cpp.o:\\\\
\t@echo \"Making (c++) \" \\$$at_sign \\\\
\t@\\${CXX} -o \\$$at_sign -c \\${CXXFLAGS} \$<"`

   AC_SUBST(CPPRULE)

   CCRULE=`echo ".cc.o:\\\\
\t@echo \"Making (c++) \" \\$$at_sign \\\\
\t@\\${CXX} -o \\$$at_sign -c \\${CXXFLAGS} \$<"`

   AC_SUBST(CCRULE)

   CAPCRULE=`echo ".C.o:\\\\
\t@echo \"Making (c++) \" \\$$at_sign \\\\
\t@\\${CXX} -o \\$$at_sign -c \\${CXXFLAGS} \$<"`

   AC_SUBST(CAPCRULE)

   F77RULE=`echo ".f.o:\\\\
\t@echo \"Making (f) \" \\$$at_sign \\\\
\t@\\${F77} -o \\$$at_sign -c \\${FFLAGS} \$<"`

   AC_SUBST(F77RULE)

])

dnl Macro to save compiler state flags for invoking dnl compiler tests
dnl NOTE that this is NOT currently a stack so can dnl only be called
dnl in push/pop order.  push push pop pop dnl will fail
AC_DEFUN([CASC_PUSH_COMPILER_STATE],[
   casc_save_LIBS=$LIBS
   casc_save_CXXFLAGS=$CXXFLAGS
])

dnl Macro to restore compiler state flags for invoking
dnl compiler tests
AC_DEFUN([CASC_POP_COMPILER_STATE],[
   LIBS=$casc_save_LIBS
   unset casc_save_LIBS
   CXXFLAGS=$casc_save_CXXFLAGS
   unset casc_save_CXXFLAGS
])
dnl Define a macro for supporting SILO

AC_DEFUN([CASC_SUPPORT_SILO],[

# Begin CASC_SUPPORT_SILO
# Defines silo_PREFIX silo_INCLUDES and silo_LIBS if with-silo is specified.
AC_ARG_WITH(silo,
[ --with-silo[=PATH]  Use SILO and optionally specify where SILO is installed.],
, with_silo=no)

case "$with_silo" in
  no)
    AC_MSG_NOTICE([configuring without SILO support])
    : Do nothing
  ;;
  yes)
    # SILO install path was not specified.
    # Look in a couple of standard locations to probe if 
    # SILO header files are there.
    AC_MSG_CHECKING([for SILO installation])
    for dir in /usr /usr/local; do
      if test -f ${dir}/include/silo.h; then
        silo_PREFIX=${dir}
        break
      fi
    done
    AC_MSG_RESULT([$silo_PREFIX])
  ;;
  *)
    # SILO install path was specified.
    AC_MSG_CHECKING([for SILO installation])
    silo_PREFIX=$with_silo
    silo_INCLUDES="-I${silo_PREFIX}/include"
    if test -f ${silo_PREFIX}/include/silo.h; then
        AC_MSG_RESULT([$silo_PREFIX])
    else
        AC_MSG_RESULT([$silo_PREFIX])
        AC_MSG_ERROR([SILO not found in $with_silo])
    fi
  ;;
esac

# Determine which SILO library is built
if test "${silo_PREFIX+set}" = set; then
   AC_MSG_CHECKING([for SILO library])
   if test -f ${silo_PREFIX}/lib/libsilo.a; then
      silo_LIBS='-lsilo'
      AC_MSG_RESULT([using $silo_LIBS])
   elif test -f ${silo_PREFIX}/lib/libsiloh5.a; then
      silo_LIBS='-lsiloh5'
      AC_MSG_RESULT([using $silo_LIBS])
   else
      AC_MSG_RESULT([using $silo_LIBS])
      AC_MSG_ERROR([Could not fine silo library in $silo_PREFIX])
   fi

   silo_LIBS="-L${silo_PREFIX}/lib ${silo_LIBS}"
fi

# END CASC_SUPPORT_SILO

])dnl End definition of CASC_SUPPORT_SILO

AC_DEFUN([CASC_SPLIT_LIBS_STRING],[
dnl
dnl Macro CASC_SPLIT_LIBS_STRING
dnl
dnl This macro takes an automake-style LIBS string (arg1) and
dnl splits it into the -L part (arg2, what CASC usually calls
dnl LIB_PATH) and -l part (arg3, what CASC calls LIB_NAME).
dnl The rest are also lumped into the LIB_NAME part, for lack
dnl of generality in the CASC distinction.
dnl
dnl
# Split $1 into the LIB_PATH part ($2) and the LIB_NAME part ($3)
if test -n "${$1}"; then
  for i in ${$1}; do
    case "$i" in
    -L*) $2="${$2} $i" ;;
    *) $3="${$3} $i" ;;
    esac
  done
fi
])

dnl Define a macro for supporting TCL

AC_DEFUN([CASC_SUPPORT_TCL],[

# Begin CASC_SUPPORT_TCL
# Defines tcl_PREFIX tcl_INCLUDES and tcl_LIBS if with-tcl is specified.
AC_ARG_WITH(tcl,
[ --with-tcl[=PATH]  Use TCL and optionally specify where TCL is installed.],
, with_tcl=no)

case "$with_tcl" in
  no|yes)
    # TCL install path was not specified.
    # Look in a couple of standard locations to probe if 
    # TCL header files are there.
    AC_MSG_CHECKING([for TCL installation])
    for dir in /usr /usr/local; do
      if test -f ${dir}/include/tcl.h; then
        tcl_PREFIX=${dir}
        break
      fi
    done
    AC_MSG_RESULT([$tcl_PREFIX])
  ;;
  *)
    # TCL install path was specified.
    AC_MSG_CHECKING([for TCL installation])
    tcl_PREFIX=$with_tcl
    tcl_INCLUDES="-I${tcl_PREFIX}/include"
    if test -f ${tcl_PREFIX}/include/tcl.h; then
        AC_MSG_RESULT([$tcl_PREFIX])
    else
        AC_MSG_RESULT([$tcl_PREFIX])
        AC_MSG_ERROR([TCL not found in $with_tcl])
    fi
  ;;
esac

# Determine which TCL library is built
if test "${tcl_PREFIX+set}" = set; then
   AC_MSG_CHECKING([for TCL library])
   if test -f ${tcl_PREFIX}/lib/libtcl.so; then
      tcl_LIBS='-ltcl'
      AC_MSG_RESULT([using $tcl_LIBS])
   elif test -f ${tcl_PREFIX}/lib/libtcl8.4.so; then
      tcl_LIBS='-ltcl8.4'
      AC_MSG_RESULT([using $tcl_LIBS])
   elif test -f ${tcl_PREFIX}/lib/libtcl8.5.so; then
      tcl_LIBS='-ltcl8.5'
      AC_MSG_RESULT([using $tcl_LIBS])
   elif test -f ${tcl_PREFIX}/lib/libtcl.dylib; then
      tcl_LIBS='-ltcl'
      AC_MSG_RESULT([using $tcl_LIBS])
   elif test -f ${tcl_PREFIX}/lib/libtcl8.4.dylib; then
      tcl_LIBS='-ltcl8.4'
      AC_MSG_RESULT([using $tcl_LIBS])
   elif test -f ${tcl_PREFIX}/lib/libtcl8.5.dylib; then
      tcl_LIBS='-ltcl8.5'
      AC_MSG_RESULT([using $tcl_LIBS])
   else
      AC_MSG_RESULT([could not find a tcl library...assuming not needed])
   fi
   
   if test -n "${tcl_LIBS}"; then
      tcl_LIBS="-L${tcl_PREFIX}/lib ${tcl_LIBS}"
   else
      tcl_LIBS=""
   fi
fi

# END CASC_SUPPORT_TCL

])dnl End definition of CASC_SUPPORT_TCL
