@echo off

powershell -Command "&{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}; """"& { $((Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/bo0vsthewrld/Spo0tify/main/Spo0tify.ps1').Content)} -start_spoti """" | Invoke-Expression"

pause
exit /b
