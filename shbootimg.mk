LOCAL_PATH := $(call my-dir)

uncompressed_ramdisk := $(PRODUCT_OUT)/ramdisk.cpio
$(uncompressed_ramdisk): $(INSTALLED_RAMDISK_TARGET)
	zcat $< > $@

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
$(INSTALLED_BOOTIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(uncompressed_ramdisk) $(INSTALLED_RAMDISK_TARGET) $(TARGET_RECOVERY_ROOT_OUT) $(PRODUCT_OUT)/utilities/busybox $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Boot image: $@")


	$(hide) rm -rf $(PRODUCT_OUT)/combinedroot
	$(hide) mkdir -p $(PRODUCT_OUT)/combinedroot/sbin

	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $(recovery_uncompressed_ramdisk)
	$(hide) cp $(uncompressed_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(recovery_uncompressed_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin/

	$(hide) touch $(PRODUCT_OUT)/boot.img

	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
	$(recovery_ramdisk) \
	$(recovery_kernel) \
	$(recovery_uncompressed_ramdisk)


	$(hide) mkdir -p $(PRODUCT_OUT)/combinedroot/sbin
	@echo ----- Making recovery image ------
	cp $(recovery_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin
	cp $(recovery_kernel) $(PRODUCT_OUT)/combinedroot/sbin
	echo $(hide) $(MKBOOTIMG) -o $@ --kernel $(PRODUCT_OUT)/kernel --ramdisk $(PRODUCT_OUT)/ramdisk-recovery.img --cmdline '$(cat $(LOCAL_PATH)/../$(TARGET_DEVICE)/config/cmdline)' --base $(BOARD_KERNEL_BASE) $(BOARD_MKBOOTIMG_ARGS)
	@echo ----- Made recovery image -------- $@
