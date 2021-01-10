
# Check / Verify Fotos 2020 photo backup

## Get all files

```
Get-ChildItem -File -Recurse |
  Where-Object Length -gt 10000 |
  Resolve-Path -Relative
```

## Powershell multi line enter

Just hit Shift+Enter.

## Calculate checksum

```
Get-ChildItem -File -Path .\Fotos_2020\ -Recurse |
  Where-Object Length -gt 10000 |
  Resolve-Path -Relative |
  Sort-Object | %{
  $FILE="$_"
  $CHECKSUM=(Get-FileHash -Algorithm SHA256 "$FILE").Hash
  Write-Output "$CHECKSUM $FILE"
  "$CHECKSUM $FILE" | Out-File -Append Fotos_2020_2021-01-10.sha256
}
```

## Reminder "Check max items per folder"

```
gci -Recurse -Depth 1 -Directory |
  Resolve-Path -Relative | %{
    echo "$_"
    $c=(gci -Depth 1 -Path "$_" -File | measure).count
    echo $c
    if ($c -gt 999) {
      echo ">>Alaaaarm: 1u1 max 3K Files pro Ordner: "$_" ("$c")<<<<"
    }
  }
```

## Reminder "Create folder structure"

```
gci -Directory -Recurse | 
  Resolve-Path -Relative | %{ 
    mkdir -Verbose "E:\Fotos_2020\$_" 
  }
```

## Verify checksum

```
$CHECKSUMFILE="D:\Daniel\__\Fotos_2020_Zusammenstellung\Fotos_2020_2021-01-10.sha256"; $COUNT_ALL=(gc "$CHECKSUMFILE"|measure).Count; 

$i=0; $err=0; gc "$CHECKSUMFILE" | %{
  $SPL=("$_" -split " .\\")
  $CHECKSUM=$SPL[0]
  $FILE=$SPL[1]
  $CHECKSUM_TO_VERIFY=(Get-FileHash -Algorithm SHA256 "E:\$FILE").Hash
  $_
  $CHECKSUM
  $CHECKSUM_TO_VERIFY
  if ($CHECKSUM -ne $CHECKSUM_TO_VERIFY) {
    "Alaaaarm: $FILE has saved checksum $CHECKSUM and computed $CHECKSUM_TO_VERIFY"
    $_ | Out-File -Append "checksum_2020.error"
    $err=$err+1
  } else {
    $FILE | Out-File -Append "checksum_2020.success"
  }
  $i=$i+1
  Write-Progress -Activity "Doing Fotos_2020 ($err errors so far ...)" -Status "$i of $COUNT_ALL completed" -PercentComplete ($i*100/$COUNT_ALL)
}
```