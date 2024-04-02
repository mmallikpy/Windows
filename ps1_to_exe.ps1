# This script can make ps1 to exe

Import-Module ps2exe
Set-ExecutionPolicy Unrestricted
Invoke-PS2EXE "C:\Users\Mithun\Desktop\Script\Tracert_Report_v2.ps1" "C:\Users\Mithun\Desktop\Script\TraceReport.exe"
