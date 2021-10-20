@ECHO OFF

set /p input=Enter some text: 
set string=%input%#
call :lengloop string
ECHO %len%
EXIT /b

:lengloop
setlocal EnableDelayedExpansion
:loop
if NOT "!%1:~%len%!"=="#" set /a len+=1 & goto :loop
endlocal & EXIT /b