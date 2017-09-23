Function Move-ESXtoDataCenter {
    <#
    .SYNOPSIS
        Moves a ESX to the location that is specified by the Datacenter parameter
    .PARAMETER ESXName
        Specifies the ESX you want to move to another location
    .PARAMETER DatacenterName
        Specifies the datacenter where you want to move the ESX
    .EXAMPLE
        Move-ESXtoDataCenter -ESXName 10.20.30.40 -DatacenterName 'theDatacenter'
    .NOTES
        Copyright VMware, Inc. 2010-2013.  All Rights Reserved.
    #>

    Param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$ESXName,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$DatacenterName
    )

    "Put ESX host in maintenance mode before performing move action"
    Set-VMHost -VMHost $ESXName -State "Maintenance"

    "Move ESX $ESXName to Datacenter $DatacenterName"
    Move-VMHost -VMHost $ESXName -Destination $DatacenterName

    "Put the ESXi out of maintenance mode"
    Set-VMHost -VMHost $ESXName -State "Connected"
}