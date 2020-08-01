# input variables
$inputfilepath = "C:\Users\Pheenoh\Desktop\DME\TP_CleanWatchFile.dmw" # replace with your old dmw path
$outputfilepath = "C:\Users\Pheenoh\Desktop\DME\TP_CleanWatchFile.dmw" # replace with your new dmw path. CAREFUL HERE! making this the same as input path will overwrite the input file
[int32]$addr = "0x8038F8B4" # starting address
[int32]$endaddr = "0x8038F95C" # ending address
$groupname = "tp_link_wolf_swim" # the name that will be generated for the group
$membername = "member_prop" # the name of the members in the group

$inputobject = Get-Content $inputfilepath| ConvertFrom-Json

$groupobj = New-Object System.Collections.Generic.List[object]
$object = New-Object System.Collections.Generic.List[object]

$groupobj.Add([pscustomobject]@{
        "groupEntries" = @();
        "groupName"    = $groupname;
    })

do {
    $object.Add([pscustomobject]@{
            "address"   = '{0:X8}' -f ($addr);
            "baseIndex" = "0";
            "label"     = $membername;
            "typeIndex" = "0";
            "unsigned"  = [bool]"true";
        })
    $addr++
}
until ($addr -eq $endaddr)

$inputobject.watchList += $groupobj

$counter = 0
foreach ($obj in $inputobject.watchList) {
    if ($obj.groupname -eq $groupname) {
        $index = $counter
        break
    }
    else { $counter++; continue }
    
}
Write-Output $index
$inputobject.watchList[$index].groupentries += $object

$inputobject | ConvertTo-Json -depth 50 | out-file $outputfilepath -Force
