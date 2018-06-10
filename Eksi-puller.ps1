#Windonis
#EksiSozluk Puller

$data = Invoke-WebRequest https://eksisozluk.com/basliklar/bugun/2 
$pageCount = ($data.AllElements | Where-Object class -eq "pager")."data-pagecount" | get-unique
$count = 5;
function get-titles ($element) 
{
    $allTitles = New-Object System.Collections.ArrayList($null)
    $allTitles += $element
    #Start-Sleep 30
    Set-Clean -link $allTitles
}
function Get-allTitles () 
{
    for ($i = 1; $i -le $pageCount; $i++) 
    {
        $titles = (((Invoke-WebRequest "https://eksisozluk.com/basliklar/bugun/$i").Links).href) | Select-String "day" 
        foreach ($title in $titles) 
        {
            get-Titles -element "$title"
        }    
    }   
}
function Set-Clean ($link) 
{

    $cleanLink = $link |ForEach-Object{$_.split("?")[0]}
    return $cleanLink
}

Get-AllTitles