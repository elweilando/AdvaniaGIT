﻿Function Start-NAVRemoteInstanceTenantSync {
    param(
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [System.Management.Automation.Runspaces.PSSession]$Session,
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [PSObject]$SelectedTenant
    )
    PROCESS 
    {
        # Invoke the "same" command on the remote machine
        Invoke-Command -Session $Session -ScriptBlock `
            {
                param([PSObject] $SelectedTenant)
                Load-InstanceAdminTools -SetupParameters $SetupParameters
                Get-NAVTenant -ServerInstance $SelectedTenant.ServerInstance -Tenant $SelectedTenant.Id | Sync-NAVTenant -Mode Sync -Force                
                UnLoad-InstanceAdminTools
            } -ArgumentList $SelectedTenant
    }    
}
