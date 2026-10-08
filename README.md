# TWRP 3.7.1_12 for SM-T510 — PIN-free FBE fix

Unofficial ARM32 recovery, Android 12.1 base, ARM64 Linux 4.4.302 kernel.
The 2026-10-07 image has been physically tested with LineageOS 21 / Android 14:
automatic CE decryption without a PIN, ordinary PIN verification, real CE
read/write, recovery stability and return to native ARM64 Android. No data
formatting or encryption disablement was used.

- [Updated image, Odin AP package and instructions](https://github.com/oddhap/android_build_samsung_gta3xlwifi/releases/tag/lineage-21.0-arm64-beta-20261007)
- [Build integration, manifests and runtime reports](https://github.com/oddhap/android_build_samsung_gta3xlwifi/tree/lineage-21.0-arm64)
- [Recovery kernel](https://github.com/oddhap/android_kernel_samsung_gta3xlwifi/tree/twrp-12.1)

## Source

The device configuration is unchanged from the previous FBE recovery. The complete
`patches/system-vold-complete.patch` is relative to TeamWin android_system_vold
revision `a164ba05c5fef288059774a776b2e6e1119957cf`; it includes the existing
FBE/Keymaster fixes and the new bounded keystore wait, zero-padded NONE token
and authenticated GCM decryption.

Apply that complete patch to the pinned vold tree with `git apply`, together with
the pinned bootable/recovery patch from the integration repository. Do not apply
the old complete vold patch first. `tools/fix-twrp-pinfree.py` is an idempotent
upgrade helper for trees that already have the previous FBE port.

The supplied header remains Android 14 / September 2026. The exact tested ROM
ZIP preserves this new recovery as unknown; source for future ROM builds
recognizes both exact payloads. Other OS/SPL inputs are not covered by this test.

New tools/configuration are Apache-2.0; upstream code and kernel retain their
original license notices. The complete platform code changes are published as
patches, not only binary images.
