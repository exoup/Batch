@ECHO off
SETLOCAL EnableDelayedExpansion

set regpath64=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
set regpath32=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall
set regpath=%regpath64%
set trycount=1
set maxretry=4
set regcheck=0
set SoftName=!!DONUT LEAVE BLANK!!

GOTO BEGIN

:RETRYLOOP
ping -n 10 localhost 2>&1>nul
if !trycount! GTR !maxretry! (
    ECHO Uninstall failed after !trycount! tries.
    EXIT /B
    )
if !trycount! LEQ !maxretry! (
    reg query "!keycheck!" /f "%SoftName%" 2>&1>nul
    if %ERRORLEVEL% EQU 0 (
        set /a trycount=trycount+1
        ECHO Try number: !trycount!
        !SilentUninstall!
        GOTO RETRYLOOP
        ) ELSE (
        ECHO Uninstall successful after !trycount! tries.
        EXIT /B
)
)

:BEGIN
reg query "%regpath%" /f "%SoftName%" /s /d |findstr "DisplayName" 2>&1>nul
if !ERRORLEVEL! EQU 0 (
    for /f "tokens=1,2*" %%a in ('reg query "%regpath%" /s /d /f "%SoftName%"') do (
        if "%%a"=="DisplayName" (
            ECHO Found: %%c
            set Uninstall=!key!
            set keycheck=!key!
            ECHO Registry Key: !key!
            for /f "tokens=2*" %%d in ('reg query "!key!" /v "UninstallString"') do (
                set Uninstall=%%e
                REM Checking uninstall type
                if /i "!Uninstall:~0,3!"=="Msi" (
                        REM Catch-all replacement for when uninstall string is /I or /X
                        set Uninstall=!Uninstall:*{=MsiExec.exe /qn /norestart /X{!
                        set SilentUninstall=!Uninstall!
                        ECHO Uninstallation command found: "!Uninstall!"
                        ECHO Try Number: !trycount!
                        !SilentUninstall!
                            ) ELSE (
                        ECHO Uninstallation command found: !Uninstall!
                        set SilentUninstall=!Uninstall! /S
                        ECHO Try number: !trycount!
                        !SilentUninstall!
                        )
                ping -n 15 localhost 2>&1>nul
                REM Checking if install still exists.
                reg query "!keycheck!" /f "%SoftName%" 2>&1>nul
                if !ERRORLEVEL! EQU 0 (
                        CALL :RETRYLOOP
                    ) ELSE (
                        ECHO Done!
                        set trycount=1
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
    ECHO %SoftName% not installed.
    GOTO:eof
)
)