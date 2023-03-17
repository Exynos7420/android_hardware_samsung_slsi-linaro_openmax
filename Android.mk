ifeq ($(TARGET_SLSI_VARIANT),bsp)
openmax_dirs := \
	videocodec \
	openmax

include $(call all-named-subdir-makefiles,$(openmax_dirs))
else
PREFIX := $(shell echo $(TARGET_BOARD_PLATFORM) | head -c 6)
ifneq ($(filter exynos, $(PREFIX)),)
openmax_dirs := \
	videocodec \
	openmax

include $(call all-named-subdir-makefiles,$(openmax_dirs))
endif

ifeq ($(BOARD_OMX_USES_HDR),true)
	LOCAL_CFLAGS += -DUSE_HDR
endif
endif