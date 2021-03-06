;***************************************************************************
;*
;* HARDWARE.INC - Gameboy Hardware definitions
;*
;***************************************************************************

_HW	EQU $FF00

_VRAM	EQU $8000	; $8000->$A000
_RAM	EQU $C000	; $C000->$E000
_OAMRAM	EQU $FE00	; $FE00->$FE9F
_AUD3WAVERAM	EQU $FF30	; $FF30->$FF3F		; not sure!


; --
; -- OAM flags
; --

OAMF_PRI	EQU %10000000	; Priority
OAMF_YFLIP	EQU %01000000	; Y flip
OAMF_XFLIP	EQU %00100000	; X flip
OAMF_PAL0	EQU %00000000	; Palette number; 0,1
OAMF_PAL1	EQU %00010000	; Palette number; 0,1


;***************************************************************************
;*
;* Custom registers
;*
;***************************************************************************

; --
; -- P1 ($FF00)
; -- Register for reading joy pad info.    (R/W)
; --
rP1	EQU $00

P1F_5	EQU %00100000	; P15 out port
P1F_4	EQU %00010000	; P14 out port
P1F_3	EQU %00001000	; P13 out port
P1F_2	EQU %00000100	; P12 out port
P1F_1	EQU %00000010	; P11 out port
P1F_0	EQU %00000001	; P10 out port


; --
; -- LCDC ($FF40)
; -- LCD Control (R/W)
; --
rLCDC	EQU $40

LCDCF_OFF	EQU %00000000	; LCD Control Operation
LCDCF_ON	EQU %10000000	; LCD Control Operation
LCDCF_WIN9800	EQU %00000000	; Window Screen Display Data Select
LCDCF_WIN9C00	EQU %01000000	; Window Screen Display Data Select
LCDCF_WINOFF	EQU %00000000	; Window Display
LCDCF_WINON	EQU %00100000	; Window Display
LCDCF_BG8800	EQU %00000000	; BG Character Data Select
LCDCF_BG8000	EQU %00010000	; BG Character Data Select
LCDCF_BG9800	EQU %00000000	; BG Screen Display Data Select
LCDCF_BG9C00	EQU %00001000	; BG Screen Display Data Select
LCDCF_OBJ8	EQU %00000000	; OBJ Construction
LCDCF_OBJ16	EQU %00000100	; OBJ Construction
LCDCF_OBJOFF	EQU %00000000	; OBJ Display
LCDCF_OBJON	EQU %00000010	; OBJ Display
LCDCF_BGOFF	EQU %00000000	; BG Display
LCDCF_BGON	EQU %00000001	; BG Display
; "Window Character Data Select" follows BG


; --
; -- STAT ($FF41)
; -- LCDC Status   (R/W)
; --
rSTAT	EQU $41

STATF_LYC	EQU %01000000	; LYCEQULY Coincidence (Selectable)
STATF_MODE10	EQU %00100000	; Mode 10
STATF_MODE01	EQU %00010000	; Mode 01 (V-Blank)
STATF_MODE00	EQU %00001000	; Mode 00 (H-Blank)
STATF_LYCF	EQU %00000100	; Coincidence Flag
STATF_HB	EQU %00000000	; H-Blank
STATF_VB	EQU %00000001	; V-Blank
STATF_OAM	EQU %00000010	; OAM-RAM is used by system
STATF_LCD	EQU %00000011	; Both OAM and VRAM used by system


; --
; -- SCY ($FF42)
; -- Scroll Y (R/W)
; --
rSCY	EQU $42


; --
; -- SCY ($FF43)
; -- Scroll X (R/W)
; --
rSCX	EQU $43


; --
; -- LY ($FF44)
; -- LCDC Y-Coordinate (R)
; --
; -- Values range from 0->153. 144->153 is the VBlank period.
; --
rLY	EQU $44


; --
; -- LYC ($FF45)
; -- LY Compare (R/W)
; --
; -- When LYEQUEQULYC, STATF_LYCF will be set in STAT
; --
rLYC	EQU $45


; --
; -- BGP ($FF47)
; -- BG Palette Data (W)
; --
; -- Bit 7-6 - Intensity for %11
; -- Bit 5-4 - Intensity for %10
; -- Bit 3-2 - Intensity for %01
; -- Bit 1-0 - Intensity for %00
; --
rBGP	EQU $47


; --
; -- OBP0 ($FF48)
; -- Object Palette 0 Data (W)
; --
; -- See BGP for info
; --
rOBP0	EQU $48


