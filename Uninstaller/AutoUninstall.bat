@ECHO off
SETLOCAL EnableDelayedExpansion

set regpath64=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
set regpath32=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall
set regpath=%regpath64%
set regcheck=0
set SoftName=C++

:BEGIN
reg query "%regpath%" /f "%SoftName%" /s /d |findstr "DisplayName" 2>&1>nul
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=1,2*" %%a in ('reg query "%regpath%" /s /d /f "%SoftName%"') do (
        if "%%a"=="DisplayName" (
            ECHO Found: %%c
            set Uninstall=!key!
            ECHO Registry Key: !key!
            for /f "tokens=2*" %%d in ('reg query "!key!" /v "UninstallString"') do (
                set Uninstall=%%e
                REM Checking uninstall type
                if /i "!Uninstall:~0,3!"=="Msi" (
                        REM Catch-all replacement for when uninstall string is /I or /X
                        set Uninstall=!Uninstall:*{=MsiExec.exe /qn /norestart /X{!
                        ECHO Uninstallation command found: "!Uninstall!"
                        ECHO Trying silent MSI uninstallation.
                        REM !Uninstall!
                        ECHO Uninstall complete.
                            ) ELSE (
                        ECHO Uninstallation command found: !Uninstall!
                        ECHO Trying silent .exe uninstallation
                        REM Just throwing parameters at a wall, but it probably works for my need.
                        REM !Uninstall! /s /q /silent /quiet
                        ECHO Uninstall complete.
                    )
            )
            ) ELSE (
            set str=%%a
            if "!str:~0,4!"=="HKEY" set key=%%a
        )
    )
) ELSE (
if %regcheck% EQU 0 (
ECHO %SoftName% not found in %regpath%.
ECHO Changing paths
set regcheck=1
set regpath=%regpath32%
GOTO BEGIN
)
if %regcheck% EQU 1 (
ECHO %SoftName% not found in %regpath%.
ECHO %SoftName% not installed at this location.
GOTO:eof
)
)