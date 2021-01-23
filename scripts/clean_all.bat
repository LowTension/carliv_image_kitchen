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
echo(    
ecco {1B}
echo ***************************************************
echo *                                                 *
echo *      Carliv Image Kitchen for Android v2.1      *
echo *    boot ^& recovery images (c)2020 carliv.eu     *
echo * including support for MTK powered phones images *
echo *               WINDOWS x86 version               *
echo *                                                 *
ecco ***************************************************{0F}{\n}
echo *           Cleaning the kitchen folder           *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
attrib +h "bin" >nul 2>&1
attrib +h "input" >nul 2>&1
attrib +h "output" >nul 2>&1
attrib +h "scripts" >nul 2>&1
attrib +h "working" >nul 2>&1
attrib +h "*.bat" >nul 2>&1
attrib +h "*.img" >nul 2>&1
for /d %%d in ("%~dp0\*") do rd /s /q "%%d" >nul 2>&1
for /f %%a in ("%~dp0\*") do del /q "%%a" >nul 2>&1
attrib -h "input" >nul 2>&1
attrib -h "output" >nul 2>&1
attrib -h "*.bat" >nul 2>&1
attrib -h "*.img" >nul 2>&1 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
ecco {0E}The kitchen folder is clean now!{#}{\n}
goto end
echo(
:end
