
# Check / Verify Fotos 2020 photo backup

## Get all files

```csharp
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