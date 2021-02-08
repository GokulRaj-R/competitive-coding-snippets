@echo off
setlocal EnableDelayedExpansion

for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESCchar=%%E"
set "yellow=%ESCchar%[93m"
set "white=%ESCchar%[97m"
set "black=%ESCchar%[90m"
set "blue=%ESCchar%[36m"
set "magenta=%ESCchar%[35m"
set "green=%ESCchar%[32m"
set start=%time%

:: Runs your command
cmd /c %~1

set end=%time%
set options="tokens=1-4 delims=:.,"
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

:: Mission accomplished
set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
:: echo.
:: echo %cream%Execution time : %white%%totalsecs%.%ms%s
if [%~2] == [] (
  echo %black%Execution time : %white%%totalsecs%.%ms%s
) else (
  endlocal 
  set %~2=%totalsecs%.%ms%s
)