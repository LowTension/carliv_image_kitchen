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
echo(    
echo ***************************************************
echo *                                                 *
cecho *      {0B}Carliv Image Kitchen for Android{#} v1.3      *{\n}
cecho *     boot+recovery images (c)2016 {0B}carliv@xda{#}     *{\n}
cecho * including support for {0E}MTK powered {#}phones images *{\n}
cecho *               {0A}WINDOWS x86 {#}version               *{\n}
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
cecho Display the informations for{0E} %file%{#}.{\n}
echo(
imageinfo %file%
echo(
echo(
cecho Done. All informations are saved in{0E} %~n1.img-infos.txt{#}.{\n}
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
echo(
cecho {0C}No image file selected. Exit script.{#}{\n}
echo(
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
