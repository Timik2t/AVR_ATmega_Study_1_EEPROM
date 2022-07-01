.include "m8515def.inc"

.def temp0=r15
.def temp1=r16
.def temp2=r17
.def temp3=r18
.def counter0=r19
.def counter1=r20

ldi r19,$00
ldi r21,$00
ldi r22,$00


ldi	YL,$60
ldi	YH,0


 Eeprom_to_sram:

  sbic EECR,EEWE
  rjmp Eeprom_to_sram
  out EEARH,r21
  out EEARL,counter0
  sbi EECR,EERE
  in temp0,EEDR
  st Y+,temp0
  inc counter0
  cpi counter0,$10
  brne Eeprom_to_sram
  
 


 ldi counter0,$0E
 ldi counter1,$10
 mov temp0,YL
 ldi temp3,$0E
  loop0:
	mov counter1,temp3
	dec temp3
	mov YL,temp0
	loop1:
		ld temp2,-Y
		ld temp1,-Y
		cp temp2,temp1
		brlo replace
		inc YL 
		dec counter1
		brne loop1
	dec counter0
	brne loop0

 ldi r30,0
 ldi r31,0
 ldi r19,$00
 ldi r16,$00

 ldi ZH,$10
 ldi ZL,$1F
 inc YL


 sram_to_eemprom:

  sbic EECR,EEWE 
  rjmp sram_to_eemprom
  out EEARH,ZH
  out EEARL,ZL
  ld temp1,-Y
  out EEDR,temp1
  st -Z,temp1
  sbi EECR,EEMWE 
  sbi EECR,EEWE
  inc counter0
  cpi counter0,$10 
 brne sram_to_eemprom

wait:rjmp wait

  replace:
	st Y+,temp2
	st Y,temp1
	dec counter1
	brne loop1
	dec counter0
	rjmp loop0	


 
