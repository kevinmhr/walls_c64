!cpu 6510
!to "walls.prg",cbm
;designed by keyvan mehrbakhsh 2023
;keyvanmehrbakhsh@gmail.com
;its free to alter 
 
lastkey=$21
position = $20
 
attdec   =$31
susrel   =$32
volume   =$33
hifreq   =$34
lofreq   =$35
wavefm   =$36
whiteblock =$37
appleblock =$38
positionh =$49
positionl =$46
character =$4006
character1 =$4007
character2 =$4008
character3 =$4009
fourty = $6387
bgchar =$022
bgcolor =$024
charactertemporary = $026
charactercolour = $27
wallschar = $6677
wallscolour = $89
objectschar2 = $6689
objectschar3 = $6643
objectschar4 = $6699
bulletchar =$6634
oppbulletchar =$6635
opposebulletposl = $6249
opposebulletposl2 = $6252
opposebulletposh = $6250
opposebulletposh2 = $6253
opposebulletcolor = $47
wallspositionh = $29
wallspositionl = $30
bulletpositionh = $6848
bulletpositionl = $6248
scoreones =$40ff
scoretens =$40fe
voicefreq = $31
scorehunds = $40fd
scorethous = $40fa 
bulletcolor = $2055
shuf = $6c00
increment = $6896
currentcell = $03
scrollvalue = $37
scrolltrigger = $38
positionlbuffer = $39
positionlbuffer2 = $40
zp = $71
zp2 = $72
zp3 = $73
zp4 = $74
reversetrigger = $42
joysttrig = $43
bullettrigger = $44
joystktr= $45
 
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820
              

lda $01    
and #251    
sta $01    
 
copyoriginalchartonewlocation
 
sei
lda $d000,x
sta $2000,x
lda $d100,x
sta $2100,x
lda $d200,x
sta $2200,x
lda $d300,x
sta $2300,x
lda $d400,x
sta $2400,x
lda $d500,x
sta $2500,x
lda $d600,x
sta $2600,x
lda $d700,x
sta $2700,x
         

 
 

 
inx
 
 
beq stopcpy
jmp copyoriginalchartonewlocation
 
stopcpy  
         lda $01
         ora #4
         sta $01

      
lda circle1 
sta $2260 
lda circle2 
sta $2261 
lda circle3 
sta $2262 
lda circle4 
sta $2263  
lda circle5 
sta $2264 
lda circle6 
sta $2265  
lda circle7 
sta $2266 
 lda circle8 
sta $2267        

copyshipcharacter
ldy #0
copyshipcharacterloop

lda theship,y
sta $2268,y
lda theship2,y
sta $2270,y
lda theship3,y
sta $2278,y
lda theship4,y
sta $2280,y
 

 
iny
cpy #8
bne copyshipcharacterloop
 

init 
lda #26
sta positionl
ldx #0
ldy #0
  
lda #128
sta oppbulletchar
lda #0
 
sta $d021
lda #40
sta reversetrigger
lda #1
sta wallsbuffer
sta shuf
lda #$04
sta positionh
lda #87
sta character
lda #79
sta character1
lda #78
sta character2
lda #80
sta character3
lda #0
sta $d020
 
 lda #2
 sta opposebulletcolor
lda #03
sta charactercolour
lda #0
sta joysttrig
sta bullettrigger
lda #0
sta scoreones
sta scoretens 
sta scorehunds
sta scorethous
lda #$18
sta $d018
 lda #01
 sta wallspositionh
lda positionl
 sta bulletpositionl
 
  lda positionh
 sta bulletpositionh
     lda #$44
 sta opposebulletposl
  lda #$01
 sta opposebulletposh
     lda #$44
 sta opposebulletposl2
  lda #$01
 sta opposebulletposh2
 
 lda #76
sta bgchar 
lda #2
sta bgcolor 
lda #123
sta wallschar
lda #82
sta objectschar2
lda #84
sta objectschar3
lda #83
sta objectschar4
lda #85
sta bulletchar 
lda #6
sta bulletcolor
lda #2
sta wallscolour
ldx #0
 
startscreen

