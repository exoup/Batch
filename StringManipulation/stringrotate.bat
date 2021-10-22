@ECHO OFF
setlocal EnableDelayedExpansion
set "upper=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
set "lower=a b c d e f g h i j k l m n o p q r s t u v w x y z"
set rotate=%1
if NOT DEFINED rotate (set rotate=13)

set /p input=Enter some text: 
if NOT DEFINED input (set input=DEFault)
cls
REM Useful string replacement: set "var=%var:?=?%" 
set "string=%input%#"
call :loop string strlen
call :letterarray
call :strreplace
ECHO String: !input!
ECHO $ROT%rotate%: !rotstr!
ECHO Length: %strlen%
endlocal & EXIT /b

:loop
if NOT "!%1:~%len%!"=="#" set /a len+=1 & goto :loop
set %2=%len%
EXIT /b

:strreplace
for /L %%S in (0,1,%strlen%) do (
    set math=0
    if NOT "!string:~%%S!"=="#" (
        set strstub.%%S=!string:~%%S,1!
        for /L %%V in (!upcount!,-1,1) do (
            if !strstub.%%S!==!up.%%V! (
                    set /a math=%%V+%rotate%
                    if !math! GTR 26 ( set /a math-=26 )
                    call set "rotstr=!rotstr!%%up.!math!%%"
                )
            )
            if "!strstub.%%S!"==" " set "rotstr=!rotstr! "
        for /L %%M in (!lowcount!,-1,1) do (
            if !strstub.%%S!==!low.%%M! (
                    set /a math=%%M+%rotate%
                    if !math! GTR 26 ( SET /a math-=26 )
                    call set "rotstr=!rotstr!%%low.!math!%%"
                )
            )
        )
    )
EXIT /b

:letterarray
set upcount=0
set lowcount=0
for %%L in (%lower%) do (
set /a lowcount+=1
set "low.!lowcount!=%%L"
)
for %%U in (%upper%) do (
set /a upcount+=1
set "up.!upcount!=%%U"
)
EXIT /b
