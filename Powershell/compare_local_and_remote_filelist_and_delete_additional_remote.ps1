gci -Recurse -File |
  Resolve-Path -Relative |
  Out-File C:\Users\gewin\Fotos_2015_1u1.files
  
gci -Recurse -File |
  Resolve-Path -Relative |
  Out-File C:\Users\gewin\Fotos_2015.files

((compare -ReferenceObject (gc C:\Users\gewin\Fotos_2015.files) -DifferenceObject (gc C:\Users\gewin\Fotos_2015_1u1.files)) | Where-Object -Property SideIndicator -EQ '=>').InputObject | %{ rm -Verbose "$_" }

