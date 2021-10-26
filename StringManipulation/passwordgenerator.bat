@ECHO OFF
setlocal EnableDelayedExpansion
set "case=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r t u v w x y z 1 2 3 4 5 6 7 8 9 0 ^^^! # $ %% ^& ' ( ) + , - . / : < > @ [ \ ] _ ` { | } ~"
set "canclip=1"
REM Special Characters: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~

for %%P in (%*) do (
set param=%%P
if /I !param!==/d (set debug=%%P)
if /I !param!==/c (set clip=%%P)
if /I "!param:~0,2!"=="/h" (call :help & EXIT /b)
if NOT !param!==/d (if NOT !param!==/c (if NOT !param!==/h set length=%%P))
)
if NOT DEFINED length set /p length=Desired password length: & if NOT DEFINED length set length=16
for %%C in (!case!) do (
set /a count+=1
set "char[!count!]=%%C"
)
for /L %%L in (%length%,-1,1) do (
set /a R=!random! %% !count! + 1
for %%R in (!R!) do (
    if "!char[%%R]!"=="&" (set canclip=0)
    if "!char[%%R]!"=="|" (set canclip=0)
    if "!char[%%R]!"==">" (set canclip=0)
    if "!char[%%R]!"=="<" (set canclip=0)
    set "randstring=!randstring!!char[%%R]!" & if !debug!==/d ECHO Random=!random! R=!R! Count=!count! Char=!char[%%R]! Clip=!canclip!
    )
)
ECHO !randstring!
if !clip!==/c (
    if !canclip! EQU 1 (
        ECHO !randstring! | clip
        ) ELSE (
        ECHO Can not clip due to redirect characters.
        )
    )
endlocal & EXIT /b

:help
ECHO PasswordGenerator.bat [N] [/c] [/d] [/h(elp)]
ECHO.
ECHO  N             Passes number through program and uses that as input.
ECHO /c             Enacles "copy" mode. Automatically copies string to clipboard. Except for ( ^< ^> ^| ^& )
ECHO /d             Enables "debug" mode. Shows steps.
ECHO /h(elp)        Shows this text!
EXIT /b