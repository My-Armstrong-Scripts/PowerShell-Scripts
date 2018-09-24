Invoke-Command -ScriptBlock {
    Get-Disk |
        Where-Object PartitionStyle -eq 'raw' |
            Initialize-Dsik -PassThru  |
                New-Partition -UseMaximumSize -AssignDriveLetter |
                    Format-Volume -FileSystem (ReFS/NTFS)

} -ComputerName Server

# Chose a file system
# Chose the computer name of what server you want the drives to be formatted on  