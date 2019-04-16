
	.SEGMENT "STARTUP"


	.FUNCT	SETUP-SCREEN,?TMP1
	GETB	0,39 >FONT-X
	GETB	0,38 >FONT-Y
	MOUSE-LIMIT	-1
	GET	0,8
	BTST	STACK,32 \?CND1
	SET	'ACTIVE-MOUSE,TRUE-VALUE
?CND1:	GET	0,18 >?TMP1
	GET	0,17
	WINSIZE	S-FULL,?TMP1,STACK
	GETB	0,33 >WIDTH
	RETURN	WIDTH


	.FUNCT	GO
?FCN:	ICALL1	SETUP-SCREEN
	SET	'TOWER-BEATEN,PYRAMID
	SET	'CLOAK-LOC,CLOTHES-CLOSET
	ZERO?	DEMO-VERSION? /?CND1
	RANDOM	7
	SUB	STACK,1
	GET	SLAB-TABLE,STACK >HOLEY-SLAB
	ICALL1	SLIDE-SHOW
	JUMP	?FCN
?CND1:	SET	'CURRENT-SPLIT,TEXT-WINDOW-PIC-LOC
	SET	'CURRENT-BORDER,CASTLE-BORDER
	ICALL	QUEUE,I-GIVE-OBJECT,-1
	ICALL	QUEUE,I-PROLOGUE,-1
	ICALL	QUEUE,I-TAKE-OBJECT,-1
	ICALL1	V-$REFRESH
	CRLF	
	ICALL2	MARGINAL-PIC,PROLOGUE-LETTER
	DIROUT	D-SCREEN-OFF
	PRINTC	65
	DIROUT	D-SCREEN-ON
	PRINTI	"nother frantic day at the castle; Lord Dimwit Flathead the Excessive has invited a few thousand friends over for dinner. Three hundred dragons have been slaughtered for the occasion, and the kitchen is suffocated by the stench of their roasting flesh."
	CRLF	
	ICALL1	CLEAR-CRCNT
	CRLF	
	ICALL1	V-LOOK
	ICALL1	I-PROLOGUE
	ICALL1	I-GIVE-OBJECT
	ICALL1	MAIN-LOOP
	JUMP	?FCN


	.FUNCT	CLEAR-CRCNT,NUM
	WINGET	S-TEXT,WCRCNT >NUM
?PRG1:	ZERO?	NUM /TRUE
	CRLF	
	DEC	'NUM
	JUMP	?PRG1


	.FUNCT	SLIDE-SHOW-HANDLER
	SET	'DEMO-VERSION?,1
	RTRUE	


	.FUNCT	SLIDE-SHOW,RM,?TMP1
	GET	0,18 >?TMP1
	GET	0,17
	WINSIZE	S-TEXT,?TMP1,STACK
	ICALL1	TITLE-SCREEN
	INPUT	1,SLIDE-SHOW-TIMEOUT,SLIDE-SHOW-HANDLER
	CLEAR	-1
	PRINTI	"This is a demonstration version of ZORK ZERO: The Revenge of Megaboz
Copyright (c) 1988 by Infocom, Inc. All rights reserved.

	First you will see a few samples of the graphic screens that await you in ZORK ZERO.We've used graphics in surprising new ways to enhance the story without detracting from Infocom's traditional richness and depth.
	Then you will be able to interact with a small section of ZORK ZERO.Feel free to try the new friendlier parser, the optional mouse interface, and the on-screen hints.Solve a couple of puzzles.Meet the quizzical jester, who will test you with games, riddles, or tricks.
	ZORK ZERO is the ""prequel"" to the ZORK trilogy, the best-selling computer entertainment of all time.In ZORK ZERO the Great Underground Empire is in its heyday, and no adventurer has yet set foot in the ""open field west of a white house.""But the inhabitants are fleeing in the wake of a dread wizard's curse, which has already disposed of the royal Flathead family and threatens to destroy the entire kingdom -- unless you can stop it. 	Hit any key to begin..."
	INPUT	1,DEMO-TIMEOUT,SLIDE-SHOW-HANDLER
	CLEAR	-1
	ICALL	PICTURED-ENTRY,MEGABOZ-ILL,MEGABOZ-TEXT,TRUE-VALUE
	SCREEN	S-FULL
	CURSET	1,1
	INPUT	1,SLIDE-SHOW-TIMEOUT,SLIDE-SHOW-HANDLER
	CLEAR	-1
	SCREEN	S-FULL
	DISPLAY	REBUS-1,1,1
	INPUT	1,SLIDE-SHOW-TIMEOUT,SLIDE-SHOW-HANDLER
	CLEAR	-1
	FIRST?	ROOMS >RM /?PRG2
?PRG2:	ZERO?	RM /?REP3
	GETP	RM,P?MAP-LOC
	GET	STACK,0
	EQUAL?	FOOZLE-MAP-NUM,STACK \?CND4
	FSET	RM,TOUCHBIT
?CND4:	NEXT?	RM >RM /?PRG2
	JUMP	?PRG2
?REP3:	SET	'HERE,CROSSROADS
	SET	'MAP-NOTE,TRUE-VALUE
	ICALL1	DO-MAP
	INPUT	1,SLIDE-SHOW-TIMEOUT,SLIDE-SHOW-HANDLER
	CLEAR	-1
	ICALL1	SETUP-CARDS
	PUT	F-CARD-TABLE,0,7
	PUT	F-CARD-TABLE,1,10
	PUT	F-CARD-TABLE,2,16
	PUT	F-CARD-TABLE,4,11
	PUT	F-CARD-TABLE,5,15
	PUT	F-CARD-TABLE,6,0
	PUT	F-CARD-TABLE,8,8
	PUT	F-CARD-TABLE,9,5
	ICALL1	SETUP-FANUCCI
	SCREEN	S-FULL
	CURSET	1,1
	INPUT	1,SLIDE-SHOW-TIMEOUT,SLIDE-SHOW-HANDLER
	CLEAR	-1
	SET	'CURRENT-SPLIT,TEXT-WINDOW-PIC-LOC
	SET	'CURRENT-BORDER,CASTLE-BORDER
	ICALL1	V-$REFRESH
	PRINTI	"Now you are welcome to interact with a demonstration version of

