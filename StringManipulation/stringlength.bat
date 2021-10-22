@ECHO OFF

set /p input=Enter some text: 
set string=%input%#
call :lengloop string strlen
ECHO %strlen%
EXIT /b

:lengloop
setlocal EnableDelayedExpansion
:loop
if NOT "!%1:~%len%!"=="#" set /a len+=1 & goto :loop
endlocal & set %2=%len%
EXIT /b