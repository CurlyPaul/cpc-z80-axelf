


PLY_AKG_SetCurrentLineBeforeReadLine

Loads the current line number from PLY_AKG_PatternDecreasingHeight ?

and stores it in (PLY_AKG_PatternDecreasingHeight + PLY_AKG_Offset1b)




AxelF_Subsong0_Track0 hold all of the note data from the song


 PLY_AKG_CHANNEL1_TRACKNOTE equ 17256 - &4368

Address that are changed in a cycle:

Seems to always be the same

(PLY_AKG_CHANNEL1_READTRACK) seems to change everytime the ticker gets to the bottom


4495
414c    PLY_AKG_TICKDECREASINGCOUNTER
42e5
4373
4367
439e
4392
43c9
43bd 
436e    PLY_AKG_Channel1_InstrumentStep
4452
43f2
439c
4399
4473
4411
43c7
43c4
4474
4432


Screen Switching

if the song is 11 seconds long

11*50 = 550 vsyncs - check that this is reasonable!


If the AKG ticker decreases from 9 to 1 each time play is called. 

Count how many times the ticker hits one per loop of the audio

from that I can work out the length of a bar, and at which points I need to switch the screen