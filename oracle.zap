
	.SEGMENT "SECRET"


	.FUNCT	ORACLE-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	GRTR?	ORACLE-EXIT-NUMBER,4 \?CCL3
	RANDOM	5
	SUB	STACK,1 >ORACLE-EXIT-NUMBER
	CALL	QUEUE,I-AMULET,4
	RSTACK	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in an irregularly shaped chamber, hewn out of bedrock by untold ages of trickling waters. The walls are slimy, and shadows dance in the unlit crevices. A stream of slime drips sluggishly down an uneven tunnel which heads roughly upwards."
	CRLF	
	PRINTI	"   "
	CALL1	D-ORACLE
	RSTACK	

	.ENDSEG

	.SEGMENT "SECRET"


	.FUNCT	ORACLE-OBJECT-F,VARG,TAKER,RM
	ZERO?	VARG \FALSE
	EQUAL?	PRSA,V?TELL,V?PRAY,V?ASK-ABOUT \?CCL5
	EQUAL?	PRSO,ORACLE-OBJECT \?CCL5
	PRINTI	"The oracle stares at the far wall of the cave, impassive and unresponsive."
	ZERO?	ORACLE-USED \?CND8
	PRINTI	" It appears that the ancient claims of the oracle's amazing abilities were just wild fictions."
?CND8:	CRLF	
	CALL1	STOP
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?EXAMINE \?CCL11
	ICALL1	D-ORACLE
	FIRST?	ORACLE-OBJECT \?CCL14
	PRINTI	" Sitting in the mouth of the oracle is"
	CALL1	D-NOTHING
	RSTACK	
?CCL14:	CRLF	
	RTRUE	
?CCL11:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL16
	CALL	NOUN-USED?,ORACLE-OBJECT,W?MOUTH
	ZERO?	STACK /?CCL16
	IN?	PROTAGONIST,ORACLE-OBJECT /?CCL16
	PRINTR	"The wide-open mouth is larger than you!"
?CCL16:	EQUAL?	PRSA,V?THROW,V?PUT \?CCL21
	EQUAL?	PRSI,ORACLE-OBJECT \?CCL21
	PRINTI	"You "
	EQUAL?	PRSA,V?THROW \?CCL26
	PRINTI	"toss"
	JUMP	?CND24
?CCL26:	PRINTI	"place"
?CND24:	ICALL1	TPRINT-PRSO
	PRINTI	" into the mouth of the oracle"
	IN?	RUBY,DEPRESSION \?CCL29
	GET	ORACLE-TABLE,ORACLE-EXIT-NUMBER >RM
	MOVE	PRSO,RM
	PRINTI	", and it instantly vanishes!"
	CRLF	
	CALL	FIND-IN,RM,WHITEBIT >TAKER
	ZERO?	TAKER \?CCL31
	CALL	FIND-IN,RM,BLACKBIT >TAKER
	ZERO?	TAKER /?CND30
?CCL31:	MOVE	PRSO,TAKER
	EQUAL?	PRSO,PIGEON \?CND30
	ICALL2	MOVE-TO-PERCH,TAKER
?CND30:	CALL1	NOW-DARK?
	RSTACK	
?CCL29:	MOVE	PRSO,ORACLE-OBJECT
	PRINT	PERIOD-CR
	RTRUE	
?CCL21:	EQUAL?	PRSA,V?ENTER \FALSE
	ZERO?	LIT \?CCL40
	PRINT	TOO-DARK
	CRLF	
	RTRUE	
?CCL40:	IN?	BEDBUG,HERE \?CCL42
	ZERO?	TIME-STOPPED \?CCL42
	CALL2	DO-WALK,P?UP
	RSTACK	
?CCL42:	IN?	RUBY,DEPRESSION \FALSE
	ZERO?	ORACLE-USED /?CCL49
	PRINTC	68
	JUMP	?CND47
?CCL49:	ICALL	SPLIT-BY-PICTURE,TEXT-WINDOW-PIC-LOC,TRUE-VALUE
	SCREEN	S-TEXT
	CRLF	
	ICALL2	MARGINAL-PIC,TELEPORT-LETTER
	DIROUT	D-SCREEN-OFF
	PRINTC	68
	DIROUT	D-SCREEN-ON
?CND47:	PRINTI	"arkness envelopes you"
	ZERO?	ORACLE-USED \?CCL52
	PRINTI	" with a giant hand swathed in a glove of black velvet. You feel disembodied; there is no up and down. You are motionless in time and space. A moment drags out for a century -- or is it a century that has flown by in a moment? After an immeasurable time, you notice"
	JUMP	?CND50
?CCL52:	PRINTI	". You feel"
?CND50:	PRINTI	" a stabbing pain... swirling lights... dizziness"
	PRINT	ELLIPSIS
	ZERO?	BORDER-ON \?CND53
	ICALL2	INIT-STATUS-LINE,TRUE-VALUE
?CND53:	GET	ORACLE-TABLE,ORACLE-EXIT-NUMBER
	ICALL2	GOTO,STACK
	SET	'ORACLE-USED,TRUE-VALUE
	RETURN	ORACLE-USED


	.FUNCT	D-ORACLE
	IN?	PROTAGONIST,ORACLE-OBJECT \?CCL3
	PRINTI	"Surrounding you is"
	JUMP	?CND1
?CCL3:	PRINTI	"Before you sits"
?CND1:	PRINTI	" the legendary Oracle of Bargth. Shaped like an enormous serpent's head, its huge mouth hangs open in an expression of insatiable hunger; its four "
	IN?	RUBY,DEPRESSION \?CCL6
	PRINTI	"glowing"
	JUMP	?CND4
?CCL6:	PRINTI	"dark"
?CND4:	PRINTI	" eyes seem fixed upon you. In the center of the serpent's forehead is a"
	IN?	RUBY,DEPRESSION \?CCL9
	PRINTI	"n enormous ruby."
	RTRUE	
?CCL9:	PRINTI	" depression."
	RTRUE	


	.FUNCT	DEPRESSION-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The semi-spherical depression is a few inches across."
	IN?	RUBY,DEPRESSION \?CND4
	PRINTR	" A huge ruby rests in the depresssion."
?CND4:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL7
	EQUAL?	PRSO,RUBY \?CCL7
	FSET?	RUBY,NDESCBIT \?CCL7
	CALL2	ITAKE,TRUE-VALUE
	EQUAL?	STACK,M-FATAL,FALSE-VALUE /TRUE
	FCLEAR	RUBY,NDESCBIT
	FCLEAR	RUBY,NALLBIT
	PRINTR	"Taken."
?CCL7:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,SAPPHIRE \?CCL18
	MOVE	SAPPHIRE,HERE
	PRINTR	"The sapphire is a bit smaller than the depression; it stays for a moment but then drops to the ground."
?CCL18:	EQUAL?	PRSO,RUBY \?CCL20
	MOVE	RUBY,DEPRESSION
	FSET	RUBY,NDESCBIT
	FSET	RUBY,NALLBIT
	PRINTI	"The moby ruby fits perfectly into the depression. As it sinks into place, the eyes of the oracle begin to glow."
	FIRST?	ORACLE-OBJECT \?CND21
	GET	ORACLE-TABLE,ORACLE-EXIT-NUMBER
	ICALL	ROB,ORACLE-OBJECT,STACK
	PRINTI	" Everything in the oracle's mouth suddenly vanishes!"
?CND21:	CRLF	
	ICALL2	INC-SCORE,ORACLE-SCORE
	SET	'ORACLE-SCORE,0
	RTRUE	
?CCL20:	PRINTR	"It doesn't fit the depression."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	AMULET-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The amulet is in the shape of a serpent's head. "
	FSET?	HERE,BEYONDBIT \?CCL6
	PRINTI	"It seems to be glowing slightly"
	JUMP	?CND4
?CCL6:	GET	EYE-TABLE,ORACLE-EXIT-NUMBER
	PRINT	STACK
	PRINTI	" of its four eyes "
	EQUAL?	ORACLE-EXIT-NUMBER,1 \?CCL9
	PRINTI	"is"
	JUMP	?CND7
?CCL9:	PRINTI	"are"
?CND7:	PRINTI	" open"
?CND4:	PRINT	PERIOD-CR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TOUCH \FALSE
	FSET?	HERE,BEYONDBIT \?CCL14
	ICALL1	CAST-HUNGER-SPELL
	PRINTI	"A stream of light undulates slowly from the amulet "
	FSET?	AMULET,WORNBIT \?CCL17
	PRINTI	"and envelops you like a mist. After a moment, the mist clears"
	PRINT	ELLIPSIS
	CALL2	GOTO,G-U-MOUNTAIN
	RSTACK	
?CCL17:	PRINTR	"but then quickly fades."
?CCL14:	ZERO?	TIME-STOPPED \FALSE
	PRINTR	"The amulet, for one brief moment, glows from deep within."


	.FUNCT	I-AMULET
	ICALL	QUEUE,I-AMULET,4
	IGRTR?	'ORACLE-EXIT-NUMBER,4 \?CND1
	SET	'ORACLE-EXIT-NUMBER,0
?CND1:	EQUAL?	HERE,ORACLE \FALSE
	IN?	RUBY,DEPRESSION \FALSE
	ZERO?	LIT /FALSE
	ICALL1	RETURN-FROM-MAP
	PRINTR	"   The oracle seems to blink for a moment."

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	FLATHEAD-MOUNTAINS-F
	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB,V?ENTER /?CCL3
	EQUAL?	PRSA,V?CLIMB-DOWN \FALSE
?CCL3:	CALL1	V-WALK-AROUND
	RSTACK	


	.FUNCT	HOLLOW-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a chamber, open to the sky, formed by cliff-like mountain walls. Strange and frightening runes have been carved into the cliff wall to the south, next to a "
	ZERO?	IRON-MINE-OPEN /?CCL6
	PRINTI	"dark cave entrance"
	JUMP	?CND4
?CCL6:	PRINTI	"six-sided hole"
?CND4:	PRINTI	". The only "
	ZERO?	IRON-MINE-OPEN /?CCL9
	PRINTI	"other"
	JUMP	?CND7
?CCL9:	PRINTI	"apparent"
?CND7:	PRINTI	" exit is northeast."
	RTRUE	


	.FUNCT	HEXAGONAL-HOLE-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The small, six-sided hole has been neatly carved into the cliff wall."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL5
	PRINT	ONLY-BLACKNESS
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?REACH-IN \?CCL7
	PRINTR	"Your hand is about the same size as the hole, and since your hand isn't hexagonal, it doesn't fit."
?CCL7:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,HEXAGONAL-BLOCK \?CCL12
	SET	'IRON-MINE-OPEN,TRUE-VALUE
	SET	'COMPASS-CHANGED,TRUE-VALUE
	REMOVE	HEXAGONAL-BLOCK
	REMOVE	HEXAGONAL-HOLE
	PRINTI	"A seam appears in the cliff wall, and a huge slab of rock slides silently aside! A breeze of stale, dusty air caresses you as the dark opening to the south beckons ominously."
	CRLF	
	CALL2	INC-SCORE,14
	RSTACK	
