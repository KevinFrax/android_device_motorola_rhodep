#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from motorola sm6375-common
-include device/motorola/sm6375-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/rhodep

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := rhodep

# Display
TARGET_SCREEN_DENSITY := 400

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.hab.product=rhodep
#TARGET_KERNEL_CONFIG += vendor/lineage_rhodep.config

BOARD_KERNEL_BINARIES := kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
TARGET_KERNEL_CONFIG := holi_QGKI
TARGET_PREBUILT_DTB := $(DEVICE_PATH)-kernel/dtb.img
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)-kernel/dtb.img:$(TARGET_COPY_OUT)/dtb.img \
    $(DEVICE_PATH)-kernel/kernel:kernel \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)-kernel/ramdisk-modules/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules) \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)-kernel/vendor-modules/,$(TARGET_COPY_OUT_VENDOR)/lib/modules)

# Kernel Modules
#BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
#BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
#BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 116681322496
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 3195027456
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 872398848
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 914399232
endif
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 8608808960 #(BOARD_SUPER_PARTITION_SIZE - 4194304)
BOARD_SUPER_PARTITION_SIZE := 8613003264

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security
VENDOR_SECURITY_PATCH := 2023-10-01

# Inherit from the proprietary version
-include vendor/motorola/rhodep/BoardConfigVendor.mk
