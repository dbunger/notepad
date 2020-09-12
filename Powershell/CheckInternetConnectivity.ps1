while ($true) {
    if (Test-Connection -Count 4 -Quiet -Delay 3 www.heise.de) { 
        Write-Output Yay 
    }
    else {
        Write-Output Noooooooooooooooooooooooooooooooooo
        Get-Date | Out-File -Append Reconnect_fritzbox.log
        netsh wlan disconnect; Start-Sleep 3;
        netsh wlan connect name=Drahtlos23;
    }
    Get-Date
    Start-Sleep 3
}