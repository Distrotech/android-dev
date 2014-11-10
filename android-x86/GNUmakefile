LUNCH_VERSION = android_x86-eng
IMGFILE = out/target/product/x86/android_x86.iso

.NOTPARALLEL:
all iso_img: .repo .repo.ok $(IMGFILE)

repo:
	@wget https://storage.googleapis.com/git-repo-downloads/repo && chmod 750 repo

repo_init: repo
	@./repo init -u http://git.android-x86.org/manifest -b $(BRANCH)

repo_sync: repo_init
	@./repo sync -d && touch .repo.ok

.repo .repo.ok:
	@$(MAKE) BRANCH=${BRANCH} repo_sync

.ONESHELL:
.NOTPARALLEL:
$(IMGFILE):
	@. build/envsetup.sh
	@lunch $(LUNCH_VERSION)
	@$(MAKE) -f Makefile $@

.ONESHELL:
clean:
	@. build/envsetup.sh
	@lunch $(LUNCH_VERSION)
	@$(MAKE) -f Makefile clean installclean clobber
	@rm -f buildspec.mk repo
	@rm -rf out

distclean: clean
	@rm -f .repo.ok

install:
	install -d $(DESTDIR)/opt/android/android-x86
	install -T $(IMGFILE) $(DESTDIR)/opt/android/android-x86/$(BRANCH).iso

.PHONY: iso_img clean all distclean repo_init repo_sync install
.FEATURES: jobserver oneshell
