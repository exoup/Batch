@ECHO OFF
setlocal EnableDelayedExpansion
set attachment=ATTACHMENT PATH HERE
set subject=SUBJECT LINE HERE

:start
set /p name=Input your name: 
set /p email=Input your email address: 
cls

ECHO Name: %name%
ECHO Email Address: %email%
choice /c yn /m "Is this correct?"
if !ERRORLEVEL! EQU 1 (
set body=Dear %name%, REST OF TEXT HERE
ECHO Opening Outlook.
) ELSE (
if !ERRORLEVEL! EQU 2 (
cls
goto :start
)
)

"C:\Program Files\Microsoft Office\root\Office16\Outlook.exe" /a "%attachment%" /c ipm.note /m "%email%?subject=%subject%&body=%body%"

ECHO Please check Outlook. && pause > NUL
exit /b