"
	ICALL1	V-VERSION
	CRLF	
	MOVE	DIRIGIBLE,SMALLER-HANGAR
	PUTP	GONDOLA,P?REGION,STR?249
	MOVE	RECIPE,RUINED-HALL
	PUTP	ROOSTER,P?FDESC,0
	MOVE	ROOSTER,DESERTED-CASTLE
	PUTP	DESERTED-CASTLE,P?ACTION,DESERTED-CASTLE-F
	PUTP	FOX,P?FDESC,0
	MOVE	FOX,SMALLER-HANGAR
	PUTP	SMALLER-HANGAR,P?ACTION,SMALLER-HANGAR-F
	MOVE	WORM,HOTHOUSE
	WINPUT	S-TEXT,15,-999
	SET	'PROLOGUE-NOVICE-COUNTER,0
	ICALL2	GOTO,RUINED-HALL
	CALL1	MAIN-LOOP
	RSTACK	


	.FUNCT	READ-DEMO,ARG1,ARG2,CHR
	SET	'DEMO-VERSION?,-1
	READ	ARG1,ARG2,DEMO-TIMEOUT,SLIDE-SHOW-HANDLER >CHR
	EQUAL?	DEMO-VERSION?,1 \?CCL4
	CALL1	END-DEMO
	RSTACK	
?CCL4:	WINPUT	S-TEXT,15,-999
	RETURN	CHR


	.FUNCT	INPUT-DEMO,ARG,CHR
	SET	'DEMO-VERSION?,-1
	INPUT	ARG,DEMO-TIMEOUT,SLIDE-SHOW-HANDLER >CHR
	EQUAL?	DEMO-VERSION?,1 \?CCL4
	CALL1	END-DEMO
	RSTACK	
?CCL4:	WINPUT	S-TEXT,15,-999
	RETURN	CHR


	.FUNCT	END-DEMO
?FCN:	CLEAR	-1
	PRINTI	"
You have reached the end of this demonstration version of
"
	ICALL1	V-VERSION
	PRINTI	"

Hit any key to start over..."
	INPUT	1,SLIDE-SHOW-TIMEOUT,SLIDE-SHOW-HANDLER
	SCREEN	S-TEXT
	COLOR	1,1
	RESTART	
	PRINT	FAILED
	JUMP	?FCN

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	BANQUET-FOOD-F
	EQUAL?	PRSA,V?TASTE,V?DRINK,V?EAT /?CCL3
	EQUAL?	PRSA,V?TAKE,V?TOUCH \FALSE
?CCL3:	PRINTR	"The food and drink is for the guests, not the servants."


	.FUNCT	SMOKE-PS
	EQUAL?	PRSA,V?SMELL \?CCL3
	ICALL	PERFORM,V?SMELL,CAULDRON
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?ENTER \?CCL5
	PRINTR	"""Choke, choke, cough, cough."""
?CCL5:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,HANDS \FALSE
	PRINT	NOTHING-HAPPENS
	RTRUE	


	.FUNCT	BANQUET-HALL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK /?CCL6
	PRINTI	"The hall is filled to capacity, and the thousands of reveling guests are raising quite a din"
	JUMP	?CND4
?CCL6:	PRINTI	"Many royal feasts have been held in this hall, which could easily hold ten thousand guests. Legends say that Dimwit's more excessive banquets would require the combined farm outputs of three provinces"
?CND4:	PRINTI	". The primary exits are to the west and south; smaller openings lead east and northeast."
	RTRUE	


	.FUNCT	KITCHEN-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK /?CCL6
	PRINTI	"You are assaulted by waves of greasy odors and buffetted by mobs of bustling cooks and servants"
	JUMP	?CND4
?CCL6:	PRINTI	"Although this is the largest cooking area in the Empire, it must've still been crowded when all 600 of Dimwit's chefs were working at the same time"
?CND4:	PRINTI	". There are passages to the west and north, and a stair leads downward"
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK \?CND7
	PRINTI	" into darkness"
?CND7:	PRINTC	46
	RTRUE	


	.FUNCT	SCULLERY-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is where the castle's pots and pans, the output of the forges of Borphee for three years, are cleaned and stored. Passages open to the south and southwest, and a stair descends"
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK \?CND4
	PRINTI	" into darkness"
?CND4:	PRINTC	46
	RTRUE	

	.SEGMENT "0"


	.FUNCT	STRAW-F
	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL3
	IN?	STRAW,BOWL \?CCL6
	PRINT	ONLY-BLACKNESS
	RTRUE	
?CCL6:	PRINTR	"You see a point of light: the far end of the straw."
?CCL3:	EQUAL?	PRSA,V?SUCK-WITH \?CCL8
	EQUAL?	PRSI,STRAW \?CCL8
	ICALL	PERFORM,V?DRINK-WITH,PRSO,STRAW
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?SUCK-ON \?CCL12
	SET	'FINGER-ON-STRAW,FALSE-VALUE
	SET	'ELIXIR-TRAPPED,FALSE-VALUE
	IN?	STRAW,BOWL \?CCL15
	ICALL	PERFORM,V?DRINK-WITH,ELIXIR,STRAW
	RTRUE	
