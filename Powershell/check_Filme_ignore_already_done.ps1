
$env:Path += "C:\Users\gewin\bin\ffmpeg-4.2-win64-static\bin"

Get-ChildItem -File | 
Where-Object Name -NotLike "*_.*" | 
Where-Object Length -GT 300000000 | 
ForEach-Object {
    $NAME = $_.Name
    $NAME
    $LOGNAME = "$NAME.log"
    if ( Test-Path $LOGNAME ) {
        Write-Output "Already checked ..."
    }
    else {
        $TMPNAME = $NAME -replace "\.", "_."
        $TMPNAME
        ffmpeg.exe -i "$NAME" -codec copy "$TMPNAME" *>> $LOGNAME
    }
}