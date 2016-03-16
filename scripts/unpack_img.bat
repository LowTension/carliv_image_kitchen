::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                    :::
:::          Carliv Image Kitchen for Android          :::
:::   boot+recovery images copyright-2015 carliv@xda   :::
:::   including support for MTK powered phones images  :::
:::                                                    :::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
cd "%~dp0"
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Setlocal EnableDelayedExpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::       
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo ***************************************************
echo *           The unpacking images script           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~1" == "" goto noinput
if "%~2" == "" goto noinput
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "folder=%~n2"
ctext "Your image:{0E} %folder%.img {07}{\n}"
set "file=%~nx1"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:unpack
echo(
ctext "Create the{0E} %~n2 {07}folder.{\n}"
echo(
::if "%folder%"=="recovery" set "folder=recovery_cka"
::if "%folder%"=="recovery_cka" ctext "Because Windows doesn't like folders named {0E}[recovery]{07}, we changed the name for your folder to {0E}%folder%{07}{\n}"
if exist "%folder%" rd /s/q "%folder%"
md %folder%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
unpackbootimg -i %file% -o %folder%
cd %folder%
for %%a in ("%file%-ramdisk.*") do set ext=%%~xa
ctext "Compression used:{0E} %ext:~1% {07}{\n}"
type nul > %file%-ramdisk-compress
echo %ext:~1% > "%file%-ramdisk-compress"
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
gzip -dcv "../%file%-ramdisk.gz" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.gz"
cd ..\
echo(
ctext "Done. Your image is unpacked in{0E} %folder% {07}folder.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
cd ramdisk
xz -dcv "../%file%-ramdisk.lzma" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.lzma"
cd ..\
echo(
ctext "Done. Your image is unpacked in{0E} %folder% {07}folder.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
cd ramdisk
xz -dcv "../%file%-ramdisk.xz" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.xz"
cd ..\
echo(
ctext "Done. Your image is unpacked in{0E} %folder% {07}folder.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
cd ramdisk
bzip2 -dcv "../%file%-ramdisk.bz2" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.bz2"
cd ..\
echo(
ctext "Done. Your image is unpacked in{0E} %folder% {07}folder.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lz4
cd ramdisk
lz4 -dv "../%file%-ramdisk.lz4" stdout | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.lz4"
cd ..\
echo(
ctext "Done. Your image is unpacked in{0E} %folder% {07}folder.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzo
cd ramdisk
lzop -dcv "../%file%-ramdisk.lzo" | cpio -i
if %errorlevel% neq 0 goto ziperror
cd ..\
del "%file%-ramdisk.lzo"
cd ..\
echo(
ctext "Done. Your image is unpacked in{0E} %folder% {07}folder.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:unknown
echo(
ctext "{0C}Your image ramdisk is packed with an unsupported archive format. Please inform the author of this tool about the error and provide the image for helping him to find a solution. Exit the script.{07}{\n}"
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
ctext "{0C}Your image name doesn't contain the words{0E} boot{0C} or{0E} recovery{0C}. Don't use this tool for other type of images, or rename your boot and recovery including the type in name. Exit script.{07}{\n}"
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ziperror
echo(
ctext "{0C}Your ramdisk archive is corrupt. Are you trying to unpack a {0B}MTK{0C} image with regular script? If so, please use unpack_MTK_img script. Exit script.{07}{\n}"
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
ctext "{0C}No image file selected. Exit script.{07}{\n}"
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
