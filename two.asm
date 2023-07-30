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
ldy positionl
cpy #255
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
sta $0400,y
 
lda charactercolour
sta $d800,y
 
rts
displaypagetwo

lda character 
sta $0500,y
 
lda charactercolour
sta $d900,y
 
 
rts
displaypagefour
 

lda character
sta $0700,y
 
lda charactercolour
sta $db00,y
 
rts

displaypagethree
 
lda character
sta $0600,y
 
lda charactercolour
sta $da00,y
 
 
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
 
displaywalls
ldx #0
ldy #0
 
displaywallslp

jsr collisionhi 
backtowherewewere 
 
 lda wallsbuffer,y

 sty zp
 
sta $0400,y
 
lda wallscolour
sta $d800,y

 
 
 lda wallsbuffer2,y
sta zp2
 
 
sta $0500,y
 
lda wallscolour
sta $d900,y
 
 

 
 lda wallsbuffer3,y
 sta zp3
 
 
 
sta $0600,y
 
lda wallscolour
sta $da00,y
 

lda wallsbuffer4,y
sta zp4
 

 
sta $0700,y

lda wallscolour
sta $db00,y




 iny
cpy #255


bne displaywallslp


 
 rts
collisionhi
lda positionh
cmp #1
 beq collidepage1br
lda positionh
cmp #2
 beq collidepage2br
lda positionh
cmp #3
beq collidepage3br
lda positionh
cmp #4
 beq collidepage4br
rts
collidepage1br
 jmp collidepage1
rts
collidepage2br
 jmp collidepage2
rts
collidepage3br
jmp collidepage3
rts
collidepage4br
 jmp collidepage4
rts
 
collidepage2
lda positionl
sbc #1
tax
lda wallsbuffer2,x
cmp #76
beq jsnoleft
lda positionl
adc #1
tax
lda wallsbuffer2,x
cmp #76
beq jsnoright
lda positionl
sbc #39
tax
lda wallsbuffer2,x
cmp #76
beq jsnoup
lda positionl
adc #40
tax
lda wallsbuffer2,x
cmp #76
beq jsnodown
rts 
collidepage4
lda positionl
sbc #1
tax
lda wallsbuffer4,x
cmp #76
beq jsnoleft
lda positionl
adc #1
tax
lda wallsbuffer4,x
cmp #76
beq jsnoright
lda positionl
sbc #39
tax
lda wallsbuffer4,x
cmp #76
beq jsnoup
lda positionl
adc #40
tax
lda wallsbuffer4,x
cmp #76
beq jsnodown
rts
jsnoleft
jsr noleft2
rts
jsnoright
jsr noright2
rts
jsnoup
jsr noup2
rts
jsnodown
jsr nodown2
rts

collidepage3
lda positionl
sbc #1
tax
lda wallsbuffer3,x
cmp #76
beq jsnoleft
lda positionl
adc #1
tax
lda wallsbuffer3,x
cmp #76
beq jsnoright
lda positionl
sbc #39
tax
lda wallsbuffer3,x
cmp #76
beq jsnoup
lda positionl
adc #40
tax
lda wallsbuffer3,x
cmp #76
beq jsnodown
rts
collidepage1
lda positionl
sbc #1
tax
lda wallsbuffer,x
cmp #76
beq jsnoleft
lda positionl
adc #1
tax
lda wallsbuffer,x
cmp #76
beq jsnoright
lda positionl
sbc #39
tax
lda wallsbuffer,x
cmp #76
beq jsnoup
lda positionl
adc #40
tax
lda wallsbuffer,x
cmp #76
beq jsnodown
rts
 
 
nodown2
lda #28
sta joystktr
lda #0
sta scrollvalue
rts 

noright2
lda #48
sta joystktr
lda #0
sta scrollvalue
rts
 
noleft2
lda #23
sta joystktr
lda #0
sta scrollvalue
rts
 
noup2
lda #26
sta joystktr
lda #0
sta scrollvalue
rts 



 



