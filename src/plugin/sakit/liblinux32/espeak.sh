#!/bin/sh
#this script calls sakit espeak on Linux32
#
#change the values below for other archs, the paths are relative to the
#position of this script
LIBPORTAUDIO=libportaudio_x86.so  #portaudio library
#LIBESPEAK=libespeak_x64.so       #for freebsd
ESPEAKBIN=speak_x86               #espeak binary
DATADIRECTORY=../                 #directory of espeak-data
#
CALLDIR=${0%/*}/
export LD_PRELOAD=$CALLDIR$LIBPORTAUDIO
#export LD_PRELOAD=$CALLDIR$LIBPORTAUDIO:$CALLDIR$LIBESPEAK #for freebsd
$CALLDIR/$ESPEAKBIN --path=$CALLDIR/$DATADIRECTORY "$@"