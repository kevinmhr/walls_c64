smiley 
ldx #0
smileyloop
inx
      lda #170
      sta $059d,x
      sta $05a5,x
      lda #2
      sta $d99d,x
      sta $d9a5,x
     lda #126
     sta $061b
      sta $0643
      sta $066b
       lda #2
       sta $da1b
      sta $da43
     ;sta $da6b
      
    
      lda #128
       sta $061d
       sta $0619
        sta $da1d
       sta $da19
cpx #4

bne smileyloop
rts
smiley2
ldx #0
smileyloop2
inx
     lda #171
     sta $05ee,x
      sta $05f6,x
         lda #3
        sta $d9ee,x
      sta $d9f6,x
    lda #127
     sta $05c4,x
      sta $05c9,x
      sta $05cc,x
      sta $05d1,x
      lda #2
      sta $d9c4,x
      sta $d9c9,x
      sta $d9cc,x
      sta $d9d1,x

cpx #2

bne smileyloop
rts
circle !byte 0,2,40,81,122,162,178,138,99,59,19

drawcircle
ldx #0
ldy #0
drawcircleloop

ldx circle,y
iny
      lda #126
      sta $059a,x
      sta $d99a,x
    sta $054a,x
      sta $d94a,x
      cpy #11
      bne drawcircleloop
     rts

lips 
ldx #0
lipsloop
inx
lda #128
sta $06b8,x
sta $06e0,x
cpx #5
bne lipsloop
rts
face 
jsr smiley
jsr smiley2
jsr drawcircle
jsr lips
rts
display 
ldx #$0
ldy #0

displayloop
clc
lda positionh
ldx positionl
cpx #255
beq bypass4
cmp #$01
beq displaypageone
cmp #$02
beq displaypagetwo 
cmp #$03
beq displaypagethree  
cmp #$04
beq displaypagefour  
bypass4
    
rts 
displaypageone

lda character 
sta $0400,x
 
lda charactercolour
sta $d800,x
 
rts
displaypagetwo

lda character 
sta $0500,x
 
lda charactercolour
sta $d900,x
 
 
rts
displaypagefour
 

lda character
sta $0700,x
 
lda charactercolour
sta $db00,x
 
rts

displaypagethree
 
lda character
sta $0600,x
 
lda charactercolour
sta $da00,x 
 
 
rts

incroppbulletpositionh2
 
 


lda opposebulletposh2
cmp #4
beq resetopposebulletposh2
inc opposebulletposh2
 
rts
resetopposebulletposh2 

lda #1 
sta opposebulletposh2
rts
 


displayoppbullet2
 

displayoppbulletloop2
clc
inx
iny

 

ldx opposebulletposl2
 txa
adc #1
 eor #254

  tax
 
 stx opposebulletposl2
  bcs incroppbulletpositionh2
 
 stx opposebulletposl2
 
 
 


    ldx opposebulletposl2
lda opposebulletposh2
cmp #$01
beq displayoppbullet2pg1
cmp #$02
beq displayoppbullet2pg2
cmp #$03
beq displayoppbullet2pg3 
cmp #$04
beq displayoppbullet2pg4

  
 
rts
checkpositionh
lda positionh
cmp opposebulletposh2
beq gameoverbridge
rts
gameoverbridge
jsr showgameover
rts


displayoppbullet2pg1

lda #87
sta $0400,x
 
lda opposebulletcolor
sta $d800,x
 
 


rts
displayoppbullet2pg2
 
lda #87
sta $0500,x
 
lda opposebulletcolor
sta $d900,x
 
 
rts
displayoppbullet2pg3
 
 
 
lda #87

sta $0600,x
 
lda opposebulletcolor
sta $da00,x
 
  
 rts


displayoppbullet2pg4
 

lda #87
sta $0700,x
 
 
lda opposebulletcolor
sta $db00,x
 
 
 rts
 
 
