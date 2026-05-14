#!/bin/bash
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
	
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
