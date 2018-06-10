#Windonis
#EksiSozluk Puller

$data = Invoke-WebRequest https://eksisozluk.com/basliklar/bugun/2 
$pageCount = ($data.AllElements | Where-Object class -eq "pager")."data-pagecount" | get-unique

function Get-allTitles () 
{
    for ($i = 1; $i -le $pageCount; $i++) 
    {
        (((Invoke-WebRequest https://eksisozluk.com/basliklar/bugun/$i).Links).href) | Select-String "day" >> D:\\enissil.txt
    }    
}
