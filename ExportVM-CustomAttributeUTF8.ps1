#Executable Script
$timestamp = Get-Date -format "yyyyMMdd-HH.mm"
$startdir = "D:\GitHubZone\ExportVM-CustomAttribute"
$exportfile = "$startdir\vm-custom-attributes-$timestamp.csv"

$vms = Get-VM 
$Report =@()
    foreach ($vm in $vms) {
		$customattribs = $vm | select -ExpandProperty CustomFields 
        $row = "" | Select VM, "AP", "AP Value", "SP", "SP Value", "業務系統名稱", "業務系統名稱 Value", "業務系統編號", "業務系統編號 Value", "業務系統說明", "業務系統說明 Value"
        $row.VM = $vm.Name
		$row."AP" = $customattribs[0].Key
        $row."AP Value" = $customattribs[0].value
		$row."SP" = $customattribs[1].Key
        $row."SP Value" = $customattribs[1].value
		$row."業務系統名稱" = $customattribs[2].Key
        $row."業務系統名稱 Value" = $customattribs[2].value
		$row."業務系統編號" = $customattribs[3].Key
        $row."業務系統編號 Value" = $customattribs[3].value
		$row."業務系統說明" = $customattribs[4].Key
        $row."業務系統說明 Value" = $customattribs[4].value
		$Report += $row
    }
#Export CSV
$report | Export-Csv "$exportfile" -NoTypeInformation -Encoding utf8

#Original Script
<#
$timestamp = Get-Date -format "yyyyMMdd-HH.mm"
$startdir = "D:\sjoerd"
$exportfile = "$startdir\vm-custom-attributes-$timestamp.csv"
 
$vms = Get-VM 
$Report =@()
    foreach ($vm in $vms) {
        $row = "" | Select Name, Notes, DR, "DR Value", DRStorage, "DRStorage Value", Cluster, "Cluster Value", "DataCatagory", "DataCatagory Value"
        $row.name = $vm.Name
        $row.Notes = $vm.Notes
        $customattribs = $vm | select -ExpandProperty CustomFields
        $row.DR = $customattribs[0].Key
        $row."DR Value" = $customattribs[0].value
        $row.DRStorage = $customattribs[1].Key
        $row."DRStorage Value" = $customattribs[1].value
        $row.Cluster = $customattribs[2].Key
        $row."Cluster Value" = $customattribs[2].value
        $row."DataCatagory" = $customattribs[3].Key
        $row."DataCatagory Value" = $customattribs[3].value    
        $Report += $row
    }
 
$report | Export-Csv "$exportfile" -NoTypeInformation
#>

#Old Script
<#
#Connect to vCenter Server
Connect-VIserver

$valueList =@()
Get-VM | % {
for($i = 0; $i -lt $_.CustomFields.Count; $i ++ ){
#Create row for VMName, FieldKey, FieldValue
$row = "" | Select VMName, FieldKey, FieldValue
$row.VMName = $_.Name
$row.FieldKey = $_.CustomFields.Keys[$i]
$row.FieldValue = $_.CustomFields.Values[$i]
$valueList += $row
}
}
#Export CSV file with encoding utf8
$valueList | Export-Csv ".\exported-attributes-value.csv" -NoTypeInformation -encoding utf8
#>