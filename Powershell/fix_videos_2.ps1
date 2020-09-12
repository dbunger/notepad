
<#
    Direct streams from SAT has some invalid MPEG settings and errors.
    Fixing them by running them through FFMPEG with just copy.
    Fixes timestamps and removes unnecessary audio streams
#>


$env:Path += "C:\Users\gewin\bin\ffmpeg-4.2-win64-static\bin"

gci | % { 

    if ($_.Length -gt 1000000000) {

        $SRC = $_.Name
        $SRC
        $LOG = $SRC + ".log"
        $LOG
        $TARGET = $SRC -replace "\.", "-."
        $TARGET
        #Start-Transcript "$LOG" -Append
        C:\Users\gewin\bin\ffmpeg-4.2-win64-static\bin\ffmpeg.exe -i "$SRC" -codec copy "$TARGET" *>> "$LOG"
        #Stop-Transcript

    }
}