?CCL15:	PRINTR	"You suck some air through the straw."
?CCL12:	EQUAL?	PRSA,V?INFLATE \?CCL17
	SET	'FINGER-ON-STRAW,FALSE-VALUE
	SET	'ELIXIR-TRAPPED,FALSE-VALUE
	PRINTI	"Air "
	IN?	STRAW,BOWL \?CCL20
	PRINTI	"bubbles up through the elixir"
	JUMP	?CND18
?CCL20:	PRINTI	"blows out the far end of the straw"
?CND18:	PRINTR	". Wow."
?CCL17:	EQUAL?	PRSA,V?TAKE \FALSE
	ZERO?	FINGER-ON-STRAW /FALSE
	ZERO?	ELIXIR-TRAPPED /FALSE
	IN?	STRAW,BOWL \FALSE
	SET	'FINGER-ON-STRAW,FALSE-VALUE
	SET	'ELIXIR-TRAPPED,FALSE-VALUE
	MOVE	STRAW,PROTAGONIST
	PRINTI	"As you lift the straw with your finger over the end of it, the elixir within is trapped. Then the suction breaks, and the elixir dribbles onto you. "
	CALL1	TOUCH-ELIXIR
	RSTACK	

	.ENDSEG

	.SEGMENT "LAKE"


	.FUNCT	TOUCH-ELIXIR
	PRINTI	"The liquid feels warm and cleansing."
	FSET?	LARGE-FLY,TRYTAKEBIT \?CCL3
	FCLEAR	LARGE-FLY,TRYTAKEBIT
	FCLEAR	LARGER-FLY,TRYTAKEBIT
	FCLEAR	EVEN-LARGER-FLY,TRYTAKEBIT
	FCLEAR	LARGEST-FLY,TRYTAKEBIT
	PRINTI	" You experience a wave of ecstasy, accompanied by a brief desire to spin a cocoon, collect sap, and eat animal excrement."
	CRLF	
	CALL2	INC-SCORE,16
	RSTACK	
?CCL3:	CRLF	
	RTRUE	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	I-FINGER-OFF-STRAW,TOLD
	ZERO?	FINGER-ON-STRAW /?CND1
	CALL2	VISIBLE?,STRAW
	ZERO?	STACK /?CND1
	ICALL1	RETURN-FROM-MAP
	SET	'TOLD,TRUE-VALUE
	PRINTI	"   Your finger gets tired, so you remove it from the end of the straw."
	CRLF	
?CND1:	SET	'FINGER-ON-STRAW,FALSE-VALUE
	SET	'ELIXIR-TRAPPED,FALSE-VALUE
	ZERO?	TOLD \TRUE
	RFALSE	

	.ENDSEG

	.SEGMENT "0"

	.SEGMENT "CASTLE"


	.FUNCT	UNOPENED-NUT-F
	EQUAL?	PRSA,V?SHAKE \?CCL3
	PRINTR	"A nut rattles around within."
?CCL3:	EQUAL?	PRSA,V?OPEN \?CCL5
	EQUAL?	PRSI,HAMMER \?CCL5
	ICALL	PERFORM,V?MUNG,PRSO,HAMMER
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?MUNG,V?LOOK-INSIDE,V?OPEN /?PRD11
	EQUAL?	PRSA,V?KILL \?CCL9
?PRD11:	EQUAL?	PRSO,UNOPENED-NUT \?CCL9
	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \?CCL16
	FSET?	GOGGLES,WORNBIT \?CCL16
	ICALL	PERFORM,V?LOOK-INSIDE,NUT-SHELL
	RTRUE	
?CCL16:	ZERO?	PRSI \?CCL20
	PRINTI	"This is one tough shell. You can't seem to crack it with your "
	ZERO?	ALLIGATOR /?CCL23
	PRINTI	"paws"
	JUMP	?CND21
?CCL23:	PRINTI	"hands"
?CND21:	PRINT	PERIOD-CR
	RTRUE	
?CCL20:	EQUAL?	PRSI,LOBSTER \?CCL25
	FSET?	PRSI,ANIMATEDBIT /?CCL25
	CALL2	VISIBLE?,JESTER
	ZERO?	STACK /?CND28
	PRINTI	"The jester watches with interest. "
	SET	'NUT-OPENED,TRUE-VALUE
?CND28:	LOC	UNOPENED-NUT
	MOVE	NUT-SHELL,STACK
	MOVE	NUT,NUT-SHELL
	ICALL2	THIS-IS-IT,NUT
	REMOVE	UNOPENED-NUT
	PRINTR	"""Crack!"" Opening the walnut shell reveals a walnut."
?CCL25:	EQUAL?	PRSA,V?KILL,V?MUNG \?CCL31
	GETP	PRSI,P?SIZE
	GRTR?	STACK,15 \?CCL31
	REMOVE	UNOPENED-NUT
	PRINTR	"This succeeds in crushing the shell (and its contents) to dust."
?CCL31:	PRINT	YOU-CANT
	PRINTI	"open a nutshell with"
	CALL2	ARPRINT,PRSI
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?PUT-ON \?CCL35
	EQUAL?	PRSI,UNOPENED-NUT \?CCL35
	GETP	PRSO,P?SIZE
	GRTR?	STACK,14 \?CCL35
	ICALL	PERFORM,V?MUNG,UNOPENED-NUT,PRSO
	RTRUE	
?CCL35:	EQUAL?	PRSA,V?STAND-ON \FALSE
	FSET?	UNOPENED-NUT,OPENBIT /FALSE
	PRINTR	"Even your full weight is insufficient to crack the shell (you lightweight you)."


	.FUNCT	NUT-SHELL-F
	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINT	YOU-CANT
	PRINTR	"reclose the shell! Don't fret, though. Instead, remember that old Miznian proverb: ""It's no use crying over cracked nutshells."""


	.FUNCT	NUT-F
	EQUAL?	PRSA,V?EAT \FALSE
	REMOVE	NUT
	CALL2	VISIBLE?,JESTER
	ZERO?	STACK /?CCL6
	ZERO?	NUT-SHOWN /?CCL9
	SET	'NUT-EATEN,TRUE-VALUE
	PRINTI	"""I'm very impressed; you passed my test! When you exit from the West Wing, I'll no longer be molesting."""
	ICALL1	J-EXITS
	CALL2	INC-SCORE,20
	RSTACK	
