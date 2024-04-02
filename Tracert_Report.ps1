# In my case, each of my distant branches has a VPN connection. Every branch uses a mobile network or a local internet provider. My Head Office has an NIX (BDiX) connection to an ISP.
# Additionally, my branch is linked to NIX (BDiX). They occasionally report to us that the branch is unable to establish a VPN connection. Next, my group uses Teamviewer or Anydesk to access the remote desktop.
# They also attempt to perform certain manual tasks, such as gathering branch ISP information and tracing routes, which take more than 30 minutes every support call because of the sluggish internet.

# The script's current objective is to create a.exe. And users of my branch can execute it with ease. The script gathers certain data, including PC name, public IP address, and traceroute.
# It will ask for your email password and e-mail address. It will then send our staff an email after that.


"`n`n"
Write-host "[#####] Script is working. It will take some time, so please be Patient. [#####]"
"`n`n"

# Get public IP address
$myIP = (Invoke-WebRequest -Uri "http://ifconfig.me/ip").Content

# Get current directory
$cd = Get-Location

# Perform trace route to 8.8.8.8 and cisco.com
$trace = tracert -d cisco.com
$trace > "$cd\tracerReport.txt" 
"`n---------------------------------------`n" >> "$cd\tracerReport.txt"
$tracegdns = tracert -d 8.8.8.8
$tracegdns >> "$cd\tracerReport.txt"

# Get system information
$hostname = hostname
$date = Get-Date

# Email configuration
$smtpServer = "smtp.office365.com"
$smtpPort = 587
$recipient = "mithun@test.com"
$Cc = "anup.malakar@test.com"
$subject = "Trace Report of $hostname"
$body = @"
Hi Admin,

My Public IP is: $myIP
My Hostname is: $hostname
Date: $date

Please check the attached traceroute report.

Best Regards,
"@

$attachment = "$cd\tracerReport.txt"


# Validate domain
while($true){
    $sender = Read-Host -Prompt "[+] Give your Email address"
    $userDomain = $sender.Split('@')

    if($userDomain[1].Equals('test.com') -eq $true){
        break
    }else{ Write-Host "`n[-] Give the correct email address`n"}
}

# Prompt for password securely
$password = Read-Host -Prompt "[+] Enter your Email password" -AsSecureString

# Create credentials object
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $sender, $password

# Send mail
try{
    Send-MailMessage -From $sender -To $recipient -Cc $Cc -Subject $subject -Body $body -Attachments $attachment -SmtpServer $smtpServer -Port $smtpPort -Credential $credentials -UseSsl
    Write-Host "`n[*] Email sent successfully!"
    Write-Host "[*] Thanks for your help"
}catch {
   Write-Output "[-] Email Send Failed"
}

Start-Sleep -Seconds 3