; --
; -- OBP1 ($FF49)
; -- Object Palette 1 Data (W)
; --
; -- See BGP for info
; --
rOBP1	EQU $49


; --
; -- DMA ($FF46)
; -- DMA Transfer and Start Address (W)
; --
rDMA	EQU $46


; --
; -- IF ($FF0F)
; -- Interrupt Flag (R/W)
; --
; -- IE ($FFFF)
; -- Interrupt Enable (R/W)
; --
rIF	EQU $0F
rIE	EQU $FF

IEF_HILO	EQU %00010000	; Transition from High to Low of Pin number P10-P13
IEF_SERIAL	EQU %00001000	; Serial I/O transfer end
IEF_TIMER	EQU %00000100	; Timer Overflow
IEF_LCDC	EQU %00000010	; LCDC (see STAT)
IEF_VBLANK	EQU %00000001	; V-Blank


; --
; -- WY ($FF4A)
; -- Window Y Position (R/W)
; --
; -- 0 <EQU WY <EQU 143
; --
rWY	EQU $4A


; --
; -- WX ($FF4B)
; -- Window X Position (R/W)
; --
; -- 7 <EQU WX <EQU 166
; --
rWX	EQU $4B




;***************************************************************************
;*
;* Sound control registers
;*
;***************************************************************************

