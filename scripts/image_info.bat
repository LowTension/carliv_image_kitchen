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
echo(    
ecco {1B}
echo ***************************************************
echo *                                                 *
echo *      Carliv Image Kitchen for Android v2.3      *
echo *    boot ^& recovery images (c)2021 carliv.eu     *
echo * including support for MTK powered phones images *
echo *               WINDOWS x64 version               *
echo *                                                 *
ecco ***************************************************{0F}{\n}
echo *          The informations image script          *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~1" == "" goto noinput
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "file=%~nx1"
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ecco Display the informations for{0E} %file%{#}.{\n}
echo(
if exist "file_info.txt" (
	type "file_info.txt"
)
if not exist "file_info.txt" ( 
	imageinfo -i %file%
	imageinfo -i %file% > %file%.txt
)
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
echo(
ecco {0C}No image file selected. Exit script.{#}{\n}
echo(
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
