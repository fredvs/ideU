#!/bin/sh
#this script calls sakit espeak on Mac32
#
#change the values below for other archs, the paths are relative to the
#position of this script
LIBPORTAUDIO=libportaudio_32.dylib  #portaudio library
ESPEAKBIN=speak               #espeak binary
DATADIRECTORY=../                 #directory of espeak-data
#
CALLDIR=${0%/*}/
export LD_PRELOAD=$CALLDIR$LIBPORTAUDIO
$CALLDIR/$ESPEAKBIN --path=$CALLDIR/$DATADIRECTORY "$@"
