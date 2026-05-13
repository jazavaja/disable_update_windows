@echo off
:: ================================================
:: Disable Windows background bandwidth-consuming services
:: Must be run as Administrator
:: ================================================

echo Disabling services...
echo.

:: --- Windows Update ---
sc.exe stop wuauserv >nul 2>&1
sc.exe config wuauserv start= disabled
sc.exe stop bits >nul 2>&1
sc.exe config bits start= disabled
sc.exe stop UsoSvc >nul 2>&1
sc.exe config UsoSvc start= disabled
echo [OK] Windows Update disabled

:: --- Delivery Optimization ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul
echo [OK] Delivery Optimization disabled

:: --- Telemetry and Diagnostics ---
sc.exe stop DiagTrack >nul 2>&1
sc.exe config DiagTrack start= disabled
sc.exe stop dmwappushservice >nul 2>&1
sc.exe config dmwappushservice start= disabled
echo [OK] Telemetry disabled

:: --- Defender automatic updates ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ForceUpdateFromMU" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ScheduleDay" /t REG_DWORD /d 8 /f >nul
echo [OK] Defender automatic updates disabled

:: --- Microsoft Store automatic updates ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [OK] Microsoft Store automatic updates disabled

:: --- Kill running background apps ---
taskkill /f /im ms-teams.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1
echo [OK] Background apps closed

echo.
echo ================================================
echo Done. Please restart your system.
echo ================================================
pause