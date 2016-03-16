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
:main
cls
echo( 
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
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
if /I %env%==E goto eof
echo(
ctext "{0C}%env% is not a valid option. Please try again! {07}{\n}"
pause
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:boot
cls
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
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
set bootfile=%bootlist%
goto bootmenu
:booterror
echo(
ctext "{0C}That is not a valid option. Please try again! {07}{\n}"
pause
goto boot
:bootmenu
cls
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo *                                                 *
echo ***************************************************
ctext "*               {0B}BOOT scripts{07} section              *{\n}"
echo ***************************************************
echo(
echo If your image is for a phone powered by Mediatek, choose an option from right side, else choose from left. The Info menu is same for both.
echo(
ctext "Your selected image is {0A}%bootfile%{07}.{\n}"
for %%i in ("%bootfile%") do set "bfolder=%%~ni"
if "%bfolder%"=="%bfolder:boot=%" set "bfolder=boot-%bfolder%"
set bfolder=%bfolder: =_%
if not exist "%bfolder%" goto bmenulist
ctext "The folder for repack will be {0A}%bfolder%{07}.{\n}"
echo Make sure that the folder exists and you didn't delete it, because if you did, it will display an error message.
:bmenulist
echo(
echo ][*************************][*************************][
ctext "][    {0B}ANDROID REGULAR{07}      ][         {0E}MEDIATEK{07}        ][{\n}"
echo ][*************************][*************************][
ctext "][  {0B}1. Unpack boot{07}         ][  {0E}3. Unpack MTK boot{07}     ][{\n}"
echo ][*************************][*************************][
ctext "][  {0B}2. Repack boot{07}         ][  {0E}4. Repack MTK boot{07}     ][{\n}"
echo ][*************************][*************************][
echo ][*************************][*************************][
ctext "][  {0D}I. Display image info{07}  ][  {0C}E. Go Back{07}             ][{\n}"
echo ][*************************][*************************][
echo ][                 Q. Go to main menu                 ][
echo ][*************************][*************************][
echo(
set /p benv=Type your option [1,2,3,4,I,E,Q] then press ENTER: || set benv="0"
if /I %benv%==1 goto boot_unpack
if /I %benv%==2 goto boot_repack
if /I %benv%==3 goto boot_mtk_unpack
if /I %benv%==4 goto boot_mtk_repack
if /I %benv%==I goto boot_info
if /I %benv%==E goto boot
if /I %benv%==Q goto main
echo(
ctext "{0C}%benv% is not a valid option. Please try again! {07}{\n}"
pause
goto bootmenu
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:recovery
cls
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
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
set recfile=%reclist%
goto recmenu
:recerror
echo(
ctext "{0C}That is not a valid option. Please try again! {07}{\n}"
pause
goto recovery
:recmenu
cls
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo *                                                 *
echo ***************************************************
ctext "*            {0E}RECOVERY scripts{07} section             *{\n}"
echo ***************************************************
echo(
echo If your image is for a phone powered by Mediatek, choose an option from right side, else choose from left. The Info menu is same for both.
echo(
ctext "Your selected image is {0A}%recfile%{07}.{\n}"
for %%d in ("%recfile%") do set "rfolder=%%~nd"
if "%rfolder%"=="%rfolder:recovery=%" set "rfolder=recovery-%rfolder%"
set rfolder=%rfolder: =_%
if not exist "%rfolder%" goto rmenulist
ctext "The folder for repack will be {0A}%rfolder%{07}.{\n}"
echo Make sure that the folder exists and you didn't delete it, because if you did, it will display an error message.
:rmenulist
echo(
echo ][*************************][*************************][
ctext "][    {0B}ANDROID REGULAR{07}      ][         {0E}MEDIATEK{07}        ][{\n}"
echo ][*************************][*************************][
ctext "][  {0B}1. Unpack recovery{07}     ][  {0E}3. Unpack MTK recovery{07} ][{\n}"
echo ][*************************][*************************][
ctext "][  {0B}2. Repack recovery{07}     ][  {0E}4. Repack MTK recovery{07} ][{\n}"
echo ][*************************][*************************][
echo ][*************************][*************************][
ctext "][  {0D}I. Display image info{07}  ][  {0C}E. Go Back to select{07}   ][{\n}"
echo ][*************************][*************************][
echo ][                 Q. Go to main menu                 ][
echo ][*************************][*************************][
echo(
set /p renv=Type your option [1,2,3,4,I,E,Q] then press ENTER: || set renv="0"
if /I %renv%==1 goto rec_unpack
if /I %renv%==2 goto rec_repack
if /I %renv%==3 goto rec_mtk_unpack
if /I %renv%==4 goto rec_mtk_repack
if /I %renv%==I goto rec_info
if /I %renv%==E goto recovery
if /I %renv%==Q goto main
echo(
ctext "{0C}%renv% is not a valid option. Please try again! {07}{\n}"
pause
goto recmenu
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:boot_unpack
cls
copy "scripts\unpack_img.bat" "unpack_img.bat" >nul
copy "boot-resources\%bootlist%" boot.img >nul
call unpack_img.bat boot.img %bfolder%
if exist boot.img del boot.img >nul
if exist "unpack_img.bat" del "unpack_img.bat" >nul
pause
goto bootmenu
:boot_repack
cls
copy "scripts\repack_img.bat" "repack_img.bat" >nul
call repack_img.bat "%bfolder%"
ctext "You can find it in {0E}[output]{07} folder.{\n}"
if exist "repack_img.bat" del "repack_img.bat" >nul
pause
goto bootmenu
:boot_mtk_unpack
cls
copy "scripts\unpack_MTK_img.bat" "unpack_MTK_img.bat" >nul
copy "boot-resources\%bootlist%" boot.img >nul
call unpack_MTK_img.bat boot.img %bfolder%
if exist boot.img del boot.img >nul
if exist "unpack_MTK_img.bat" del "unpack_MTK_img.bat" >nul
pause
goto bootmenu
:boot_mtk_repack
cls
copy "scripts\repack_MTK_img.bat" "repack_MTK_img.bat" >nul
call repack_MTK_img.bat "%bfolder%"
ctext "You can find it in{0E}[output]{07} folder.{\n}"
if exist "repack_MTK_img.bat" del "repack_MTK_img.bat" >nul
pause
goto bootmenu
:boot_info
cls
copy "scripts\image_info.bat" "image_info.bat" >nul
copy "boot-resources\%bootlist%" "%bootfile%" >nul
call image_info.bat "%bootfile%"
if exist "%bootfile%" del "%bootfile%" >nul
if exist "image_info.bat" del "image_info.bat" >nul
pause
goto bootmenu
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:rec_unpack
cls
copy "scripts\unpack_img.bat" "unpack_img.bat" >nul
copy "recovery-resources\%reclist%" recovery.img >nul
call unpack_img.bat recovery.img "%rfolder%"
if exist recovery.img del recovery.img >nul
if exist "unpack_img.bat" del "unpack_img.bat" >nul
pause
goto recmenu
:rec_repack
cls
copy "scripts\repack_img.bat" "repack_img.bat" >nul
call repack_img.bat "%rfolder%"
ctext "You can find it in{0E}[output]{07} folder.{\n}"
if exist "repack_img.bat" del "repack_img.bat" >nul
pause
goto recmenu
:rec_mtk_unpack
cls
copy "scripts\unpack_MTK_img.bat" "unpack_MTK_img.bat" >nul
copy "recovery-resources\%reclist%" recovery.img >nul
call unpack_MTK_img.bat recovery.img "%rfolder%"
if exist recovery.img del recovery.img >nul
if exist "unpack_MTK_img.bat" del "unpack_MTK_img.bat" >nul
pause
goto recmenu
:rec_mtk_repack
cls
copy "scripts\repack_MTK_img.bat" "repack_MTK_img.bat" >nul
call repack_MTK_img.bat "%rfolder%"
ctext "You can find it in{0E}[output]{07} folder.{\n}"
if exist "repack_MTK_img.bat" del "repack_MTK_img.bat" >nul
pause
goto recmenu
:rec_info
cls
copy "scripts\image_info.bat" "image_info.bat" >nul
copy "recovery-resources\%reclist%" "%recfile%" >nul
call image_info.bat "%recfile%"
if exist "%recfile%" del "%recfile%" >nul
if exist "image_info.bat" del "image_info.bat" >nul
pause
goto recmenu
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
if exist "clean_all.bat" del "clean_all.bat" >nul
pause
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
echo(
pause
