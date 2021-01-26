Import-Module -Name Microsoft.PowerShell.Management, Microsoft.Powershell.LocalAccounts, ActiveDirectory

function Get-Info {
    Get-ComputerInfo | select csname, csmodel, osname, cspartofdomain, csdomain, csprocessors, cstotalphysicalmemory
}

function Unlock-Account {
    Param($member, $Credential)
    Unlock-ADAccount $member -Credential (Read-Host -Prompt "9-account username")
}

function Select-Command {
    Param($Option)

    if ($Option -eq 1) {
        Write-Host "Rename Computer"
    }elseif ($Option -eq 2) {
        Write-Host "Leave or Join a Domain"
    }elseif ($Option -eq 3) {
        Write-Host "Enable Remote Desktop"
    }elseif ($Option -eq 4) {
        Write-Host "Enable Remote Registry"
    }elseif ($Option -eq 5) {
        if (Test-ComputerSecureChannel){
            Write-Output "Your computer is connected to:" Get-ComputerInfo | select cspartofdomain
        } else {
            Write-Output "Your computer is not connected to a domain"
        }
    }elseif ($Option -eq 6) {
        Test-ComputerSecureChannel -OutVariable repairStatus -Repair
        if ($repairStatus){
            Write-Host "Domain repair successful"
        }else {
            Write-Host "Domain rejoin failed"
        }
    }elseif ($Option -eq 7) {
        Write-Host "Reset AD Password"
    }elseif ($Option -eq 8) {
       $User = Read-Host -Prompt 'Which User Account Would you like to unlock?'
       Get-ADUser -Identity $User
       Unlock-Account($User)
       #$User.GetType()
    }elseif ($Option -eq 9) {
        Write-Host  "Rename a Local User"
    }elseif ($Option -eq 10) {
        Write-Host "Change Local User Pasword"
    }else {
        Write-Host " Please select an option between 1 and 10"
    }

}

Write-Host "Timken Tools"

Get-Info

Write-Host @"
1. Rename Computer
2. Leave or Join a Domain
3. Enable Remote Desktop
4. Enable Remote Registry
5. Check Domain Status
6. Fix Domain Status
7. Reset AD Password
8. Unlock AD Account
9. Rename Local User
10. Change Local User Password
"@
$Option = Read-host -Prompt "What would you like to do"
Select-Command($Option)
