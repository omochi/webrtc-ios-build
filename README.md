# webrtc-ios-build

This is build helper tool for [webrtc_ios](https://webrtc.org/native-code/ios/).

## features

- It provides header files to be include.

- It provides many fat static libraries. (armv7, arm64, i386, x86-64)

- It provides xcode-project for use it as framework (dynamic library).

- It provides bitcode support.

# Usage

## fetch webrtc_ios

Download webrtc_ios sources by following [official instructions](https://webrtc.org/native-code/development/).
I recommend `webrtc_ios` as destination path .

Or, run my fetching script. It was written with reference to above.

```
$ ./fetch-webrtc-ios.bash
```

It takes about 3 hours in my environment.

## build all

Build all by this script.

```
$ ./webrtc-ios-build.bash
```

It references `webrtc_ios` as webrtc_ios sources for default.

You can specify webrtc_ios directory with `--webrtc` option.

It takes about 40 minutes in my environment.

## install to your project

There are 2 options.
One is using library as framework (dynamic library).
I recommend it. But it may not be stable.

The other is using library as static library.

### install as framework

Copy them into your project.

- `out/include`
- `out/lib`
- `framework-project`

**Keep their relative location.**

In xcode, add `framework-project/webrtc.xcodeproj` as subproject.
In application target `General` tab, set its product to `Embedded Binaries`.
In application target `Build Settings` tab, add them below to `Header Search Paths`.

- `out/include`
- `out/include/talk/app/webrtc/objc` (If you want to use Objective-C items)

### install as static libraries

Copy them into your project.

- `out/include`
- `out/lib`

In xcode, add all static libraries in `out/lib` to project.
In application target `Build Settings` tab,
add `out/lib` to `Library Search Paths`.
add items to `Header Search Paths` same as framework cases. 

## options

You can disable embedding bitcode by `--disable-bitcode` option.
This is google's configuration.

## clean

You can clean all by delete `out`.
This script skips each step if directory exists.
So you can retry specific step by delete a directory.

- `out/project-ninja/$platform-$arch` is made by each build (compile).
- `out/lib` is made by generating fat lib step.
- `out/include` is made by header copy step.

# Example

I configured example project with Google's `AppRTCDemo` example at `example/AppRTCDemo`.
It references `framework-project` and `out` directory.
But in your case, copy them to appropriate location.

# Internal Detail

This script is written by ruby.

## Bitcode support

Unfortunately chromium team may not support bitcode now.
This link relates it.

- [Disable ENABLE_BITCODE for iOS 9.](https://groups.google.com/a/chromium.org/forum/#!topic/chromium-reviews/MEca51xoey8)

So this script patch gyp in webrtc source repository to support this option.
gyp is meta build tool.

And write option to gyp.

## Symbol visibility change

webrtc_ios focuses static library build.
If it is linked into dynamic library,
library symbols is hidden from dynamic libraries user.

- [Controlling Symbol Visibility](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/CppRuntimeEnv/Articles/SymbolVisibility.html)

This script remove `-fvisibility=hidden` from compile flags by modifing gyp.

## Force to be fat

Some libraries built only specific archtectures.
Xcode warns lack of archtecture in fat library.
This script makes dummy library contains such code.

```
int libvpx_intrinsics_sse2_dummy_symbol() { return 0; }
```

## Bug avoidance

It removed compile targets which is specified twice.

# Success report

You can switch webrtc_ios version.

```
$ cd webrtc_ios/src
$ git checkout <commit>
$ gclient sync
```

This commit can built.

```
* commit ba3e25e50296518cccca4732b769e698dfc03365 (HEAD, origin/master, origin/HEAD, master)
| Author: Peter Boström <pbos@webrtc.org>
| Date:   Tue Feb 23 11:35:30 2016 +0100
| 
|     Simple RTCP receiver fuzzer.
|     
|     Doesn't utilize the clock or any callbacks out of the receiver but
|     should still be useful to test input packet parsing.
|     
|     BUG=webrtc:4771
|     R=danilchap@webrtc.org
|     
|     Review URL: https://codereview.webrtc.org/1716143002 .
|     
|     Cr-Commit-Position: refs/heads/master@{#11717}
```




