LOCAL_PATH := $(call my-dir)

ifeq ($(BOARD_USE_SKYPE_HD), true)

#################################
#### libExynosOMX_SkypeHD_Enc ###
#################################
include $(CLEAR_VARS)

LOCAL_CFLAGS :=
LOCAL_MODULE_TAGS := optional

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libExynosOMX_SkypeHD_Enc
ifeq ($(BOARD_USES_VENDORIMAGE), true)
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CFLAGS += -DUSE_VENDOR_IMAGE
endif

LOCAL_CFLAGS += -DUSE_SKYPE_HD
LOCAL_CFLAGS += -DBUILD_ENC

LOCAL_SRC_FILES := Exynos_OSAL_SkypeHD.c

LOCAL_C_INCLUDES := \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/enc \
	$(EXYNOS_OMX_COMPONENT)/video/enc/h264 \
	$(EXYNOS_VIDEO_CODEC)/include \
	$(TOP)/hardware/samsung_slsi/exynos/include

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_HEADER_LIBRARIES := media_plugin_headers
LOCAL_CFLAGS += -DUSE_ANDROID
endif
endif

ifdef BOARD_EXYNOS_S10B_FORMAT_ALIGN
LOCAL_CFLAGS += -DS10B_FORMAT_8B_ALIGNMENT=$(BOARD_EXYNOS_S10B_FORMAT_ALIGN)
endif

LOCAL_CFLAGS += -Wno-unused-variable -Wno-unused-label

include $(BUILD_STATIC_LIBRARY)

#################################
#### libExynosOMX_SkypeHD_Dec ###
#################################
include $(CLEAR_VARS)

LOCAL_CFLAGS :=
LOCAL_MODULE_TAGS := optional

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libExynosOMX_SkypeHD_Dec
ifeq ($(BOARD_USES_VENDORIMAGE), true)
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CFLAGS += -DUSE_VENDOR_IMAGE
endif

LOCAL_CFLAGS += -DUSE_SKYPE_HD
LOCAL_CFLAGS += -DBUILD_DEC
LOCAL_SRC_FILES := Exynos_OSAL_SkypeHD.c

LOCAL_C_INCLUDES := \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/dec \
	$(EXYNOS_OMX_COMPONENT)/video/dec/h264 \
	$(EXYNOS_VIDEO_CODEC)/include \
	$(TOP)/hardware/samsung_slsi/exynos/include

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_HEADER_LIBRARIES := media_plugin_headers
LOCAL_CFLAGS += -DUSE_ANDROID
endif
endif

ifdef BOARD_EXYNOS_S10B_FORMAT_ALIGN
LOCAL_CFLAGS += -DS10B_FORMAT_8B_ALIGNMENT=$(BOARD_EXYNOS_S10B_FORMAT_ALIGN)
endif

LOCAL_CFLAGS += -Wno-unused-variable -Wno-unused-label

include $(BUILD_STATIC_LIBRARY)
endif  # for Skype HD


##########################
#### libExynosOMX_OSAL ###
##########################
include $(CLEAR_VARS)

LOCAL_CFLAGS :=
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	Exynos_OSAL_Event.c \
	Exynos_OSAL_Queue.c \
	Exynos_OSAL_ETC.c \
	Exynos_OSAL_Mutex.c \
	Exynos_OSAL_Thread.c \
	Exynos_OSAL_Memory.c \
	Exynos_OSAL_Semaphore.c \
	Exynos_OSAL_Library.c \
	Exynos_OSAL_Log.c \
	Exynos_OSAL_SharedMemory.c

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libExynosOMX_OSAL
ifeq ($(BOARD_USES_VENDORIMAGE), true)
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CFLAGS += -DUSE_VENDOR_IMAGE
endif

ifeq ($(BOARD_USE_DMA_BUF), true)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

ifeq ($(BOARD_USE_CSC_HW), true)
LOCAL_CFLAGS += -DUSE_CSC_HW
endif

ifeq ($(BOARD_USE_NON_CACHED_GRAPHICBUFFER), true)
LOCAL_CFLAGS += -DUSE_NON_CACHED_GRAPHICBUFFER
endif

ifdef BOARD_MFC_CHROMA_VALIGN
LOCAL_CFLAGS += -DCHROMA_VALIGN=$(BOARD_MFC_CHROMA_VALIGN)
else
LOCAL_CFLAGS += -DCHROMA_VALIGN=1
endif

ifeq ($(BOARD_USE_WA_ION_BUF_REF), true)
LOCAL_CFLAGS += -DUSE_WA_ION_BUF_REF
endif

LOCAL_STATIC_LIBRARIES := libExynosVideoApi
LOCAL_SHARED_LIBRARIES := \
    libc \
    libcutils \
    libutils \
    liblog \
    libion \
    libhardware \
    libhidlbase \
    android.hardware.graphics.mapper@2.0 \
    android.hardware.power@1.0 \
    libion_exynos \

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/dec \
	$(EXYNOS_OMX_COMPONENT)/video/enc \
	$(EXYNOS_VIDEO_CODEC)/include \
	$(TOP)/frameworks/native/libs/arect/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_SOC)/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi/exynos/include

LOCAL_ADDITIONAL_DEPENDENCIES += \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_SRC_FILES += \
	Exynos_OSAL_Android.cpp \
	Exynos_OSAL_ImageConverter.cpp

ifeq ($(BOARD_USES_EXYNOS_DATASPACE_FEATURE), true)
LOCAL_CFLAGS += -DUSE_BT709_SUPPORT
endif

ifeq ($(BOARD_USES_EXYNOS_GRALLOC_VERSION), 1)
LOCAL_CFLAGS += -DGRALLOC_VERSION1
LOCAL_CFLAGS += -DUSE_PRIV_USAGE
else
ifeq ($(BOARD_USES_EXYNOS_GRALLOC_VERSION), 3)
LOCAL_CFLAGS += -DGRALLOC_VERSION1
LOCAL_CFLAGS += -DGRALLOC_VERSION3
LOCAL_CFLAGS += -DUSE_PRIV_USAGE
else
LOCAL_CFLAGS += -DUSE_PRIV_FORMAT
endif
endif
endif

ifeq ($(BOARD_USE_SKYPE_HD), true)
LOCAL_CFLAGS += -DUSE_SKYPE_HD
endif

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_HEADER_LIBRARIES := media_plugin_headers
LOCAL_CFLAGS += -DUSE_ANDROID
endif
endif

ifdef BOARD_EXYNOS_S10B_FORMAT_ALIGN
LOCAL_CFLAGS += -DS10B_FORMAT_8B_ALIGNMENT=$(BOARD_EXYNOS_S10B_FORMAT_ALIGN)
endif

LOCAL_CFLAGS += -Wno-unused-variable -Wno-unused-label

include $(BUILD_STATIC_LIBRARY)