?CCL9:	PRINTR	"You swallow the walnut. ""I guess you don't win, place, or show!"" comments the jester enigmatically."
?CCL6:	PRINTR	"The walnut is tasty, but hardly filling."

	.ENDSEG

	.SEGMENT "STARTUP"

	.SEGMENT "CASTLE"


	.FUNCT	I-PROLOGUE
	EQUAL?	HERE,BANQUET-HALL \FALSE
	INC	'PROLOGUE-COUNTER
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   "
	EQUAL?	PROLOGUE-COUNTER,1 \?CCL5
	FCLEAR	DIMWIT,NDESCBIT
	PRINTR	"Dimwit is seated at the dais. His loud voice carries across the crowded hall. ""Now that the statue is done, we must do something ceremonial. I have it! A dedication! We'll give everyone in the kingdom a year off and invite them to the Fublio Valley..."""
?CCL5:	EQUAL?	PROLOGUE-COUNTER,2 \?CCL7
	PRINTR	"Dimwit is ranting at his advisors. ""There's not enough in the royal treasury to build my new continent, Lord Feepness? Then we'll increase the tax levy! It's only 98%! That still leaves two percent!""
   ""With all deference, your Lordship, people are refusing to pay even the 98%. Your decree, 'Anyone withholding payment shall be killed along with everyone they've ever met' simply isn't working. If you increase it to 100%, the people..."""
?CCL7:	EQUAL?	PROLOGUE-COUNTER,3 \?CCL9
	ICALL2	DEQUEUE,I-TAKE-OBJECT
	ICALL2	DEQUEUE,I-GIVE-OBJECT
	MOVE	MEGABOZ,HERE
	SET	'PROLOGUE-NOVICE-COUNTER,6
	PRINTR	"""How about this?"" shouts Dimwit with his mouth full of dragon meat. ""I'll adopt everyone in the kingdom... and then I'll announce that they've been naughty and I've cut off their allowance! It's inspired! Lord Feepness, draw up the proclam...""
   Dimwit is interrupted by an explosion of billowing smoke in the center of the hall. A gaunt, bearded man strides forth from the smoke!"
?CCL9:	EQUAL?	PROLOGUE-COUNTER,4 \?CCL11
	MOVE	PARCHMENT,MEGABOZ
	SET	'PROLOGUE-NOVICE-COUNTER,7
	PRINTR	"""Show me the one responsible for the statue!"" bellows the newcomer. ""The statue that now darkens Fublio!"" Every head silently turns toward Dimwit, whose delight at the pyrotechnics is now tinged by fear. ""Go away,"" orders Dimwit, waving a shaky hand at the stranger. ""This is a private function.""
   Ignoring the order, the newcomer paces forward, until he is standing almost next to you. A scrap of parchment protrudes from his pocket. ""My favorite grove of shade trees now lies beneath the toe of that cursed statue! No man, be he peasant or king, crosses Megaboz the Magnificent!"" He raises his arms, and every guest who knows how dangerous an angry wizard can be begins diving under the tables."
?CCL11:	EQUAL?	PROLOGUE-COUNTER,5 \?CCL13
	PRINTI	"""Dimwit, thy kingship is a mockery of all worldly values! I curse your life! I curse your family! And I curse your Empire!"" Sheets of power begin spewing from his fingertips. ""Frobnitz! Frobnosia! Prob Fset Cond! Zmemqb Intbl Foo!"" As the last word is spoken, the wizard turns into a vast fireball which explodes outward, searing everything in its path"
	ZERO?	UNDER-TABLE \?CCL16
	CALL2	JIGS-UP,STR?264
	RSTACK	
?CCL16:	REMOVE	MEGABOZ
	FCLEAR	PARCHMENT,NDESCBIT
	MOVE	PARCHMENT,HERE
	MOVE	CAULDRON,HERE
	SET	'PROLOGUE-NOVICE-COUNTER,8
	PRINTR	". Then, silence.
   You slowly open your eyes, and where last you saw Megaboz, there now sits a huge black cauldron, bubbling and roiling and spewing noisome fumes. All eyes are transfixed on the incredible cauldron; you seem to be the only one who notices the parchment scrap which Megaboz has dropped on the stone floor, just beyond your reach."
?CCL13:	EQUAL?	PROLOGUE-COUNTER,6 \?CCL18
	SET	'PROLOGUE-NOVICE-COUNTER,9
	PRINTR	"Many of the guests are burned and dying. This doesn't seem to bother Dimwit much, but he does seem concerned by the bubbling cauldron. He summons his court magicians, who huddle about the cauldron, sampling the brew, casting exploratory spells, studying the words of Megaboz's spell, and whispering among themselves.
    Finally, they seem to reach an agreement. Combining their powers, the magicians chant a long and mysterious spell. Then, drained of energy, they turn to Dimwit."
