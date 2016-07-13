workflow start-azurermvmcustom
{
    param(
        [Parameter(HelpMessage = 'Please choose the VMs name, leaving it blank if all VMs are targeted in the RG')]
        [String[]]$vmname,
        [Parameter(Mandatory=$true,
                   HelpMessage = 'Please choose the resource group from the list')]
        [validateset('rg-avanadelab-01','rg-avanadelab-02','rg-avanadelab-03','rg-avanadelab-04','rg-avanadelab-05')]
        [String]$resourcegroupname,
        [Parameter(Mandatory=$true, 
                   HelpMessage = 'Please choose the credential to run this runbook')]
        [validateset('coecred','coepscred','orcoeadmin','pscred')]
        [String]$credentialassetname

    )
     
    # $VerbosePreference = "Continue"
        
     
    #Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name $credentialassetname
    if(!$Cred) {
        Throw "Could not find an Automation Credential Asset named �${CredentialAssetName}�. 
               Make sure you have created one in this Automation Account."
    }
 
    Login-AzureRmAccount -Credential $Cred
 
    #(optional): pick the right subscription to use. Without this line, the default subscription for your Azure Account will be used.
    Select-AzureRmSubscription -SubscriptionId 'fd79af43-136f-4aea-b3c3-a3c5005b6229'
     
    $rg = Get-AzureRmResourceGroup -Name $resourcegroupname
    if($rg -ne $null)
    {
        if ($vmname -ne $null)
        {   
              Foreach ($VM in $vmname)
              {
                    TRY{
                        Write-Output "Starting up the VM" $vm
                        Start-AzureRmVM -ResourceGroupName $ResourceGroup -Name $vm -ErrorAction Stop
                    }CATCH{"VM doesnot exist: $vm"}
              }
        }

        Else {Get-AzureRmVM -ResourceGroupName $resourcegroupname | Start-AzureRmVM }
    }

    Else {Throw "Could not find the given resource group name. So please validate"}

}

    
    
    






