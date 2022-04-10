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
echo *           The repacking images script           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~n1" == "" goto noinput
if not exist "output" md output
ecco Processing the{0E} %~n1 folder{#}.{\n}
echo(
set "folder=%~n1"
cd %folder%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Repacking the image....
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:vendor_boot
if not exist "vendor_boot" goto normal_boot
ecco This is a{0E} vendor_boot image!{#}{\n}
goto ramdisk
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:normal_boot
if not exist "kernel" goto error
set kernel=!kernel!kernel
ecco The kernel is:{0E}         %kernel%{#}{\n}
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ramdisk
echo Getting the ramdisk compression....
echo(
if not exist "ramdisk" goto error
if not exist "ramdisk_compress" goto noramdcompress
for /f "delims=" %%a in (ramdisk_compress) do set compress=!compress!%%a
ecco Ramdisk compression:{0E} %compress%{#}{\n}
goto %compress%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
echo(
mkbootfs ramdisk | minigzip -c -9 > ramdisk.gz
set ramdisk=!ramdisk!ramdisk.gz
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
echo(
mkbootfs ramdisk | xz -1zv -Ccrc32 > ramdisk.xz
set ramdisk=!ramdisk!ramdisk.xz
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
echo(
mkbootfs ramdisk | xz --format=lzma -1zv > ramdisk.lzma
set ramdisk=!ramdisk!ramdisk.lzma
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
echo(
mkbootfs ramdisk | bzip2 -zv > ramdisk.bz2
set ramdisk=!ramdisk!ramdisk.bz2
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lz4
echo(
mkbootfs ramdisk | lz4 -l stdin stdout > ramdisk.lz4
set ramdisk=!ramdisk!ramdisk.lz4
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzo
echo(
mkbootfs ramdisk | lzop -v > ramdisk.lzo
set ramdisk=!ramdisk!ramdisk.lzo
ecco The ramdisk is:{0E}      %ramdisk%{#}{\n}
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:repack
set bkernel=
set bramdisk=
set bmtk=
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
set bcmdline=
set bout=
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist "vendor_boot" (
	set "bramdisk= --vendor_ramdisk %ramdisk%"
)
if not exist "vendor_boot" ( 
	set "bramdisk= --ramdisk %ramdisk%"
)
if not exist "vendor_boot" ( 
	set "bkernel= --kernel %kernel%"
)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
echo Getting the image repacking arguments....
echo(
if not exist "board" goto noboard
for /f "delims=" %%a in (board) do set nameb=!nameb!%%a
ecco Board:{0E}             '%nameb%'{#}{\n}
set "bboard= --board '%nameb%'"
echo(
:noboard
if not exist "base" goto nobase
for /f "delims=" %%a in (base) do set base=!base!%%a
ecco Base:{0E}              %base%{#}{\n}
set "bbase= --base %base%"
echo(
:nobase
if not exist "pagesize" goto nopagesz
for /f "delims=" %%a in (pagesize) do set pagesize=!pagesize!%%a
ecco Pagesize:{0E}          %pagesize%{#}{\n}
set "pagesz= --pagesize %pagesize%"
echo(
:nopagesz
if not exist "cmdline" goto nocmdline
for /f "delims=" %%a in (cmdline) do set scmdline=!scmdline!%%a
ecco Command line:{0E}      '%scmdline%'{#}{\n}
if exist "vendor_boot" (
	set "bcmdline= --vendor_cmdline "
)
if not exist "vendor_boot" ( 
	set "bcmdline= --cmdline "
)
echo(
:nocmdline
if not exist "kernel_offset" goto nokoff
for /f "delims=" %%a in (kernel_offset) do set koff=!koff!%%a
ecco Kernel offset:{0E}     %koff%{#}{\n}
set "bkoff= --kernel_offset %koff%"
echo(
:nokoff
if not exist "ramdisk_offset" goto noramoff
for /f "delims=" %%a in (ramdisk_offset) do set ramoff=!ramoff!%%a
ecco Ramdisk offset:{0E}    %ramoff%{#}{\n}
set "brmoff= --ramdisk_offset %ramoff%"
echo(
:noramoff
if not exist "second_offset" goto nosecoff
for /f "delims=" %%a in (second_offset) do set secoff=!secoff!%%a
ecco Second offset:{0E}     %secoff%{#}{\n}
set "bsecoff= --second_offset %secoff%"
echo(
:nosecoff
if not exist "second" goto nosecd
set fsecd=!fsecd!second
ecco Second bootloader:{0E} %fsecd%{#}{\n}
set "second= --second %fsecd%"
echo(
:nosecd
if not exist "tags_offset" goto notagoff
for /f "delims=" %%a in (tags_offset) do set tagoff=!tagoff!%%a
ecco Tags offset:{0E}       %tagoff%{#}{\n}
set "btgoff= --tags_offset %tagoff%"
echo(
:notagoff
if not exist "dt" goto nodt
set fdt=!fdt!dt
ecco Device tree blob:{0E}  %fdt%{#}{\n}
set "bdt= --dt %fdt%"
:nodt
if not exist "dtb" goto nodtb
set fdtb=!fdtb!dtb
ecco Device tree blob:{0E} %fdtb%{#}{\n}
set "dtb= --dtb %fdtb%"
echo(
:nodtb
if not exist "dtb_offset" goto nodtboff
for /f "delims=" %%a in (dtb_offset) do set dtboff=!dtboff!%%a
ecco Device tree blob offset:{0E}       %dtboff%{#}{\n}
set "bdtboff= --dtb_offset %dtboff%"
echo(
:nodtboff
if not exist "recovery_dtbo" goto nodtbo
set fdtbo=!fdtbo!recovery_dtbo
ecco Device tree blob overlay:{0E} %fdtbo%{#}{\n}
set "dtbo= --recovery_dtbo %fdtbo%"
echo(
:nodtbo
if not exist "recovery_acpio" goto noacpio
set facpio=!facpio!recovery_acpio
ecco Non AB ACPIO:{0E} %facpio%{#}{\n}
set "acpio= --recovery_acpio %facpio%"
echo(
:noacpio
if not exist "os_version" goto noosvers
for /f "delims=" %%a in (os_version) do set osvers=!osvers!%%a
ecco OS version:{0E}       %osvers%{#}{\n}
set "bosver= --os_version %osvers%"
echo(
:noosvers
if not exist "os_patch_level" goto nopaklev
for /f "delims=" %%a in (os_patch_level) do set paklev=!paklev!%%a
ecco OS release date:{0E}       %paklev%{#}{\n}
set "bpaklev= --os_patch_level %paklev%"
echo(
:nopaklev
if not exist "header_version" goto nohdrver
for /f "delims=" %%a in (header_version) do set hdrver=!hdrver!%%a
ecco Boot header version:{0E}       %hdrver%{#}{\n}
set "bhdrver= --header_version %hdrver%"
echo(
:nohdrver
if not exist "hashtype" goto nohtype
for /f "delims=" %%a in (hashtype) do set hashtp=!hashtp!%%a
ecco Boot hash type:{0E}       %hashtp%{#}{\n}
set "bhashtp= --hashtype %hashtp%"
echo(
:nohtype
if not exist "mtk" goto newimage
for /f "delims=" %%a in (mtk) do set mtk=!mtk!%%a
set "bmtk= --mtk %mtk%"
echo(
:newimage
for /f "delims=" %%a in ('wmic os get LocalDateTime  ^| findstr ^[0-9]') do set "dt=%%a"
set "timestamp=cika-%dt:~8,4%"
set "newimage=cika.img"
set "packedimg=%folder%-%timestamp%"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist "vendor_boot" (
	set "bout= --vendor_boot"
)
if not exist "vendor_boot" ( 
	set "bout= --output"
)
echo(
:command
echo(
echo Executing the repacking command....
echo(
mkbootimg%bkernel%%bramdisk%%second%%dtb%%dtbo%%acpio%%bcmdline%"%scmdline%"%bboard%%bbase%%pagesz%%bdt%%bkoff%%brmoff%%bsecoff%%btgoff%%bdtboff%%bosver%%bpaklev%%bhdrver%%bhashtp%%bmtk%%bout% ..\output\%newimage%
if %errorlevel% neq 0 goto softerror
:endcommand
del "ramdisk.%compress%" >nul 2>&1
cd ..\output
copy %newimage% %packedimg%.img >nul 2>&1
del %newimage% >nul 2>&1
cd ..\
echo(
ecco Done. Your new image was repacked as{0E} %packedimg%.img{#}.{\n}
ecco You can find it in {0E}[output]{#} folder.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
ecco {0C}No folder selected. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noramdcompress
echo(
ecco {0C}No ramdisk_compress file found. Exit script.{#}{\n}
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
ecco {0C}There is an error in your folder. The kernel or ramdisk is missing. Exit script.{#}{\n}
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:softerror
echo(
ecco {0C}There is an error executing the mkbootimg. Exit script.{#}{\n}
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
