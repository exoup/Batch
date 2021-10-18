@ECHO OFF
SETLOCAL EnableDelayedExpansion
cls
set /p compname=Input computer name: 
set /p pinglength=Input ping length(Default: 100): 
IF NOT DEFINED pinglength SET "pinglength=100"
set pinginterval=1
title Computer Name: %compname% Start Time: %time%
:startping
ping -n 1 %compname% | find "Request timed out." > NUL
if %ERRORLEVEL% EQU 1 (
set pinginterval=4
) ELSE (
set pinginterval=1
)
for /L %%P in (1,1,!pinglength!) do (
ECHO Pinging...
ping -n !pinginterval! %compname% > NUL
set /a count+=1
)
if !count! GEQ !pinglength! (
ping -n 1 %compname% | find "Request timed out." > NUL
if %ERRORLEVEL% EQU 1 (
set status=offline
) ELSE (
set status=online
)
cls
msg %USERNAME% "%compname% is !status!^!"
choice /c cq /n /m "%compname% is !status!. Would you like to [C]ontinue monitoring or [Q]uit?"
if !ERRORLEVEL! EQU 1 (
goto :startping
) ELSE (
if !ERRORLEVEL! EQU 2 (
ECHO Computer: %compname%
ECHO Quit: !time!
EXIT /B
)
)
)