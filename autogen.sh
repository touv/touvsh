#!/bin/sh -
## autogen.sh - generate all the twisty little files.

here=`pwd`
cd `dirname $0`

# Generate aclocal.m4 from configure.in
aclocal -I .

# Generate Makefile.in's from Makefile.am's and configure.in
# (adding missing files that may be needed for proper operation)
automake --add-missing --gnu

# Generate configure from configure.in and aclocal.m4
autoconf

cd $here

# Instead of rerunning config.status, re-run configure from scratch
if [ -r config.status ]; then
  CMD=`awk '/^#.*\/?configure .*/ { $1 = ""; print; exit }' < config.status`
  echo "Running: $CMD $@" 1>&2
else
  CMD=`dirname $0`/configure
fi
$CMD "$@" && echo && echo "Now type 'make' to compile, and install via 'make install'."

