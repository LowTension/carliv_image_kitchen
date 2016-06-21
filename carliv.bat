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
attrib +h "bin" >nul
attrib +h "scripts" >nul
attrib +h "working" >nul
ufind "%~dp0\bin" "%~dp0\scripts" -regex ".*\.\(exe\|bat\)" -exec chmod +x {} ;
if %errorlevel% neq 0 goto error
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main
cls
echo( 
echo ***************************************************
echo *                                                 *
cecho *      {0B}Carliv Image Kitchen for Android{#} v1.2      *{\n}
cecho *     boot+recovery images (c)2016 {0B}carliv@xda{#}     *{\n}
cecho * including support for {0E}MTK powered {#}phones images *{\n}
cecho *               {0A}WINDOWS x86 {#}version               *{\n}
echo *                                                 *
echo ***************************************************
echo(
echo Choose what kind of image you need to work on.
echo(
echo ][**********************][
cecho ][ {0B}B.  BOOT {#}            ][{\n}
echo ][**********************][
cecho ][ {0E}R.  RECOVERY {#}        ][{\n}
echo ][**********************][
cecho ][ {0A}C.  CLEAR FOLDER {#}    ][{\n}
echo ][**********************][
cecho ][ {0D}O.  CLEAR OUTPUT {#}    ][{\n}
echo ][**********************][
echo ][ P.  SEE INSTRUCTIONS ][
echo ][**********************][
cecho ][ {0C}E.  EXIT {#}            ][{\n}
echo ][**********************][
echo(
set /p env=Type your option [B,R,C,O,P,E] then press ENTER: || set env="0"
if /I %env%==B goto boot
if /I %env%==R goto recovery
if /I %env%==C goto delete_all
if /I %env%==O goto delete_output
if /I %env%==P goto instructions
if /I %env%==E goto end
echo(
cecho {0C}%env% is not a valid option. Please try again! {#}{\n}
PING -n 3 127.0.0.1>nul
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:imgmenu
cls
echo ***************************************************
echo *                                                 *
cecho *      {0B}Carliv Image Kitchen for Android{#} v1.2      *{\n}
cecho *     boot+recovery images (c)2016 {0B}carliv@xda{#}     *{\n}
cecho * including support for {0E}MTK powered {#}phones images *{\n}
cecho *               {0A}WINDOWS x86 {#}version               *{\n}
echo *                                                 *
echo ***************************************************
cecho *               {0B}IMG scripts{#} section               *{\n}
echo ***************************************************
echo(
cecho Your selected image is {0A}%workfile%{#}.{\n}
for %%i in ("%workfile%") do set "workfolder=%%~ni"
if %filetype%==bootimage goto setbootfolder
if %filetype%==recoveryimage goto setrecfolder
:setbootfolder
if "%workfolder%"=="%workfolder:boot=%" set "workfolder=boot-%workfolder%"
goto cleanfoldername
:setrecfolder
if "%workfolder%"=="%workfolder:recovery=%" set "workfolder=recovery-%workfolder%"
:cleanfoldername
set workfolder=%workfolder: =_%
if not exist "%workfolder%" goto imgmenulist
cecho The folder for repack will be {0A}%workfolder%{#}.{\n}
echo Make sure that folder exists and you didn't delete it, because if you did, it will give you an error.
:imgmenulist
for /f %%k in ('"set LANG=C && grep -obUaPc "\x88\x16\x88\x58" "working\%workfile%""') do set mtk=%%k
echo(
echo ][*************************][*************************][
cecho ][  {0B}1. Unpack image{#}        ][  {0E}B. Other boot image{#}    ][{\n}
echo ][*************************][*************************][
cecho ][  {0B}2. Repack image{#}        ][  {0E}R. Other recovery image{#}][{\n}
echo ][*************************][*************************][
cecho ][             {0D}I. Display image info{#}                  ][{\n}
echo ][*************************][*************************][
echo ][                 Q. Go to main menu                 ][
echo ][*************************][*************************][
echo(
set /p imgenv=Type your option [1,2,B,R,I,Q] then press ENTER: || set imgenv="0"
if /I %imgenv%==1 goto img_unpack
if /I %imgenv%==2 goto img_repack
if /I %imgenv%==B goto boot
if /I %imgenv%==R goto recovery
if /I %imgenv%==I goto img_info
if /I %imgenv%==Q goto main
echo(
cecho {0C}%imgenv% is not a valid option. Please try again! {#}{\n}
PING -n 3 127.0.0.1>nul
goto imgmenu
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:boot
set workfile=
set filetype=
set workfolder=
set mtk=
cls
echo ***************************************************
echo *                                                 *
cecho *      {0B}Carliv Image Kitchen for Android{#} v1.2      *{\n}
cecho *     boot+recovery images (c)2016 {0B}carliv@xda{#}     *{\n}
cecho * including support for {0E}MTK powered {#}phones images *{\n}
cecho *               {0A}WINDOWS x86 {#}version               *{\n}
echo *                                                 *
echo ***************************************************
cecho *                {0B}BOOT images{#} section              *{\n}
echo ***************************************************
echo(
for /f %%g in ('dir /b "boot-resources\*.img"') do (
   goto loadboots
)
set /p noboot=There is no image in your [boot-resources] folder. Place some in there and then press [B] to start again or [Q] to go to main menu, then press ENTER: || set noboot="0"
if %noboot%=="0" goto booterror
if /I %noboot%==B goto boot
if /I %noboot%==Q goto main
:loadboots
echo(
set j=0
set maxb=0
echo ---------------------------------------------------
echo -  R. - Refresh.
echo ---------------------------------------------------
echo -  E. - Go to Main menu.
for /r %%h in ("boot-resources\*.img") do (
	set /a j+=1
	echo ---------------------------------------------------
	echo -  !j!. - %%~nxh
	set bootlist!j!=%%~nxh
	if !j! gtr !maxb! set maxb=!j!
)
echo ---------------------------------------------------
echo(
set /p bootopt=Type an image number then press ENTER: || set bootopt="0"
if %bootopt%=="0" goto booterror
if /I %bootopt%==R goto boot
if /I %bootopt%==E goto main
if %bootopt% gtr %maxb% goto booterror
set bootlist=!bootlist%bootopt%!
set workfile=%bootlist%
set filetype=bootimage
copy "boot-resources\%bootlist%" "working\%workfile%" >nul
goto imgmenu
:booterror
echo(
cecho {0C}That is not a valid option. Please try again! {#}{\n}
PING -n 3 127.0.0.1>nul
goto boot
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:recovery
set workfile=
set filetype=
set workfolder=
set mtk=
cls
echo ***************************************************
echo *                                                 *
cecho *      {0B}Carliv Image Kitchen for Android{#} v1.2      *{\n}
cecho *     boot+recovery images (c)2016 {0B}carliv@xda{#}     *{\n}
cecho * including support for {0E}MTK powered {#}phones images *{\n}
cecho *               {0A}WINDOWS x86 {#}version               *{\n}
echo *                                                 *
echo ***************************************************
cecho *             {0E}RECOVERY images{#} section             *{\n}
echo ***************************************************
echo(
for /f %%a in ('dir /b "recovery-resources\*.img"') do (
   goto loadrec
)
set /p norec=There is no image in your [recovery-resources] folder. Place some in there and then press [R] to start again or [Q] to go to main menu, then press ENTER: || set norec="0"
if %norec%=="0" goto recerror
if /I %norec%==R goto recovery
if /I %norec%==Q goto main
:loadrec
set i=0
set maxa=0
echo ---------------------------------------------------
echo -  R. - Refresh.
echo ---------------------------------------------------
echo -  E. - Go to Main menu.
for /r %%b in ("recovery-resources\*.img") do (
	set /a i+=1
	echo ---------------------------------------------------
	echo -  !i!. - %%~nxb
	set reclist!i!=%%~nxb
	if !i! gtr !maxa! set maxa=!i!
)
echo ---------------------------------------------------
echo(
set /p recopt=Type an image number then press ENTER: || set recopt="0"
if %recopt%=="0" goto recerror
if /I %recopt%==R goto recovery
if /I %recopt%==E goto main
if %recopt% gtr %maxa% goto recerror
set reclist=!reclist%recopt%!
set workfile=%reclist%
set filetype=recoveryimage
copy "recovery-resources\%reclist%" "working\%workfile%" >nul
goto imgmenu
:recerror
echo(
cecho {0C}That is not a valid option. Please try again! {#}{\n}
PING -n 3 127.0.0.1>nul
goto recovery
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:img_unpack
cls
copy "scripts\unpack_img.bat" "unpack_img.bat" >nul
if %filetype%==bootimage goto unpackboot
if %filetype%==recoveryimage goto unpackrecovery
:unpackboot
copy "working\%workfile%" boot.img >nul
if %mtk%==0 goto unpackbootreg
call unpack_img.bat boot.img %workfolder% %mtk%
goto endunpack
:unpackbootreg
call unpack_img.bat boot.img %workfolder%
goto endunpack
:unpackrecovery
copy "working\%workfile%" recovery.img >nul
if %mtk%==0 goto unpackrecreg
call unpack_img.bat recovery.img %workfolder% %mtk%
goto endunpack
:unpackrecreg
call unpack_img.bat recovery.img %workfolder%
:endunpack
if exist boot.img del boot.img >nul
if exist recovery.img del recovery.img >nul
if exist unpack_img.bat del unpack_img.bat >nul
pause
goto imgmenu
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:img_repack
cls
copy "scripts\repack_img.bat" "repack_img.bat" >nul
call repack_img.bat "%workfolder%"
echo(
cecho You can find it in {0E}[output]{#} folder.{\n}
if exist repack_img.bat del repack_img.bat >nul
pause
goto imgmenu
:img_info
cls
copy "scripts\image_info.bat" "image_info.bat" >nul
copy "working\%workfile%" "%workfile%" >nul
call image_info.bat "%workfile%"
if exist "%workfile%" del "%workfile%" >nul
if exist image_info.bat del image_info.bat >nul
pause
goto imgmenu
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:instructions
cls
type "scripts\Instructions.txt"
pause
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:delete_all
cls
copy "scripts\clean_all.bat" "clean_all.bat" >nul
call clean_all.bat
if exist clean_all.bat del clean_all.bat >nul
PING -n 3 127.0.0.1>nul
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:delete_output
cls
copy "scripts\clean_output.bat" "clean_output.bat" >nul
call clean_output.bat
if exist clean_output.bat del clean_output.bat >nul
PING -n 3 127.0.0.1>nul
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
cecho {0C}The scripts and executables can't get execution permission! The kitchen won't run this way. {#}{\n}
PING -n 3 127.0.0.1>nul
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
echo(
for /f %%a in ("%~dp0\working\*") do del /q "%%a" >nul
PING -n 1 127.0.0.1>nul
