#!/bin/bash

# vendorsetup.sh - Apply regulator-vibrator haptics patch to TWRP
# This script patches bootable/recovery/minuitwrp/events.cpp to support
# regulator-vibrator kernel driver used by itel P661N and similar devices

# Get path to this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to marker file (in device directory)
TFILE="$SCRIPT_DIR/out/hapticspath.patched"

# Path to patch file (relative to script directory)
PATCH_FILE="$SCRIPT_DIR/patches/0001-Add-regulator-vibrator-haptics-support.patch"

# Target file is at TWRP root
TARGET_FILE="bootable/recovery/minuitwrp/events.cpp"

# Search string to detect if patch is already applied
SEARCH_STRING="LEDS_VIBRATOR_BRIGHTNESS_FILE"

# Get TWRP root directory (3 levels up from device/itel/P661N)
TWRP_ROOT="$SCRIPT_DIR/../../.."

# Full path to target file
FULL_TARGET_FILE="$TWRP_ROOT/$TARGET_FILE"

# Create out directory if it doesn't exist
[ ! -d "$SCRIPT_DIR/out" ] && mkdir -p "$SCRIPT_DIR/out"

RET=0

# Check if marker file exists (already patched in this build)
if [ -f "$TFILE" ]; then
    echo "haptics path patched already, skipping"
    exit 0
fi

# Check if patch is already applied by searching for our added defines
if grep -q "$SEARCH_STRING" "$FULL_TARGET_FILE" 2>/dev/null; then
    echo "$TFILE is not found but patch appears to be already applied (found $SEARCH_STRING in $TARGET_FILE)"
    echo "Marking as patched..."
    touch "$TFILE"
    exit 0
fi

# Change to TWRP root directory
cd "$TWRP_ROOT"

# Apply patch with -N (assume never applied) and -f (force, no questions)
echo "Applying haptics patch: $PATCH_FILE"
patch -p1 -N -f < "$PATCH_FILE"
RET=$?

# patch returns 1 when patch is already applied, which is OK
if [ $RET -eq 1 ]; then
    echo "Patch appears to be already applied (exit code 1 from patch)"
    echo "Marking as patched..."
    touch "$TFILE"
    exit 0
fi

if [ $RET -ne 0 ]; then
    echo "ERROR: minuitwrp/events.cpp could not be patched! Vibration in TWRP will not work."
    echo "ERROR: Patch file: $PATCH_FILE"
    echo "ERROR: Target file: $TARGET_FILE"
    echo "ERROR: Patch exit code: $RET"
    exit $RET
else
    echo "OK: minuitwrp/events.cpp patched successfully"
    touch "$TFILE"
    exit 0
fi
