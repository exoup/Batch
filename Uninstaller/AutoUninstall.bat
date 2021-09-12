@ECHO off
SETLOCAL EnableDelayedExpansion

set regpath=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall
set SoftName=
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
                if /i "!Uninstall:~0,3!" EQU "Msi" (
						set Uninstall=!Uninstall:/I=/X!
                        ECHO Uninstallation command found: !Uninstall!
                        ECHO Trying silent MSI uninstallation.
                        !Uninstall!
                        ECHO Uninstall complete.
                            ) ELSE (
                        ECHO Uninstallation command found: !Uninstall!
                        ECHO Trying silent .exe uninstallation
						REM Just throwing parameters at a wall, but it probably works for my need.
                        !Uninstall! /s /q /silent /quiet
                        ECHO Uninstall complete.
                    )
            )
            ) ELSE (
            set str=%%a
            if "!str:~0,4!"=="HKEY" set key=%%a
        )
    )
) ELSE (
ECHO %SoftName% installation not found!
GOTO:eof
)