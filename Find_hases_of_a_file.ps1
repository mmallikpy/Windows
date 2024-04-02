$file_list = @("C:\Users\MN\Desktop\Ethical_hacker.jpg"; "C:\Users\MN\Desktop\Windows_7_x64-2024-03-23-13-39-50.png")

foreach ($x in $file_list) {  
    $hash_md5 = Get-FileHash -Path "$x" -Algorithm MD5
    $hash_SHA1 = Get-FileHash -Path "$x" -Algorithm SHA1
    $hash_SHA256 = Get-FileHash -Path "$x" -Algorithm SHA256

    Write-Host "`nFile Path is`t`t:-:`t" $x
    Write-Host "MD5 Hash value`t`t:-:`t" $hash_md5.Hash
    Write-Host "SHA1 Hash value`t`t:-:`t" $hash_SHA1.Hash
    Write-Host "SHA256 Hash value`t:-:`t" $hash_SHA256.Hash

}