?CCL12:	PRINTR	"It doesn't fit."


	.FUNCT	BIRCH-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	CALL1	PLANT-STUNNED
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB \?CCL5
	PRINT	POORLY-CONFIGURED
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?GET-NEAR \?CCL7
	CALL2	PERFORM-PRSA,SMALL-ELM
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?LISTEN \FALSE
	ZERO?	PLANT-TALKER /FALSE
	PRINTR	"The birch is poignantly bemoaning that none of its seedlings has ever taken root in this barren, rocky place."


	.FUNCT	IRON-PS
	EQUAL?	HERE,IRON-MINE \FALSE
	PRINTR	"There's no iron ore here. The vein is played out; the mine abandoned."


	.FUNCT	IRON-MINE-PS
	EQUAL?	PRSA,V?ENTER \?CCL3
	EQUAL?	HERE,HOLLOW \?CCL3
	CALL2	DO-WALK,P?IN
	RSTACK	
?CCL3:	CALL2	PERFORM-PRSA,GLOBAL-HERE
	RSTACK	

	.SEGMENT "CASTLE"


	.FUNCT	SAPPHIRE-F
	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,SAPPHIRE \FALSE
	FSET?	SAPPHIRE,TRYTAKEBIT \FALSE
	FCLEAR	SAPPHIRE,TRYTAKEBIT
	PUTP	SAPPHIRE,P?ACTION,FALSE-VALUE
	FSET	SAPPHIRE,TOUCHBIT
	MOVE	SAPPHIRE,PROTAGONIST
	PRINTR	"As you pry loose the sapphire, the skeleton's fingers crumble to dust, and the jewel glows briefly from deep within."

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	NATURAL-ARCH-OBJECT-F
	EQUAL?	PRSA,V?LOOK-UNDER,V?EXAMINE \FALSE
	PRINTR	"Under the arch, steps lead down into darkness."


	.FUNCT	ENCHANTED-CAVE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"Your light sparkles off reflective walls, spilling glittering droplets of illumination across every surface, including the dull gray altar in the very center of the room. The altar is inscribed with the single word ""Zilbeetha."" "
	IN?	STATUE,HERE \?CND4
	PRINT	STATUE-DESC
	PRINTC	32
?CND4:	PRINTI	"Strewn about the cave are the bones of many adventurers, amidst dust which might be that of even older bones. An uneven stair leads up toward light."
	RTRUE	


	.FUNCT	STATUE-F
	EQUAL?	PRSA,V?PUT-ON \?CCL3
	EQUAL?	PRSI,STATUE \?CCL3
	FSET?	PRSO,WEARBIT \?CCL3
	PRINTR	"The statue isn't a department store mannequin!"
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	PRINT	STATUE-DESC
	CRLF	
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?ALARM \FALSE
	PRINTR	"Apparently, you think breaking an enchantment is as easy as breaking an egg!"


	.FUNCT	ALTAR-F
	EQUAL?	PRSA,V?PUT-ON \FALSE
	EQUAL?	PRSO,GLITTERY-ORB,SMOKY-ORB,MILKY-ORB /?CCL3
	EQUAL?	PRSO,FIERY-ORB \FALSE
?CCL3:	EQUAL?	PRSO,ENCHANTED-ORB /?CTR9
	EQUAL?	ORBS-EXAMINED,3 \?CCL10
	FSET?	PRSO,ORBBIT /?CCL10
?CTR9:	REMOVE	PRSO
	REMOVE	STATUE
	MOVE	FLOWER,ALTAR
	FCLEAR	FLOWER,NDESCBIT
	FCLEAR	FLOWER,TRYTAKEBIT
	PRINTI	"At first, nothing happens. Then the orb glows deep within, and a gentle chorus of angels begins to swell. As the glow brightens to include the entire cave, the statue and orb are gone, replaced by a young couple in wedding garb, in rapturous embrace. As the singing of the angels reaches a crescendo, Zilbeetha and her lover recede from sight toward planes unknown, leaving a flower of incomparable fragility and beauty sitting on the altar."
	CRLF	
	CALL2	INC-SCORE,25
	RSTACK	
?CCL10:	IN?	STATUE,HERE \FALSE
	CALL2	JIGS-UP,STR?804
	RSTACK	

	.SEGMENT "0"


	.FUNCT	FLOWER-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	CALL1	PLANT-STUNNED
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL5
	FSET?	FLOWER,TRYTAKEBIT \?CCL5
	EQUAL?	PRSO,FLOWER \?CCL5
	PRINTR	"It's part of a stone statue!"
?CCL5:	EQUAL?	PRSA,V?LISTEN \?CCL10
	ZERO?	PLANT-TALKER /?CCL10
	PRINTR	"The flower is aware that, having been cut, it will shortly wilt. However, it has philosophically decided to accept this sad fate without complaint."
?CCL10:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The flower"
	FSET?	FLOWER,TRYTAKEBIT \?CND15
	PRINTI	", though made of stone,"
?CND15:	PRINTR	" is a thing of fragile beauty."

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	LOWER-LEDGE-F,RARG
	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?PUT-ON,V?THROW \?CCL5
	EQUAL?	PRSI,LOWER-LEDGE \?CCL5
	REMOVE	PRSO
	EQUAL?	PRSO,PERCH /?CCL9
	CALL	ULTIMATELY-IN?,PERCH,PRSO
	ZERO?	STACK /?CND8
?CCL9:	SET	'REMOVED-PERCH-LOC,WATER
?CND8:	PRINTI	"You toss"
	ICALL1	TPRINT-PRSO
	PRINTR	" carefully, but it skitters across the lower ledge and falls into the fjord."
?CCL5:	EQUAL?	PRSA,V?EXAMINE \?CCL13
	EQUAL?	HERE,UPPER-LEDGE \?CCL13
	FSET?	LOWER-LEDGE,TOUCHBIT /?CCL13
	PRINTR	"By leaning far out, you can just make out the edge of something on the ledge below. Most of it is hidden by protrusions in the cliff wall, though, so you can't make out what it is."
?CCL13:	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER \?CCL18
	EQUAL?	HERE,LOWER-LEDGE \?CCL21
	PRINT	LOOK-AROUND
	RTRUE	
?CCL21:	CALL2	DO-WALK,P?DOWN
	RSTACK	
?CCL18:	EQUAL?	PRSA,V?LEAP \FALSE
	SET	'PRSO,FALSE-VALUE
	RFALSE	


	.FUNCT	NARROW-CRACK-PS
	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL3
	PRINT	ONLY-BLACKNESS
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?REACH-IN \FALSE
	ZERO?	ROPE-PLACED \?CCL8
	CALL2	JIGS-UP,STR?810
	RSTACK	
?CCL8:	PRINT	NOTHING-IN-REACH
	RTRUE	

	.SEGMENT "0"


	.FUNCT	LANDSCAPE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"You're not a student of art, but it sure looks like this landscape was done more with a catapult than a brush. "
	EQUAL?	HERE,LOWER-LEDGE \?CND4
	PRINTI	"In fact, the artist seems to have gotten more paint on the cliff and ledge than on the canvas. "
?CND4:	PRINTR	"Despite its flaws, the landscape is obviously of the Flathead Fjord."


	.FUNCT	G-PAINTING-F,SRES,F
	RETURN	LANDSCAPE

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	FJORD-F
	CALL2	TOUCHING?,FJORD
	ZERO?	STACK /FALSE
	CALL2	CANT-REACH,FJORD
	RSTACK	


	.FUNCT	GLACIER-DEATH,RARG
	ZERO?	RARG \FALSE
	CALL2	JIGS-UP,STR?816
	RSTACK	


	.FUNCT	MIRROR-LAKE-F,RARG,TMP,DIR
	EQUAL?	RARG,M-BEG \?CCL3
	EQUAL?	PRSO,REFLECTION \?CCL3
	CALL2	GET-OWNER,PRSO
	EQUAL?	STACK,MIRROR,REFLECTION \?CCL3
	PRINT	HUH
	RTRUE	
?CCL3:	EQUAL?	RARG,M-BEG \?CCL8
	EQUAL?	PRSA,V?EXAMINE \?CCL8
	EQUAL?	PRSO,REFLECTION \?CCL8
	CALL2	GET-OWNER,PRSO >TMP
	ZERO?	TMP /?CCL8
	ICALL	PERFORM,V?MIRROR-LOOK,TMP,MIRROR
	RTRUE	
?CCL8:	EQUAL?	RARG,M-BEG \?CCL14
	EQUAL?	PRSA,V?THROW /?CTR13
	EQUAL?	PRSA,V?STHROW \?CCL14
	EQUAL?	PRSI,INTDIR \?CCL14
?CTR13:	CALL1	IDROP
	ZERO?	STACK \TRUE
	EQUAL?	PRSA,V?THROW \?CCL25
	RANDOM	100
	LESS?	25,STACK /?CCL28
	SET	'DIR,P?EAST
	JUMP	?CND21
?CCL28:	RANDOM	100
	LESS?	33,STACK /?CCL30
	SET	'DIR,P?WEST
	JUMP	?CND21
?CCL30:	RANDOM	100
	LESS?	50,STACK /?CCL32
	SET	'DIR,P?NORTH
	JUMP	?CND21
?CCL32:	SET	'DIR,P?SOUTH
	JUMP	?CND21
?CCL25:	CALL	NOUN-USED?,INTDIR,W?NORTH,W?NE,W?NW
	ZERO?	STACK /?CCL34
	SET	'DIR,P?NORTH
	JUMP	?CND21
?CCL34:	CALL	NOUN-USED?,INTDIR,W?SOUTH,W?SE,W?SW
	ZERO?	STACK /?CCL36
	SET	'DIR,P?SOUTH
	JUMP	?CND21
?CCL36:	CALL	NOUN-USED?,INTDIR,W?EAST
	ZERO?	STACK /?CCL38
	SET	'DIR,P?EAST
	JUMP	?CND21
?CCL38:	SET	'DIR,P?WEST
?CND21:	CALL	LEAVE-MIRROR,STR?819,DIR
	RSTACK	
?CCL14:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?PUSH \FALSE
	FSET?	PRSO,WHITEBIT /?CCL40
	FSET?	PRSO,BLACKBIT \FALSE
?CCL40:	RANDOM	100
	LESS?	25,STACK /?CCL48
	SET	'DIR,P?EAST
	JUMP	?CND46
?CCL48:	RANDOM	100
	LESS?	33,STACK /?CCL50
	SET	'DIR,P?WEST
	JUMP	?CND46
?CCL50:	RANDOM	100
	LESS?	50,STACK /?CCL52
	SET	'DIR,P?NORTH
	JUMP	?CND46
