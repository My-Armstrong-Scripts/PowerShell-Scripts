 # Get a list of volumes attached to an instance where Backup=True (tag, you need to create a tag [on instance] if you dont have one) and snapshot them.
$volumes = Get-EC2Volume
# For each volume, snapshot
foreach($vol in $volumes)
{
    $instanceId = ""
    if ($vol.Attachment -ne $null)
    {
        $instanceId =$vol.Attachment.InstanceId
        $ShouldSnapshot = Get-EC2Tag |
            Where-Object -Property "ResourceId" -eq "$instanceId"|
            Where-Object -Property "Key" -eq "Backup" |
             Select-Object -ExpandProperty Value
        if($ShouldSnapshot -eq "True")
        {
            $instanceName = Get-EC2Tag | Where-Object -Property "resourceId" -eq "$instanceId"|
                Where-Object -Property "Key" -eq "Name" |
                    Select-Object -ExpandProperty Value
                Write-Host ("Taken Snapshot of {0} for instance {1} " -f $vol.Attachment.Device, $instanceName)
                New-EC2Snapshot -VolumeId $vol.VolumeId -Description ("{0}-{1}" -f $instanceName,$vol.Attachment.Device)
        }
    }
}