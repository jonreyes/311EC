Param([Parameter(Mandatory = $true)] [String] $BasePath)
$class = New-Object System.Collections.Generic.List[System.Object]
$jar = New-Object System.Collections.Generic.List[System.Object]
$Origin = Get-Location
Set-Location $BasePath
$Files=((echo (Get-ChildItem -Path (Get-Location) -Recurse -File).FullName | Resolve-Path -Relative)).Substring(2)
ForEach($File in $Files){
	$Ext = [IO.Path]::GetExtension((Get-ChildItem $File))
	if($Ext -eq ".class"){$class.Add($File)}
	elseif($Ext -eq ".jar"){$jar.Add($File)}
}
Set-Location $Origin
echo $class > class_report.txt
echo $jar > jar_report.txt
#echo "Class Report:"
#cat class_report.txt
#echo "Jar Report:"
#cat jar_report.txt
#echo api_report.txt
#$Java = ($env:path.split(';') | Where-Object {$_ -match "java"})
#echo $Java