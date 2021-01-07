$processName = "myprocesstokill"
$timeOut = [timespan]'0:0:15'

Function GetMyIPSync
{
    $wc1=New-Object net.webclient
    $wc1.downloadstring("http://checkip.dyndns.com") -replace "[^\d\.]"
}

$initialIp = GetMyIPSync

Write-Host "La ip que monitorearemos es:" $initialIp
Write-Host "...presiona q para Salir o cualquier otra tecla para continuar."
$key = Read-Host
if($key -eq 'q'){ Exit }

$currentIp = $initialIp
$watch = [System.Diagnostics.Stopwatch]::StartNew()
$isSecondChance = $FALSE
while($currentIp -eq $initialIp){
    Write-Host "Todo esta bien conectado con la ip:" $currentIp

    $wc=New-Object net.webclient
    $result = $wc.downloadstringtaskasync("http://checkip.dyndns.com")
    if ($result.AsyncWaitHandle.WaitOne($timeOut) -eq $false) 
    { 
        Write-Host "no se ha podido conectar en:" $timeOut.TotalSeconds "segundos... intentando de nuevo..."
        if($isSecondChance){
			break
		}
		[System.Threading.Thread]::Sleep($timeOut)
        $isSecondChance = $TRUE
		continue
    }
    else
    { 
        Write-Host "connection within" $timeOut.TotalSeconds "seconds"
        $currentIp = $result.Result -replace "[^\d\.]"
    }
    $wc.Dispose()
}

Write-Error "Algo esta mal con la ip ... terminando proceso..."
Get-Process | Where-Object{$_.ProcessName -match $processName} | ForEach-Object{ kill $_.Id}
Write-Host $processName "terminado despues de:" $watch.Elapsed.TotalMinutes "minutos"
Write-Host "Presiona cualquier tecla para terminar..."
Read-Host
