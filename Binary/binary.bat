@ECHO OFF
SETLOCAL EnableDelayedExpansion
REM SETLOCAL ENABLEEXTENSIONS
set count=1
set num=empty

for %%P in (%*) do (
if /I %%P==/d (set debug=%%P)
if /I %%P==/h (call :help && EXIT /b)
if NOT %%P==/d (if NOT %%P==/h set num=%%P)
)
if "!num!"=="empty" set /p num=Input decimal number: 

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
ECHO Binary.bat [%%number%%] [/d] [/h]
ECHO.
ECHO %%number%%
ECHO    Passes number through program and uses that as input.
ECHO.
ECHO /d
ECHO    Enables "debug" mode. Shows each step of the math.
ECHO.
ECHO /h
ECHO    Shows this text!
EXIT /b