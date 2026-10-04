#!/system/bin/sh
# Read the installed OS version used to create hardware-backed keys. Never
# change the persistent property store or write to the system partition.
set -e
# Refuse mismatched credentials/header levels after an Android upgrade.
header=$(dd if=/dev/block/platform/13500000.dwmmc0/by-name/recovery bs=1 skip=44 count=4 2>/dev/null | od -An -tu4)
major=$(( (header >> 25) & 127 ))
year=$(( 2000 + ((header >> 4) & 127) ))
month=$(( header & 15 ))
header_month=$(printf '%04d-%02d' "$year" "$month")
release=$(sed -n 's/^ro.build.version.release=//p' /system_root/system/build.prop | head -n 1)
patch=$(sed -n 's/^ro.build.version.security_patch=//p' /system_root/system/build.prop | head -n 1)
test "${release%%.*}" = "$major"
test "${patch%-*}" = "$header_month"
for key in ro.build.version.release ro.build.version.security_patch ro.build.type; do
    value=$(sed -n "s/^${key}=//p" /system_root/system/build.prop | head -n 1)
    test -n "$value" || exit 1
    /system/bin/resetprop -n "$key" "$value"
done
# Bootloader already received this level from the recovery image header.
patch=$(sed -n 's/^ro.build.version.security_patch=//p' /system_root/system/build.prop | head -n 1)
/system/bin/resetprop -n ro.bootimage.build.version.security_patch "$patch"

setprop twrp.crypto.props.ready 1
