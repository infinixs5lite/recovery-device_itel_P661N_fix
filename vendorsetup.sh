#!/bin/bash

export OF_DISABLE_OTA_MENU=1
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1
export OF_DEFAULT_KEYMASTER_VERSION=4.1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_MAINTAINER="nino"
export FOX_VARIANT="R12_nino"
export OF_FLASHLIGHT_ENABLE=1
export OF_FL_PATH1="/sys/class/torch/torch/torch_level"

export FOX_USE_BASH_SHELL=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_ASH_IS_BASH=1
export OF_ENABLE_LPTOOLS=1
export FOX_DELETE_MAGISK_ADDON=1
export FOX_DELETE_AROMAFM=1
export FOX_ENABLE_APP_MANAGER=1
export OF_SUPPORT_VBMETA_AVB2_PATCHING=1

export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1

export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

export OF_USE_LZ4_COMPRESSION=true

export OF_SCREEN_H=2400
export OF_STATUS_H=95
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_ALLOW_DISABLE_NAVBAR=0
export OF_CLOCK_POS=1

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_MAXSIZE="5G"
export CCACHE_DIR=".ccache"

if [ ! -d ${CCACHE_DIR} ]; then
  mkdir $CCACHE_DIR
fi

export LC_ALL="C"

device_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd "${device_dir}/../../.." && pwd)"
patch_file="${device_dir}/patches/0001-Add-regulator-vibrator-haptics-support.patch"

if [ ! -f "${patch_file}" ]; then
	echo "[P661N] Missing patch: ${patch_file}"
elif ! command -v patch >/dev/null 2>&1; then
	echo "[P661N] Missing required command: patch"
elif (
	cd "${workspace_root}" &&
	patch -p1 -N --dry-run --silent < "${patch_file}" >/dev/null 2>&1
); then
	if (
		cd "${workspace_root}" &&
		patch -p1 -N --silent < "${patch_file}" >/dev/null 2>&1
	); then
		echo "[P661N] Applied haptics patch"
	else
		echo "[P661N] Failed to apply haptics patch"
	fi
else
	echo "[P661N] Haptics patch already applied or not applicable"
fi

unset device_dir workspace_root patch_file
