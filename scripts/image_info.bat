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
echo(    
echo ***************************************************
echo *                                                 *
ctext "*      {0B}Carliv Image Kitchen for Android{07} v1.0      *{\n}"
ctext "*     boot+recovery images (c)2015 {0B}carliv@xda{07}     *{\n}"
ctext "* {07}including support for {0E}MTK powered {07}phones images *{\n}"
ctext "*                 {0A}WINDOWS {07}version                 *{\n}"
echo ***************************************************
echo *          Printing the image info script         *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~1" == "" goto noinput
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "file=%~nx1"
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ctext "Display the informations for{0E} %file%{07}.{\n}"
echo(
imageinfo %file%
echo(
echo(
ctext "Done. All informations are saved in{0E} %~n1.img-infos.txt{07}.{\n}"
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
echo(
ctext "{0C}No image file selected. Exit script.{07}{\n}"
echo(
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
