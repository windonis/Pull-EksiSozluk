#Windonis
$i = 0
(((Invoke-WebRequest https://eksisozluk.com/basliklar/bugun/$i).Links).innerHTML) | Select-String "<SMALL>" | ForEach-Object {$_.line.split("<")[0]}
