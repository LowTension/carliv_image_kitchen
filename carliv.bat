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
:main
cls
echo( 
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.1      *{\n}"
ctext "*     boot+recovery images (c)2016 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo *                                                 *
echo ***************************************************
echo(
echo  Choose what kind of image you need to work on.
echo(
echo ][**********************][
ctext "][ {0B}B.  BOOT {07}            ][{\n}"
echo ][**********************][
ctext "][ {0E}R.  RECOVERY {07}        ][{\n}"
echo ][**********************][
ctext "][ {0A}C.  CLEAR FOLDER {07}    ][{\n}"
echo ][**********************][
echo ][ P.  SEE INSTRUCTIONS ][
echo ][**********************][
ctext "][ {0C}E.  EXIT {07}            ][{\n}"
echo ][**********************][
echo(
set /p env=Type your option [B,R,C,P,E] then press ENTER: || set env="0"
if /I %env%==B goto boot
if /I %env%==R goto recovery
if /I %env%==C goto delete_all
if /I %env%==P goto instructions
if /I %env%==E goto end
echo(
ctext "{0C}%env% is not a valid option. Please try again! {07}{\n}"
PING -n 3 127.0.0.1>nul
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:imgmenu
cls
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.1      *{\n}"
ctext "*     boot+recovery images (c)2016 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo *                                                 *
echo ***************************************************
ctext "*               {0B}IMG scripts{07} section               *{\n}"
echo ***************************************************
echo(
ctext "Your selected image is {0A}%workfile%{07}.{\n}"
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
ctext "The folder for repack will be {0A}%workfolder%{07}.{\n}"
echo Make sure that folder exists and you didn't delete it, because if you did, it will give you an error.
:imgmenulist
for /f %%k in ('"set LANG=C && grep -obUaPc "\x88\x16\x88\x58" "working\%workfile%""') do set mtk=%%k
echo(
echo ][*************************][*************************][
ctext "][  {0B}1. Unpack image{07}        ][  {0E}B. Other boot image{07}    ][{\n}"
echo ][*************************][*************************][
ctext "][  {0B}2. Repack image{07}        ][  {0E}R. Other recovery image{07}][{\n}"
echo ][*************************][*************************][
ctext "][             {0D}I. Display image info{07}                  ][{\n}"
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
ctext "{0C}%imgenv% is not a valid option. Please try again! {07}{\n}"
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
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.1      *{\n}"
ctext "*     boot+recovery images (c)2016 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo *                                                 *
echo ***************************************************
ctext "*                {0B}BOOT images{07} section              *{\n}"
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
ctext "{0C}That is not a valid option. Please try again! {07}{\n}"
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
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.1      *{\n}"
ctext "*     boot+recovery images (c)2016 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo *                                                 *
echo ***************************************************
ctext "*             {0E}RECOVERY images{07} section             *{\n}"
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
ctext "{0C}That is not a valid option. Please try again! {07}{\n}"
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
:img_repack
cls
copy "scripts\repack_img.bat" "repack_img.bat" >nul
call repack_img.bat "%workfolder%"
ctext "You can find it in {0E}[output]{07} folder.{\n}"
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
:end
echo(
for /f %%a in ("%~dp0\working\*") do del /q "%%a" >nul
PING -n 1 127.0.0.1>nul
