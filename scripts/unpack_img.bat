::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                    :::
:::          Carliv Image Kitchen for Android          :::
:::      boot & recovery images (c)-2021 carliv.eu     :::
:::   including support for MTK powered phones images  :::
:::                                                    :::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
cd "%~dp0"
IF EXIST "%~dp0\bin" SET PATH="%~dp0\bin";%PATH%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Setlocal EnableDelayedExpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::       
ecco {1B}
echo ***************************************************
echo *                                                 *
echo *      Carliv Image Kitchen for Android v2.6      *
echo *    boot ^& recovery images (c)2021 carliv.eu     *
echo * including support for MTK powered phones images *
echo *               WINDOWS x64 version               *
echo *                                                 *
ecco ***************************************************{0F}{\n}
echo *           The unpacking images script           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~1" == "" goto noinput
if "%~2" == "" goto noinput
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "folder=%~n2"
ecco Your image:{0E} %folder%.img {#}{\n}
set "file=%~nx1"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:unpack
echo(
ecco Create the{0E} %~n2 {#}folder.{\n}
echo(
if exist "%folder%" rd /s/q "%folder%"
md %folder%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
unpackbootimg -i %file% -o %folder%
if %errorlevel% neq 0 goto verserror
:donecheck
cd %folder%
for %%a in ("ramdisk.*") do set ext=%%~xa
type nul > ramdisk_compress
echo %ext:~1% > "ramdisk_compress"
echo(
md ramdisk
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Unpacking the ramdisk....
echo(
goto %ext:~1%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
cd ramdisk
gzip -dcv "../ramdisk.gz" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "ramdisk.gz"
cd ..\
echo(
ecco Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
cd ramdisk
xz -dcv --format=lzma "../ramdisk.lzma" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "ramdisk.lzma"
cd ..\
echo(
ecco Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
cd ramdisk
xz -dcv "../ramdisk.xz" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "ramdisk.xz"
cd ..\
echo(
ecco Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
cd ramdisk
bzip2 -dcv "../ramdisk.bz2" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "ramdisk.bz2"
cd ..\
echo(
ecco Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lz4
cd ramdisk
lz4 -dv "../ramdisk.lz4" stdout | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "ramdisk.lz4"
cd ..\
echo(
ecco Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzo
cd ramdisk
lzop -dcv "../ramdisk.lzo" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "ramdisk.lzo"
cd ..\
echo(
ecco Done. Your image is unpacked in{0E} %folder% {#}folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cpio
echo(
ecco {0C}Your ramdisk archive has an unknown format. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ziperror
echo(
ecco {0C}Your ramdisk archive is corrupt or unknown format. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:verserror
echo(
ecco {0C}Boot and recovery images with header version 4 or above are not supported. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
ecco {0C}No image file selected. Exit script.{#}{\n}
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
