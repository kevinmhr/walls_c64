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
 
 

lda #32
sta $04ff
sta $05ff
sta $06ff
sta $07ff
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
 
jsr flightscollision
 
 


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

lda oppbulletchar
sta $0400,x
 
lda opposebulletcolor
sta $d800,x
 
 


rts
displayoppbullet2pg2
 
lda oppbulletchar
sta $0500,x
 
lda opposebulletcolor
sta $d900,x
 
 
rts
displayoppbullet2pg3
 
 
 
lda oppbulletchar

sta $0600,x
 
lda opposebulletcolor
sta $da00,x
 
  
 rts


displayoppbullet2pg4
 

lda oppbulletchar
sta $0700,x
 
 
lda opposebulletcolor
sta $db00,x
 
 
 rts
 
movewalls
ldy increment
 ldx #40
 
 
backtowherewewere 
 iny
 lda wallpix,y
 
 sta wallsbuffer,y
 
 lda wallsbuffer,y
 iny
 sta wallsbuffer,x
  
 lda wallpix2,y
 
 sta wallsbuffer2,y
 
 lda wallsbuffer2,y
iny
 sta wallsbuffer2,x
 
  
 lda wallpix3,y
 
 sta wallsbuffer3,y
 
 lda wallsbuffer3,y
 iny
 sta wallsbuffer3,x
  
 lda wallpix4,y
 
 sta wallsbuffer4,y
 
 lda wallsbuffer4,y
iny
 sta wallsbuffer4,x
 
 
 
 
 iny
 

 inx
 
 cpx #255
bne backtowherewewere
 

rts


displaywalls
ldx #0
ldy #0
 
ldx #0
ldy #0
displaywallslp

inc colorshadow
 
lda #0
sta lookoutbit
 
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
 
maskingnoncollidablebits
ldx #0
maskingnoncollidablebitslp
lda #32
sta wallsbuffer,x
sta wallsbuffer2,x
sta wallsbuffer3,x
sta wallsbuffer4,x
inx
cpx #60
bne maskingnoncollidablebitslp
ldx #210
maskingnoncollidablebitslp2
lda #32
sta wallsbuffer,x
sta wallsbuffer2,x
sta wallsbuffer3,x
sta wallsbuffer4,x
inx
cpx #255
bne maskingnoncollidablebitslp2






rts


showingbits
ldy #0
ldx #0
showingbitslp
lda #34
sta wallsbuffer,x
lda #35
sta wallsbuffer2,x
lda #36
sta wallsbuffer3,x
lda #37
sta wallsbuffer4,x
inx
cpx #255
bne showingbitslp
rts

 
displaywallslpjmp
jsr displaywallslp
rts
collisionhi
 
lda #28
sta joystktr 
lda #28
sta joystktd 
lda #28
sta joystktl
 lda #28
sta joystktu

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
clc
lda positionl
sbc #39
tax
 lda colorshadow
sta $d900,x
lda wallsbuffer2,x
cmp #76
beq jsnoup2
recheckdown2
clc
lda positionl
adc #40
tax
lda colorshadow
sta $d900,x
lda wallsbuffer2,x
cmp #32
beq jsnodown

recheckleft2
clc
lda positionl
sbc #0
tax
lda colorshadow
sta $d900,x
lda wallsbuffer2,x
cmp #76
beq jsnoleft
recheckright2
clc
lda positionl
adc #1
adc lookoutbit
tax
lda colorshadow
sta $d900,x
lda wallsbuffer2,x
cmp #76
beq jsnoright


rts 

jsnoup2
jsr noup2
rts
collidepage4
clc
lda positionl
sbc #39
tax
 lda colorshadow
sta $db00,x
lda wallsbuffer4,x
cmp #76
beq jsnoup
recheckdown4

clc
lda positionl
adc #40
tax
 lda colorshadow
sta $db00,x
lda wallsbuffer4,x
cmp #32
beq jsnodown
recheckleft4
clc
lda positionl
sbc #0
tax
 lda colorshadow
sta $db00,x
lda wallsbuffer4,x
cmp #76
beq jsnoleft
recheckright4
clc
lda positionl

adc #1
adc lookoutbit
tax
lda wallsbuffer4,x
cmp #76
beq jsnoright


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
clc
lda positionl
sbc #39
tax
  lda colorshadow
sta $da00,x
lda wallsbuffer3,x
 

cmp #76
beq jsnoup
recheckdown3
clc
lda positionl
adc #40
tax
   lda colorshadow
sta $da00,x
lda wallsbuffer3,x
 

cmp #32
beq jsnodown
recheckleft3
clc
lda positionl
sbc #0
tax
   lda colorshadow
sta $da00,x
lda wallsbuffer3,x
 

