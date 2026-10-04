# Native TWRP for Samsung SM-T510 / gta3xlwifi

TWRP 3.7.1_12 / Android 12.1, ARM32 recovery with source-built ARM64 4.4 kernel.
The tested recovery reaches its menu automatically and supports touch, root ADB,
software recovery reboot and ROM installation. Samsung FBE data decryption is
unsupported: missing keystore services are reported while encrypted data stays
locked. No claim of general stability, MTP or backup/restore validation is made.

Includes the SM-T510 1200x1920 display, configfs USB, correct Android fs_mgr and
TWRP fstabs, libresetprop packaging and XZ ramdisk configuration. The compressed
ramdisk must stay below 16 MiB to avoid overlapping the bootloader's DTB address.
DECON display initialization must use the normal FBIOBLANK/UNBLANK sequence.
Recovery ADB has no authentication; the Android ROM has its separate policy.
TeamWin's recovery policy includes permissive domains even with global enforcing.

Clone at `device/samsung/gta3xlwifi` inside the separate TWRP checkout. Required
FBE-startup and library-relink platform fixes, pinned manifests, checked recovery
inputs and build/verification instructions are in:
https://github.com/oddhap/android_build_samsung_gta3xlwifi

Device reference audited: gta3xlwifi-dev/android_device_samsung_gta3xlwifi_twrp,
revision d74a521b1af73c8e9ee990aa763c6947d5eb3c55. This tree corrects that
reference's model, display geometry and boot header for the tested SM-T510.
New configuration is Apache-2.0; upstream and stock notices retain their terms.

## Version and preferences

The UI displays only `3.7.1_12`. Device options `TW_OMIT_DEVICE_VERSION` and
`TW_SETTINGS_STORAGE_PATH` require the platform patches in the build repository.
Only recovery preferences are stored at `/cache/TWRP/.twrps`, independent of
locked internal media. The system modification prompt checkbox remains usable
while FBE is locked. Clearing cache also clears these preferences. Backup paths
and Android encryption are unchanged; no PIN or encryption keys are persisted
as TWRP preferences. PIN-based Samsung FBE decryption has been demonstrated with the installed
LineageOS 21 / Android 14 data. See the FBE validation note in the build repo.


## Samsung FBE hardware services

`install_keyring` creates the inherited legacy keyring used by Linux 4.4.
Recovery mounts the installed vendor and Android system read-only and starts
MobiCore, Keymaster 4.0, Gatekeeper 1.0 and Keystore2 in order. Gatekeeper requires
normal EFS read/write access for verification state and counters; provisioning
files must never be wiped as a decryption workaround. Recovery-only SELinux
rules label the dedicated RPMB block node and allow the kernel worker to access
that node. The kernel handles failed opens without dereferencing error pointers.

The recovery header uses OS 14.0.0 / patch 2026-09-01 to match this LineageOS 21
Keymaster input. A startup guard compares it with installed Android properties.
This is compatibility metadata, not an upgrade of TWRP's Android 12.1 code or
its security patch level. A ROM upgrade changing those inputs needs a matching
recovery build. Other firmware, credentials or Android releases remain untested.

Existing Android key files are read, not generated or replaced. The Android
Keystore DB and any WAL are copied to tmpfs with recovery Keystore2 stopped;
the source DB remains untouched. Hardware authentication failures preserve the
locked state. PINs are entered through TWRP and are not recovery preferences.
