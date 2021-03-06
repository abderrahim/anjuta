#!/bin/sh
# Run this to generate all the initial makefiles, etc.

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

PKG_NAME=anjuta

(test -f $srcdir/configure.in \
  && test -f $srcdir/autogen.sh \
  && test -d $srcdir/src \
  && test -f $srcdir/src/anjuta.c) || {
    echo -n "**Error**: Directory "\`$srcdir\'" does not look like the"
    echo " top-level $PKG_NAME directory"
    exit 1
}

which gnome-autogen.sh || {
    echo "You need to install gnome-common from the GNOME CVS"
    exit 1
}

echo "Generating initial interface files"
sh -c "cd $srcdir/libanjuta/interfaces && \
perl anjuta-idl-compiler.pl libanjuta && \
touch iface-built.stamp"

REQUIRED_AUTOMAKE_VERSION=1.9 GNOME_DATADIR="$gnome_datadir" USE_GNOME2_MACROS=1 USE_COMMON_DOC_BUILD=yes . gnome-autogen.sh