cmp #76
beq jsnoleft
recheckright3
clc
lda positionl
adc #1
adc lookoutbit
tax
   lda colorshadow
sta $da00,x
lda wallsbuffer3,x
 

cmp #76
beq jsnoright


rts
collidepage1
clc
lda positionl
sbc #39
tax
   lda colorshadow
sta $d800,x
lda wallsbuffer,x

cmp #76
beq jsnoup

recheckdown1
clc
lda positionl
adc #40
tax
   lda colorshadow
sta $d800,x
lda wallsbuffer,x
cmp #32
beq jsnodown
recheckleft1
clc
lda positionl
sbc #0
tax
   lda colorshadow
sta $d800,x
lda wallsbuffer,x
cmp #76
beq jsnoleft2
recheckright1
clc
lda positionl
adc #1
adc lookoutbit
tax
   lda colorshadow
sta $d800,x
lda wallsbuffer,x
cmp #76
beq jsnoright2
 
rts
checkleftagain1

jsnoleft2
jsr noleft2
rts
jsnoright2
jsr noright2
rts
collisioncomplexcheck6
lda joystktu
cmp #26
beq jmpdothetrick3
rts
collisioncomplexcheck5
lda joystktl
cmp #23
beq  dothetrick2 
rts
collisioncomplexcheck4
lda joystktd
cmp #5
beq jmpdothetrick
rts
checkleft3
lda joystktl
cmp #28
beq checkright3
rts
checkright3
lda joystktr
cmp #28
beq checkup3
rts
checkup3
lda joystktu
cmp #28
beq jmpdothetrick 
rts
jmpdothetrick 
jsr dothetrick
rts
collisioncomplexcheck3
lda joystktd
cmp #5
beq checkleft2
rts
 
collisioncomplexcheck2
lda joystktu
cmp #26
beq checkright

rts
checkright
lda joystktr
cmp #28
beq checkleft
 

rts
checkleft
lda joystktd
cmp #28
beq jmpdothetrick3

lda joystktl
cmp #23
beq dothetrick

rts
jmpdothetrick3
jsr dothetrick3
rts
checkleft2

lda joystktu
cmp #26
beq dothetrick2
lda joystktl
cmp #23
beq dothetrick2



rts
checkdown2
lda joystktd
cmp #28
beq dothetrick3
rts

lda joystktd
cmp #28
beq dothetrick

collisioncomplexcheck
lda joystktu
cmp #26
beq checkdown

lda joystktl
cmp #23
beq checkdown
rts
checkdown

lda joystktd
cmp #28
beq dothetrick

rts

dothetrick2
 

lda #0
sta lookoutbit
lda positionh
cmp #1
beq jmprecheckright1
lda positionh
cmp #2
beq jmprecheckright2
lda positionh
cmp #3
beq jmprecheckright3
lda positionh
cmp #4
beq jmprecheckright4
rts 
jmprecheckright1
jsr recheckright1
rts
jmprecheckright2
jsr recheckright2
rts
jmprecheckright4
jsr recheckright4
rts
jmprecheckright3
jsr recheckright3
rts

dothetrick
 

lda #0
sta lookoutbit
lda positionh
cmp #1
beq jmprecheckleft1
lda positionh
cmp #2
beq jmprecheckleft2
lda positionh
cmp #3
beq jmprecheckleft3
lda positionh
cmp #4
beq jmprecheckleft4
rts 
jmprecheckleft1
jsr recheckleft1
rts
jmprecheckleft2
jsr recheckleft2
rts
jmprecheckleft4
jsr recheckleft4
rts
jmprecheckleft3
jsr recheckleft3
rts

dothetrick3
 

lda #0
sta lookoutbit
lda positionh
cmp #1
beq jmprecheckdown1
lda positionh
cmp #2
beq jmprecheckdown2
lda positionh
cmp #3
beq jmprecheckdown3
lda positionh
cmp #4
beq jmprecheckdown4
rts 
jmprecheckdown1
jsr recheckdown1
rts
jmprecheckdown2
jsr recheckdown2
rts
jmprecheckdown4
jsr recheckdown4
rts
jmprecheckdown3
jsr recheckdown3
rts



nodown2
lda #5
sta joystktd

rts 

noright2
lda #48
sta joystktr
 
 
rts
 
noleft2
lda #23
sta joystktl
 
 
rts
 
noup2
lda #26
sta joystktu
lda #0
sta scrollvalue
rts 

correctwalls
ldx #0
correctwallslp
lda #32
sta wallsbuffer,x
sta wallsbuffer2,x
sta wallsbuffer3,x
sta wallsbuffer4,x
inx
cpx #40
bne correctwallslp

rts

 



