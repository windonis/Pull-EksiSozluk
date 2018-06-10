#Windonis
#EksiSozluk Puller

$data = Invoke-WebRequest "https://eksisozluk.com/basliklar/bugun/2"
$pageCount = ($data.AllElements | Where-Object class -eq "pager")."data-pagecount" | get-unique
#$pageCount = 4
$allTitles = New-Object System.Collections.ArrayList($null)
$tmp = New-TemporaryFile
function Get-titles ($element, $keyWord) 
{
    $allTitles += $element
    Set-Clean -link $allTitles -keyWord $keyWord
}
function Get-allTitles ($keyWord) 
{
    for ($i = 1; $i -le $pageCount; $i++) 
    {
        $titles = (((Invoke-WebRequest "https://eksisozluk.com/basliklar/bugun/$i").Links).href) | Select-String "day" 
        foreach ($title in $titles) 
        {
            get-Titles -element "$title" -keyWord $keyWord
        }
        
    }   
}
function Set-Clean ($link, $keyWord) 
{
    $cleanLink = $link |ForEach-Object{$_.split("?")[0]}
    if ($cleanLink -like "*$keyword*")
    {
        $cleanLink >> $tmp.FullName
    }
    
}

function Get-TitleForKeyword ($keyWord) 
{
    $titles = Get-Content $tmp.Fullname
    foreach ($title in $titles) {
        if ($title -like "*$keyWord*") 
        {
            Write-Host $title
        }
    }    
}

Get-AllTitles -keyWord "muharrem"