?CCL52:	SET	'DIR,P?SOUTH
?CND46:	CALL	LEAVE-MIRROR,STR?820,DIR
	RSTACK	


	.FUNCT	LEAVE-MIRROR,STRING,DIR,AV,DESTINATION
	PRINTI	"As you throw"
	ICALL1	TPRINT-PRSO
	PRINTI	", you slide across the ice in the opposite direction, and plow into a powdery snow bank"
	PRINT	ELLIPSIS
	LOC	PROTAGONIST >AV
	EQUAL?	DIR,P?NORTH \?CCL3
	MOVE	PRSO,NORTH-OF-MIRROR
	SET	'DESTINATION,SOUTH-OF-MIRROR
	JUMP	?CND1
?CCL3:	EQUAL?	DIR,P?SOUTH \?CCL5
	MOVE	PRSO,SOUTH-OF-MIRROR
	SET	'DESTINATION,NORTH-OF-MIRROR
	JUMP	?CND1
?CCL5:	EQUAL?	DIR,P?EAST \?CCL7
	MOVE	PRSO,EAST-OF-MIRROR
	SET	'DESTINATION,WEST-OF-MIRROR
	JUMP	?CND1
?CCL7:	MOVE	PRSO,WEST-OF-MIRROR
	SET	'DESTINATION,EAST-OF-MIRROR
?CND1:	FSET?	AV,VEHBIT \?CCL10
	MOVE	AV,DESTINATION
	ICALL2	GOTO,AV
	JUMP	?CND8
?CCL10:	ICALL2	GOTO,DESTINATION
?CND8:	EQUAL?	PRSO,PIT-BOMB \?CND11
	REMOVE	PIT-BOMB
	PRINTI	"   Some pit-filling agents drift by in a useless cloud, dispersing."
	CRLF	
?CND11:	ICALL2	INC-SCORE,MIRROR-SCORE
	SET	'MIRROR-SCORE,0
	RTRUE	


	.FUNCT	MIRROR-F,TMP
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?CCL3
	PRINTR	"As you stare at your reflection in the mirrored surface, you look as you always have; and yet, you see things you've never seen before: youthful exuberance and courage, yet tempered by the wisdom and experience of untold generations of forebears, whose spirits seem to hover over you protectively.
   Who knows what secrets might be revealed by looking at the reflection of other things in this magical mirror!?!"
?CCL3:	EQUAL?	PRSA,V?MIRROR-LOOK \?CCL5
	EQUAL?	PRSI,MIRROR \?CCL5
	EQUAL?	PRSO,PROTAGONIST,ME \?CCL10
	ICALL	PERFORM,V?EXAMINE,MIRROR
	RTRUE	
?CCL10:	EQUAL?	PRSO,ENCHANTED-ORB \?CCL12
	SET	'ORB-FOUND,TRUE-VALUE
	PRINTI	"As you gaze at the reflection of"
	ICALL1	TPRINT-PRSO
	PRINTR	", a different vision takes shape: a beautiful young maiden, in peaceful sleep. Then, the vision fades."
?CCL12:	EQUAL?	PRSO,WAND \?CCL14
	PRINTR	"The reflection of the wand is unnaturally still; more frozen than even the arctic landscape that surrounds you."
?CCL14:	EQUAL?	PRSO,FLASK \?CCL16
	PRINTR	"You see the shadow of death hanging over the flask."
?CCL16:	EQUAL?	PRSO,CLOAK \?CCL18
	PRINTR	"The reflection reveals a checkered pattern in the cloth, not visible when you look at the garment itself."
?CCL18:	EQUAL?	PRSO,GLOVE \?CCL20
	PRINTR	"The glove's reflection conveys a feeling of fingers more sensitive and dexterous than the world's greatest surgeon."
?CCL20:	EQUAL?	PRSO,GOGGLES \?CCL22
	PRINTR	"The image of the goggles appears surrounded by a brick wall which slowly transforms to glass!"
?CCL22:	EQUAL?	PRSO,RING \?CCL24
	PRINTI	"Odd. Although the ring has no face of any kind, as you gaze at its reflection you get the distinct impression that the ring is laughing at you!"
	CRLF	
	CALL2	ULTIMATELY-IN?,RING
	ZERO?	STACK /TRUE
	MOVE	RING,HERE
	PRINTR	"   Perhaps in reaction to this impression, it seems that you have dropped the ring."
?CCL24:	EQUAL?	PRSO,NW-SE-PASSAGE,N-S-PASSAGE \?CCL28
	PRINTR	"The reflection of the passage reveals a feature which is invisible when you look at the passage itself: the edges dripping with unset glue."
?CCL28:	EQUAL?	PRSO,PARCHMENT \?CCL30
	PRINTR	"The paper of the parchment, as seen in the mirror, is suffused with an other-wordly glow."
?CCL30:	EQUAL?	PRSO,PIGEON \?CCL32
	PRINTR	"The reflection of the inert pigeon is most startling: it appears soaring majestically through space on widespread wings, bearing a rider regally upon its back!"
?CCL32:	EQUAL?	PRSO,PERCH \?CCL34
	PRINTR	"You see not an image of a ceramic perch, but of a proud mountain aerie! A powerful bird is flying toward the nest from a great distance."
?CCL34:	EQUAL?	PRSO,AMULET \?CCL36
	PRINTR	"The reflection of the amulet is suffused in a glow of amazing energies! A vague ghost of a serpent's head floats over it. A hand reaches to touch the amulet -- and the mirror goes blank!"
?CCL36:	EQUAL?	PRSO,CANDLE \?CCL38
	PRINTR	"A flurry of images surrounds the candle's reflection: an aged wizard weaving spells above a vat of bubbling tallow; the same mage handing a taper to a royal handmaiden; a chambermaid lighting the candle for a young prince; the same candle, never growing shorter, casting shadows on the faces of a succession of kings. The last image is of a servant placing the candle in a dark passageway and closing a concealed doorway behind him."
?CCL38:	EQUAL?	PRSO,JESTER \?CCL40
	ICALL1	REMOVE-J
	PRINTR	"The jester's reflection is that of a much older man! And there's something else...but the jester notices you studying his reflection, and vanishes hastily!"
?CCL40:	EQUAL?	PRSO,POTION \?CCL42
	PRINTR	"The image shows a flowering plant growing from the potion. It seems to be calling to you."
?CCL42:	EQUAL?	PRSO,SAPPHIRE \?CCL44
	PRINTR	"As you look at the jewel's reflection, the skeleton's bony hand still seems clamped around it. Then the reflection enlarges, and a chill spreads from your heart as you see that the hand belongs to Death himself! He silently laughs at you from within his dark cowl before vanishing!"
?CCL44:	FSET?	PRSO,WHITEBIT /?CTR45
	FSET?	PRSO,BLACKBIT \?CCL46
?CTR45:	PRINTI	"Behind the image of"
	ICALL1	TPRINT-PRSO
	PRINTR	" you see endless generations of masters, hunched over a small checkered board."
?CCL46:	GETP	PRSO,P?INANIMATE-DESC
	ZERO?	STACK /?CCL50
	FSET?	PRSO,ANIMATEDBIT /?CCL50
	PRINTI	"You see the image of a "
	PRINTD	PRSO
	PRINTR	"!"
?CCL50:	EQUAL?	PRSO,REFLECTION \?CND53
	CALL2	GET-OWNER,PRSO >TMP
	ZERO?	TMP /?CND53
	SET	'PRSO,TMP
?CND53:	EQUAL?	PRSO,GLITTERY-ORB,SMOKY-ORB,MILKY-ORB /?PRD60
	EQUAL?	PRSO,FIERY-ORB \?CND57
?PRD60:	FSET?	PRSO,ORBBIT /?CND57
	FSET	PRSO,ORBBIT
	INC	'ORBS-EXAMINED
?CND57:	PRINTI	"The reflection of "
	FSET?	PRSO,NARTICLEBIT /?CND63
	PRINTI	"the "
?CND63:	ICALL2	DPRINT,PRSO
	PRINTI	" looks just like "
	FSET?	PRSO,NARTICLEBIT /?CND65
	PRINTI	"the "
?CND65:	ICALL2	DPRINT,PRSO
	PRINTR	" itself."
?CCL5:	EQUAL?	PRSA,V?MUNG \FALSE
	CALL2	JIGS-UP,STR?822
	RSTACK	


	.FUNCT	REFLECTION-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	ICALL	PERFORM,V?EXAMINE,MIRROR
	RTRUE	


	.FUNCT	EAST-OF-MIRROR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	MIRRORS-EDGE-DESC,STR?824,STR?825,STR?826
	RSTACK	


	.FUNCT	MIRRORS-EDGE-DESC,STR1,STR2,STR3
	PRINTI	"You are in a snow drift. To the "
	PRINT	STR1
	PRINTI	" is a lake with a mirrored surface. You could probably plow around the mirror to the "
	PRINT	STR2
	PRINTI	" and "
	PRINT	STR3
	PRINTC	46
	RTRUE	


	.FUNCT	WEST-OF-MIRROR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ICALL	MIRRORS-EDGE-DESC,STR?827,STR?828,STR?263
	PRINTI	" A ski chalet, half-buried in the snow, lies to the west."
	RTRUE	


	.FUNCT	NORTH-OF-MIRROR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	MIRRORS-EDGE-DESC,STR?199,STR?263,STR?826
	RSTACK	


	.FUNCT	SOUTH-OF-MIRROR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	MIRRORS-EDGE-DESC,STR?198,STR?828,STR?825
	RSTACK	


	.FUNCT	LILY-PAD-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	CALL1	PLANT-STUNNED
	RSTACK	
?CCL3:	ZERO?	ARG \FALSE
	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER \?CCL7
	CALL2	VISIBLE?,OTTO
	ZERO?	STACK /?CCL10
	PRINTR	"""For toads only, buster."""
?CCL10:	PRINTR	"Only a toad could be comfortable there."
?CCL7:	EQUAL?	PRSA,V?LISTEN \FALSE
	ZERO?	PLANT-TALKER /FALSE
	PRINTI	"The lily pad is "
	EQUAL?	PRSO,LARGE-LILY-PAD \?CCL17
	CALL2	VISIBLE?,OTTO
	ZERO?	STACK /?CCL20
	PRINTI	"moaning about"
	JUMP	?CND18
?CCL20:	PRINTI	"giddy at the absence of"
?CND18:	PRINTR	" the weight of the giant toad."
?CCL17:	PRINTR	"composing an ode to sunlight."


	.FUNCT	OTTO-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	EQUAL?	PRSA,V?GIVE \?PRD8
	EQUAL?	PRSO,SPYGLASS \?PRD8
	EQUAL?	PRSI,ME /?CTR5