?CCL18:	EQUAL?	PROLOGUE-COUNTER,7 \FALSE
	PRINTI	"""We have done our best, your Lordship,"" begins the chief magician, ""but the spell of Megaboz is a mighty one indeed. We delayed its effects for 94 years, but after that time, this castle -- in fact, all the eastlands -- will be destroyed.""
   Dimwit shrugs. ""Big deal! I won't be around in 94 years!""
   ""Truer than you think,"" continues the chief magician. ""There's more to the Curse. Lordship, you and your eleven siblings are doomed!""
   ""Doomed?"" whines Dimwit. ""As in dead? That's not fair! When?""
   ""Moonrise, perhaps a bit later..."" The king lurches suddenly and collapses onto his dinner. ""...perhaps a bit sooner.""
   Dimwit's personal physician rushes to the stricken king, and then looks solemnly at the assembled guests. ""The king is dead!"""
	CRLF	
	ICALL2	DEQUEUE,I-PROLOGUE
	SET	'MOVES,0
	SET	'CLOCK-WAIT,TRUE-VALUE
	IN?	PARCHMENT,PROTAGONIST \?CCL23
	MOVE	PARCHMENT,GREAT-HALL
	JUMP	?CND21
?CCL23:	REMOVE	PARCHMENT
?CND21:	ICALL1	STOP
	ICALL2	ROB,PROTAGONIST
	REMOVE	DIMWIT
	REMOVE	HELLHOUND-BONES
	REMOVE	ROC-TERIYAKI
	REMOVE	CAKE
	REMOVE	KEG
	REMOVE	LINEN
	MOVE	UNOPENED-NUT,ROOT-CELLAR
	MOVE	STRAW,SCULLERY
	MOVE	CALENDAR,GREAT-HALL
	MOVE	PROCLAMATION,ENTRANCE-HALL
	FCLEAR	BANQUET-HALL,TOUCHBIT
	FCLEAR	SCULLERY,TOUCHBIT
	FCLEAR	KITCHEN,TOUCHBIT
	FCLEAR	ROOT-CELLAR,ONBIT
	FCLEAR	WINE-CELLAR,ONBIT
	SET	'UNDER-TABLE,FALSE-VALUE
	REMOVE	TABLES
	MOVE	CROWN,TREASURE-CHEST
	FSET	CROWN,TAKEBIT
	FCLEAR	CROWN,NDESCBIT
	MOVE	ROBE,TRUNK
	FSET	ROBE,TAKEBIT
	RANDOM	12
	SUB	STACK,1 >MID-NAME-NUM
	RANDOM	2400 >DIAL-NUMBER
	RANDOM	7
	SUB	STACK,1
	GET	SLAB-TABLE,STACK >HOLEY-SLAB
	REMOVE	BANQUET-FOOD
	CRLF	
	CRLF	
	ICALL1	HIT-ANY-KEY
	ICALL1	TITLE-SCREEN
	INPUT	1
	ICALL1	MOUSE-INPUT?
	SET	'CURRENT-SPLIT,TEXT-WINDOW-PIC-LOC
	ICALL1	V-$REFRESH
	ICALL1	V-VERSION
	HLIGHT	H-BOLD
	CRLF	
	PRINTI	"94 YEARS LATER"
	PRINT	ELLIPSIS
	HLIGHT	H-NORMAL
	ICALL2	MARGINAL-PIC,MAIN-LETTER
	DIROUT	D-SCREEN-OFF
	PRINTC	89
	DIROUT	D-SCREEN-ON
	PRINTI	"ou awake on a hard stone floor, sorting the chaotic images from yesterday: thousands of Flatheadians fleeing the castle, the last of the royal guard attempting to hold off the looters, pathetic attempts by charlatans to forestall the Curse, and a rowdy party as the remaining peasants broke into the wine cellars"
	PRINT	ELLIPSIS
	CALL2	GOTO,GREAT-HALL
	RSTACK	


	.FUNCT	I-TAKE-OBJECT
	EQUAL?	HERE,BANQUET-HALL \?CCL3
	ICALL1	RETURN-FROM-MAP
	IN?	CAKE,PROTAGONIST \?CCL6
	REMOVE	CAKE
	PRINTR	"   A head waiter relieves you of the huge cake and delivers it to Dimwit, who claps with delight at his huge private pastry."
?CCL6:	IN?	KEG,PROTAGONIST \FALSE
	REMOVE	KEG
	PRINTR	"   A sommelier grabs the wine keg and bustles across the crowded hall."
?CCL3:	EQUAL?	HERE,KITCHEN \?CCL10
	ICALL1	RETURN-FROM-MAP
	IN?	LINEN,PROTAGONIST \?CCL13
	REMOVE	LINEN
	PRINTR	"   ""Finally,"" gasps one of the head servants, snatching the linen and dashing off."
?CCL13:	IN?	ROC-TERIYAKI,PROTAGONIST \FALSE
	REMOVE	ROC-TERIYAKI
	PRINTR	"   A cook grabs the tray. ""Not well-done enough? Those slobs wouldn't know good roc teriyaki if it flew up and bit them on the..."" The rest of the cook's comment is lost amidst the din of the kitchen."
?CCL10:	EQUAL?	HERE,SCULLERY \FALSE
	ICALL1	RETURN-FROM-MAP
	IN?	HELLHOUND-BONES,PROTAGONIST \FALSE
	REMOVE	HELLHOUND-BONES
	PRINTR	"   A scrubwoman grabs the platter, dumps the bones down a chute, and tosses the platter into a scrub basin."


	.FUNCT	I-GIVE-OBJECT
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   "
	EQUAL?	HERE,BANQUET-HALL \?CCL3
	IN?	HELLHOUND-BONES,PROTAGONIST \?CCL6
	SET	'PROLOGUE-NOVICE-COUNTER,1
	PRINTR	"""I thought I told you to take that platter into the scullery!"""
?CCL6:	IN?	ROC-TERIYAKI,PROTAGONIST \?CCL8
	SET	'PROLOGUE-NOVICE-COUNTER,4
	PRINTR	"""Well? Get that appetizer back to the kitchen!"""
