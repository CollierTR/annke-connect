:: TODO: 1. find the Mac address. -  2. test the script.

@echo off
setlocal enabledelayedexpansion

set TARGET_MAC=c0-33-5e-ef-31-0b
set FOUND_IP=

echo Scanning ARP table for MAC: %TARGET_MAC%

for /f "tokens=1,2 delims= " %%a in ('arp -a') do (
    set ip=%%a
    set mac=%%b

    rem Normalize MAC case
    set mac=!mac:~0,17!
    set mac=!mac:.=!
    set mac=!mac:,=!
    set mac=!mac:"=!
    set mac=!mac: =!

    if /i "!mac!"=="%TARGET_MAC%" (
        set FOUND_IP=%%a
        goto :found
    )
)

echo MAC address not found in ARP table.
goto :end

:found
echo Found device at IP: %FOUND_IP%
start chrome http://%FOUND_IP%

:end
pause

