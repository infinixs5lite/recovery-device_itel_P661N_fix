#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/itel/P661N

# Inherit from mt6833-common
include device/transsion/mt6833-common/BoardConfigCommon.mk

# Assert
TARGET_OTA_ASSERT_DEVICE := P661N

# Init
TARGET_INIT_VENDOR_LIB := libinit_itel-P661N
TARGET_RECOVERY_DEVICE_MODULES := libinit_itel-P661N

# Version
TW_DEVICE_VERSION := NINO
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