; --
; -- AUDVOL/NR50 ($FF24)
; -- Channel control / ON-OFF / Volume (R/W)
; --
; -- Bit 7   - Vin->SO2 ON/OFF (Vin??)
; -- Bit 6-4 - SO2 output level (volume) (# 0-7)
; -- Bit 3   - Vin->SO1 ON/OFF (Vin??)
; -- Bit 2-0 - SO1 output level (volume) (# 0-7)
; --
rNR50	EQU $24
rAUDVOL	EQU rNR50


; --
; -- AUDTERM/NR51 ($FF25)
; -- Selection of Sound output terminal (R/W)
; --
; -- Bit 7   - Output sound 4 to SO2 terminal
; -- Bit 6   - Output sound 3 to SO2 terminal
; -- Bit 5   - Output sound 2 to SO2 terminal
; -- Bit 4   - Output sound 1 to SO2 terminal
; -- Bit 3   - Output sound 4 to SO1 terminal
; -- Bit 2   - Output sound 3 to SO1 terminal
; -- Bit 1   - Output sound 2 to SO1 terminal
; -- Bit 0   - Output sound 0 to SO1 terminal
; --
rNR51	EQU $25
rAUDTERM	EQU rNR51


; --
; -- AUDENA/NR52 ($FF26)
; -- Sound on/off (R/W)
; --
; -- Bit 7   - All sound on/off (sets all audio regs to 0!)
; -- Bit 3   - Sound 4 ON flag (doesn't work!)
; -- Bit 2   - Sound 3 ON flag (doesn't work!)
; -- Bit 1   - Sound 2 ON flag (doesn't work!)
; -- Bit 0   - Sound 1 ON flag (doesn't work!)
; --
rNR52	EQU $26
rAUDENA	EQU rNR52


;***************************************************************************
;*
;* SoundChannel #1 registers
;*
;***************************************************************************

; --
; -- AUD1SWEEP/NR10 ($FF10)
; -- Sweep register (R/W)
; --
; -- Bit 6-4 - Sweep Time
; -- Bit 3   - Sweep Increase/Decrease
; --           0: Addition    (frequency increases???)
; --           1: Subtraction (frequency increases???)
; -- Bit 2-0 - Number of sweep shift (# 0-7)
; -- Sweep Time: (n*7.8ms)
; --
rNR10	EQU $10
rAUD1SWEEP	EQU rNR10


; --
; -- AUD1LEN/NR11 ($FF11)
; -- Sound length/Wave pattern duty (R/W)
; --
; -- Bit 7-6 - Wave Pattern Duty (00:12.5% 01:25% 10:50% 11:75%)
; -- Bit 5-0 - Sound length data (# 0-63)
; --
rNR11	EQU $11
rAUD1LEN	EQU rNR11


; --
; -- AUD1ENV/NR12 ($FF12)
; -- Envelope (R/W)
; --
; -- Bit 7-4 - Initial value of envelope
; -- Bit 3   - Envelope UP/DOWN
; --           0: Decrease
; --           1: Range of increase
; -- Bit 2-0 - Number of envelope sweep (# 0-7)
; --
rNR12	EQU $12
rAUD1ENV	EQU rNR12


; --
; -- AUD1LOW/NR13 ($FF13)
; -- Frequency lo (W)
; --
rNR13	EQU $13
rAUD1LOW	EQU rNR13


; --
; -- AUD1HIGH/NR14 ($FF14)
; -- Frequency hi (W)
; --
; -- Bit 7   - Initial (when set, sound restarts)
; -- Bit 6   - Counter/consecutive selection
; -- Bit 2-0 - Frequency's higher 3 bits
; --
rNR14	EQU $14
rAUD1HIGH	EQU rNR14


;***************************************************************************
;*
;* SoundChannel #2 registers
;*
;***************************************************************************

; --
; -- AUD2LEN/NR21 ($FF16)
; -- Sound Length; Wave Pattern Duty (R/W)
; --
; -- see AUD1LEN for info
; --
rNR21	EQU $16
rAUD2LEN	EQU rNR21


; --
; -- AUD2ENV/NR22 ($FF17)
; -- Envelope (R/W)
; --
; -- see AUD1ENV for info
; --
rNR22	EQU $17
rAUD2ENV	EQU rNR22


; --
; -- AUD2LOW/NR23 ($FF18)
; -- Frequency lo (W)
; --
rNR23	EQU $18
rAUD2LOW	EQU rNR23


; --
; -- AUD2HIGH/NR24 ($FF19)
; -- Frequency hi (W)
; --
; -- see AUD1HIGH for info
; --
rNR24	EQU $19
rAUD2HIGH	EQU rNR24


;***************************************************************************
;*
;* SoundChannel #3 registers
;*
;***************************************************************************

; --
; -- AUD3ENA/NR30 ($FF1A)
; -- Sound on/off (R/W)
; --
; -- Bit 7   - Sound ON/OFF (1EQUON,0EQUOFF)
; --
rNR30	EQU $1A
rAUD3ENA	EQU rNR30


; --
; -- AUD3LEN/NR31 ($FF1B)
; -- Sound length (R/W)
; --
; -- Bit 7-0 - Sound length
; --
rNR31	EQU $1B
rAUD3LEN	EQU rNR31


; --
; -- AUD3LEVEL/NR32 ($FF1C)
; -- Select output level
; --
; -- Bit 6-5 - Select output level
; --           00: 0/1 (mute)
; --           01: 1/1
; --           10: 1/2
; --           11: 1/4
; --
rNR32	EQU $1C
rAUD3LEVEL	EQU rNR32


; --
; -- AUD3LOW/NR33 ($FF1D)
; -- Frequency lo (W)
; --
; -- see AUD1LOW for info
; --
rNR33	EQU $1D
rAUD3LOW	EQU rNR33


; --
; -- AUD3HIGH/NR34 ($FF1E)
; -- Frequency hi (W)
; --
; -- see AUD1HIGH for info
; --
rNR34	EQU $1E
rAUD3HIGH	EQU rNR34


; --
; -- AUD4LEN/NR41 ($FF20)
; -- Sound length (R/W)
; --
; -- Bit 5-0 - Sound length data (# 0-63)
; --
rNR41	EQU $20
rAUD4LEN	EQU rNR41


; --
; -- AUD4ENV/NR42 ($FF21)
; -- Envelope (R/W)
; --
; -- see AUD1ENV for info
; --
rNR42	EQU $21
rAUD4ENV	EQU rNR42


; --
; -- AUD4POLY/NR42 ($FF22)
; -- Polynomial counter (R/W)
; --
; -- Bit 7-4 - Selection of the shift clock frequency of the (scf)
; --           polynomial counter (0000-1101)
; --           freqEQUdrf*1/2^scf (not sure)
; -- Bit 3 -   Selection of the polynomial counter's step
; --           0: 15 steps
; --           1: 7 steps
; -- Bit 2-0 - Selection of the dividing ratio of frequencies (drf)
; --           000: f/4   001: f/8   010: f/16  011: f/24
; --           100: f/32  101: f/40  110: f/48  111: f/56  (fEQU4.194304 Mhz)
; --
rNR42_2	EQU $22
rAUD4POLY	EQU rNR42_2


; --
; -- AUD4GO/NR43 ($FF23)
; -- (has wrong name and value (ff30) in Dr.Pan's doc!)
; --
; -- Bit 7 -   Inital
; -- Bit 6 -   Counter/consecutive selection
; --
rNR43	EQU $23
rAUD4GO	EQU rNR43