?CCL8:	IN?	LINEN,PROTAGONIST \?CCL10
	SET	'PROLOGUE-NOVICE-COUNTER,4
	PRINTR	"One of the other servants looks appalled and nods you eastward. ""Clean linen to the kitchen, imbecile!"""
?CCL10:	FSET?	HELLHOUND-BONES,TOUCHBIT \?CCL12
	MOVE	ROC-TERIYAKI,PROTAGONIST
	SET	'PROLOGUE-NOVICE-COUNTER,4
	PRINTR	"A tray of roc teriyaki is dumped into your arms. ""This appetizer is undercooked! Bring it back to the kitchen!"" You are nudged eastward."
?CCL12:	MOVE	HELLHOUND-BONES,PROTAGONIST
	FSET	HELLHOUND-BONES,TOUCHBIT
	ICALL2	THIS-IS-IT,HELLHOUND-BONES
	SET	'PROLOGUE-NOVICE-COUNTER,1
	PRINTR	"Someone thrusts a platter of hellhound bones into your hands. ""Bring this to the scullery, servant!"" An insistent finger points northeast."
?CCL3:	EQUAL?	HERE,KITCHEN \?CCL14
	IN?	CAKE,PROTAGONIST /?CTR16
	IN?	KEG,PROTAGONIST \?CCL17
?CTR16:	SET	'PROLOGUE-NOVICE-COUNTER,5
	PRINTI	"""Why haven't you brought that "
	IN?	CAKE,PROTAGONIST \?CCL22
	PRINTI	"cake"
	JUMP	?CND20
?CCL22:	PRINTI	"keg"
?CND20:	PRINTR	" out to the hall? The royal executioners are never too busy for an impudent servant..."""
?CCL17:	IN?	HELLHOUND-BONES,PROTAGONIST \?CCL24
	SET	'PROLOGUE-NOVICE-COUNTER,10
	PRINTR	"""No! No! No!"" someone is shouting at you. ""Garbage and soiled dishware to the scullery!"" A strong arm spins you around to the north."
?CCL24:	FSET?	CAKE,TOUCHBIT \?CCL26
	SET	'PROLOGUE-NOVICE-COUNTER,5
	MOVE	KEG,PROTAGONIST
	PRINTR	"A wine steward bounds up the stairs and deposits a huge wine keg onto your shoulder. ""For the banquet hall!"" he calls over his shoulder."
?CCL26:	FSET	CAKE,TOUCHBIT
	MOVE	CAKE,PROTAGONIST
	SET	'PROLOGUE-NOVICE-COUNTER,5
	PRINTR	"A baker gives you an enormous cake in the shape of Double Fanucci trebled fromps. ""To the king's table,"" he orders, aiming you westward."
?CCL14:	EQUAL?	HERE,SCULLERY \?CCL28
	IN?	ROC-TERIYAKI,PROTAGONIST /?CTR30
	IN?	CAKE,PROTAGONIST /?CTR30
	IN?	KEG,PROTAGONIST \?CCL31
?CTR30:	PRINTI	"""Idiot, that goes to the "
	IN?	ROC-TERIYAKI,PROTAGONIST \?CCL37
	SET	'PROLOGUE-NOVICE-COUNTER,2
	PRINTI	"kitchen"
	JUMP	?CND35
?CCL37:	SET	'PROLOGUE-NOVICE-COUNTER,11
	PRINTI	"banquet hall"
?CND35:	PRINTI	". Where do we get our servants, the local madhouse?"" An impatient finger points south"
	IN?	ROC-TERIYAKI,PROTAGONIST /?CND38
	PRINTI	"west"
?CND38:	PRINT	PERIOD-CR
	RTRUE	
?CCL31:	IN?	LINEN,PROTAGONIST \?CCL41
	SET	'PROLOGUE-NOVICE-COUNTER,2
	PRINTR	"""When I give an order, servant, I mean NOW!"" The force of the voice is almost enough to propel you southward."
?CCL41:	MOVE	LINEN,PROTAGONIST
	SET	'PROLOGUE-NOVICE-COUNTER,2
	PRINTR	"Someone drops a load of monogrammed napkins into your arms and pushes you toward the south. ""Bring these to the kitchen! They're running low!"""
?CCL28:	CALL2	JIGS-UP,STR?265
	RSTACK	


	.FUNCT	SERVANT-ITEM-F
	EQUAL?	PRSA,V?THROW,V?DROP \?CCL3
	PRINTR	"Recalling yesterday's execution of ninety-seven unsatisfactory servants, you change your mind."
?CCL3:	EQUAL?	PRSA,V?CUT \?CCL5
	EQUAL?	PRSO,CAKE \?CCL5
	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?DRINK,V?BITE,V?EAT \FALSE
	EQUAL?	PRSO,ROC-TERIYAKI \?CCL12
	PRINTR	"But it's undercooked!"
?CCL12:	EQUAL?	PRSO,HELLHOUND-BONES \?CCL14
	PRINT	THERES-NOTHING
	PRINTR	"left but bones."
?CCL14:	ICALL	PERFORM,V?DROP,PRSO
	RTRUE	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	PARCHMENT-F
	EQUAL?	PRSA,V?WALK-TO \?CCL3
	ZERO?	UNDER-TABLE /?CCL3
	ICALL2	PERFORM,V?STAND
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?READ \FALSE
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK \?CND8
	PRINTI	"The parchment has been in your family for generations, and is now yellowed with age. Family lore claims this parchment was acquired by an ancestor who served in Dimwit's court, and dates from the very day that the Curse of Megaboz was cast! "
