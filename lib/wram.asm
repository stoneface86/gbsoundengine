; -----------------------------------------------------------------------------
; WRAM variables

SECTION "tbengine_wram", WRAM0, ALIGN[3]

; this part of the section is aligned to quad words (8 bytes)
; so when calculating the address, the channel id can be added to the low byte
; of the address without having to worry about carry

tbe_wWramBegin:

; ========================================================== Quad #0: $00 - $07

; channel pointers, these point to the current row being played
tbe_wCh1Ptr:            DS 2
tbe_wCh2Ptr:            DS 2
tbe_wCh3Ptr:            DS 2
tbe_wCh4Ptr:            DS 2

; ========================================================== Quad #1: $08 - $0F

tbe_wRowCounter1:       DS 1
tbe_wRowCounter2:       DS 1
tbe_wRowCounter3:       DS 1
tbe_wRowCounter4:       DS 1

; persistent row durations (default is 0)
tbe_wRowDuration1:      DS 1
tbe_wRowDuration2:      DS 1
tbe_wRowDuration3:      DS 1
tbe_wRowDuration4:      DS 1

; ========================================================== Quad #2: $10 - $17

tbe_wStatus:            DS 1
tbe_wTimer:             DS 1        ; current timer value
tbe_wTimerPeriod:       DS 1        ; number of frames per row in Q5.3 format

; bits 0-3: new row for CH1-4
; bits 4-7: lock status for CH1-4
tbe_wChflags:           DS 1

tbe_wOrderCount:        DS 1        ; number of patterns in order less 1
tbe_wOrderCounter:      DS 1
tbe_wOrderTable:        DS 2        ; pointer to pattern order table

; ========================================================== Quad #3: $18 - $1F


tbe_wCurrentOrder:      DS 2        ; pointer to the current order

; stack pointer when tbe_update is called
tbe_wStack:             DS 2

; number of rows remaining in the pattern
; when this overflows, it's time to load the next pattern
tbe_wPatternCounter:    DS 1
; size, in rows - 1, of a pattern
; the patternCounter is reloaded with this variable when a new pattern plays
tbe_wPatternSize:       DS 1

; pattern command
; 00 - do nothing
; 01 - pattern goto
; 10 - pattern skip, start at row
tbe_wPatternCommand:    DS 1
tbe_wPatternParam:      DS 1

; ========================================================== Quad #4: $20 - $27

; register data
; music updates the data here first and then to registers if the channel is
; unlocked (A locked channel has a sound effect playing on it)

tbe_wChannelSettings:

; flags for determining which registers need updating

; bit 0: write timbre
; bit 1: write envelope
; bit 2: write panning
; bit 3: retrigger
tbe_wRegStatus1:        DS 1
tbe_wRegStatus2:        DS 1
tbe_wRegStatus3:        DS 1
tbe_wRegStatus4:        DS 1


; timbre for square is duty, wave volume for wave and step width for noise
; bit 0-1: ch1 duty (12.5%, 25%, 50%, 75%)
; bit 2-3: ch2 duty (12.5%, 25%, 50%, 75%)
; bit 4-5: ch3 volume (0%, 100%, 50%, 25%)
; bit 6: ch4 step width (15-bit, 7-bit)
tbe_wTimbre:            DS 1

; channel panning, exact format as NR51
tbe_wPanning:           DS 1

; envelope settings for channels 1, 2 and 4
; for channel 3 the envelope is the waveform id
tbe_wEnvelope1:         DS 1
tbe_wEnvelope2:         DS 1
tbe_wEnvelope3:         DS 1
tbe_wEnvelope4:         DS 1

tbe_wChannelSettingsEnd:

; END OF QUAD WORD ALIGNMENT

tbe_wFreqControl1:      DS FreqControl_SIZEOF
tbe_wFreqControl2:      DS FreqControl_SIZEOF
tbe_wFreqControl3:      DS FreqControl_SIZEOF

tbe_wWramEnd:
