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
echo *           Cleaning the working folder           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
attrib +h "bin" >nul
attrib +h "boot-resources" >nul
attrib +h "recovery-resources" >nul
attrib +h "output" >nul
attrib +h "scripts" >nul
attrib +h "*.bat" >nul
attrib +h "*.img" >nul
for /d %%d in ("%~dp0\*") do rd /s /q "%%d" >nul
for /f %%a in ("%~dp0\*") do del /q "%%a" >nul
attrib -h "boot-resources" >nul
attrib -h "recovery-resources" >nul
attrib -h "output" >nul
attrib -h "scripts" >nul
attrib -h "*.bat" >nul
attrib -h "*.img" >nul 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
ctext "{0E}The working folder is clean now!{07}{\n}"
goto end
echo(
:end
