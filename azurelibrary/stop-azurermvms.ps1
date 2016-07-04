workflow stop-azurermvms
{
    param(
                  )
     
    $VerbosePreference = "Continue"
        
    #The name of the Automation Credential Asset this runbook will use to authenticate to Azure.
    $CredentialAssetName = "coecred"
    $ResourceGroup = "rg-avanadelab-03"
 
    #Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name $CredentialAssetName
    if(!$Cred) {
        Throw "Could not find an Automation Credential Asset named �${CredentialAssetName}�. 
               Make sure you have created one in this Automation Account."
    }
 
    Login-AzureRmAccount -Credential $Cred
 
    #(optional): pick the right subscription to use. Without this line, the default subscription for your Azure Account will be used.
    Select-AzureRmSubscription -SubscriptionId 'fd79af43-136f-4aea-b3c3-a3c5005b6229'
 
        
    $VMs = (Get-AzureRmVM -ResourceGroupName $ResourceGroup).Name

    Foreach ($VM in $VMs)
    {
        Write-Output "Shutting down VM" $vm.Name
        Stop-AzureRmVM -ResourceGroupName $ResourceGroup -Name $vm -Force
 
    }
}

