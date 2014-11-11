JVMDIR = /usr/lib64/jvm
JAVA6 = $(JVMDIR)/jdk-1.6.0_32
SDK_INSTALL_DIR = /opt/android
ANT_HOME = /usr/lib64/jvm/apache-ant-1.9.2
STUDIO = tools/idea/out/artifacts/android-studio-SNAPSHOT.tar.gz
CWD=$(shell /bin/pwd)
VERSION = 1
LINTOOLS = out/adt/sdk-repo-linux-tools-$(VERSION).zip 
GRADLE_FILE = out/build/swt/uiautomatorviewer/build/libs/uiautomatorviewer-23.2.1.jar

.NOTPARALLEL:
android-studio all: tools studio

repo:
	@wget https://storage.googleapis.com/git-repo-downloads/repo && chmod 750 repo

repo_init: repo
	@./repo init -u https://android.googlesource.com/platform/manifest -b $(BRANCH)

repo_sync: repo_init
	@./repo sync -d && touch .repo.ok

.repo .repo.ok:
	@$(MAKE) BRANCH=${BRANCH} repo_sync

.ONESHELL:
$(GRADLE_FILE):
	@JAVA_HOME=$(JAVA6);
	@PATH=$(JAVA6)/bin:${PATH};
	@cd tools;
	@./gradlew prepareRepo;
	@./gradlew clean assemble;

.ONESHELL:
$(LINTOOLS):
	@JAVA_HOME=$(JAVA6);
	@PATH=$(JAVA6)/bin:${PATH};
	@mkdir -p out/adt;
	@./tools/buildSrc/servers/build_tools.sh $(CWD)/out $(CWD)/out/adt $(VERSION)

$(STUDIO):
	cd tools/idea && ant

gradle: .repo .repo.ok $(GRADLE_FILE)

studio: .repo .repo.ok gradle $(STUDIO)

tools: .repo .repo.ok gradle $(LINTOOLS)

clean:
	@rm -rf out tools/idea/out repo

distclean: clean
	@rm -f .repo.ok

install studio-install:
	@install -d $(DESTDIR)$(SDK_INSTALL_DIR) $(DESTDIR)$(SDK_INSTALL_DIR)-studio
	@unzip -d $(DESTDIR)$(SDK_INSTALL_DIR) -o $(LINTOOLS)
	@tar -C $(DESTDIR)$(SDK_INSTALL_DIR)-studio --strip-components=1 -xf $(STUDIO)

.PHONY: all repo_init repo_sync gradle studio tools clean distclean install android-studio studio-install
.FEATURES: jobserver oneshell
