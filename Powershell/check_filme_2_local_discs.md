
## Mirror folder on 2 local usb drives

 - Get file list
 - Record files with delta in error log file
 - Store successes in file
 - Repeat until _all files_ are equal to _success files_ 

```
$SOURCE_DIR="\\Diskstation\usbshare1-2\Daten_Krokodil\Filme"
$TARGET_DIR="\\Diskstation\usbshare2-2\Daten_Krokodil_on_Papagei\Filme"

$LOG_DIR="C:\Users\gewin"

cd "$SOURCE_DIR"; gci -File -Recurse |
  Resolve-Path -Relative |
  Out-File -Append "$LOG_DIR\check_filme.all"

cp "$LOG_DIR\check_filme.all" "$LOG_DIR\check_filme.todo"

cd "$SOURCE_DIR"; gc "$LOG_DIR\check_filme.todo" | % {
  $FILE=$_
  $FILE
  $SOURCE_CHECKSUM=(Get-FileHash -Algorithm SHA256 "$SOURCE_DIR\$FILE").Hash
  $SOURCE_CHECKSUM
  $TARGET_CHECKSUM=(Get-FileHash -Algorithm SHA256 "$TARGET_DIR\$FILE").Hash
  $TARGET_CHECKSUM
  if ($SOURCE_CHECKSUM -ne $TARGET_CHECKSUM) {
    $FILE | Out-File -Append "$LOG_DIR\check_filme.error"
    "Problem with $FILE"
  } else {
    "All good with $FILE"
    $FILE | Out-File -Append "$LOG_DIR\check_filme.ok"
  }
}
  
((compare -ReferenceObject (gc "$LOG_DIR\check_filme.todo") -DifferenceObject (gc "$LOG_DIR\check_filme.ok")) | Where-Object -Property SideIndicator -EQ '<=').InputObject | %{ "$_" | Out-File -Append "$LOG_DIR\check_filme.next" }

rm "$LOG_DIR\check_filme.todo"; mv "$LOG_DIR\check_filme.next" "$LOG_DIR\check_filme.todo"

```