
## Fixing _Permission denied_ on media folder

Root cause: snap default permissions
Fix: `sudo snap connect ffmpeg:removable-media`

Thanks to https://unix.stackexchange.com/questions/580357/permission-denied-with-ffmpeg-via-snap-on-external-drive .

Context info: `snap connections | grep ffmpeg`
