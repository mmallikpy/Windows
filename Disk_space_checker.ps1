#This script will found the Disk Space if the space below 5Gb it will notify.

$freelist = (Get-PSDrive -Name [A-Z]).Free
$driveName = (Get-PSDrive -Name [A-Z]).Name


for ($count = 0; $count -lt $freelist.Length; $count++) {
    $dSize = $freelist[$count]/1024/1024/1024
    $drive = $driveName[$count]
    if($dSize -le 5.0){
        Add-Type -AssemblyName System.Windows.Forms
        $global:balloon = New-Object System.Windows.Forms.NotifyIcon
        $path = (Get-Process -id $pid).Path
        $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
        $balloon.BalloonTipText = "Free Space on Drive $drive : $($dSize) GB"
        $balloon.BalloonTipTitle = "Attention $Env:USERNAME" 
        $balloon.Visible = $true 
        $balloon.ShowBalloonTip(5000)
    }
}