jsr cls
ldy #0

startscreenloop


lda startuptext,y
 
iny
sta $0550,y
lda #3
sta $d950,y
cpy #$4
bne startscreenloop 
ldy #0
startscreenloop2 

lda startuptext2,y
iny
sta $0750,y
lda #3
sta $db50,y
cpy #$16
bne startscreenloop2   
lda $dc00
cmp #$6f
bne startscreen
cmp #$6f
beq copyboxcharacter
rts

copyboxcharacter 
ldy #0
copyboxcharacterloop
lda bulletchardata,y
sta $22a8,y

lda thebox,y
sta $2288,y
lda thebox1,y
sta $2290,y
lda thebox2,y
sta $2298,y
lda thebox3,y
sta $22a0,y
lda bulletchardata,y
sta $22a8,y
lda oppbulletchardata,y
sta $22b0,y
lda sidebulletchardata,y
sta $22b8,y
iny
cpy #8
 
bne copyboxcharacterloop
copybulletcharacter 
ldy #0
copybulletcharacterloop





iny
 
bne copybulletcharacterloop

loadwalls
          
 
ldx #0  
 ldy #0
loadwallsloop  
 
 
lda wallpix,x
 
 
 sta wallsbuffer,x
 
 lda wallpix2,x
  sta wallsbuffer2,x
 
lda wallpix3,x
   sta wallsbuffer3,x
 
lda wallpix4,x
    sta wallsbuffer4,x
    
 inx


 
cpx #255
 bne loadwallsloop
ldy #0

 
inc increment
 

mainloop
ldx #0
  ldy #0
 
jsr jump
 
lda #1
sta joystktr 


 
 ldx #$0
 
   ldy #0
jsr scrolling
 
  
  jsr printscore
   ldy #0
 

 


 ldx #0
ldy #$0
 

 
  jsr displaywalls
 jsr display


 
 jsr displayoppbullet2
wastetime

 
 


inc opposebulletcolor



 
 
 jsr dojoy
jsr movejoy


jmp mainloop

rts
bulletchars 
 
ldx oppbulletchar

cpx #255

beq bulletcharreset
ldx opposebulletcolor
cpx #0
;beq bulletcolorreset


rts
bulletcharreset
lda #200
sta oppbulletchar
rts
bulletcolorreset
lda #3
sta opposebulletcolor
rts

  
 
 
 
 
scrolling


lda scrolltrigger
cmp #0
beq somelinedown
lda scrollvalue


adc #26

sta scrollvalue
somelinedown

lda scrollvalue
sbc positionlbuffer
sta scrollvalue
rts

cls
 
 

 

 
 rts
 

 
 
 

checkscoreones

 lda scoreones
 cmp #0
 beq loadwallsbrid
 
 
rts
loadwallsbrid
jsr loadwalls
rts
storekey 
 

  
    
 
rts
 
 


reloadposition

lda positionh
sta bulletpositionh
 
rts

decrbulletpositionh


lda bulletpositionh
cmp #0
beq putbulletback

dec bulletpositionh
 

 
rts
putbulletback
lda #0
sta bullettrigger
lda positionl
sta bulletpositionl
rts 
displaybullet
lda #1
sta bullettrigger
displaybulletloop
 
ldx bulletpositionl
sec
txa
sbc #40

  tax
stx bulletpositionl
  bcc decrbulletpositionh
 stx bulletpositionl
 


 ldx bulletpositionl
   
lda bulletpositionh
cmp #$01
beq displaybulletpg1
cmp #$02
beq displaybulletpg2
cmp #$03
beq displaybulletpg3 
cmp #$04
beq displaybulletpg4

 
 
 
returntomain

 
rts

jumptonotascore
jsr notascore
rts
displaybulletpg1

lda bulletchar
sta $0400,x
; sta $0401,x
lda bulletcolor
sta $d800,x
 ;sta $d801,x
 


rts
displaybulletpg2
 
lda bulletchar
sta $0500,x
;sta $0501,x
lda bulletcolor
sta $d900,x
;sta $d901,x
 
rts
displaybulletpg3
 
 
 
lda bulletchar

