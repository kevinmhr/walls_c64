


fire	
 lda bullettrigger
 cmp #0

 ;beq fire2 
 rts
fire2
 
lda positionl
sta bulletpositionl

 lda positionh
sta bulletpositionh
 
 
  jsr lazbeep1 
 


 
notascore
 

lda #$7f
sta lastkey
 

rts
 

dojoy
lda $dc00
sta lastkey
rts
ballmovement
 
movedown
 clc
lda positionl
adc movementno
 
 sta positionl
bcs incresehighbytejmp
  sta positionl
rts
 
 
ballmovement2
 
moveup
sec
lda positionl
sbc movementno2
 
 
 sta positionl
bcc decreasehibytejmp
 
  sta positionl


rts
ballmovement3
 clc
moveright
clc
lda positionl
adc movementno3
   sta positionl
  bcs incresehighbytejmp
  sta positionl
rts
ballmovement4
sec 
moveleft
sec
lda positionl
sbc movementno4
  sta positionl
 bcc decreasehibytejmp
sta positionl


rts
incresehighbytejmp
jsr incresehighbyte
rts
decreasehibytejmp
jsr decreasehibyte
rts

 


jmptoup
 jsr up
lda $d012
cmp #10
beq donejump
jsr  up

donejump

rts
 
jmpdecreasehibyte
jsr decreasehibyte
rts

movejoy 
                
                 jsr collisionhi
         
 
  jsr collisioncomplexcheck
    jsr collisioncomplexcheck2
    jsr collisioncomplexcheck3
    jsr collisioncomplexcheck4  
  jsr collisioncomplexcheck5
    jsr collisioncomplexcheck6
                lda lastkey
              
                cmp #$7b   
				beq left 
				cmp #$7e   
				beq jsrup
				cmp #$77    
				beq right
				cmp #$7d   
				beq down
				cmp #$6f
                beq jmptoup
              
				rts
				
 

rts
jsrup
jsr up
rts
left 
  
lda joystktl
cmp #28
beq soleft
rts
soleft
 jsr noright22
     
    rts
counterrecount
jsr decreasehibyte
lda #1
sta positionl
 
rts
right 
lda joystktr
cmp #28
beq soright
rts
soright
 jsr noleft22
    rts
recount
jsr incresehighbyte
lda #0
sta positionl
 
rts

down
lda joystktd
cmp #28
beq sodown
 
rts
decreasehibyte   
 

lda positionh
cmp #0
beq inchibyteagain
dec positionh
out
rts
sodown
 jsr noup22

lda #216
 
 
   jsr expnoz
   lda positionl
 
    clc
    adc #40
    sta positionl
    sta positionlbuffer
    
    bcs incresehighbyte
 
    lda #01
 sta scrolltrigger
 
 
 
  
    rts
up
lda joystktu
cmp #26
bne soup
rts
soup 
jsr nodown22
rts

jsrshowgameover
;jsr showgameover
rts






incresehighbyte   
clc


inc positionh

lda positionh
cmp #5
beq dechibyteagain
 
 
rts
dechibyteagain
 jsr movewalls
lda #01
sta positionh
increaselowbyte
 lda positionl
adc #23
 sta positionl
 


rts


inchibyteagain
 
lda #04
sta positionh
decreaselowbyte

lda positionl
sbc #20
 sta positionl
 
rts
 
changeblockcharacter
ldy #0
inc increment2
ldx increment2
changeblockcharacterlp
txa
ror

 
sta $2260 ,y
iny
cpy #8
bne changeblockcharacterlp

rts

