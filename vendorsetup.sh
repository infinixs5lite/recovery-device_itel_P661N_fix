#!/bin/bash

TFILE=$PWD/out/hapticspath.patched
[ ! -d "out" ] && mkdir -p out

RET=0
REVERSE=0
PATCH_FILE="patches/0001-Add-regulator-vibrator-haptics-support.patch"

if [ -f "$TFILE" ]; then
    echo "haptics path patched already, skipping"
elif [ -d "bootable/recovery/.git" ]; then
    cd bootable/recovery
    git apply --reverse --check ../../$PATCH_FILE || REVERSE=$?
    cd ../../

    if [ $REVERSE -eq 0 ]; then
        touch $TFILE
    else
        cd bootable/recovery
        git apply ../../$PATCH_FILE || RET=$?
        cd ../../
        if [ $RET -ne 0 ]; then
            echo "ERROR: minuitwrp/events.cpp could not be patched! Vibration in TWRP will not work."
        else
            echo "OK: minuitwrp/events.cpp patched"
            touch $TFILE
        fi
    fi
else
    patch -p1 -N -f < $PATCH_FILE >/dev/null 2>&1
    RET=$?
    if [ $RET -eq 0 ]; then
        echo "OK: minuitwrp/events.cpp patched"
        touch $TFILE
    elif [ $RET -eq 1 ]; then
        touch $TFILE
    else
        echo "ERROR: minuitwrp/events.cpp could not be patched! Vibration in TWRP will not work."
    fi
fi