sta $0600,x
; sta $0601,x
lda bulletcolor
sta $da00,x
 ;sta $da01,x
  
 rts


displaybulletpg4
 

lda bulletchar
sta $0700,x
 
; sta $0701,x
lda bulletcolor
sta $db00,x
; sta $db01,x
 
 rts
incroppbulletpositionh
 
 


lda opposebulletposh
cmp #5
beq resetopposebulletposh
inc opposebulletposh
 
rts
resetopposebulletposh 
 
 
lda opposebulletposl2
sta opposebulletposl
lda wallspositionh
sta opposebulletposh
rts
 
 
  
 

 
displayoppbullet
 

displayoppbulletloop
clc
inx
iny
 
 

ldx opposebulletposl
 txa
adc #40
 
tax
 
 stx opposebulletposl
  bcs incroppbulletpositionh
 
 stx opposebulletposl
 
 
oppbulllab


    ldx opposebulletposl
lda opposebulletposh
cmp #$01
beq displayoppbulletpg1
cmp #$02
beq displayoppbulletpg2
cmp #$03
beq displayoppbulletpg3 
cmp #$04
beq displayoppbulletpg4

 
 
rts

displayoppbulletloopbridge
jsr displayoppbulletloop
rts

displayoppbulletpg1

lda #86
sta $0400,x
 
lda opposebulletcolor
sta $d800,x
 
 
 

rts
displayoppbulletpg2
 
lda #86
sta $0500,x
 
lda opposebulletcolor
sta $d900,x
 
 
rts
displayoppbulletpg3
 
 
 
lda #86

sta $0600,x
 
lda opposebulletcolor
sta $da00,x
 
  
 rts


displayoppbulletpg4
 

lda #86
sta $0700,x
 
 
lda opposebulletcolor
sta $db00,x
 
 
 rts

bullettobullet

lda opposebulletposl
cmp bulletpositionl

beq bullettobulleth
rts
bullettobulleth
lda opposebulletposh
cmp bulletpositionh
lda opposebulletposh
;beq score
rts



flightscollision
lda opposebulletposl2

cmp positionl
beq checkhiflight
adc #1

cmp positionl
beq checkhiflight
sbc #1

cmp positionl
beq checkhiflight
rts
checkhiflight
lda opposebulletposh2
cmp positionh
beq addscorejmp

rts
addscorejmp
jsr addscore
rts

bullettoboxcollision2
 
lda wallsbuffer,y
cmp positionl
;beq safearea
adc #1
cmp positionl
;beq safearea
sbc #1
cmp positionl
;beq safearea
lda wallsbuffer,y
cmp #255
;beq safearea
cmp #0
;beq safearea
cmp bulletpositionl
beq checkhigh
adc #1
cmp bulletpositionl
beq checkhigh
sbc #1
cmp bulletpositionl
beq checkhigh
sbc #2
cmp bulletpositionl
beq checkhigh
adc #2
cmp bulletpositionl
beq checkhigh
rts
checkhigh


lda bulletpositionh
cmp wallspositionh
beq score
 
rts


 

boxexp
ldy #0

boxexploop

 
lda thejack,y
sta $2288,y
lda thejack1,y
sta $2290,y
lda thejack2,y
sta $2298,y
lda thejack3,y
sta $22a0,y

iny
cpy #8
bne boxexploop
 
rts
score
lda bulletpositionh
cmp #1
beq score2
rts
score2

inc opposebulletposl

 
lda #0 
sta wallsbuffer,y
lda positionl
sta bulletpositionl
 
jsr addscore
lda scoretens
 adc scoreones
cmp #2 
beq butterflyload
cmp #4
beq boxexp
cmp #6
beq butterflyload
cmp #8
beq boxexp
  lda scorehunds
 cmp #1
 beq butterflyload
 



rts 
butterflyload
ldy #0
                
butterflyloadloop
lda thebuttfly1,y
sta $2288,y
lda thebuttfly2,y
sta $2290,y
lda thebuttfly3,y
sta $2298,y
lda thebuttfly4,y
sta $22a0,y 
iny
cpy #8
bne butterflyloadloop
 
