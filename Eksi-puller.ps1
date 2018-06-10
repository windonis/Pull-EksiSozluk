#Windonis
#EksiSozluk Puller

$data = Invoke-WebRequest "https://eksisozluk.com/basliklar/bugun/2"
#$pageCount = ($data.AllElements | Where-Object class -eq "pager")."data-pagecount" | get-unique
$pageCount = 4
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
    Get-Entries
    
}

function Get-Entries () 
{
    $KeyTitles = Get-Content C:\Users\kollugil\AppData\Local\Temp\tmp99A2.tmp
    $KeyTitles | ForEach-Object {

    $datas = Invoke-WebRequest "https://eksisozluk.com$_"
    $pageCount1 = (($datas).AllElements | Where-Object class -eq "pager")."data-pagecount" | get-unique
        for ($i = 1; $i -le $pageCount1; $i++) {
            $newLink = "$_" + "?p=$i"
            ((Invoke-WebRequest "https://eksisozluk.com$newlink").AllElements | Where-Object data-id)."data-id" | ForEach-Object {
                    Write-Host $_

            }
        }
    }
}
    


Get-AllTitles -keyWord "muharrem"


