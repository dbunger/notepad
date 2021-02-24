
 * Check, if file exists.
 * Grep
 * Write-Progress

```Powershell
$CHECKSUMFILE="D:\Daniel\Prüfsummen Backups\Fotos_2017.sha256"
$DELIMITER=" Fotos_2017\\"
$REMOTE_DIR="E:\Fotos_2017\"
$COUNTALL=(gc "$CHECKSUMFILE"|measure).Count; $i=0; gc "$CHECKSUMFILE" | %{
  $SPL=("$_" -split "$DELIMITER")
  $CHECKSUM=$SPL[0]
  $FILE=$SPL[1]
  if ( -Not (Test-Path "checksum_2017.success" ) -Or -Not (Select-String -SimpleMatch "$FILE" "checksum_2017.success")) {
    $RETRY_COUNT=1
    $CHECKSUM_COMPUTED=(Get-FileHash "$REMOTE_DIR$FILE").Hash
    if ($CHECKSUM -ne $CHECKSUM_COMPUTED) {
    "Alaaaarm: $FILE has saved checksum $CHECKSUM and computed $CHECKSUM_COMPUTED"
    } else {
    $FILE | Out-File -Append "checksum_2017.success"
    }
  } else {
    "Skipping $FILE"
  }
  $i=$i+1
  Write-Progress -Activity "Doing $CHECKSUMFILE" -Status "$i of $COUNTALL completed" -PercentComplete ($i*100/$COUNTALL);
}
```

