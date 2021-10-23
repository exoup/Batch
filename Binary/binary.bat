@ECHO OFF
SETLOCAL EnableDelayedExpansion
set count=1

for %%P in (%*) do (
set param=%%P
if /I !param!==/d (set debug=%%P)
if /I "!param:~0,2!"=="/h" (call :help & EXIT /b)
if NOT !param!==/d (if NOT %%P==/h set num=%%P)
)
if NOT DEFINED num set /p num=Input decimal number: 

cls
set decnum=!num!

:mathloop
if !count! GTR 1 set num=!div!
set /a div=num/2
set /a mod=num%%2
set /a c[!count!]=%mod%
if !debug!==/d ECHO Remainder: !c[%count%]!, Div: !div!, Count: !count!
if !div! GEQ 1 (
set /a count=count+=1
goto :mathloop
)
for /L %%C in (1,1,!count!) do set "binnum=!c[%%C]!!binnum!"
ECHO ###############
ECHO !decnum! =
ECHO 0b!binnum!
ECHO ###############
pause > NUL && EXIT /b

:help
ECHO Binary.bat [%%number%%] [/d] [/h(elp)]
ECHO.
ECHO %%number%%       Passes number through program and uses that as input.
ECHO /d             Enables "debug" mode. Shows each step of the math.
ECHO /h(elp)        Shows this text!
EXIT /b