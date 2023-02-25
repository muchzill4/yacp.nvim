Output focus-demo.mp4

Set Padding 0
Set FontFamily "Rec Mono Duotone"
Set FontSize 12
Set Width 640
Set Height 480

Hide
Type "nvim"
Enter
Show
Space
Type "p"

Sleep 1s
Type@300ms "fose"
Enter

Sleep 250ms
Type@75ms "sp | term echo 'run something repetitive!'"
Enter

Sleep 1s
Space
Type "p"

Sleep 1s
Type@300ms "foru"
Enter

Sleep 2s
Type "i"
Enter

Sleep 0.5s
Type@75ms ":lua require('yacp').replay()"
Enter

Sleep 2s
Type "i"
Enter
