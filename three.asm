


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
jsr jump
 


 
notascore
 

lda #$7f
sta lastkey
 

rts
jump 

ldx #0
lda $dc00
cmp #$6f
beq sojump
jsr down
rts
sojump
ldx #0
jumplp
sec
 
lda positionl



sbc #40
sta positionl
bcc decreasehibyte
sta positionl
 



rts

dojoy
lda $dc00

sta lastkey
rts




movejoy 
                
                lda lastkey
              
                cmp #$7b   
				beq left 
				cmp #$7e   
				beq up
				cmp #$77    
				beq right
				cmp #$7d   
				beq down
               
				rts
				
 

left 
  
lda joystktr
cmp #23
bne soleft
rts
soleft
lda #1
sta scrollvalue
jsr addscore
   
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
cmp #48
bne soright
rts
soright
lda #254
sta scrollvalue

jsr addscore
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

lda joystktr
cmp #28
bne sodown
rts
decreasehibyte   
 
dec positionh
lda positionh
cmp #0
beq inchibyteagain
 
 
rts
sodown
lda #216
sta scrollvalue

jsr addscore
 
   
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
lda joystktr
cmp #26
bne soup
rts
soup 

lda #40
sta scrollvalue
jsr addscore
 
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