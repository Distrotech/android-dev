android-dev
===========

Developer tools for android includes x86_64 SDK/ADT/Android Studio/Android X86

This repository consists only of make files.

To build SDK/ADT/Studio/android-x86 ISO

make -j&lt;Number of CPU cores&gt;

To install SDK/ADT/Studio

make install

To build SDK

make -j&lt;Number of CPU cores&gt; sdk

To build ADT/Studio

make -j&lt;Number of CPU cores&gt; android-studio

To build x86 lollipop (android-x86/out/target/product/x86/android_x86.iso)

make -j&lt;Number of CPU cores&gt; android-x86

To remove build directories

make clean

To remove build directories and update / checkout repositories on next build
make distclean