?PRD8:	EQUAL?	PRSA,V?SGIVE \?CCL6
	EQUAL?	PRSO,ME \?CCL6
	EQUAL?	PRSI,SPYGLASS \?CCL6
?CTR5:	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-FOR,OTTO,SPYGLASS
	SET	'WINNER,OTTO
	RTRUE	
?CCL6:	EQUAL?	PRSA,V?YES \?CCL16
	EQUAL?	AWAITING-REPLY,2 \?CCL16
	CALL1	V-YES
	RSTACK	
?CCL16:	EQUAL?	PRSA,V?NO \?CCL20
	EQUAL?	AWAITING-REPLY,2 \?CCL20
	CALL1	V-NO
	RSTACK	
?CCL20:	SET	'AWAITING-REPLY,2
	ICALL	QUEUE,I-REPLY,2
	PRINTI	"""Quiet. I've got a headache. Do you think you own this swamp?"""
	CRLF	
	CALL1	STOP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL24
	PRINTR	"The toad is not only ugly, it is bright blue and the size of a small shack. It also looks pretty grumpy."
?CCL24:	CALL	ADJ-USED?,OTTO,W?UGLY
	ZERO?	STACK /?CCL26
	CALL2	VISIBLE?,OTTO
	ZERO?	STACK /?CCL26
	PRINTI	"""Who're you calling ugly?!? You're no prize yourself, you know!"""
	CRLF	
	CALL1	STOP
	RSTACK	
?CCL26:	CALL	NOUN-USED?,OTTO,W?TOAD
	ZERO?	STACK /?CCL30
	CALL2	VISIBLE?,OTTO
	ZERO?	STACK /?CCL30
	INC	'OTTO-NAME-COUNTER
	PRINTI	"""I have a name, you know"
	MOD	OTTO-NAME-COUNTER,5
	ZERO?	STACK \?CND33
	PRINTI	", a great name, known throughout many lands. And though I spent many years at sea, few pirates will know my name"
?CND33:	PRINTI	"."""
	CRLF	
	CALL1	STOP
	RSTACK	
?CCL30:	EQUAL?	PRSA,V?ASK-FOR \?CCL36
	EQUAL?	PRSI,SPYGLASS \?CCL36
	EQUAL?	FLIES-EATEN,4 \?CCL41
	MOVE	SPYGLASS,SMALL-LILY-PAD
	FCLEAR	SPYGLASS,TRYTAKEBIT
	ICALL2	THIS-IS-IT,SPYGLASS
	PRINTR	"""Okay, take the stupid thing, but shut up and let me have some peace and quiet."" The toad places the spyglass on the small lily pad."
?CCL41:	PRINTI	"""If you want this spyglass, you must bring me the "
	ZERO?	FLIES-EATEN \?CCL44
	PRINTI	"Four "
	JUMP	?CND42
?CCL44:	PRINTI	"remaining "
	EQUAL?	FLIES-EATEN,1 \?CCL47
	PRINTI	"three "
	JUMP	?CND42
?CCL47:	EQUAL?	FLIES-EATEN,2 \?CND42
	PRINTI	"two "
?CND42:	PRINTI	"Fantastic Fl"
	EQUAL?	FLIES-EATEN,3 \?CCL51
	PRINTC	121
	JUMP	?CND49
?CCL51:	PRINTI	"ies"
?CND49:	PRINTR	" of Famathria."""
?CCL36:	EQUAL?	PRSA,V?EAT \FALSE
	ZERO?	ALLIGATOR /FALSE
	PRINTR	"Although the toad looks tasty, he's about ten times your size."


	.FUNCT	I-STONE-TO-OTTO
	MOVE	OTTO,LARGE-LILY-PAD
	EQUAL?	HERE,DELTA-6 \FALSE
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   Otto emerges from the muck of the swamp, looking quite displeased. Dripping with mud, he plops down on his favorite lily pad"
	CALL2	VISIBLE?,WAND
	ZERO?	STACK /?CND4
	REMOVE	WAND
	PRINTI	". ""Let's just make sure we don't have any repetitions of that, eh?"" He wraps his tongue around the wand and snaps it into a zillion splinters"
?CND4:	PRINT	PERIOD-CR
	RTRUE	

	.SEGMENT "0"


	.FUNCT	SPYGLASS-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	SPYGLASS,TRYTAKEBIT \?CCL3
	IN?	SPYGLASS,SMALL-LILY-PAD \?CND6
	MOVE	SPYGLASS,OTTO
	PRINTI	"The toad snatches the spyglass with its long tongue. "
?CND6:	PRINTR	"""If you want it, you'll have to ask me to give it to you."""
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL9
	PRINTR	"The spyglass magnifies distant objects."
?CCL9:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	PRSI,SPYGLASS \FALSE
	PRINT	YOU-SEE
	ICALL1	TPRINT-PRSO
	PRINTR	", somewhat enlarged."


	.FUNCT	FLY-F
	EQUAL?	PRSA,V?DROP \?CCL3
	ICALL2	ORDER-FLIES,HERE
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"This is one juicy delicious-looking hunk of fly... that is, if you're the type who goes for insect meat..."
?CCL5:	EQUAL?	PRSA,V?GIVE \?CCL7
	EQUAL?	PRSI,OTTO \?CCL7
	REMOVE	PRSO
	INC	'FLIES-EATEN
	PRINTR	"The toad wraps its long tongue around the fly, snaps it gluttonously into its mouth, and burps rudely."
?CCL7:	EQUAL?	PRSA,V?CATCH \?CCL11
	ICALL	PERFORM,V?TAKE,PRSO
	RTRUE	
?CCL11:	CALL2	TOUCHING?,PRSO
	ZERO?	STACK /FALSE
	EQUAL?	PRSA,V?TAKE \?CND14
	ICALL2	ORDER-FLIES,PROTAGONIST
?CND14:	FSET?	PRSO,TRYTAKEBIT \FALSE
	FSET?	GLOVE,WORNBIT \?CCL21
	PRINTR	"Your gloved hand strikes with amazing speed, but the fly darts out of the way by a hair's breadth."
?CCL21:	PRINTR	"The fly buzzes just out of reach."

	.ENDSEG

	.SEGMENT "ORACLE"

	.SEGMENT "SECRET"

	.SEGMENT "LAKE"


	.FUNCT	FLY-ROOM-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	HERE,TOUCHBIT /FALSE
	IN?	LARGE-FLY,LOCAL-GLOBALS \?CCL8
	MOVE	LARGE-FLY,HERE
	RTRUE	
?CCL8:	IN?	LARGER-FLY,LOCAL-GLOBALS \?CCL10
	MOVE	LARGER-FLY,HERE
	RTRUE	
?CCL10:	IN?	EVEN-LARGER-FLY,LOCAL-GLOBALS \?CCL12
	MOVE	EVEN-LARGER-FLY,HERE
	RTRUE	
?CCL12:	IN?	LARGEST-FLY,LOCAL-GLOBALS \FALSE
	MOVE	LARGEST-FLY,HERE
	RTRUE	

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	FOOT-OF-STATUE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This once verdant valley is now barren. "
	PRINT	NEAR-STATUE-DESC
	PRINTI	" A trail approaches a hilltop to the southwest."
	RTRUE	


	.FUNCT	DIMWIT-STATUE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,FOOT-OF-STATUE \?CCL6
	PRINT	NEAR-STATUE-DESC
	CRLF	
	RTRUE	
?CCL6:	PRINT	DISTANT-STATUE-DESC
	CRLF	
	RTRUE	


	.FUNCT	TREE-PS
	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB \FALSE
	PRINTR	"There are no trees here suitable for climbing."


	.FUNCT	VIEW-OF-STATUE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are on a tall hilltop near the center of barren Fublio Valley. A few small trees are beginning the arduous task of refoliating the valley. "
	PRINT	DISTANT-STATUE-DESC
	PRINTI	" Trails lead northeast, southeast, west, and south."
	RTRUE	


	.FUNCT	MEGABOZ-HUT-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in the unassuming shack where the legendary magician Megaboz once lived. Embroidered wall hangings adorn one side of the hut, and a poem has been scrawled on the opposite wall; oddly, some of the words are missing. The only exit is east. "
	PRINT	MEGABOZ-CEILING-DESC
	RTRUE	


	.FUNCT	ATTIC-ENTER-F,RARG
	FSET?	MEGABOZ-TRAP-DOOR,OPENBIT /?CCL3
	ZERO?	RARG \FALSE
	ICALL1	RETURN-FROM-MAP
	ICALL2	DO-FIRST,STR?845
	RFALSE	
?CCL3:	IN?	PROTAGONIST,LADDER /?CCL7
	ZERO?	RARG \FALSE
	ICALL1	RETURN-FROM-MAP
	ICALL2	CANT-REACH,MEGABOZ-TRAP-DOOR
	RFALSE	
?CCL7:	RETURN	ATTIC


	.FUNCT	MEGABOZ-TRAP-DOOR-F
	EQUAL?	HERE,MEGABOZ-HUT \?CCL3
	CALL2	TOUCHING?,MEGABOZ-TRAP-DOOR
	ZERO?	STACK /?CCL3
	IN?	PROTAGONIST,LADDER /?CCL3
	CALL2	CANT-REACH,MEGABOZ-TRAP-DOOR
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?ENTER \FALSE
	EQUAL?	HERE,MEGABOZ-HUT \FALSE
	CALL2	DO-WALK,P?UP
	RSTACK	


	.FUNCT	TRUNK-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	TRUNK,LOCKEDBIT /?CCL3
	ZERO?	FLY-IN-TRUNK /?CCL3
	ZERO?	PRSI /?CND7
	FSET?	PRSI,KEYBIT /FALSE
?CND7:	SET	'FLY-IN-TRUNK,FALSE-VALUE
	IN?	LARGE-FLY,LOCAL-GLOBALS \?CCL13
	MOVE	LARGE-FLY,HERE
	JUMP	?CND11
?CCL13:	IN?	LARGER-FLY,LOCAL-GLOBALS \?CCL15
	MOVE	LARGER-FLY,HERE
	JUMP	?CND11
?CCL15:	IN?	EVEN-LARGER-FLY,LOCAL-GLOBALS \?CCL17
	MOVE	EVEN-LARGER-FLY,HERE
	JUMP	?CND11
?CCL17:	IN?	LARGEST-FLY,LOCAL-GLOBALS \?CND11
	MOVE	LARGEST-FLY,HERE
?CND11:	PRINTI	"As you raise the lid, a huge fly zooms out and begins buzzing around the room. "
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL20
	EQUAL?	PRSO,TRUNK \?CCL20
	PRINTR	"The trunk turns out to be too large and heavy to move."
?CCL20:	EQUAL?	PRSA,V?UNLOCK \?CCL24
	FSET?	TRUNK,LOCKEDBIT \?CCL24
	EQUAL?	PRSI,RUSTY-KEY \?CCL24
	EQUAL?	SACRED-WORD-NUMBER,10 \?CND28
	RANDOM	10
	SUB	STACK,1 >SACRED-WORD-NUMBER
