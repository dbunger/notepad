
<#
    Direct streams from SAT has some invalid MPEG settings and errors.
    Fixing them by running them through FFMPEG with just copy.
    Fixes timestamps and removes unnecessary audio streams
#>


$env:Path += "C:\Users\gewin\bin\ffmpeg-4.2-win64-static\bin"

Get-ChildItem | ForEach-Object { 

    $SRC = $_.Name
    $TARGET = $SRC -replace "\.", "-."
    ffmpeg.exe -i "$SRC" -codec copy "$TARGET"
}