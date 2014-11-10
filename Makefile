JVMDIR = /usr/lib64/jvm
JAVA6 = $(JVMDIR)/jdk-1.6.0_32
AOSP_BRANCH = android-5.0.0_r2
ANDROID_X86_BRANCH = lollipop-x86
STUDIO_BRANCH = studio-1.1-release

SDK_SYSTEM = linux-x86
SDK_ARCH = x86_64
SDK_LUNCH_VERSION = sdk_$(SDK_ARCH)-eng
SDK_DIR = out/host/$(SDK_SYSTEM)/sdk/sdk_$(SDK_ARCH)/android-sdk_eng.root_$(SDK_SYSTEM)

all: sdk android-studio android-x86

studio gradle tools android-studio studio-install:
	@$(MAKE) -C android-studio BRANCH=$(STUDIO_BRANCH) JAVA6=$(JAVA6) $@

sdk:
	@$(MAKE) -C aosp BRANCH=$(AOSP_BRANCH) MAKE_TARGET=$@ SDK_DIR=$(SDK_DIR) $(SDK_LUNCH_VERSION).$@

android-x86:
	@$(MAKE) -C android-x86 BRANCH=$(ANDROID_X86_BRANCH)

clean::
	@rm -f android-sdk-*.rpm
	@rm -rf rpm/BUILD rpm/RPMS

repo repo_sync distclean .repo.ok .repo install clean::
	@$(MAKE) -C android-studio BRANCH=$(STUDIO_BRANCH) JAVA6=$(JAVA6) $@
	@$(MAKE) -C aosp BRANCH=$(AOSP_BRANCH) LUNCH_VERSION=$(SDK_LUNCH_VERSION) SDK_DIR=$(SDK_DIR) $@
	@$(MAKE) -C android-x86 BRANCH=$(ANDROID_X86_BRANCH) $@

rpm: all
	install -d rpm/BUILD rpm/RPMS/$(SDK_ARCH)
	@$(MAKE) DESTDIR=../rpm/BUILDROOT install
	@rpmbuild -bb --buildroot=`pwd`/rpm/BUILDROOT rpm/SPECS/android-sdk.spec
	@mv rpm/RPMS/$(SDK_ARCH)/* .
	@rm -rf rpm/BUILD rpm/RPMS

.PHONY: studio gradle tools android-studio studio-install clean sdk repo_sync repo_init repo .repo .repo.ok android-x86 rpm
.FEATURES: jobserver oneshell
