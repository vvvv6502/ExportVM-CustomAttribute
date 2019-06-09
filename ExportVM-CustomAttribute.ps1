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
