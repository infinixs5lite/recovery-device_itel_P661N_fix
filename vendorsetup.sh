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