?CND28:	FCLEAR	TRUNK,LOCKEDBIT
	CALL	LOCKED-UNLOCKED,TRUNK,TRUE-VALUE
	RSTACK	
?CCL24:	EQUAL?	PRSA,V?LOCK \FALSE
	FSET?	TRUNK,LOCKEDBIT /FALSE
	EQUAL?	PRSI,RUSTY-KEY \FALSE
	FSET	TRUNK,LOCKEDBIT
	CALL2	LOCKED-UNLOCKED,TRUNK
	RSTACK	

	.SEGMENT "0"


	.FUNCT	PAN-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINT	HUH
	RTRUE	


	.FUNCT	NOTEBOOK-F
	EQUAL?	PRSA,V?EXAMINE,V?OPEN,V?READ \FALSE
	PRINTI	"The notebook is either gibberish or far in advance of your understanding. It seems to be filled with all kinds of formulas, spells, and shopping lists.
   Near the end, you discover what appears to be a list of things to do: ""1) Mail OZMOO scrolls to Gurth. 2) Cast Curse on Flatheads. 3) Pick up milk and bread.""
   Below is a sketch of a steaming kettle and a single word, """
	GET	SACRED-WORDS,SACRED-WORD-NUMBER
	PRINT	STACK
	PRINTR	"."""


	.FUNCT	HARMONICA-F
	EQUAL?	PRSA,V?INFLATE,V?PLAY \FALSE
	PRINTR	"The harmonica produces a sound like that of cats being tortured."

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	CAIRN-OBJECT-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	PRINTR	"The stones, individually, are uninteresting; the entire pile is much too massive to take."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"The cairn probably has a magical or religious significance."
?CCL5:	EQUAL?	PRSA,V?COUNT \FALSE
	CALL	NOUN-USED?,CAIRN-OBJECT,W?STONES
	ZERO?	STACK /FALSE
	PRINTR	"Thousands."


	.FUNCT	GUMBOZ-SHACK-F,RARG,SPILL
	EQUAL?	RARG,M-END \FALSE
	CALL2	ULTIMATELY-IN?,LARGE-VIAL
	ZERO?	STACK /?CND4
	GRTR?	LARGE-VIAL-GLOOPS,0 \?CND4
	SET	'LARGE-VIAL-GLOOPS,0
	REMOVE	LARGE-VIAL-WATER
	SET	'SPILL,TRUE-VALUE
?CND4:	CALL2	ULTIMATELY-IN?,SMALL-VIAL
	ZERO?	STACK /?CND8
	GRTR?	SMALL-VIAL-GLOOPS,0 \?CND8
	SET	'SMALL-VIAL-GLOOPS,0
	REMOVE	SMALL-VIAL-WATER
	SET	'SPILL,TRUE-VALUE
?CND8:	CALL2	ULTIMATELY-IN?,CUP
	ZERO?	STACK /?CND12
	IN?	POTION,CUP \?CND12
	REMOVE	POTION
	SET	'SPILL,TRUE-VALUE
?CND12:	ZERO?	SPILL \?CCL18
	RANDOM	100
	LESS?	20,STACK /FALSE
?CCL18:	ICALL1	RETURN-FROM-MAP
	PRINTI	"   You trip over something invisible (perhaps some sort of feeble anti-theft device). Fortunately, you manage to keep your footing."
	ZERO?	SPILL /?CND21
	PRINTR	" Unfortunately, you seem to have spilled something."
?CND21:	CRLF	
	RTRUE	


	.FUNCT	SHACK-EXIT-F,RARG
	ZERO?	RARG \?CND1
	ICALL1	RETURN-FROM-MAP
	ICALL1	CAST-HUNGER-SPELL
?CND1:	RETURN	OUTSIDE-SHACK

	.SEGMENT "0"


	.FUNCT	CAST-HUNGER-SPELL
	EQUAL?	HERE,GUMBOZ-SHACK \FALSE
	CALL2	ULTIMATELY-IN?,SMALL-VIAL
	ZERO?	STACK /FALSE
	ZERO?	HUNGER-SPELL-CAST \FALSE
	SET	'HUNGER-SPELL-CAST,TRUE-VALUE
	ICALL	QUEUE,I-HUNGER,36
	SET	'HUNGER-COUNT,1
	FCLEAR	SMALL-VIAL,TRYTAKEBIT
	PRINTI	"You hear a cry of ""Stop, thief! My vial!"" and a feeble but very angry wizard begins to appear. Noting that your departure is imminent, he casts his quickest spell on you; fortunately, it doesn't sound very powerful.
   You're suddenly very hungry."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	I-HUNGER
	INC	'HUNGER-COUNT
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   "
	EQUAL?	HUNGER-COUNT,2 \?CCL3
	ICALL	QUEUE,I-HUNGER,18
	PRINTR	"You're really famished now. Odd -- you had quite a huge meal last night."
?CCL3:	EQUAL?	HUNGER-COUNT,3 \?CCL5
	ICALL	QUEUE,I-HUNGER,12
	PRINTR	"You've never felt this hungry in your life!"
?CCL5:	EQUAL?	HUNGER-COUNT,4 \?CCL7
	ICALL	QUEUE,I-HUNGER,6
	PRINTR	"If your stomach could talk, it would be screaming, ""Get some food down here right away, jerk!"""
?CCL7:	CALL2	JIGS-UP,STR?863
	RSTACK	

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	TIRED-PINE-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	CALL1	PLANT-STUNNED
	RSTACK	
?CCL3:	CALL2	TOUCHING?,TIRED-PINE
	ZERO?	STACK /?CCL5
	EQUAL?	HERE,QUARRY \?CCL5
	CALL2	CANT-REACH,TIRED-PINE
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?GET-NEAR \?CCL9
	GET	PARSE-RESULT,7
	EQUAL?	STACK,W?UNDER \?CCL9
	EQUAL?	HERE,QUARRY \?CCL14
	PRINT	LOOK-AROUND
	RTRUE	
?CCL14:	CALL2	DO-WALK,P?DOWN
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB \?CCL16
	PRINT	POORLY-CONFIGURED
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?GET-NEAR \?CCL18
	CALL2	PERFORM-PRSA,SMALL-ELM
	RSTACK	
?CCL18:	EQUAL?	PRSA,V?LISTEN \FALSE
	ZERO?	PLANT-TALKER /FALSE
	PRINTR	"The tree relates a life-long fantasy about being transplanted in the fertile soil of Gurth."


	.FUNCT	QUARRY-F,RARG
	EQUAL?	RARG,M-END \?CCL3
	IN?	RUSTY-KEY,LOCAL-GLOBALS \?CCL3
	CALL2	ULTIMATELY-IN?,SAPPHIRE
	ZERO?	STACK /?CCL3
	FSET?	RING,WORNBIT \?CCL3
	MOVE	RUSTY-KEY,HERE
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   A strange drowsiness comes over you, and you fall into a swoon. An unknown number of minutes later, you are roused by a gentle breeze"
	PRINT	ELLIPSIS
	ICALL1	V-LOOK
	CALL2	INC-SCORE,14
	RSTACK	
?CCL3:	ZERO?	RARG \FALSE
	EQUAL?	HERE,QUARRYS-EDGE \FALSE
	EQUAL?	PRSA,V?ENTER \FALSE
	EQUAL?	P-PRSA-WORD,W?JUMP \FALSE
	CALL1	JUMPLOSS
	RSTACK	


	.FUNCT	QUARRY-SHADOW-PS
	EQUAL?	PRSA,V?ENTER \FALSE
	EQUAL?	HERE,QUARRY \?CCL6
	PRINTR	"You are; the tree's shadow covers the entire floor of the quarry."
?CCL6:	CALL2	DO-WALK,P?DOWN
	RSTACK	

	.SEGMENT "0"


	.FUNCT	RUSTY-KEY-F
	EQUAL?	PRSA,V?CLEAN \?CCL3
	FSET	RUSTY-KEY,READBIT
	PRINTR	"You clean off some of the rust, revealing words engraved on the key."
?CCL3:	EQUAL?	PRSA,V?READ \FALSE
	FSET?	RUSTY-KEY,READBIT \FALSE
	PRINTR	"""Frobozz Magic Trunk Key Company"""

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	TOE-FUNGUS-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	EQUAL?	PRSA,V?GIVE,V?FIND \?CCL6
	EQUAL?	PRSO,LITTLE-FUNGUS \?CCL6
	IN?	LITTLE-FUNGUS,GLOBAL-OBJECTS \?CCL6
	EQUAL?	FUNGUS-NUMBER,12 /?CCL6
	GET	FUNGUS-WORDS,FUNGUS-NUMBER
	CALL	NOUN-USED?,LITTLE-FUNGUS,STACK
	ZERO?	STACK /?CCL6
	CALL1	GET-LITTLE-FUNGUS
	RSTACK	
?CCL6:	CALL1	PLANT-STUNNED
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?LISTEN \?CCL13
	ZERO?	PLANT-TALKER /?CCL13
	PRINTR	"You hear a vast murmur of countless little fungi, all discussing spore-care techniques."
?CCL13:	EQUAL?	PRSA,V?RESEARCH \?CCL17
	CALL2	PERFORM-PRSA,EAR-FUNGUS
	RSTACK	
?CCL17:	EQUAL?	PRSA,V?ASK-ABOUT \FALSE
	ZERO?	PLANT-TALKER /FALSE
	EQUAL?	PRSI,LITTLE-FUNGUS \FALSE
	IN?	LITTLE-FUNGUS,GLOBAL-OBJECTS \FALSE
	EQUAL?	FUNGUS-NUMBER,12 /FALSE
	GET	FUNGUS-WORDS,FUNGUS-NUMBER
	CALL	NOUN-USED?,LITTLE-FUNGUS,STACK
	ZERO?	STACK /FALSE
	CALL1	GET-LITTLE-FUNGUS
	RSTACK	


	.FUNCT	GET-LITTLE-FUNGUS
	FSET	LITTLE-FUNGUS,TAKEBIT
	ICALL2	THIS-IS-IT,LITTLE-FUNGUS
	MOVE	LITTLE-FUNGUS,HERE
	PRINTR	"A little fungus trots up and says, ""That's me!"""

	.SEGMENT "0"


	.FUNCT	LITTLE-FUNGUS-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	CALL1	PLANT-STUNNED
	RSTACK	
?CCL3:	IN?	PRSO,GLOBAL-OBJECTS \?CCL5
	EQUAL?	PRSA,V?SAY,V?YELL,V?CALL /?PRD10
	EQUAL?	PRSA,V?FIND \?CCL8
