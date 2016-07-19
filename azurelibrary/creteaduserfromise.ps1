param(
    [Parameter(Mandatory=$true)][String]$firstname,
    [Parameter(Mandatory=$true)][String]$lastname,
    [Parameter(Mandatory=$true)][String]$password,
    [Parameter()][String]$city = "Kolkata",
    [Parameter()][String]$office = "KDC1",
    [Parameter()][String]$country = "India",
    [Parameter()][String]$department = "Capability"
    
)

$displayname = $firstname + " " + $lastname 
$username = $displayname
$userprincipalname = $firstname + '.' + $lastname + '@acpcloud691hotmail.onmicrosoft.com'
$upn = $userprincipalname
$mobilephone = $mobilephone.ToString()
$officenumber = $officenumber.ToString()

$login = Get-AutomationPSCredential -Name 'iscred'
Connect-MsolService -Credential $login

New-MsolUser -UserPrincipalName $upn `
             -DisplayName $username `
             -ForceChangePassword $false `
             -StrongPasswordRequired $true `
             -Password $password `
             -FirstName $firstname `
             -LastName $lastname `
             -City $city `
             -Office $office `
             -Department $department `
             



             


