JVMDIR = /usr/lib64/jvm
JAVA6 = $(JVMDIR)/jdk-1.6.0_32
AOSP_BRANCH = android-5.0.0_r2
ANDROID_X86_BRANCH = lollipop-x86
STUDIO_BRANCH = studio-1.1-release

SDK_SYSTEM = linux-x86
SDK_ARCH = x86_64
SDK_LUNCH_VERSION = sdk_$(SDK_ARCH)-user
SDK_DIR = out/host/$(SDK_SYSTEM)/sdk/sdk_$(SDK_ARCH)/android-sdk_eng.root_$(SDK_SYSTEM)

all: sdk android-studio android-x86

studio gradle tools android-studio studio-install:
	@$(MAKE) -C android-studio BRANCH=$(STUDIO_BRANCH) JAVA6=$(JAVA6) $@

sdk:
	@$(MAKE) -C aosp BRANCH=$(AOSP_BRANCH) MAKE_TARGET=$@ SDK_DIR=$(SDK_DIR) $(SDK_LUNCH_VERSION).$@

android-x86:
	@$(MAKE) -C android-x86 BRANCH=$(ANDROID_X86_BRANCH)

repo repo_sync clean distclean .repo.ok .repo install:
	@$(MAKE) -C android-studio BRANCH=$(STUDIO_BRANCH) JAVA6=$(JAVA6) $@
	@$(MAKE) -C aosp BRANCH=$(AOSP_BRANCH) LUNCH_VERSION=$(SDK_LUNCH_VERSION) SDK_DIR=$(SDK_DIR) $@
	@$(MAKE) -C android-x86 BRANCH=$(ANDROID_X86_BRANCH) $@

.PHONY: studio gradle tools android-studio studio-install clean sdk repo_sync repo_init repo .repo .repo.ok android-x86
.FEATURES: jobserver oneshell
