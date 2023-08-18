


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
 


jmptoup
jsr up
jsr up
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
				beq jmptoup
				cmp #$77    
				beq right
				cmp #$7d   
				beq down
				cmp #$6f
                beq jmptoup
              
				rts
				
 

rts
left 
  
lda joystktl
cmp #28
beq soleft
rts
soleft
lda #1
sta scrollvalue
 jsr expnoz
   
    lda positionl
    sec
    sbc #01
    sta positionl
    sta positionlbuffer
  bcc counterrecount
   lda #01
 sta scrolltrigger
   
     
    rts
counterrecount
jsr decreasehibyte
lda #255
sta positionl
 
rts
right 
lda joystktr
cmp #28
beq soright
rts
soright
lda #254
sta scrollvalue
jsr expnoz
 
 lda positionl
    clc
    adc #01
    sta positionl
  sta positionlbuffer
  bcs recount
    
      lda #01
 sta scrolltrigger
   
    rts
recount
jsr incresehighbyte
lda #0
sta positionl
 
rts

down
lda joystktd
cmp #28
bne sodown
 
rts
decreasehibyte   
 
dec positionh
lda positionh
cmp #0
beq inchibyteagain
out
rts
sodown
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

lda #40
sta scrollvalue
 jsr expnoz
 
  lda positionl
    sec
    sbc #40
    
    sta positionl
 sta positionlbuffer
   
 
 bcc decreasehibyte
 
    lda #01
 sta scrolltrigger
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
sbc #24
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

