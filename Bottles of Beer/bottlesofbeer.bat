@ECHO OFF
SETLOCAL EnableDelayedExpansion
set beernum=99

Title 99 Bottles of Beer
:loop
for /f %%G in ("%beernum%") do (
ECHO ###################################################
ECHO !beernum! bottles of beer on the wall. !beernum! bottles of beer.
SET /a beernum=beernum-1
ECHO Take one down, pass it around.
ECHO !beernum! bottles of beer on the wall.
)
if %beernum% GEQ 2 (
GOTO loop
) ELSE (
if %beernum% EQU 1 (
ECHO ####################################################
ECHO !beernum! bottle of beer on the wall. !beernum! bottle of beer.
set /a beernum=beernum-0
ECHO Take one down, pass it around.
ECHO No more bottles of beer on the wall.
)
)