?CND8:	PRINTR	"[You can find this scrap of parchment in your ZORK ZERO package.]"


	.FUNCT	DIMWIT-F,ARG
	EQUAL?	ARG,M-WINNER \?CCL3
	PRINTI	"One of the King's personal attendants gives you a bone-jarring mind-numbing smack on the side of your head as you attempt to speak to the King."
	CRLF	
	CALL1	STOP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?RESEARCH \?CCL5
	CALL	PICTURED-ENTRY,DIMWIT-ILL,STR?269
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTR	"From his gaudy crown to his 369 course meal, Dimwit is the very model of excessiveness."
?CCL7:	EQUAL?	PRSA,V?MUNG,V?KICK,V?KILL \FALSE
	PRINTR	"You'd never get past his legion of personal guards."


	.FUNCT	G-DIMWIT-F,TBL,F
	GET	F,6
	EQUAL?	STACK,W?STATUE \?CCL3
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK /FALSE
	RETURN	DIMWIT-STATUE
?CCL3:	GET	F,6
	EQUAL?	STACK,W?PAINTING /FALSE
	RETURN	DIMWIT

	.ENDSEG

	.SEGMENT "STARTUP"


	.FUNCT	TABLES-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The tables are slathered with food and bones and dirty platters and puddles or wine and even a few sleeping bodies. Royal guests don't tend to have the best manners."
?CCL3:	EQUAL?	PRSA,V?HIDE,V?CRAWL-UNDER \?CCL5
	ZERO?	UNDER-TABLE /?CCL8
	PRINT	LOOK-AROUND
	RTRUE	
?CCL8:	SET	'UNDER-TABLE,TRUE-VALUE
	SET	'OLD-HERE,FALSE-VALUE
	PRINTR	"You are now under the table."
?CCL5:	EQUAL?	PRSA,V?EXIT \FALSE
	ZERO?	UNDER-TABLE /FALSE
	SET	'PRSO,FALSE-VALUE
	CALL1	V-STAND
	RSTACK	

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	CAULDRON-F,CAULDRON-SCORE
	EQUAL?	PRSA,V?CLOSE \?CCL3
	PRINTR	"No lid."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTI	"The cauldron is "
	FSET?	OUTER-GATE,OPENBIT \?CCL8
	PRINTR	"cold and empty!"
?CCL8:	ZERO?	TIME-STOPPED /?CCL10
	PRINTR	"surrounded by unmoving clouds of smoke!"
?CCL10:	DIV	NUMBER-OF-ITEMS,2
	GET	CAULDRON-DESCS,STACK
	PRINT	STACK
	PRINTR	"."
?CCL5:	EQUAL?	PRSA,V?SMELL \?CCL12
	PRINTR	"Phew!!!"
?CCL12:	EQUAL?	PRSA,V?ENTER,V?DRINK-FROM,V?DRINK \?CCL14
	PRINTR	"As you near the cauldron, acrid fumes drive you back."
?CCL14:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL16
	ZERO?	TIME-STOPPED /?CCL19
	ICALL	PERFORM,V?EXAMINE,CAULDRON
	RTRUE	
?CCL19:	PRINTR	"All you can see is churning smoke."
?CCL16:	EQUAL?	PRSA,V?REACH-IN,V?SEARCH \?CCL21
	PRINTR	"You feel nothing within the cauldron, but after you withdraw your hand it tingles maddeningly for a few moments."
?CCL21:	EQUAL?	PRSA,V?PUT \FALSE
	CALL2	RUNNING?,I-PROLOGUE
	ZERO?	STACK /?CCL26
	REMOVE	PRSO
	PRINTI	"There is no apparent effect as"
	ICALL1	TPRINT-PRSO
	PRINTR	" vanishes into the cauldron."
?CCL26:	ZERO?	TIME-STOPPED /?CND24
	MOVE	PRSO,HERE
	PRINTI	"As though there were now an invisible bubble around the cauldron,"
	ICALL1	TPRINT-PRSO
	PRINTR	" slides away from it and lands on the floor."
?CND24:	PRINTI	"With a puff of magically charged smoke,"
	ICALL1	TPRINT-PRSO
	PRINTI	" vanishes amidst the vapors. The cauldron's level of activity seems to increase"
	EQUAL?	PRSO,CUP \?CND28
	IN?	POTION,CUP \?CND28
	REMOVE	POTION
?CND28:	CALL2	PUT-ITEM-IN-CAULDRON,PRSO >CAULDRON-SCORE
	FSET?	PRSO,MAGICBIT /?CCL34
	PRINTI	" momentarily"
	JUMP	?CND32
?CCL34:	MOD	NUMBER-OF-ITEMS,2
	ZERO?	STACK \?CND32
	PRINTI	"; it is now "
	DIV	NUMBER-OF-ITEMS,2
	GET	CAULDRON-DESCS,STACK
	PRINT	STACK
?CND32:	PRINTC	46
	EQUAL?	NUMBER-OF-ITEMS,24 \?CND36
	ZERO?	CAULDRON-MUNGED \?CND36
	ICALL2	DEQUEUE,I-JESTER
	FCLEAR	GUTTERING-TORCH,ONBIT
	FCLEAR	GUTTERING-TORCH,FLAMEBIT
	FCLEAR	FLICKERING-TORCH,ONBIT
	FCLEAR	FLICKERING-TORCH,FLAMEBIT
	FSET	CLOSET-REBUS-BUTTON,TOUCHBIT
	PUTP	CLOSET-REBUS-BUTTON,P?SDESC,STR?270
	FSET	BASEMENT-REBUS-BUTTON,TOUCHBIT
	PUTP	BASEMENT-REBUS-BUTTON,P?SDESC,STR?270
	FCLEAR	IRON-MAIDEN,OPENBIT
	FCLEAR	SNAKE-PIT,OPENBIT
	FCLEAR	WATER-CHAMBER,OPENBIT
	SET	'TIME-STOPPED,TRUE-VALUE
	PRINTI	" Suddenly, the smoke stops swirling; in fact, everything in sight has ground to a halt. It is as if time itself has stopped. You don't seem to be affected, however."
	IN?	JESTER,HERE \?CND36
	ICALL1	REMOVE-J
	PRINTI	" In addition, the jester has vanished."
