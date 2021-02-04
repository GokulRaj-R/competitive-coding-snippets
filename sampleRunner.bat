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
  type %%f
  echo %green%
  CMDTimer %1 < %%f
  echo %red%================================%white%
  echo off
)
