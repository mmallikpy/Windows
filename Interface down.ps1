$ping_check = TNC 192.168.20.1 | select PingSucceeded
$interface_status = Get-NetLbfoTeamMember | select Name, AdministrativeMode, OperationalStatus

$active_ether = $interface_status[1].Name
$active_ether_AdministrativeMode = $interface_status[1].AdministrativeMode
$active_ether_OperationalStatus = $interface_status[1].OperationalStatus

$stand_ether_r = $interface_status[0].Name
$stand_ether_r_AdministrativeMode = $interface_status[0].AdministrativeMode
$stand_ether_r_OperationalStatus = $interface_status[0].OperationalStatus


if ($ping_check.PingSucceeded -in "False"){
    if ($active_ether_AdministrativeMode -eq "Active" -and $active_ether_OperationalStatus -eq "Active"){
        Disable-NetAdapter $active_ether -Confirm:$false
    }

}

if ($ping_check.PingSucceeded -in "False"){
    if ($stand_ether_r_AdministrativeMode -eq "Standby" -and $stand_ether_r_OperationalStatus -eq "Active"){
        Enable-NetAdapter $active_ether
    }
}