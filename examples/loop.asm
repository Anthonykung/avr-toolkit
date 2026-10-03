; AVRA standalone example for ATmega32U4 only.
; No external device include or board pin mapping is needed.
.device ATmega32U4
.cseg
.org 0
    rjmp start
start:
    rjmp start
