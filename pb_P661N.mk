#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from P661N device
$(call inherit-product, device/itel/P661N/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/pb/config/common.mk)

PRODUCT_DEVICE := P661N
PRODUCT_NAME := pb_P661N
PRODUCT_BRAND := Itel
PRODUCT_MODEL := itel P55 5G
PRODUCT_MANUFACTURER := ITEL

PRODUCT_GMS_CLIENTID_BASE := android-transsion

# Hide Reflash TWRP & FUSE passthrough
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    persist.sys.fuse.passthrough.enable=true


PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="vnd_p661n_h334-user 12 SP1A.210812.016 928046 release-keys"

BUILD_FINGERPRINT := Itel/P661N-GL/itel-P661N:12/SP1A.210812.016/250723V610:user/release-keys
