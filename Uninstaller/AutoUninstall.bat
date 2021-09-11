@ECHO off
SETLOCAL EnableDelayedExpansion

set regpath=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall
set SoftName=vc
reg query "%regpath%" /f "%SoftName%" /s 2>&1>nul
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=1,2*" %%a in ('reg query "%regpath%" /s /d /f "%SoftName%"') do (
        if "%%a"=="DisplayName" (
            ECHO Found %%c
            set Uninstall=!key!
            ECHO Registry Key: !key!
            for /f "tokens=2*" %%d in ('reg query "!key!" /v "UninstallString"') do (
                set Uninstall=%%e
                ECHO ####CHECKING UNINSTALL####
                if /i "!Uninstall:~0,3!" EQU "Msi" (
                        ECHO MsiExec uninstallation command found!
                        ECHO Uninstall String: !Uninstall!
                        ECHO Trying silent MSI uninstallation.
                        !uninstall!
                        ECHO Uninstall complete.
                            ) ELSE (
                        ECHO Exe uninstallation command found!
                        ECHO UninstallString: !Uninstall!
                        ECHO Trying silent .exe uninstallation 
                        !uninstall! /s
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