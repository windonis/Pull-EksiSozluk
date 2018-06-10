#Windonis
$i = 1
(((Invoke-WebRequest https://eksisozluk.com/basliklar/bugun/$i).Links).href) | Select-String "day"