?PRD10:	EQUAL?	HERE,ON-TOP-OF-THE-WORLD \?CCL8
	ZERO?	PLANT-TALKER /?CCL8
	EQUAL?	FUNGUS-NUMBER,12 /?CCL8
	GET	FUNGUS-WORDS,FUNGUS-NUMBER
	CALL	NOUN-USED?,LITTLE-FUNGUS,STACK
	ZERO?	STACK /?CCL8
	CALL1	GET-LITTLE-FUNGUS
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?SAY,V?YELL,V?CALL \?CCL17
	PRINT	NOTHING-HAPPENS
	RTRUE	
?CCL17:	CALL2	HANDLE,LITTLE-FUNGUS
	ZERO?	STACK /?CCL19
	CALL2	CANT-SEE,LITTLE-FUNGUS
	RSTACK	
?CCL19:	PRINT	BY-THAT-NAME
	RTRUE	
?CCL5:	CALL	NOUN-USED?,LITTLE-FUNGUS,W?SEYMOUR,W?SHERMAN,W?IRVING
	ZERO?	STACK \?PRD23
	CALL	NOUN-USED?,LITTLE-FUNGUS,W?SAMMY,W?MYRON,W?BORIS
	ZERO?	STACK \?PRD23
	CALL	NOUN-USED?,LITTLE-FUNGUS,W?MELVIN,W?LESTER,W?JULIUS
	ZERO?	STACK \?PRD23
	CALL	NOUN-USED?,LITTLE-FUNGUS,W?RICARDO,W?OMAR,W?BARNABY
	ZERO?	STACK /?CCL21
?PRD23:	GET	FUNGUS-WORDS,FUNGUS-NUMBER
	CALL	NOUN-USED?,LITTLE-FUNGUS,STACK
	ZERO?	STACK \?CCL21
	CALL2	HANDLE,LITTLE-FUNGUS
	ZERO?	STACK \?CTR20
	EQUAL?	PRSA,V?FOLLOW \?CCL21
?CTR20:	PRINT	BY-THAT-NAME
	CALL1	STOP
	RSTACK	
?CCL21:	EQUAL?	PRSA,V?DROP \?PRD34
	EQUAL?	HERE,EAR /?CCL32
?PRD34:	EQUAL?	PRSA,V?PUT,V?SHOW,V?GIVE /?PRD39
	EQUAL?	PRSA,V?PUT-ON \?PRD37
?PRD39:	EQUAL?	PRSI,EAR-FUNGUS /?CCL32
?PRD37:	EQUAL?	PRSA,V?PUT-ON,V?PUT \FALSE
	EQUAL?	PRSI,BROGMOID \FALSE
	CALL	NOUN-USED?,BROGMOID,W?EAR
	ZERO?	STACK /FALSE
?CCL32:	SET	'EAR-PASSAGE-OPEN,TRUE-VALUE
	REMOVE	LITTLE-FUNGUS
	PRINTI	"There follows a joyful reunion between the little fungus and his long-lost cousins. Grateful, the ear fungi part, forming a passageway leading deeper into the ear."
	CRLF	
	CALL2	INC-SCORE,18
	RSTACK	

	.ENDSEG

	.SEGMENT "0"

	.SEGMENT "ORACLE"


	.FUNCT	BAT-F
	CALL2	TOUCHING?,BAT
	ZERO?	STACK /?CCL3
	FSET?	BAT,TRYTAKEBIT \?CCL3
	PRINTR	"An invisible force prevents you from approaching the wooden club."
?CCL3:	EQUAL?	PRSA,V?SWING \FALSE
	INC	'BAT-SWINGS
	PRINTI	"""Strike "
	PRINTN	BAT-SWINGS
	PRINTC	33
	EQUAL?	BAT-SWINGS,3 \?CCL10
	CALL2	JIGS-UP,STR?883
	RSTACK	
?CCL10:	PRINTR	""""

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	FENCE-PS
	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB,V?CROSS /?CTR2
	EQUAL?	PRSA,V?CLIMB-OVER \?CCL3
?CTR2:	CALL2	DO-WALK,P?SOUTH
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?THROW-OVER \FALSE
	EQUAL?	PRSO,PERCH \?CND8
	SET	'REMOVED-PERCH-LOC,PSEUDO-OBJECT
?CND8:	REMOVE	PRSO
	PRINTI	"A good throw --"
	ICALL1	TPRINT-PRSO
	PRINTR	" sails over the fence and disappears into a tangle of barbed wire beyond."


	.FUNCT	AERIE-F,RARG,OBJ,OWINNER
	EQUAL?	RARG,M-END \?CCL3
	CALL	FIND-IN,PROTAGONIST,ONBIT >OBJ
	ZERO?	OBJ \?PRG8
	CALL1	FIND-LANTERN >OBJ
	ZERO?	OBJ /?CCL3
?PRG8:	SET	'OWINNER,WINNER
	SET	'WINNER,NEST
	CALL2	VISIBLE?,OBJ
	ZERO?	STACK /?CND10
	MOVE	OBJ,CLIFF-BOTTOM
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   ""Caw! Caw!"" A huge black bird swoops down and snatches your "
	ICALL2	DPRINT,OBJ
	PRINTI	" in its mighty talons. It flies westward, drops"
	ICALL2	TPRINT,OBJ
	PRINTR	" over the precipice, and flutters into the clouds."
?CND10:	LOC	OBJ >OBJ
	SET	'WINNER,OWINNER
	JUMP	?PRG8
?CCL3:	EQUAL?	RARG,M-END \FALSE
	RANDOM	100
	LESS?	40,STACK /FALSE
	PRINTR	"   A gust of wind sends a whirl of dust dancing in a circle around the bird's nest."


	.FUNCT	FIND-LANTERN
	CALL2	ULTIMATELY-IN?,LANTERN
	ZERO?	STACK /FALSE
	RETURN	LANTERN


	.FUNCT	NEST-F,VARG
	ZERO?	VARG \FALSE
	EQUAL?	PRSA,V?SEARCH,V?EXAMINE \?CCL5
	IN?	SILK-TIE,LOCAL-GLOBALS \?CCL5
	MOVE	SILK-TIE,NEST
	PRINTR	"Among the items woven into the nest is a faded silk tie!"
?CCL5:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	IN?	SILK-TIE,LOCAL-GLOBALS \?CCL12
	ICALL	PERFORM,V?EXAMINE,NEST
	RTRUE	
?CCL12:	PRINTR	"The nest is, at the moment, birdless."


	.FUNCT	ICKY-CAVE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The walls of this small cavern are covered with thick, black slime. It drips from the stalactites and puddles up on the floor."
	IN?	SICKLY-WITCH,HERE /?CND4
	PRINTI	" Considering the furnishings and relics, this cave must be the home of several witches. However, the witches are either out or hiding."
?CND4:	PRINTI	" The only exit from this tiny cavern is northwest."
	RTRUE	


	.FUNCT	WITCH-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	FSET?	BAT,TRYTAKEBIT \?CCL6
	PRINTI	"""Bring us "
	ZERO?	VIAL-GIVEN /?CCL9
	PRINTI	"earwax of brogmoid"
	JUMP	?CND7
?CCL9:	PRINTI	"exactly six gloops of water from the Great Underground Oasis"
?CND7:	PRINTI	", and we shall remove the enchantment on that which you seek."""
	IN?	LARGE-VIAL,LOCAL-GLOBALS \?CND10
	MOVE	LARGE-VIAL,HERE
	PRINTR	" A vial appears in front of you."
?CND10:	CRLF	
	RTRUE	
?CCL6:	PRINTR	"""Stop pestering us, or we'll restore the enchantment... and worse!"""
?CCL3:	EQUAL?	PRSA,V?GIVE \?CCL13
	EQUAL?	PRSI,SICKLY-WITCH,PRICKLY-WITCH \?CCL13
	ZERO?	LIT \?CCL13
	PRINT	TOO-DARK
	CRLF	
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?GIVE \FALSE
	EQUAL?	PRSO,EARWAX \FALSE
	REMOVE	EARWAX
	SET	'EARWAX-GIVEN,TRUE-VALUE
	ZERO?	VIAL-GIVEN /?CCL23
	FCLEAR	BAT,TRYTAKEBIT
	PRINTI	"""A fine specimen!"" cackles the witch. ""Now, where were we? Ah, yes... "
	PRINTI	"Brogmoid earwax!"
	PRINT	FINISH-ENCHANTMENT
	RTRUE	
?CCL23:	PRINTR	"""Ah, brogmoid ear wax! A goodly portion, too! Always handy to have around."" She squirrels it away."

	.SEGMENT "0"


	.FUNCT	G-VIAL-F,SRES,F
	GET	F,5
	ADD	STACK,10
	GET	STACK,0
	EQUAL?	STACK,W?INT.NUM \FALSE
	GET	F,10
	EQUAL?	STACK,4 \?CCL6
	RETURN	SMALL-VIAL
?CCL6:	GET	F,10
	EQUAL?	STACK,9 \?CCL8
	RETURN	LARGE-VIAL
?CCL8:	RETURN	NOT-HERE-OBJECT


	.FUNCT	CONVERT-NUMBER,ADJS,ADJ
	ADD	ADJS,8
	GET	STACK,1 >ADJ
	EQUAL?	ADJ,W?INT.NUM \?CCL3
	RETURN	P-NUMBER
?CCL3:	GET	INTEGERS,0
	INTBL?	ADJ,INTEGERS,STACK >ADJ \FALSE
	SUB	ADJ,INTEGERS
	DIV	STACK,2
	RSTACK	


	.FUNCT	VIAL-F,NUM,PRSO-VIAL-GLOOPS,PRSI-VIAL-GLOOPS,ADJ
	EQUAL?	PRSO,SMALL-VIAL \?CCL3
	SET	'PRSO-VIAL-GLOOPS,SMALL-VIAL-GLOOPS
	JUMP	?CND1
?CCL3:	SET	'PRSO-VIAL-GLOOPS,LARGE-VIAL-GLOOPS
?CND1:	ZERO?	PRSI /?CND4
	EQUAL?	PRSI,SMALL-VIAL \?CCL8
	SET	'PRSI-VIAL-GLOOPS,SMALL-VIAL-GLOOPS
	JUMP	?CND4
?CCL8:	SET	'PRSI-VIAL-GLOOPS,LARGE-VIAL-GLOOPS
?CND4:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?CCL11
	PRINTI	"The vial "
	ZERO?	PRSO-VIAL-GLOOPS \?CCL14
	PRINTI	"is empty"
	JUMP	?CND12
?CCL14:	PRINTI	"contains "
	EQUAL?	PRSO,LARGE-VIAL \?PRD18
	ZERO?	LARGE-VIAL-IMPRECISE \?CCL16
?PRD18:	EQUAL?	PRSO,SMALL-VIAL \?CND15
	ZERO?	SMALL-VIAL-IMPRECISE /?CND15
