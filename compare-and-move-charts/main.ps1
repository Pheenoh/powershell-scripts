# input variables
$localchartpath = "/your/local/charts/path/here"
$remotechartpath = "/your/remote/chart/path/here"

$localhashes = Get-ChildItem $localchartpath -recurse -Include "*.mid","*.chart" | Get-FileHash
$remotehashes = Get-ChildItem $remotechartpath -recurse -Include "*.mid","*.chart" | Get-FileHash

foreach ($hash in $localhashes) {
    if ($remotehashes.Hash -contains $hash.Hash) {
        Write-Output "$($hash.Path) matched, skipping!"
        Continue
    }
    else {
        $folderpath = $hash.Path.substring(0, $hash.path.LastIndexOf(".")-6)
        Write-Output "Before transform $($hash.Path)"
        Write-Output "After transform $folderpath"
        Write-Output "Moving $folderpath"
        Move-Item -Path $folderpath -Destination $remotechartpath
    }
}