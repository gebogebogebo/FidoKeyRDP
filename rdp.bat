echo off
set rpid=
set pin=
set /P rpid="rpid: "
set /P pin="pin: "
powershell -NoProfile -ExecutionPolicy Unrestricted .\%~n0.ps1 %rpid% %pin%
Timeout 3