?CND36:	CRLF	
	CALL2	INC-SCORE,CAULDRON-SCORE
	RSTACK	


	.FUNCT	PUT-ITEM-IN-CAULDRON,OBJ,X,N,CAULDRON-SCORE
	FIRST?	OBJ >X /?PRG2
?PRG2:	ZERO?	X /?REP3
	NEXT?	X >N /?BOGUS7
?BOGUS7:	FSET?	X,NDESCBIT /?CND4
	CALL2	PUT-ITEM-IN-CAULDRON,X
	ADD	CAULDRON-SCORE,STACK >CAULDRON-SCORE
?CND4:	SET	'X,N
	JUMP	?PRG2
?REP3:	FSET?	OBJ,MAGICBIT \?CCL12
	REMOVE	OBJ
	INC	'NUMBER-OF-ITEMS
	ADD	CAULDRON-SCORE,5 >CAULDRON-SCORE
	GETP	OBJ,P?VALUE
	EQUAL?	STACK,12 \?CND10
	ADD	CAULDRON-SCORE,12 >CAULDRON-SCORE
	RETURN	CAULDRON-SCORE
?CCL12:	EQUAL?	OBJ,LARGE-VIAL \?CCL17
	REMOVE	LARGE-VIAL-WATER
	SET	'LARGE-VIAL-GLOOPS,0
	JUMP	?CND15
?CCL17:	EQUAL?	OBJ,SMALL-VIAL \?CND15
	REMOVE	SMALL-VIAL-WATER
	SET	'SMALL-VIAL-GLOOPS,0
?CND15:	FCLEAR	OBJ,ONBIT
	ICALL	QUEUE,I-CAULDRON,3
	EQUAL?	OBJ,NUT \?CCL20
	IN?	NUT,UNOPENED-NUT /?CND19
?CCL20:	MOVE	OBJ,MEGABOZ
?CND19:	EQUAL?	PRSO,PERCH \?CND23
	SET	'REMOVED-PERCH-LOC,MEGABOZ
?CND23:	SUB	CAULDRON-SCORE,5 >CAULDRON-SCORE
	SET	'CAULDRON-MUNGED,TRUE-VALUE
?CND10:	RETURN	CAULDRON-SCORE


	.FUNCT	I-CAULDRON,X,TWO
	FIRST?	MEGABOZ \FALSE
	IN?	PERCH,MEGABOZ \?CND1
	SET	'REMOVED-PERCH-LOC,FALSE-VALUE
?CND1:	EQUAL?	HERE,BANQUET-HALL \?CND5
	ICALL1	RETURN-FROM-MAP
	PRINTI	"   With a startling belch of green flame and vile-smelling smoke, the cauldron regurgitates"
	FIRST?	MEGABOZ >X \?CND7
	NEXT?	X \?CND7
	SET	'TWO,TRUE-VALUE
?CND7:	ICALL	D-CONTENTS,MEGABOZ,2
	ZERO?	TWO /?CCL13
	PRINTI	" They "
	JUMP	?CND11
?CCL13:	PRINTI	" It "
?CND11:	RANDOM	100
	LESS?	15,STACK /?CCL16
	ZERO?	TWO \?CCL16
	GETP	X,P?SIZE
	GRTR?	STACK,4 \?CCL16
	ICALL2	JIGS-UP,STR?284
	JUMP	?CND5
?CCL16:	ZERO?	TWO /?CCL22
	PRINTI	"whiz"
	JUMP	?CND20
?CCL22:	PRINTI	"whizzes"
?CND20:	PRINTI	" past your ear with alarming velocity."
?CND5:	ICALL	ROB,MEGABOZ,BANQUET-HALL
	EQUAL?	HERE,BANQUET-HALL \FALSE
	CRLF	
	RTRUE	

	.ENDSEG

	.SEGMENT "STARTUP"


	.FUNCT	MEGABOZ-F,ARG
	EQUAL?	ARG,M-OBJDESC,M-OBJDESC? \?CCL3
	EQUAL?	ARG,M-OBJDESC? /TRUE
	PRINTI	"   An angry wizard stands defiantly in the center of the hall."
	IN?	PARCHMENT,MEGABOZ \TRUE
	PRINTI	" A scrap of parchment sticks out from a pocket of his robe."
	RTRUE	
?CCL3:	EQUAL?	ARG,M-WINNER /?CTR8
	EQUAL?	PRSA,V?TELL \?CCL9
?CTR8:	PRINTI	"Megaboz ignores you."
	CRLF	
	RETURN	2
?CCL9:	EQUAL?	PRSA,V?RESEARCH \?CCL15
	CALL	PICTURED-ENTRY,MEGABOZ-ILL,MEGABOZ-TEXT
	RSTACK	
?CCL15:	EQUAL?	PRSA,V?EXAMINE \?CCL17
	PRINTR	"Even the most ignorant lay observer can see that the gaunt man is a powerful mage. His wizardly robe and cap crackle with magical energy, and his darting eyes seem to see inside everyone he looks at."
?CCL17:	EQUAL?	PRSA,V?KILL,V?KISS,V?KICK /?PRD21
	EQUAL?	PRSA,V?MUNG \FALSE
?PRD21:	EQUAL?	PRSO,MEGABOZ \FALSE
	CALL2	JIGS-UP,STR?285
	RSTACK	

	.SEGMENT "CASTLE"

	.ENDSEG

	.ENDI
