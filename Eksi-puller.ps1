function Get-Titles 
{
    param 
    (
        $page
    )    
    $Titles = (Invoke-WebRequest -Uri https://eksisozluk.com/basliklar/m/populer?p=$page).links | foreach {$_.href}  | Where {$_ -match "a=popular"} | foreach {$_.Substring(0,$_.Length-10)} | foreach {$_ + '?a=nice'}
    return $Titles
}

function Get-PagesCount 
{
    $count = ((Invoke-WebRequest -Uri https://eksisozluk.com/basliklar/m/populer?p=2).allElements | Where-Object class -eq "pager")."data-pagecount"
    return $count
}

function Get-Best 
{
    param 
    (
        $title
    )
    $site = "https://eksisozluk.com"
    $url = $site + $title
    $html = Invoke-WebRequest -Uri $url
    $entry = ($html.allelements | where "data-id")."outerText"[1]
    $yazar = ($html.allelements | where "data-id")."data-author"[1]
    $fav = ($html.allelements | where "data-id")."data-favorite-count"[1]
    Write-Host
    "
    ----------------------------
    ---------->Entry<-----------
    -----------------------------


    $entry


    -----------------------------
    ----------->Yazar<----------
    ----------------------------

    $yazar
    
    -----------------------------
    ------->Favori Sayisi<-------
    -----------------------------
    $fav
    "
}
function Start-Puller 
{
    $counts = Get-PagesCount
    for ($i = 1; $i -le $counts; $i++)
    {
       $titles = Get-Titles
       foreach ($title in $titles)
       {
           Write-Host $title -BackgroundColor red -ForegroundColor White 
           Get-Best -title $title
       }
    }

}

Start-Puller
