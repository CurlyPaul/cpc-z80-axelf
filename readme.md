# Simple Music Player and Gfx Sync  



## Build

Make any changes needed in Arkos and expert as AKG to the file called axel.asm. Leave all options default in the dialog

Run buildsong.ps1 - this converts the RASM into winape asm

Load CaptureVolumeTrack.asm
    - This isn't finished as the player destroys the shadow registers and I don't yet know how to save to a disk without the firmware

Pause once finished, and using the debugger save C000-C48E to volumetrack.bin

Open Main.asm
Set release to 1

Open winape and mount axelf.dsk - this contains the only copy of the loader!

Run, and there should be new files generated on the disk