rts

 


 

showgameover 

jsr expnoz2
showgameover2 
jsr smiley
jsr smiley2
jsr drawcircle
jsr lips
ldy #0
showgameoverloop

 
lda gameovertex,y
 


sta $0459,y
lda #3
sta $d859,y
iny
cpy #$17
bne showgameoverloop
 
lda $dc00
cmp #$6f
bne showgameover2
lda $dc00
cmp #$6f
beq reset
 
jmp mainloop
rts
reset 

 
jsr init
rts


collision
 

lda opposebulletposl
sbc #1  
cmp positionl
beq forward
lda opposebulletposl
 
cmp positionl
beq forward

lda opposebulletposl2
sbc #1
cmp positionl
beq forward2
 
lda opposebulletposl2
 
cmp positionl
beq forward2
rts 
forward 
lda opposebulletposh
cmp positionh
beq showgameover
rts
forward2

lda opposebulletposh2
cmp positionh
beq showgameover
rts 
 
 
collisionforship

iny
 
inx

lda wallpix,x

adc scrollvalue
cmp positionl

beq soshipcollisionoccured 

 cpy #255
bne collisionforship
rts
soshipcollisionoccured

lda #$0
sta scrolltrigger
sta positionlbuffer
 

rts


 


  
scorecorrection
lda scoreones
cmp #0 
beq zeroscoreone
rts
zeroscoreone
lda #0 
sta scoreones
rts
 
 
zeroscore
lda #0 
sta scoreones
lda #0
sta scoretens
rts
 
backtostart
jsr loadwalls
rts
 
addscore		
                
                jsr movewalls
           inc oppbulletchar
           inc opposebulletcolor
        inc wallscolour
            inc bgcolor
              jsr bulletchars

                 clc
			    lda #0
			    ldx #0
			    ldy #0
				jsr lazbeep1
				inc scoreones
			 
               
			 
				lda scoreones
			 
				sec
				sbc #10
			 
				cmp #$ 
				beq addtens
			    
           
        
			 
				rts

addtens			 
              
            
          
               inc scoretens
			
				lda #00
				sta scoreones
			   
			   lda scoretens
			    sec
				sbc #10
			    cmp #$
			    beq addhunds
				 
				rts 
addhunds        inc scorehunds
                lda #00
				sta scoreones
				lda #00
				sta scoretens
				lda scorehunds
			    sec
				sbc #10
			    cmp #$
			    beq addthous
			 
				rts 

				rts
addthous        inc scorethous
                lda #00
				sta scoreones
				lda #00
				sta scoretens
			    lda #00
				sta scorehunds
			 
				rts				
printscore		 
				
			  
				clc
				lda scoreones
				adc #$30
				
				sta $07e3
				lda #1
				sta $dbe3
				lda scoretens
				adc #$30
				sta $07e2
			lda #2
				sta $dbe2
				lda scorehunds
				adc #$30
				sta $07e1
			lda #3
				sta $dbe1
				lda scorethous
				adc #$30
				sta $07e0
				lda #4
				sta $dbe0	
				rts
 
somenum
         !byte     0,0,0,0,0,0,0,0,0,0 
abitmove   !byte 0,1,2,3,2,1,0
startuptext !scr "vois"
startuptext2   !scr "keyvan mehrbakhsh 2023"
gameovertex

          !scr " you are hit press fire " 
;objecbuffer
   ;      !byte     0,0,0,0,0,0,0,0,0,0 
circle1
 !byte %1111111
circle2 
 !byte %1100011
circle3 
 !byte %1010101
circle4 
 !byte %1001001
circle5 
 !byte %1001001
circle6 
 !byte %1010101
circle7 
 !byte %1100011
circle8 
 !byte %1111111
 
 
somenum2
!byte 15,20,35,40,55,60,75,80,95,100,115,120,135,140,155,160,175,180,195,200,215,220,235,240
 
 
wallsbuffer !byte  32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
wallsbuffer2 !byte  32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
wallsbuffer3 !byte  32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
wallsbuffer4 !byte  32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76 
 
 
wallpix !byte  32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
wallpix2 !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
wallpix3 !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
wallpix4 !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
diamonds !byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,76,76,76,32,32,32,32,32,32,32,32,32,32,32,76,76,76,76,76,76,76
theship   !byte   %00000001
          !byte   %00000001
          !byte   %00110001
          !byte   %00110011
          !byte   %00111101
          !byte   %00010111
          !byte   %00100001
          !byte   %00011111
          
