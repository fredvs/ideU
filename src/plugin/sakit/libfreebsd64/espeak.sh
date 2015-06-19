#!/bin/sh
#this script calls sakit espeak on freeBSD64
#
#change the values below for other archs, the paths are relative to the
#position of this script
#
ESPEAKBIN=espeak_x64             #espeak binary
DATADIRECTORY=./                 #directory of espeak-data
#
CALLDIR=${0%/*}/
export LD_LIBRARY_PATH=$CALLDIR #for freebsd
$CALLDIR/$ESPEAKBIN --path=$CALLDIR/$DATADIRECTORY "$@"