?CCL16:	PRINTI	"approximately "
?CND15:	PRINTN	PRSO-VIAL-GLOOPS
	PRINTI	" gloop"
	EQUAL?	PRSO-VIAL-GLOOPS,1 /?CND23
	PRINTC	115
?CND23:	PRINTI	" of water"
?CND12:	PRINTC	46
	EQUAL?	PRSA,V?EXAMINE \?CND25
	PRINTR	" There is some writing etched onto it."
?CND25:	CRLF	
	RTRUE	
?CCL11:	EQUAL?	PRSA,V?READ \?CCL28
	PRINTI	"""Frobozz Magic Vial Company. Capacity (to the brim): "
	EQUAL?	PRSO,LARGE-VIAL \?CCL31
	PRINTC	57
	JUMP	?CND29
?CCL31:	PRINTC	52
?CND29:	PRINTR	" gloops."""
?CCL28:	EQUAL?	PRSA,V?GIVE \?CCL33
	EQUAL?	PRSO,LARGE-VIAL \?CCL33
	EQUAL?	PRSI,PRICKLY-WITCH,SICKLY-WITCH \?CCL33
	EQUAL?	LARGE-VIAL-GLOOPS,6 \?CCL39
	ZERO?	LARGE-VIAL-TAINTED \?CTR41
	ZERO?	LARGE-VIAL-IMPRECISE /?CCL42
?CTR41:	PRINTI	"The witch examines the water, grows angry, and flings it out of the vial. ""This is not "
	ZERO?	LARGE-VIAL-TAINTED /?CCL47
	PRINTI	"pure Oasis water"
	JUMP	?CND45
?CCL47:	PRINTI	"precisely 6 gloops"
?CND45:	SET	'LARGE-VIAL-TAINTED,FALSE-VALUE
	SET	'LARGE-VIAL-GLOOPS,0
	REMOVE	LARGE-VIAL-WATER
	PRINTR	"! You thought we would not know, fool?"" She throws the vial back at you. ""Do not return until you have done EXACTLY as we ask."""
?CCL42:	REMOVE	LARGE-VIAL
	SET	'VIAL-GIVEN,TRUE-VALUE
	PRINTI	"""You have done well,"" croak the witches. ""We shall do as we promised.""
   ""Hair of hellhound!"" calls the sickly witch. The prickly witch rummages around and hands her a clump of coarse black fur.
   ""Toenail of tarantula!"" The prickly witch produces half a handful of clippings.
   ""Spleen of troll!"" The prickly witch hands over a wrinkled organ, caked with dried blood.
   ""Earwax of brogmoid!"
	ZERO?	EARWAX-GIVEN /?CCL50
	FCLEAR	BAT,TRYTAKEBIT
	PRINT	FINISH-ENCHANTMENT
	RTRUE	
?CCL50:	PRINTR	""" The prickly witch rummages around the cave, mumbling with increasing irritation. ""Earwax of yipple. Earwax of sea slug. Earwax of adventurer. Carbuncle of brogmoid. Belly-button lint of brogmoid."" She shakes her head sadly. ""No earwax of brogmoid. I think we used it up last month... you remember... when we conjured up that male stripper...""
   The sickly witch turns to you. ""Sorry, we cannot remove the enchantment until you bring us some brogmoid earwax."""
?CCL39:	PRINTI	"""We asked you for 6 gloops!"" screams the witch. ""No less, no more! Begone, and return not until you do what we ask!"" A fiery bolt shoots from the witches fingers, missing your rump by inches as you scurry from the cave."
	CRLF	
	CRLF	
	CALL2	GOTO,AERIE
	RSTACK	
?CCL33:	EQUAL?	PRSA,V?PUT \?CCL52
	EQUAL?	PRSI,LARGE-VIAL,SMALL-VIAL \?CCL52
	FSET?	PRSO,TAKEBIT \FALSE
	GETP	PRSO,P?SIZE
	GRTR?	STACK,2 \?CCL60
	PRINTR	"The mouth of the vial is too narrow."
?CCL60:	CALL1	WASTES
	RSTACK	
?CCL52:	EQUAL?	PRSA,V?PUT \?CCL62
	EQUAL?	PRSI,WATER \?CCL62
	ICALL	PERFORM,V?FILL,PRSO,WATER
	RTRUE	
?CCL62:	EQUAL?	PRSA,V?FILL \?CCL66
	EQUAL?	PRSI,LAKE-FLATHEAD,OASIS-OBJECT \?CND67
	SET	'PRSI,WATER
?CND67:	EQUAL?	PRSI,WATER \?CCL71
	EQUAL?	PRSO,SMALL-VIAL \?PRD76
	EQUAL?	SMALL-VIAL-GLOOPS,4 /?CTR73
?PRD76:	EQUAL?	PRSO,LARGE-VIAL \?CCL74
	EQUAL?	LARGE-VIAL-GLOOPS,9 \?CCL74
?CTR73:	PRINTI	"The "
	ICALL2	DPRINT,PRSO
	PRINTR	" is already filled to the brim!"
?CCL74:	IN?	PROTAGONIST,HERE /?CCL82
	CALL2	CANT-REACH,WATER
	RSTACK	
?CCL82:	EQUAL?	PRSO,SMALL-VIAL \?CCL84
	EQUAL?	HERE,OASIS /?CND85
	SET	'SMALL-VIAL-TAINTED,TRUE-VALUE
?CND85:	CALL	NOUN-USED?,WATER,W?GLOOP,W?GLOOPS
	ZERO?	STACK /?CCL89
	CALL	ADJ-USED?,WATER,FALSE-VALUE
	ZERO?	STACK \?CCL89
	GET	FINDER,5 >ADJ
	ZERO?	ADJ /?CCL89
	CALL2	CONVERT-NUMBER,ADJ >P-NUMBER
	ZERO?	P-NUMBER /?CCL89
	LESS?	P-NUMBER,4 \?CCL89
	GRTR?	P-NUMBER,0 \?CCL89
	SET	'SMALL-VIAL-GLOOPS,P-NUMBER
	SET	'SMALL-VIAL-IMPRECISE,TRUE-VALUE
	PRINTI	"You fill"
	CALL2	NO-GRADATIONS,P-NUMBER
	RSTACK	
?CCL89:	SET	'SMALL-VIAL-IMPRECISE,FALSE-VALUE
	SET	'SMALL-VIAL-GLOOPS,4
	MOVE	SMALL-VIAL-WATER,SMALL-VIAL
	PRINTR	"You fill the vial to the brim."
?CCL84:	EQUAL?	HERE,OASIS /?CND96
	SET	'LARGE-VIAL-TAINTED,TRUE-VALUE
?CND96:	CALL	NOUN-USED?,WATER,W?GLOOP,W?GLOOPS
	ZERO?	STACK /?CCL100
	CALL	ADJ-USED?,WATER,FALSE-VALUE
	ZERO?	STACK \?CCL100
	GET	FINDER,5 >ADJ
	ZERO?	ADJ /?CCL100
	CALL2	CONVERT-NUMBER,ADJ >P-NUMBER
	ZERO?	P-NUMBER /?CCL100
	LESS?	P-NUMBER,9 \?CCL100
	GRTR?	P-NUMBER,0 \?CCL100
	SET	'LARGE-VIAL-GLOOPS,P-NUMBER
	SET	'LARGE-VIAL-IMPRECISE,TRUE-VALUE
	PRINTI	"You fill"
	CALL2	NO-GRADATIONS,P-NUMBER
	RSTACK	
?CCL100:	SET	'LARGE-VIAL-IMPRECISE,FALSE-VALUE
	SET	'LARGE-VIAL-GLOOPS,9
	MOVE	LARGE-VIAL-WATER,LARGE-VIAL
	PRINTR	"You fill the vial to the brim."
?CCL71:	EQUAL?	PRSO,SMALL-VIAL \?CCL108
	EQUAL?	PRSI,LARGE-VIAL \?CCL108
	CALL	POUR-VIALS,LARGE-VIAL,SMALL-VIAL
	RSTACK	
?CCL108:	EQUAL?	PRSO,LARGE-VIAL \FALSE
	EQUAL?	PRSI,SMALL-VIAL \FALSE
	CALL	POUR-VIALS,SMALL-VIAL,LARGE-VIAL
	RSTACK	
?CCL66:	EQUAL?	PRSA,V?POUR \?CCL116
	EQUAL?	PRSO,LARGE-VIAL,SMALL-VIAL \?CCL116
	ICALL	PERFORM,V?EMPTY,PRSO,PRSI
	RTRUE	
?CCL116:	EQUAL?	PRSA,V?EMPTY \?CCL120
	ZERO?	PRSO-VIAL-GLOOPS \?CCL123
	PRINTR	"The vial is already empty!"
?CCL123:	EQUAL?	PRSO,SMALL-VIAL \?CCL125
	EQUAL?	PRSI,LARGE-VIAL \?CCL125
	CALL	POUR-VIALS,SMALL-VIAL,LARGE-VIAL
	RSTACK	
?CCL125:	EQUAL?	PRSI,SMALL-VIAL \?CCL129
	EQUAL?	PRSO,LARGE-VIAL \?CCL129
	CALL	POUR-VIALS,LARGE-VIAL,SMALL-VIAL
	RSTACK	
?CCL129:	ZERO?	PRSI \?CND132
	ICALL1	SET-GROUND-DESC
	SET	'PRSI,GROUND
?CND132:	EQUAL?	PRSO,SMALL-VIAL \?CCL136
	ICALL2	PRINT-GLOOP,SMALL-VIAL-GLOOPS
	SET	'SMALL-VIAL-TAINTED,FALSE-VALUE
	SET	'SMALL-VIAL-IMPRECISE,FALSE-VALUE
	SET	'SMALL-VIAL-GLOOPS,0
	REMOVE	SMALL-VIAL-WATER
	JUMP	?CND134
?CCL136:	ICALL2	PRINT-GLOOP,LARGE-VIAL-GLOOPS
	SET	'LARGE-VIAL-TAINTED,FALSE-VALUE
	SET	'LARGE-VIAL-IMPRECISE,FALSE-VALUE
	SET	'LARGE-VIAL-GLOOPS,0
	REMOVE	LARGE-VIAL-WATER
?CND134:	EQUAL?	PRSI,ELIXIR,BOWL \?CCL139
	IN?	ELIXIR,BOWL \?CCL139
	REMOVE	ELIXIR
	PRINTR	" The water and elixir undergo a reaction, and both disappear in a cloud of smoke!"
?CCL139:	EQUAL?	PRSI,CUP \?CCL143
	ICALL	PERFORM,V?FILL,CUP,WATER
	RTRUE	
?CCL143:	PRINTI	" The water spills all over"
	ICALL1	TPRINT-PRSI
	PRINTI	" and then evaporates. The "
	ICALL2	DPRINT,PRSO
	PRINTR	" is now empty."
