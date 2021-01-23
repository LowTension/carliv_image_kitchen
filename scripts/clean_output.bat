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
echo *           Cleaning the output folder            *
echo ***************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
for /d %%d in ("%~dp0\output\*") do rd /s /q "%%d" >nul 2>&1
for /f %%a in ("%~dp0\output\*") do del /q "%%a" >nul 2>&1 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
ecco {0E}The output folder is clean now!{#}{\n}
goto end
echo(
:end
