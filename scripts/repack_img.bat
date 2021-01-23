::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                    :::
:::          Carliv Image Kitchen for Android          :::
:::  boot ^& recovery images copyright-2020 carliv.eu   :::
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
echo *      Carliv Image Kitchen for Android v2.1      *
echo *    boot ^& recovery images (c)2020 carliv.eu     *
echo * including support for MTK powered phones images *
echo *               WINDOWS x86 version               *
echo *                                                 *
ecco ***************************************************{0F}{\n}
echo *           The repacking images script           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~n1" == "" goto noinput
ecco Processing the{0E} %~n1 folder{#}.{\n}
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
ecco The kernel is:{0E}         %kernel%{#}{\n}
echo(
echo Getting the ramdisk compression....
echo(
if not exist "ramdisk" goto error
for /f "delims=" %%a in (%file%.img-ramdisk-compress) do set compress=!compress!%%a
ecco Ramdisk compression:{0E} %compress%{#}{\n}
goto %compress%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
echo(
mkbootfs ramdisk | minigzip -c -9 > %file%.img-ramdisk.gz
set ramdisk=!ramdisk!%file%.img-ramdisk.gz
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
echo(
mkbootfs ramdisk | xz -1zv -Ccrc32 > %file%.img-ramdisk.xz
set ramdisk=!ramdisk!%file%.img-ramdisk.xz
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
echo(
mkbootfs ramdisk | xz --format=lzma -1zv > %file%.img-ramdisk.lzma
set ramdisk=!ramdisk!%file%.img-ramdisk.lzma
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
echo(
mkbootfs ramdisk | bzip2 -kv > %file%.img-ramdisk.bz2
set ramdisk=!ramdisk!%file%.img-ramdisk.bz2
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lz4
echo(
mkbootfs ramdisk | lz4 -l stdin stdout > %file%.img-ramdisk.lz4
set ramdisk=!ramdisk!%file%.img-ramdisk.lz4
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzo
echo(
mkbootfs ramdisk | lzop -v > %file%.img-ramdisk.lzo
set ramdisk=!ramdisk!%file%.img-ramdisk.lzo
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:repack
set bboard=
set bbase=
set pagesz=
set bkoff=
set brmoff=
set bsecoff=
set second=
set btgoff=
set bdt=
set dtb=
set bdtboff=
set dtbo=
set acpio=
set bosver=
set bpaklev=
set bhdrver=
set bhashtp=
set filetype=
echo(
echo Getting the image repacking arguments....
echo(
if not exist "%file%.img-board" goto noboard
for /f "delims=" %%a in (%file%.img-board) do set nameb=!nameb!%%a
ecco Board:{0E}             '%nameb%'{#}{\n}
set "bboard= --board '%nameb%'"
echo(
:noboard
if not exist "%file%.img-base" goto nobase
for /f "delims=" %%a in (%file%.img-base) do set base=!base!%%a
ecco Base:{0E}              %base%{#}{\n}
set "bbase= --base %base%"
echo(
:nobase
if not exist "%file%.img-pagesize" goto nopagesz
for /f "delims=" %%a in (%file%.img-pagesize) do set pagesize=!pagesize!%%a
ecco Pagesize:{0E}          %pagesize%{#}{\n}
set "pagesz= --pagesize %pagesize%"
echo(
:nopagesz
if not exist "%file%.img-cmdline" goto nocmdline
for /f "delims=" %%a in (%file%.img-cmdline) do set scmdline=!scmdline!%%a
ecco Command line:{0E}      '%scmdline%'{#}{\n}
echo(
:nocmdline
if not exist "%file%.img-kernel_offset" goto nokoff
for /f "delims=" %%a in (%file%.img-kernel_offset) do set koff=!koff!%%a
ecco Kernel offset:{0E}     %koff%{#}{\n}
set "bkoff= --kernel_offset %koff%"
echo(
:nokoff
if not exist "%file%.img-ramdisk_offset" goto noramoff
for /f "delims=" %%a in (%file%.img-ramdisk_offset) do set ramoff=!ramoff!%%a
ecco Ramdisk offset:{0E}    %ramoff%{#}{\n}
set "brmoff= --ramdisk_offset %ramoff%"
echo(
:noramoff
if not exist "%file%.img-second_offset" goto nosecoff
for /f "delims=" %%a in (%file%.img-second_offset) do set secoff=!secoff!%%a
ecco Second offset:{0E}     %secoff%{#}{\n}
set "bsecoff= --second_offset %secoff%"
echo(
:nosecoff
if not exist "%file%.img-second" goto nosecd
set fsecd=!fsecd!%file%.img-second
ecco Second bootloader:{0E} %fsecd%{#}{\n}
set "second= --second %fsecd%"
echo(
:nosecd
if not exist "%file%.img-tags_offset" goto notagoff
for /f "delims=" %%a in (%file%.img-tags_offset) do set tagoff=!tagoff!%%a
ecco Tags offset:{0E}       %tagoff%{#}{\n}
set "btgoff= --tags_offset %tagoff%"
echo(
:notagoff
if not exist "%file%.img-dt" goto nodt
set fdt=!fdt!%file%.img-dt
ecco Device tree blob:{0E}  %fdt%{#}{\n}
set "bdt= --dt %fdt%"
:nodt
if not exist "%file%.img-dtb" goto nodtboff
set fdtb=!fdtb!%file%.img-dtb
ecco Device tree blob:{0E} %fdtb%{#}{\n}
set "dtb= --dtb %fdtb%"
echo(
:nodtboff
if not exist "%file%.img-dtb_offset" goto nodtb
for /f "delims=" %%a in (%file%.img-dtb_offset) do set dtboff=!dtboff!%%a
ecco Device tree blob offset:{0E}       %dtboff%{#}{\n}
set "bdtboff= --dtb_offset %dtboff%"
echo(
:nodtb
if not exist "%file%.img-dtbo" goto nodtbo
set fdtbo=!fdtbo!%file%.img-dtbo
ecco Device tree blob overlay:{0E} %fdtbo%{#}{\n}
set "dtbo= --recovery_dtbo %fdtbo%"
echo(
:nodtbo
if not exist "%file%.img-acpio" goto noacpio
set facpio=!facpio!%file%.img-acpio
ecco Non AB ACPIO:{0E} %facpio%{#}{\n}
set "acpio= --recovery_acpio %facpio%"
echo(
:noacpio
if not exist "%file%.img-os_version" goto noosvers
for /f "delims=" %%a in (%file%.img-os_version) do set osvers=!osvers!%%a
ecco OS version:{0E}       %osvers%{#}{\n}
set "bosver= --os_version %osvers%"
echo(
:noosvers
if not exist "%file%.img-os_patch_level" goto nopaklev
for /f "delims=" %%a in (%file%.img-os_patch_level) do set paklev=!paklev!%%a
ecco OS release date:{0E}       %paklev%{#}{\n}
set "bpaklev= --os_patch_level %paklev%"
echo(
:nopaklev
if not exist "%file%.img-header_version" goto nohdrver
for /f "delims=" %%a in (%file%.img-header_version) do set hdrver=!hdrver!%%a
ecco Boot header version:{0E}       %hdrver%{#}{\n}
set "bhdrver= --header_version %hdrver%"
echo(
:nohdrver
if not exist "%file%.img-hashtype" goto nohtype
for /f "delims=" %%a in (%file%.img-hashtype) do set hashtp=!hashtp!%%a
ecco Boot hash type:{0E}       %hashtp%{#}{\n}
set "bhashtp= --hashtype %hashtp%"
echo(
:nohtype
if exist "recovery.txt" ( 
	set "filetype=recovery"
	goto newimage
)
if exist "boot.txt" ( 
	set "filetype=boot"
	goto newimage
)
echo(
:newimage
for /f "delims=" %%a in ('wmic os get LocalDateTime  ^| findstr ^[0-9]') do set "dt=%%a"
set "timestamp=cik-%dt:~8,4%"
set "newimage=%filetype%_temp"
set "packedimg=%folder%-%timestamp%"
echo(
:command
echo(
echo Executing the repacking command....
echo( 
if not exist "%file%.img-mtk" goto notmtk
mkbootimg --kernel %kernel% --ramdisk %ramdisk%%second%%dtb%%dtbo%%acpio% --cmdline "%scmdline%"%bboard%%bbase%%pagesz%%bdt%%bkoff%%brmoff%%bsecoff%%btgoff%%bdtboff%%bosver%%bpaklev%%bhdrver%%bhashtp% --mtk 1 -o ..\output\%newimage%.img
goto endcommand
:notmtk
mkbootimg --kernel %kernel% --ramdisk %ramdisk%%second%%dtb%%dtbo%%acpio% --cmdline "%scmdline%"%bboard%%bbase%%pagesz%%bdt%%bkoff%%brmoff%%bsecoff%%btgoff%%bdtboff%%bosver%%bpaklev%%bhdrver%%bhashtp% -o ..\output\%newimage%.img
:endcommand
del "%file%.img-ramdisk.%compress%" >nul 2>&1
cd ..\output
copy %newimage%.img %packedimg%.img >nul 2>&1
del %newimage%.img >nul 2>&1
cd ..\
echo(
ecco Done. Your new image was repacked as{0E} %packedimg%.img{#}.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
ecco {0C}No folder selected. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
ecco {0C}There is an error in your folder. The kernel or ramdisk is missing. Exit script.{#}{\n}
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