?CCL120:	EQUAL?	PRSA,V?TAKE,V?EMPTY-FROM \FALSE
	EQUAL?	PRSO,WATER \FALSE
	CALL2	GET-NP,PRSO >NUM
	ZERO?	NUM /?CND148
	CALL2	NUMERIC-ADJ?,NUM >NUM
?CND148:	ZERO?	NUM \?CND150
	CALL2	GET-NP,PRSO
	GET	STACK,1 >NUM
	ZERO?	NUM /?CND150
	CALL2	CONVERT-NUMBER,NUM >NUM
?CND150:	ZERO?	NUM \?CND154
	SET	'NUM,PRSI-VIAL-GLOOPS
?CND154:	ZERO?	PRSI-VIAL-GLOOPS \?CCL158
	PRINTR	"The vial is empty!"
?CCL158:	GRTR?	NUM,PRSI-VIAL-GLOOPS \?CCL160
	PRINTI	"There "
	EQUAL?	PRSI-VIAL-GLOOPS,1 /?CCL163
	PRINTI	"are"
	JUMP	?CND161
?CCL163:	PRINTI	"is"
?CND161:	PRINTI	" only "
	PRINTN	PRSI-VIAL-GLOOPS
	PRINTI	" gloop"
	EQUAL?	PRSI-VIAL-GLOOPS,1 /?CND164
	PRINTC	115
?CND164:	PRINTI	" in"
	CALL2	TRPRINT,PRSI
	RSTACK	
?CCL160:	ICALL2	PRINT-GLOOP,NUM
	SUB	PRSI-VIAL-GLOOPS,NUM >PRSI-VIAL-GLOOPS
	ZERO?	PRSI-VIAL-GLOOPS \?CCL168
	EQUAL?	PRSI,LARGE-VIAL \?CCL171
	SET	'LARGE-VIAL-GLOOPS,0
	SET	'LARGE-VIAL-IMPRECISE,FALSE-VALUE
	SET	'LARGE-VIAL-TAINTED,FALSE-VALUE
	REMOVE	LARGE-VIAL-WATER
	JUMP	?CND169
?CCL171:	SET	'SMALL-VIAL-GLOOPS,0
	REMOVE	SMALL-VIAL-WATER
	SET	'SMALL-VIAL-IMPRECISE,FALSE-VALUE
	SET	'SMALL-VIAL-TAINTED,FALSE-VALUE
?CND169:	PRINTI	" You completely empty"
	CALL2	TRPRINT,PRSI
	RSTACK	
?CCL168:	EQUAL?	PRSI,LARGE-VIAL \?CCL174
	SUB	LARGE-VIAL-GLOOPS,NUM >LARGE-VIAL-GLOOPS
	MOVE	LARGE-VIAL-WATER,LARGE-VIAL
	SET	'LARGE-VIAL-IMPRECISE,TRUE-VALUE
	JUMP	?CND172
?CCL174:	SUB	SMALL-VIAL-GLOOPS,NUM >SMALL-VIAL-GLOOPS
	MOVE	SMALL-VIAL-WATER,SMALL-VIAL
	SET	'SMALL-VIAL-IMPRECISE,TRUE-VALUE
?CND172:	PRINTI	" You pour"
	CALL2	NO-GRADATIONS,PRSI-VIAL-GLOOPS
	RSTACK	


	.FUNCT	NO-GRADATIONS,VIAL-GLOOPS
	PRINTI	" as carefully as you can, and it appears to the naked eye that there "
	EQUAL?	VIAL-GLOOPS,1 /?CCL3
	PRINTI	"are"
	JUMP	?CND1
?CCL3:	PRINTI	"is"
?CND1:	PRINTI	" now "
	PRINTN	VIAL-GLOOPS
	PRINTI	" gloop"
	EQUAL?	VIAL-GLOOPS,1 /?CND4
	PRINTC	115
?CND4:	PRINTR	" in the vial. However, since there are no gradations on the vial, it's impossible to be certain."


	.FUNCT	PRINT-GLOOP,NUM
	PRINTC	34
?PRG1:	PRINTI	"Gloop!"
	DLESS?	'NUM,1 /?REP2
	PRINTC	32
	JUMP	?PRG1
?REP2:	PRINTC	34
	RTRUE	


	.FUNCT	POUR-VIALS,FROM-VIAL,TO-VIAL,SPARE-ROOM
	EQUAL?	TO-VIAL,LARGE-VIAL \?CCL3
	SUB	9,LARGE-VIAL-GLOOPS >SPARE-ROOM
	JUMP	?CND1
?CCL3:	SUB	4,SMALL-VIAL-GLOOPS >SPARE-ROOM
?CND1:	ZERO?	SPARE-ROOM \?CCL6
	PRINTI	"But"
	ICALL2	TPRINT,TO-VIAL
	PRINTR	" is already filled to the brim!"
?CCL6:	EQUAL?	FROM-VIAL,LARGE-VIAL \?CCL8
	GRTR?	LARGE-VIAL-GLOOPS,SPARE-ROOM \?CCL11
	ZERO?	LARGE-VIAL-TAINTED /?CND12
	SET	'SMALL-VIAL-TAINTED,TRUE-VALUE
?CND12:	ICALL2	PRINT-GLOOP,SPARE-ROOM
	SUB	LARGE-VIAL-GLOOPS,SPARE-ROOM >LARGE-VIAL-GLOOPS
	MOVE	LARGE-VIAL-WATER,LARGE-VIAL
	ZERO?	SMALL-VIAL-IMPRECISE /?CND14
	SET	'LARGE-VIAL-IMPRECISE,TRUE-VALUE
?CND14:	SET	'SMALL-VIAL-IMPRECISE,FALSE-VALUE
	SET	'SMALL-VIAL-GLOOPS,4
	MOVE	SMALL-VIAL-WATER,SMALL-VIAL
	PRINTI	" The "
	ICALL2	DPRINT,TO-VIAL
	PRINTR	" is now filled to the brim."
?CCL11:	ICALL2	PRINT-GLOOP,LARGE-VIAL-GLOOPS
	ZERO?	LARGE-VIAL-TAINTED /?CND16
	SET	'SMALL-VIAL-TAINTED,TRUE-VALUE
?CND16:	ADD	SMALL-VIAL-GLOOPS,LARGE-VIAL-GLOOPS >SMALL-VIAL-GLOOPS
	MOVE	SMALL-VIAL-WATER,SMALL-VIAL
	SET	'LARGE-VIAL-GLOOPS,0
	SET	'LARGE-VIAL-TAINTED,FALSE-VALUE
	REMOVE	LARGE-VIAL-WATER
	ZERO?	LARGE-VIAL-IMPRECISE /?CND18
	SET	'LARGE-VIAL-IMPRECISE,FALSE-VALUE
	SET	'SMALL-VIAL-IMPRECISE,TRUE-VALUE
?CND18:	PRINTI	" The "
	ICALL2	DPRINT,LARGE-VIAL
	PRINTI	" has been completely emptied into"
	CALL2	TRPRINT,SMALL-VIAL
	RSTACK	
?CCL8:	GRTR?	SMALL-VIAL-GLOOPS,SPARE-ROOM \?CCL21
	ZERO?	SMALL-VIAL-TAINTED /?CND22
	SET	'LARGE-VIAL-TAINTED,TRUE-VALUE
?CND22:	ICALL2	PRINT-GLOOP,SPARE-ROOM
	SUB	SMALL-VIAL-GLOOPS,SPARE-ROOM >SMALL-VIAL-GLOOPS
	MOVE	SMALL-VIAL-WATER,SMALL-VIAL
	SET	'LARGE-VIAL-GLOOPS,9
	MOVE	LARGE-VIAL-WATER,LARGE-VIAL
	ZERO?	LARGE-VIAL-IMPRECISE /?CND24
	SET	'SMALL-VIAL-IMPRECISE,TRUE-VALUE
?CND24:	SET	'LARGE-VIAL-IMPRECISE,FALSE-VALUE
	PRINTI	" The "
	ICALL2	DPRINT,LARGE-VIAL
	PRINTR	" is now filled to the brim."
?CCL21:	ZERO?	SMALL-VIAL-TAINTED /?CND26
	SET	'LARGE-VIAL-TAINTED,TRUE-VALUE
?CND26:	ICALL2	PRINT-GLOOP,SMALL-VIAL-GLOOPS
	ADD	LARGE-VIAL-GLOOPS,SMALL-VIAL-GLOOPS >LARGE-VIAL-GLOOPS
	MOVE	LARGE-VIAL-WATER,LARGE-VIAL
	SET	'SMALL-VIAL-GLOOPS,0
	REMOVE	SMALL-VIAL-WATER
	ZERO?	SMALL-VIAL-IMPRECISE /?CND28
	SET	'LARGE-VIAL-IMPRECISE,TRUE-VALUE
?CND28:	SET	'SMALL-VIAL-IMPRECISE,FALSE-VALUE
	PRINTI	" The "
	ICALL2	DPRINT,SMALL-VIAL
	PRINTI	" has been completely emptied into"
	CALL2	TRPRINT,LARGE-VIAL
	RSTACK	

	.ENDSEG

	.SEGMENT "ORACLE"


	.FUNCT	RUBBLE-ROOM-F,RARG
	EQUAL?	RARG,M-END \FALSE
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   "
	FSET?	HARDHAT,WORNBIT \?CCL6
	PRINTI	"Clunk! A bit of rubble bounces off your hardhat."
	CRLF	
	ICALL2	INC-SCORE,RUBBLE-SCORE
	SET	'RUBBLE-SCORE,0
	RTRUE	
?CCL6:	CALL2	JIGS-UP,STR?894
	RSTACK	


	.FUNCT	GRANOLA-MINE-F
	EQUAL?	PRSA,V?ENTER \?CCL3
	EQUAL?	HERE,MINE-ENTRANCE \?CCL6
	CALL2	DO-WALK,P?IN
	RSTACK	
?CCL6:	PRINT	LOOK-AROUND
	RTRUE	
?CCL3:	EQUAL?	HERE,MINE-ENTRANCE /FALSE
	CALL2	PERFORM-PRSA,GLOBAL-HERE
	RSTACK	


	.FUNCT	GRANOLA-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	CALL2	STEP-IN-IT,STR?898
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TASTE,V?EAT \?CCL5
	CALL2	STEP-IN-IT,STR?899
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?SMELL \?CCL7
	CALL2	STEP-IN-IT,STR?900
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?ENTER,V?STAND-ON \?CCL9
	PRINTR	"Oh, yechh!"
?CCL9:	CALL2	TOUCHING?,GRANOLA
	ZERO?	STACK /FALSE
	CALL2	STEP-IN-IT,STR?901
	RSTACK	


	.FUNCT	STEP-IN-IT,STRING
	PRINTI	"It "
	PRINT	STRING
	PRINTR	" just like granola. Good thing you didn't step in it."

	.ENDSEG

	.ENDI
