;Compiles the player, the music and sfxs, using RASM.
;No ORG needed - Ammendment, seems that for winape at least, an org is needed
org #4000
    ;This is the music, and its config file.
    include "axelf.asm" 
    include "axelf_playerconfig.asm" ;Optional.
 
    ;This is the sfxs, and its config file.  
    ;include "SoundEffects.asm" 
    ;include "SoundEffects_playerconfig.asm"  ;Optional.

    ;What hardware? Uncomment the right one.
    PLY_AKG_HARDWARE_CPC = 1
    ;PLY_AKG_HARDWARE_MSX = 1        
    ;PLY_AKG_HARDWARE_SPECTRUM = 1
    ;PLY_AKG_HARDWARE_PENTAGON = 1

    ;Comment/delete this line if not using sound effects.
    ;PLY_AKG_MANAGE_SOUND_EFFECTS = 1
    PLY_AKG_STOP_SOUNDS = 1
    ;This is the player.
    include "..\libs\PlayerAkg.asm"