theship2              
           !byte   %00000010
           !byte   %00000101
           !byte   %00000011
           !byte   %00111111
           !byte   %00100111
           !byte   %01000000
           !byte   %01000000
           !byte   %01111111
           
theship3              
            !byte  %10000000
            !byte  %10000000
            !byte  %10001100
            !byte  %11001100
            !byte  %10111100
            !byte  %11101000
            !byte  %10000100
            !byte  %11111000
theship4              
             
            !byte  %01000000
            !byte  %10100000
            !byte  %11000000
            !byte  %11111100
            !byte  %11100100
            !byte  %00000010
            !byte  %00000010
            !byte  %11111110
            
            
thebox   !byte    %11111111
          !byte   %11000000
          !byte   %10100000
          !byte   %10010000
          !byte   %10001111
          !byte   %10001000
          !byte   %10001001
          !byte   %10001011
          
thebox1              
           !byte   %00000000
           !byte   %10000000
           !byte   %01000000
           !byte   %00100000
           !byte   %11110000
           !byte   %00010000
           !byte   %10010000
           !byte   %11010000
           
thebox2              
           !byte   %11010000
           !byte   %10010000
           !byte   %00010000
           !byte   %11110000
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000
thebox3              
             
           !byte   %01001011
           !byte   %00101001
           !byte   %00011000
           !byte   %00001111
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000  

           
thebuttfly1 !byte  %11110000
          !byte   %01111110
          !byte   %00110111
          !byte   %00010111
          !byte   %00001111
          !byte   %00000011
          !byte   %00000111
          !byte   %00011111
          
thebuttfly2             
           !byte   %00001111
           !byte   %01111110
           !byte   %11101100
           !byte   %11101000
           !byte   %11110000
           !byte   %11000000
           !byte   %11100000
           !byte   %11111000
           
thebuttfly3               
           !byte   %11110000
           !byte   %11111000
           !byte   %01111000
           !byte   %00010000
           !byte   %00001000
           !byte   %00101000
           !byte   %00010000
           !byte   %00000000
thebuttfly4               
             
           !byte   %00001111
           !byte   %00011111
           !byte   %00011110
           !byte   %00001000
           !byte   %00010000
           !byte   %00010100
           !byte   %00001000
           !byte   %00000000  
            
              
thejack  !byte    %00000000
          !byte   %00000000
          !byte   %00000111
          !byte   %00011111
          !byte   %00111000
          !byte   %11100000
          !byte   %11100110
          !byte   %11100110
          
thejack1              
          !byte   %00000000
          !byte   %00000000
          !byte   %11100000
          !byte   %11111000
          !byte   %00011100
          !byte   %00000111
          !byte   %01100111
          !byte   %01100111

thejack2              
             
          !byte   %00000111
          !byte   %11100111
          !byte   %11001110
          !byte   %00011100
          !byte   %11111000
          !byte   %11100000
          !byte   %00000000
          !byte   %00000000    
thejack3              
          !byte   %11100000
          !byte   %11100111
          !byte   %01110011
          !byte   %00111000
          !byte   %00011111
          !byte   %00000111
          !byte   %00000000
          !byte   %00000000
          
          
bulletchardata              
          !byte   %00000000
          !byte   %00011000
          !byte   %00011000
          !byte   %00011000
          !byte   %00011000
          !byte   %00011000
          !byte   %00111100
          !byte   %00000000
          
oppbulletchardata              
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          
sidebulletchardata              
          !byte   %00011000
          !byte   %00011000
          !byte   %00111100
          !byte   %11111111
          !byte   %00111100
          !byte   %00011000
          !byte   %00000000
          !byte   %00000000          


  !source "two.asm"    
    !source "three.asm"  
 !source "sounds.asm"

