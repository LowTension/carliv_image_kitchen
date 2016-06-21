::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                    :::
:::          Carliv Image Kitchen for Android          :::
:::   boot+recovery images copyright-2016 carliv@xda   :::
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
cecho *      {0B}Carliv Image Kitchen for Android{#} v1.2      *{\n}
cecho *     boot+recovery images (c)2016 {0B}carliv@xda{#}     *{\n}
cecho * including support for {0E}MTK powered {#}phones images *{\n}
cecho *               {0A}WINDOWS x64 {#}version               *{\n}
echo ***************************************************
echo *           The repacking images script           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~n1" == "" goto noinput
cecho Processing the{0E} %~n1 folder{#}.{\n}
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
cecho The kernel is:{0E}         %kernel%{#}{\n}
echo(
echo Getting the ramdisk compression....
echo(
if not exist "ramdisk" goto error
for /f "delims=" %%a in (%file%.img-ramdisk-compress) do set compress=!compress!%%a
cecho Ramdisk compression:{0E} %compress%{#}{\n}
goto %compress%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
echo(
mkbootfs ramdisk | minigzip -c -9 > %file%.img-ramdisk.gz
set ramdisk=!ramdisk!%file%.img-ramdisk.gz
cecho The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
echo(
mkbootfs ramdisk | xz -1zv -Ccrc32 > %file%.img-ramdisk.xz
set ramdisk=!ramdisk!%file%.img-ramdisk.xz
cecho The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
echo(
mkbootfs ramdisk | xz --format=lzma -1zv > %file%.img-ramdisk.lzma
set ramdisk=!ramdisk!%file%.img-ramdisk.lzma
cecho The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
echo(
mkbootfs ramdisk | bzip2 -kv > %file%.img-ramdisk.bz2
set ramdisk=!ramdisk!%file%.img-ramdisk.bz2
cecho The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lz4
echo(
mkbootfs ramdisk | lz4 -l stdin stdout > %file%.img-ramdisk.lz4
set ramdisk=!ramdisk!%file%.img-ramdisk.lz4
cecho The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzo
echo(
mkbootfs ramdisk | lzop -v > %file%.img-ramdisk.lzo
set ramdisk=!ramdisk!%file%.img-ramdisk.lzo
cecho The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:repack
echo(
echo Getting the image repacking arguments....
echo(
if not exist "%file%.img-board" goto noboard
for /f "delims=" %%a in (%file%.img-board) do set nameb=!nameb!%%a
cecho Board:{0E}             '%nameb%'{#}{\n}
echo(
:noboard
if not exist "%file%.img-base" goto nobase
for /f "delims=" %%a in (%file%.img-base) do set base=!base!%%a
cecho Base:{0E}              %base%{#}{\n}
echo(
:nobase
for /f "delims=" %%a in (%file%.img-pagesize) do set pagesize=!pagesize!%%a
cecho Pagesize:{0E}          %pagesize%{#}{\n}
echo(
if not exist "%file%.img-cmdline" goto nocmdline
for /f "delims=" %%a in (%file%.img-cmdline) do set scmdline=!scmdline!%%a
cecho Command line:{0E}      '%scmdline%'{#}{\n}
echo(
:nocmdline
if not exist "%file%.img-kernel_offset" goto nokoff
for /f "delims=" %%a in (%file%.img-kernel_offset) do set koff=!koff!%%a
cecho Kernel offset:{0E}     %koff%{#}{\n}
echo(
:nokoff
if not exist "%file%.img-ramdisk_offset" goto noramoff
for /f "delims=" %%a in (%file%.img-ramdisk_offset) do set ramoff=!ramoff!%%a
cecho Ramdisk offset:{0E}    %ramoff%{#}{\n}
echo(
:noramoff
if not exist "%file%.img-second_offset" goto nosecoff
for /f "delims=" %%a in (%file%.img-second_offset) do set fsecoff=!fsecoff!%%a
cecho Second offset:{0E}     %fsecoff%{#}{\n}
set "secoff=--second_offset %fsecoff%"
echo(
:nosecoff
if not exist "%file%.img-second" goto nosecd
set fsecd=!fsecd!%file%.img-second
cecho Second bootloader:{0E} %fsecd%{#}{\n}
set "second=--second %fsecd%"
echo(
:nosecd
if not exist "%file%.img-tags_offset" goto notagoff
for /f "delims=" %%a in (%file%.img-tags_offset) do set tagoff=!tagoff!%%a
cecho Tags offset:{0E}       %tagoff%{#}{\n}
echo(
:notagoff
if not exist "%file%.img-dt" goto nodt
set fdt=!fdt!%file%.img-dt
cecho Device tree blob:{0E}  %fdt%{#}{\n}
set "dtb=--dt %fdt%"
:nodt
:newimage
for /f "delims=" %%a in ('wmic os get LocalDateTime  ^| findstr ^[0-9]') do set "dt=%%a"
set "timestamp=%dt:~0,8%-%dt:~8,4%"	
set "newimage=%folder%-%timestamp%"
echo(
:command
cecho Your new image is{0E} %newimage%.img{#}.{\n}
echo(
echo Executing the repacking command....
echo( 
if not exist "%file%.img-mtk" goto notmtk
mkbootimg --kernel %kernel% --ramdisk %ramdisk% --pagesize %pagesize% --base %base% --board "%nameb%" --kernel_offset %koff% --ramdisk_offset %ramoff% --tags_offset %tagoff% %second% --cmdline "%scmdline%" %secoff% %dtb% --mtk 1 -o ..\output\%newimage%.img
goto endcommand
:notmtk
mkbootimg --kernel %kernel% --ramdisk %ramdisk% --pagesize %pagesize% --base %base% --board "%nameb%" --kernel_offset %koff% --ramdisk_offset %ramoff% --tags_offset %tagoff% %second% --cmdline "%scmdline%" %secoff% %dtb% -o ..\output\%newimage%.img
:endcommand
del "%file%.img-ramdisk.%compress%"
cd ..\
echo(
cecho Done. Your new image was repacked as{0E} %newimage%.img{#}.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
cecho {0C}No folder selected. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
cecho {0C}There is an error in your folder. The kernel or ramdisk is missing. Exit script.{#}{\n}
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
