@ECHO OFF
setlocal EnableDelayedExpansion
set attachment=C:\users\public\desktop\replacementpath.txt
set subject=REPLACEMENT TEXT

:start
set /p name=Input your name: 
set /p email=Input your email address: 
cls

REM For setting new line character in the email.
(set \n=^
%=empty, do not delete this line =%
^
%=empty, do not delete this line =%
)

ECHO Name: %name%
ECHO Email Address: %email%
choice /c yn /m "Is this correct?"
if !ERRORLEVEL! EQU 1 (
set greeting=Dear %name%,
REM Place email text after body below for it to be on a new line from the greeting. Otherwise, all one line.
set body=Replacement text. ^
This will be on the same line as the first part of the message.
ECHO Opening Outlook.
) ELSE (
if !ERRORLEVEL! EQU 2 (
cls
goto :start
)
)
REM Fill in path to your Outlook.exe here between the quotes.
"C:\Program Files\Microsoft Office\root\Office16\Outlook.exe" /a "%attachment%" /c ipm.note /m "%email%?subject=%subject%&body=%greeting%!\n!%body%"

ECHO Please check Outlook. && pause
exit /b