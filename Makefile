INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlertSpringBoard

AlertSpringBoard_FILES = Tweak.x
AlertSpringBoard_CFLAGS = -fobjc-arc
AlertSpringBoard_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
