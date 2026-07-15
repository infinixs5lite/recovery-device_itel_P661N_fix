#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/itel/P661N

# Inherit from common-mt6833
include transsion/device/common-mt6833/BoardConfigCommon.mk

# Assert
TARGET_OTA_ASSERT_DEVICE := P661N

# Version
TW_DEVICE_VERSION := NINO
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
