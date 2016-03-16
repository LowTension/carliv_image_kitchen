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
echo *         The repacking MTK images script         *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~n1" == "" goto noinput
ctext "Processing the{0E} %~n1 folder{07}.{\n}"
echo(
set "folder=%~n1"
cd %folder%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Repacking the image....
echo(
for /f "delims=" %%a in ('dir /b *-kernel') do set nfile=!nfile!%%~na
set "file=%nfile%"
if not exist "%file%.img-kernel" goto error
set kernel=!kernel!%file%.img-kernel
ctext "The kernel is:{0E}         %kernel%{07}{\n}"
echo(
echo Getting the ramdisk compression....
echo(
if not exist "ramdisk" goto error
for /f "delims=" %%a in (%file%.img-ramdisk-compress) do set compress=!compress!%%a
ctext "Ramdisk compression:{0E} %compress%{07}{\n}"
goto %compress%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
echo(
mkbootfs ramdisk | minigzip -c -9 > %file%.img-ramdisk.gz
set ramdisk=!ramdisk!%file%.img-ramdisk.gz
ctext "The ramdisk is:{0E}      %ramdisk%{07}{\n}"
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
echo(
mkbootfs ramdisk | xz -1zv -Ccrc32 > %file%.img-ramdisk.xz
set ramdisk=!ramdisk!%file%.img-ramdisk.xz
ctext "The ramdisk is:{0E}      %ramdisk%{07}{\n}"
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
echo(
mkbootfs ramdisk | xz --format=lzma -1zv > %file%.img-ramdisk.lzma
set ramdisk=!ramdisk!%file%.img-ramdisk.lzma
ctext "The ramdisk is:{0E}      %ramdisk%{07}{\n}"
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
echo(
mkbootfs ramdisk | bzip2 -kv > %file%.img-ramdisk.bz2
set ramdisk=!ramdisk!%file%.img-ramdisk.bz2
ctext "The ramdisk is:{0E}      %ramdisk%{07}{\n}"
goto repack
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lz4
echo(
mkbootfs ramdisk | lz4 -l stdin stdout > %file%.img-ramdisk.lz4
set ramdisk=!ramdisk!%file%.img-ramdisk.lz4
ctext "The ramdisk is:{0E}      %ramdisk%{07}{\n}"
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzo
echo(
mkbootfs ramdisk | lzop -v > %file%.img-ramdisk.lzo
set ramdisk=!ramdisk!%file%.img-ramdisk.lzo
ctext "The ramdisk is:{0E}      %ramdisk%{07}{\n}"
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:repack
echo(
echo Getting the image repacking arguments....
echo(
if not exist "%file%.img-board" goto noboard
for /f "delims=" %%a in (%file%.img-board) do set nameb=!nameb!%%a
ctext "Board:{0E}             '%nameb%'{07}{\n}"
echo(
:noboard
if not exist "%file%.img-base" goto nobase
for /f "delims=" %%a in (%file%.img-base) do set base=!base!%%a
ctext "Base:{0E}              %base%{07}{\n}"
echo(
:nobase
for /f "delims=" %%a in (%file%.img-pagesize) do set pagesize=!pagesize!%%a
ctext "Pagesize:{0E}          %pagesize%{07}{\n}"
echo(
if not exist "%file%.img-cmdline" goto nocmdline
for /f "delims=" %%a in (%file%.img-cmdline) do set scmdline=!scmdline!%%a
ctext "Command line:{0E}      '%scmdline%'{07}{\n}"
echo(
:nocmdline
if not exist "%file%.img-kernel_offset" goto nokoff
for /f "delims=" %%a in (%file%.img-kernel_offset) do set koff=!koff!%%a
ctext "Kernel offset:{0E}     %koff%{07}{\n}"
echo(
:nokoff
if not exist "%file%.img-ramdisk_offset" goto noramoff
for /f "delims=" %%a in (%file%.img-ramdisk_offset) do set ramoff=!ramoff!%%a
ctext "Ramdisk offset:{0E}    %ramoff%{07}{\n}"
echo(
:noramoff
if not exist "%file%.img-second_offset" goto nosecoff
for /f "delims=" %%a in (%file%.img-second_offset) do set fsecoff=!fsecoff!%%a
ctext "Second offset:{0E}     %fsecoff%{07}{\n}"
set "secoff=--second_offset %fsecoff%"
echo(
:nosecoff
if not exist "%file%.img-second" goto nosecd
set fsecd=!fsecd!%file%.img-second
ctext "Second bootloader:{0E} %fsecd%{07}{\n}"
set "second=--second %fsecd%"
echo(
:nosecd
if not exist "%file%.img-tags_offset" goto notagoff
for /f "delims=" %%a in (%file%.img-tags_offset) do set tagoff=!tagoff!%%a
ctext "Tags offset:{0E}       %tagoff%{07}{\n}"
echo(
:notagoff
if not exist "%file%.img-dt" goto nodt
set fdt=!fdt!%file%.img-dt
ctext "Device tree blob:{0E}  %fdt%{07}{\n}"
set "dtb=--dt %fdt%"
:nodt
:newimage
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set "dt=%%a"
set "timestamp=%dt:~8,6%"	
set "newimage=%folder%_%timestamp%"
echo(
:command
ctext "Your new image is{0E} %newimage%.img{07}.{\n}"
echo(
echo Executing the repacking command....
echo(
mtkbootimg --kernel %kernel% --ramdisk %ramdisk% --pagesize %pagesize% --base %base% --board "%nameb%" --kernel_offset %koff% --ramdisk_offset %ramoff% --tags_offset %tagoff% %second% --cmdline "%scmdline%" %secoff% %dtb% -o ..\output\%newimage%.img
del "%file%.img-ramdisk.%compress%"
cd ..\
echo(
ctext "Done. Your new image was repacked as{0E} %newimage%.img{07}.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
ctext "{0C}No folder selected. Exit script.{07}{\n}"
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noimage
echo(
ctext "{0C}Please enter a name for the repacked image first.{07}{\n}"
echo(
goto newimage
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
ctext "{0C}There is an error in your folder. The kernel or ramdisk is missing. Exit script.{07}{\n}"
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
