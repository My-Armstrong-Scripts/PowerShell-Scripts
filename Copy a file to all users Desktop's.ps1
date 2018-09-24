﻿$Users = Get-ChildItem C:\Users\ -Exclude "Administrator","Public","Default*" # Exclude any other defaults that you don't want.

foreach($User in $Users.name){ 
$Path = "C:\Users\$User\Desktop"; 
Copy-Item -Path "\\Path\To\Source\File.txt" -Destination $Path\File.txt 
}

# Copy a file to all users Desktop