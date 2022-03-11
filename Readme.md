# msvc-wine Issue #41 Repro

I have included a Dockerfile which extends the base `msvc-wine` image and install Ninja/CMake as well as sort out permissions for clion

```bash
sudo docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g)  $@ -t wine:x86 .
```

I'm using clion and added a docker toolchain, setting CMake path to `/opt/cmake/bin/cmake`

In clion cmake settings I set:
 - CMake options: `-G Ninja -DCMAKE_C_COMPILER_WORKS=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_CROSSCOMPILING=ON`
 - Environment: `CXX=cl;CC=cl`

## Failure Output:

```text
/opt/cmake/bin/cmake -DCMAKE_BUILD_TYPE=Release -G Ninja -DCMAKE_C_COMPILER_WORKS=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_CROSSCOMPILING=ON /tmp/msvc-wine_issue-41_repro
-- The CXX compiler identification is MSVC 19.31.31104.0
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /opt/msvc/bin/x86/cl - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine
CMake Warning:
  Manually-specified variables were not used by the project:

    CMAKE_C_COMPILER_WORKS



Cannot get compiler information:
	Compiler exited with error code 2: /opt/msvc/bin/x86/cl @/tmp/misc/response-file7293305744123650055 /tmp/misc/compiler-file5531901747247690926 | @response-file7293305744123650055=/TP /DIssueRepro_EXPORTS /DNDEBUG /DWIN32 /D_MBCS /D_USRDLL /D_WINDOWS /EHsc /EHsc -MD /GL /Oi /GF /Gy /W3 /Zi /EHsc /FI/tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine/IssueRepro/CMakeFiles/IssueRepro.dir/cmake_pch.hxx /Be /Bd /EP
	0012:err:ole:StdMarshalImpl_MarshalInterface Failed to create ifstub, hres=0x80004002
	0012:err:ole:CoMarshalInterface Failed to marshal the interface {6d5140c1-7436-11ce-8034-00aa006009fa}, 80004002
	0012:err:ole:get_local_server_stream Failed: 80004002
	0014:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	0014:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	0014:err:ole:apartment_createwindowifneeded CreateWindow failed with error 0
	000b:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	000b:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	0014:err:ole:apartment_createwindowifneeded CreateWindow failed with error 0
	0014:err:ole:apartment_createwindowifneeded CreateWindow failed with error 14007
	0014:err:ole:StdMarshalImpl_MarshalInterface Failed to create ifstub, hres=0x800736b7
	0014:err:ole:CoMarshalInterface Failed to marshal the interface {6d5140c1-7436-11ce-8034-00aa006009fa}, 800736b7
	0014:err:ole:get_local_server_stream Failed: 800736b7
	0010:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	0010:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	Could not find Wine Gecko. HTML rendering will be disabled.
	it looks like wine32-development is missing, you should install it.
	multiarch needs to be enabled first.  as root, please
	execute "dpkg --add-architecture i386 && apt-get update &&
	apt-get install wine32-development"
	0026:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	0026:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	Could not find Wine Gecko. HTML rendering will be disabled.
	wine: configuration in L"/home/wine/.wine" has been updated.
	Microsoft (R) C/C++ Optimizing Compiler Version 19.31.31104 for x86
	Copyright (C) Microsoft Corporation.  All rights reserved.
	
	all:
		@cd Z:\tmp\msvc-wine_issue-41_repro\cmake-build-release-docker-wine\IssueRepro
		@set INCLUDE=z:\opt\msvc\vc\tools\msvc\14.31.31103\include;z:\opt\msvc\kits\10\include\10.0.19041.0\shared;z:\opt\msvc\kits\10\include\10.0.19041.0\ucrt;z:\opt\msvc\kits\10\include\10.0.19041.0\um;z:\opt\msvc\kits\10\include\10.0.19041.0\winrt
		@set LIB=z:\opt\msvc\vc\tools\msvc\14.31.31103\lib\x86;z:\opt\msvc\kits\10\lib\10.0.19041.0\ucrt\x86;z:\opt\msvc\kits\10\lib\10.0.19041.0\um\x86
		@set CL=
		@set _CL_=
		@set LINK=
		Z:\opt\msvc\vc\tools\msvc\14.31.31103\bin\Hostx64\x86\cl.exe @<< z:/tmp/misc/compiler-file5531901747247690926
	/TP /DIssueRepro_EXPORTS /DNDEBUG /DWIN32 /D_MBCS /D_USRDLL /D_WINDOWS /EHsc /EHsc -MD /GL /Oi /GF /Gy /W3 /Zi /EHsc /FI/tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine/IssueRepro/CMakeFiles/IssueRepro.dir/cmake_pch.hxx /Be /Bd /EP<<
	
	cl /TP /DIssueRepro_EXPORTS /DNDEBUG /DWIN32 /D_MBCS /D_USRDLL /D_WINDOWS /EHsc /EHsc -MD /GL /Oi /GF /Gy /W3 /Zi /EHsc /FI/tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine/IssueRepro/CMakeFiles/IssueRepro.dir/cmake_pch.hxx /Be /Bd /EP
	cl : Command line error D8004 : '/FI' requires an argument
	
	
	Compiler exited with error code 2: /opt/msvc/bin/x86/cl @/tmp/misc/response-file8517182392964903778 /tmp/misc/compiler-file5531901747247690926 | @response-file8517182392964903778=/TP /DWIN32 /EHsc /EHsc -MD /GL /Zi /EHsc /FI/tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine/IssueRepro/CMakeFiles/IssueReproTest.dir/cmake_pch.hxx /Be /Bd /EP
	0012:err:ole:StdMarshalImpl_MarshalInterface Failed to create ifstub, hres=0x80004002
	0012:err:ole:CoMarshalInterface Failed to marshal the interface {6d5140c1-7436-11ce-8034-00aa006009fa}, 80004002
	0012:err:ole:get_local_server_stream Failed: 80004002
	0014:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	0014:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	0014:err:ole:apartment_createwindowifneeded CreateWindow failed with error 0
	0014:err:ole:apartment_createwindowifneeded CreateWindow failed with error 0
	000b:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	000b:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	0014:err:ole:apartment_createwindowifneeded CreateWindow failed with error 14007
	0014:err:ole:StdMarshalImpl_MarshalInterface Failed to create ifstub, hres=0x800736b7
	0014:err:ole:CoMarshalInterface Failed to marshal the interface {6d5140c1-7436-11ce-8034-00aa006009fa}, 800736b7
	0014:err:ole:get_local_server_stream Failed: 800736b7
	0010:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	0010:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	Could not find Wine Gecko. HTML rendering will be disabled.
	it looks like wine32-development is missing, you should install it.
	multiarch needs to be enabled first.  as root, please
	execute "dpkg --add-architecture i386 && apt-get update &&
	apt-get install wine32-development"
	0025:err:winediag:nodrv_CreateWindow Application tried to create a window, but no driver could be loaded.
	0025:err:winediag:nodrv_CreateWindow Make sure that your X server is running and that $DISPLAY is set correctly.
	Could not find Wine Gecko. HTML rendering will be disabled.
	wine: configuration in L"/home/wine/.wine" has been updated.
	Microsoft (R) C/C++ Optimizing Compiler Version 19.31.31104 for x86
	Copyright (C) Microsoft Corporation.  All rights reserved.
	
	all:
		@cd Z:\tmp\msvc-wine_issue-41_repro\cmake-build-release-docker-wine\IssueRepro
		@set INCLUDE=z:\opt\msvc\vc\tools\msvc\14.31.31103\include;z:\opt\msvc\kits\10\include\10.0.19041.0\shared;z:\opt\msvc\kits\10\include\10.0.19041.0\ucrt;z:\opt\msvc\kits\10\include\10.0.19041.0\um;z:\opt\msvc\kits\10\include\10.0.19041.0\winrt
		@set LIB=z:\opt\msvc\vc\tools\msvc\14.31.31103\lib\x86;z:\opt\msvc\kits\10\lib\10.0.19041.0\ucrt\x86;z:\opt\msvc\kits\10\lib\10.0.19041.0\um\x86
		@set CL=
		@set _CL_=
		@set LINK=
		Z:\opt\msvc\vc\tools\msvc\14.31.31103\bin\Hostx64\x86\cl.exe @<< z:/tmp/misc/compiler-file5531901747247690926
	/TP /DWIN32 /EHsc /EHsc -MD /GL /Zi /EHsc /FI/tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine/IssueRepro/CMakeFiles/IssueReproTest.dir/cmake_pch.hxx /Be /Bd /EP<<
	
	cl /TP /DWIN32 /EHsc /EHsc -MD /GL /Zi /EHsc /FI/tmp/msvc-wine_issue-41_repro/cmake-build-release-docker-wine/IssueRepro/CMakeFiles/IssueReproTest.dir/cmake_pch.hxx /Be /Bd /EP
	cl : Command line error D8004 : '/FI' requires an argument
```