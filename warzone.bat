:: Simple script to rename the file ModernWarfare.exe to ModernWarfare1.exe to prevent chrashes
@ECHO off
:: Change your install path here
set place=C:\Program Files (x86)\Call of Duty Modern Warfare
set PROCNAME="ModernWarfare.exe"

	:initialbattlenet
CHOICE /M "Start Battle.Net Client?"
if "%ERRORLEVEL%" == "1" GOTO startbattlenet
if "%ERRORLEVEL%" == "2" echo Then why are you clicking me? 
goto exitscript

	:startbattlenet
Echo Start Battle.net...
"%place%\Modern Warfare Launcher.exe"
@ping -n 5 localhost> nul
cls
:checkstart
TaskList|Find "Blizzard Battle.net App" >NUL || If Errorlevel 1 Goto startgame
Goto checkstart


	:startgame
echo checking game status...
tasklist /FI "IMAGENAME eq %PROCNAME%*" 2>NUL | find /I /N %PROCNAME%>NUL
if "%ERRORLEVEL%"=="0" (
    Goto gameruns
)
cls
Goto startgame


	:exitgame
CHOICE /M "Did you quit playing?"
if "%ERRORLEVEL%" == "1" GOTO gamequits
if "%ERRORLEVEL%" == "2" GOTO exitgame
@PAUSE

	:gameruns
@ping -n 5 localhost> nul
ren "%place%\ModernWarfare.exe" ModernWarfare1.exe >nul
if exist "%place%\ModernWarfare1.exe" goto startrenameok
echo Oops, something went wrong. Let's try it again
@pause
goto startgame

	:startrenameok
cls
ECHO File renamed successfully!
ECHO Have fun playing
@ping -n 5 localhost> nul
cls
GOTO exitgame

	:gamequits
ren "%place%\ModernWarfare1.exe" ModernWarfare.exe >nul
if exist "%place%\ModernWarfare.exe" goto quitrenameok
echo Oops, something went wrong. Let's try it again
goto startgame

	:quitrenameok
cls
ECHO File renamed successfully!
ECHO I hope it was fun.
GOTO exitscript

	:exitscript
echo.
echo Script will be terminated...
@ping -n 3 localhost> nul
exit