@echo off
setlocal EnableDelayedExpansion

for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESCchar=%%E"
set "yellow=%ESCchar%[93m"
set "white=%ESCchar%[97m"
set "red=%ESCchar%[31m"
set "blue=%ESCchar%[36m"
set "magenta=%ESCchar%[35m"
set "green=%ESCchar%[32m"
set "black=%ESCchar%[90m"

for %%f in (%1*.in) do (
  if [%2] == [-s] (
    echo %black%Input: %white%%%f
    echo.
    type %%f
  )
  if exist %%~nf.out (
    call CMDTimer "%1 < %%f > temp.out" ExecTime
    fc /a /n /w %%~nf.out temp.out > fctemp && (
      echo %green%
      if [%2] == [-s] (
        type %%~nf.out
        echo.
      )	
      echo Accepted^^! 
    ) || (
     echo.
     type fctemp
     echo %red%Wrong Answer^^!^^!^^!
    )
    echo.
    echo %black%Execution time : %white%!ExecTime!
    echo %red%================================%white%
  ) else ( 
    echo %green%
    call CMDTimer "%1 < %%f" ExecTime
    echo.
    echo %black%Execution time : %white%!ExecTime!
    echo %red%================================%white%
  )
  echo off
)

