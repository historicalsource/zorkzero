"PROLOGUE for
			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<GLOBAL DEMO-VERSION? <>>
<BEGIN-SEGMENT STARTUP>

<ROUTINE SETUP-SCREEN ()
	 <SETG FONT-X <LOWCORE (FWRD 1)>>
	 <SETG FONT-Y <LOWCORE (FWRD 0)>>
	 <MOUSE-LIMIT -1>
	 <COND (<NOT <EQUAL? <BAND <LOWCORE FLAGS> 32> 0>>
		<SETG ACTIVE-MOUSE T>)> 
	 <WINSIZE ,S-FULL <LOWCORE VWRD> <LOWCORE HWRD>>
	 <SETG WIDTH <LOWCORE SCRH>>>

<ROUTINE GO ()
	 <SETUP-SCREEN>
	 <SETG TOWER-BEATEN ,PYRAMID>
	 <SETG CLOAK-LOC ,CLOTHES-CLOSET>
	 <COND (,DEMO-VERSION?
		<SETG HOLEY-SLAB <GET ,SLAB-TABLE <- <RANDOM 7> 1>>>
		<SLIDE-SHOW>
		<AGAIN>)>
	 <SETG CURRENT-SPLIT ,TEXT-WINDOW-PIC-LOC>
	 <SETG CURRENT-BORDER ,CASTLE-BORDER>
	 <QUEUE I-GIVE-OBJECT -1>
	 <QUEUE I-PROLOGUE -1>
	 <QUEUE I-TAKE-OBJECT -1>
	 <V-$REFRESH>
	 <CRLF>
	 <MARGINAL-PIC ,PROLOGUE-LETTER>
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL "A"> ;"so script doesn't say NOTHER FRANTIC DAY..."
	 <DIROUT ,D-SCREEN-ON>
	 <TELL
"nother frantic day at the castle; Lord Dimwit Flathead the Excessive has
invited a few thousand friends over for dinner. Three hundred dragons have
been slaughtered for the occasion, and the kitchen is suffocated by the
stench of their roasting flesh.">
	 <CRLF>
	 <CLEAR-CRCNT> ;"in case illuminated letter is taller than intro"
	 <CRLF>
	 <V-LOOK>
	 <I-PROLOGUE>
	 <I-GIVE-OBJECT>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE CLEAR-CRCNT ("AUX" NUM)
	 <SET NUM <WINGET ,S-TEXT ,WCRCNT>>
	 <REPEAT ()
		 <COND (<0? .NUM>
			<RETURN>)>
		 <CRLF>
		 <SET NUM <- .NUM 1>>>>

<CONSTANT SLIDE-SHOW-TIMEOUT 150>
<CONSTANT DEMO-TIMEOUT 600>

<ROUTINE SLIDE-SHOW-HANDLER ()
	<SETG DEMO-VERSION? +1>
	<RTRUE>>

<ROUTINE SLIDE-SHOW ()
	<WINSIZE ,S-TEXT <LOWCORE VWRD> <LOWCORE HWRD>>
	<TITLE-SCREEN>
	<INPUT 1 ,SLIDE-SHOW-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<CLEAR -1>

	<TELL
"This is a demonstration version of ZORK ZERO: The Revenge of Megaboz|
Copyright (c) 1988 by Infocom, Inc. All rights reserved.|
|
	First you will see a few samples of the graphic screens that await you
in ZORK ZERO.We've used graphics in surprising new ways to enhance the
story without detracting from Infocom's traditional richness and depth.|
	Then you will be able to interact with a small section of ZORK
ZERO.Feel free to try the new friendlier parser, the optional mouse
interface, and the on-screen hints.Solve a couple of puzzles.Meet
the quizzical jester, who will test you with games, riddles, or tricks.|
	ZORK ZERO is the \"prequel\" to the ZORK trilogy, the best-selling computer
entertainment of all time.In ZORK ZERO the Great Underground Empire is in
its heyday, and no adventurer has yet set foot in the \"open field west of a
white house.\"But the inhabitants are fleeing in the wake of a dread
wizard's curse, which has already disposed of the royal Flathead family
and threatens to destroy the entire kingdom -- unless you can stop it.
	Hit any key to begin...">
	<INPUT 1 ,DEMO-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<CLEAR -1>

	<PICTURED-ENTRY ,MEGABOZ-ILL ,MEGABOZ-TEXT T>
	<SCREEN ,S-FULL>
	<CURSET 1 1>
	<INPUT 1 ,SLIDE-SHOW-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<CLEAR -1>

	<SCREEN ,S-FULL>
	<DISPLAY ,REBUS-1 1 1>
	<INPUT 1 ,SLIDE-SHOW-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<CLEAR -1>

	<REPEAT ((RM <FIRST? ,ROOMS>))
		<COND (<ZERO? .RM>
		       <RETURN>)
		      (<EQUAL? ,FOOZLE-MAP-NUM <GET <GETP .RM ,P?MAP-LOC> 0>>
		       <FSET .RM ,TOUCHBIT>)>
		<SET RM <NEXT? .RM>>>
	<SETG HERE ,CROSSROADS>
	<SETG MAP-NOTE T>
	<DO-MAP>
	<INPUT 1 ,SLIDE-SHOW-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<CLEAR -1>

	<SETUP-CARDS>
	<PUT ,F-CARD-TABLE 0 7>		;"nought of "
	<PUT ,F-CARD-TABLE 1 10>	;"mazes"
	<PUT ,F-CARD-TABLE 2 16>	;"hourglass"
	<PUT ,F-CARD-TABLE 4 11>	;"trebled "
	<PUT ,F-CARD-TABLE 5 15>	;"fromps"
	<PUT ,F-CARD-TABLE 6 0>		;"back of card"
	<PUT ,F-CARD-TABLE 8 8>		;"infinity of "
	<PUT ,F-CARD-TABLE 9 5>		;"ears"
	<SETUP-FANUCCI>
	<SCREEN ,S-FULL>
	<CURSET 1 1>
	<INPUT 1 ,SLIDE-SHOW-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<CLEAR -1>

	;<FCLEAR ,WEST-DOOR ,LOCKEDBIT>
	;<FCLEAR ,EAST-DOOR ,LOCKEDBIT>
	;<MOVE ,CANDLE ,PROTAGONIST>
	;<MOVE ,UNOPENED-NUT ,KITCHEN>
	;<FSET ,CRYPT ,UNDERGROUNDBIT>
	;<FSET ,SECRET-PASSAGE ,UNDERGROUNDBIT>
	<SETG CURRENT-SPLIT ,TEXT-WINDOW-PIC-LOC>
	<SETG CURRENT-BORDER ,CASTLE-BORDER>
	<V-$REFRESH>
	<TELL
"Now you are welcome to interact with a demonstration version of|
|">
	<V-VERSION>
	<CRLF>
	<MOVE ,DIRIGIBLE ,SMALLER-HANGAR>
	<PUTP ,GONDOLA ,P?REGION "Fenshire">
	<MOVE ,RECIPE ,RUINED-HALL ;,MARSH>
	<PUTP ,ROOSTER ,P?FDESC 0>
	<MOVE ,ROOSTER ,DESERTED-CASTLE>
	<PUTP ,DESERTED-CASTLE ,P?ACTION ,DESERTED-CASTLE-F>
	<PUTP ,FOX ,P?FDESC 0>
	<MOVE ,FOX ,SMALLER-HANGAR>
	<PUTP ,SMALLER-HANGAR ,P?ACTION ,SMALLER-HANGAR-F>
	<MOVE ,WORM ,HOTHOUSE>
	<WINPUT ,S-TEXT 15 -999>	;"Disable MORE counter."
	<SETG PROLOGUE-NOVICE-COUNTER 0>
	<GOTO ,RUINED-HALL>
	<MAIN-LOOP>>

<ROUTINE READ-DEMO (ARG1 "OPT" (ARG2 <>) "AUX" CHR)
 <COND (T ;,DEMO-VERSION?
	<SETG DEMO-VERSION? -1>
	<SET CHR <READ .ARG1 .ARG2 ,DEMO-TIMEOUT ,SLIDE-SHOW-HANDLER>>
	<COND (<1? ,DEMO-VERSION?>
	       <END-DEMO>)
	      (T
	       <WINPUT ,S-TEXT 15 -999>	;"Disable MORE counter."
	       .CHR)>)
       ;(T
	<INPUT .ARG>)>>

<ROUTINE INPUT-DEMO (ARG "AUX" CHR)
 <COND (T ;,DEMO-VERSION?
	<SETG DEMO-VERSION? -1>
	<SET CHR <INPUT .ARG ,DEMO-TIMEOUT ,SLIDE-SHOW-HANDLER>>
	<COND (<1? ,DEMO-VERSION?>
	       <END-DEMO>)
	      (T
	       <WINPUT ,S-TEXT 15 -999>	;"Disable MORE counter."
	       .CHR)>)
       ;(T
	<INPUT .ARG>)>>

<ROUTINE END-DEMO ()
	<CLEAR -1>
	<TELL "|
You have reached the end of this demonstration version of|">
	<V-VERSION>
	<TELL "|
|
Hit any key to start over...">
	<INPUT 1 ,SLIDE-SHOW-TIMEOUT ,SLIDE-SHOW-HANDLER>
	<SCREEN ,S-TEXT>
	<COLOR 1 1> ;"return to default before screen clears"
	<RESTART>
	<TELL ,FAILED>
	<AGAIN>>

<OBJECT RECIPE
	(DESC "recipe card")
	(SYNONYM RECIPE CARD)
	(ADJECTIVE RECIPE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 1)
	(TEXT BORPHBELLY-TEXT)>

<END-SEGMENT>

<BEGIN-SEGMENT CASTLE>

<OBJECT BANQUET-FOOD
	(LOC GLOBAL-OBJECTS)
	(DESC "banquet meal")
	(SYNONYM FOOD WINE)
	(ACTION BANQUET-FOOD-F)>

<ROUTINE BANQUET-FOOD-F ()
	 <COND (<VERB? EAT DRINK TASTE TOUCH TAKE>
		<TELL
"The food and drink is for the guests, not the servants." CR>)>>

<ROOM BANQUET-HALL
      (LOC ROOMS)
      (DESC "Banquet Hall")
      (REGION "Flatheadia")
      (WEST TO ENTRANCE-HALL)
      (SOUTH TO COURTYARD)
      (EAST TO KITCHEN)
      (NE TO SCULLERY)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM HALL)
      (ADJECTIVE BANQUET)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-6>)
      (ICON BANQUET-HALL-ICON)
      (GLOBAL KITCHEN SCULLERY)
      (ACTION BANQUET-HALL-F)
      (THINGS <> SMOKE SMOKE-PS
	      <> VAPOR SMOKE-PS)>

<ROUTINE SMOKE-PS ()
	 <COND (<VERB? SMELL>
		<PERFORM ,V?SMELL ,CAULDRON>
		<RTRUE>)
	       (<VERB? ENTER>
		<TELL "\"Choke, choke, cough, cough.\"" CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,HANDS>>
		<TELL ,NOTHING-HAPPENS>)>>

<ROUTINE BANQUET-HALL-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<RUNNING? I-PROLOGUE>
		       <TELL
"The hall is filled to capacity, and the thousands of reveling guests
are raising quite a din">)
		      (T
		       <TELL
"Many royal feasts have been held in this hall, which could easily hold
ten thousand guests. Legends say that Dimwit's more excessive banquets
would require the combined farm outputs of three provinces">)>
	       <TELL
". The primary exits are to the west and south; smaller openings lead east
and northeast.">)>>

<ROOM KITCHEN
      (LOC ROOMS)
      (DESC "Kitchen")
      (REGION "Flatheadia")
      (WEST TO BANQUET-HALL)
      (NORTH TO SCULLERY)
      (DOWN TO ROOT-CELLAR)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM KITCHEN)
      (GLOBAL STAIRS BANQUET-HALL SCULLERY)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-7>)
      (ICON KITCHEN-ICON)
      (ACTION KITCHEN-F)>

<ROUTINE KITCHEN-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<RUNNING? I-PROLOGUE>
		       <TELL
"You are assaulted by waves of greasy odors and buffetted by mobs of
bustling cooks and servants">)
		      (T
		       <TELL
"Although this is the largest cooking area in the Empire, it must've still
been crowded when all 600 of Dimwit's chefs were working at the same time">)>
		<TELL
". There are passages to the west and north, and a stair leads downward">
		<COND (<NOT <RUNNING? I-PROLOGUE>>
		       <TELL " into darkness">)>
		<TELL ".">)>>

<ROOM SCULLERY
      (LOC ROOMS)
      (DESC "Scullery")
      (REGION "Flatheadia")
      (SOUTH TO KITCHEN)
      (SW TO BANQUET-HALL)
      (DOWN TO WINE-CELLAR)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM SCULLERY)
      (GLOBAL STAIRS KITCHEN BANQUET-HALL)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-7>)
      (ACTION SCULLERY-F)>

<ROUTINE SCULLERY-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is where the castle's pots and pans, the output of the forges of
Borphee for three years, are cleaned and stored. Passages open to the
south and southwest, and a stair descends">
		<COND (<NOT <RUNNING? I-PROLOGUE>>
		       <TELL " into darkness">)>
		<TELL ".">)>>

<BEGIN-SEGMENT 0>

<OBJECT STRAW
	(DESC "drinking straw")
	(SYNONYM STRAW)
	(ADJECTIVE DRINKING)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION STRAW-F)>

<ROUTINE STRAW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<IN? ,STRAW ,BOWL>
		       <TELL ,ONLY-BLACKNESS>)
		      (T
		       <TELL
"You see a point of light: the far end of the straw." CR>)>)
	       (<AND <VERB? SUCK-WITH>
		     <PRSI? ,STRAW>>
		<PERFORM ,V?DRINK-WITH ,PRSO ,STRAW>
		<RTRUE>)
	       (<VERB? SUCK-ON>
		<SETG FINGER-ON-STRAW <>>
		<SETG ELIXIR-TRAPPED <>>
		<COND (<IN? ,STRAW ,BOWL>
		       <PERFORM ,V?DRINK-WITH ,ELIXIR ,STRAW>
		       <RTRUE>)
		      (T
		       <TELL "You suck some air through the straw." CR>)>)
	       (<VERB? INFLATE>
		<SETG FINGER-ON-STRAW <>>
		<SETG ELIXIR-TRAPPED <>>
		<TELL "Air ">
		<COND (<IN? ,STRAW ,BOWL>
		       <TELL "bubbles up through the elixir">)
		      (T
		       <TELL "blows out the far end of the straw">)>
		<TELL ". Wow." CR>)
	       (<AND <VERB? TAKE>
		     ,FINGER-ON-STRAW
		     ,ELIXIR-TRAPPED
		     <IN? ,STRAW ,BOWL>>
		<SETG FINGER-ON-STRAW <>>
		<SETG ELIXIR-TRAPPED <>>
		<MOVE ,STRAW ,PROTAGONIST>
		<TELL
"As you lift the straw with your finger over the end of it, the elixir within
is trapped. Then the suction breaks, and the elixir dribbles onto you. ">
		<TOUCH-ELIXIR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LAKE>

<ROUTINE TOUCH-ELIXIR ()
	 <TELL "The liquid feels warm and cleansing."> 
	 <COND (<FSET? ,LARGE-FLY ,TRYTAKEBIT>
		<FCLEAR ,LARGE-FLY ,TRYTAKEBIT>
		<FCLEAR ,LARGER-FLY ,TRYTAKEBIT>
		<FCLEAR ,EVEN-LARGER-FLY ,TRYTAKEBIT>
		<FCLEAR ,LARGEST-FLY ,TRYTAKEBIT>
		<TELL
" You experience a wave of ecstasy, accompanied by a brief desire to spin
a cocoon, collect sap, and eat animal excrement." CR>
		<INC-SCORE 16>)
	       (T
	 	<CRLF>)>>

<END-SEGMENT>

<BEGIN-SEGMENT 0>

<GLOBAL FINGER-ON-STRAW <>>

<GLOBAL ELIXIR-TRAPPED <>>

<ROUTINE I-FINGER-OFF-STRAW ("AUX" (TOLD <>))
	 <COND (<AND ,FINGER-ON-STRAW
		     <VISIBLE? ,STRAW>>
		<RETURN-FROM-MAP>
		<SET TOLD T>
		<TELL
"   Your finger gets tired, so you remove it from the end of the straw." CR>)>
	 <SETG FINGER-ON-STRAW <>>
	 <SETG ELIXIR-TRAPPED <>>
	 <COND (.TOLD
		<RTRUE>)
	       (T
		<RFALSE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT CASTLE>

<ROOM ROOT-CELLAR
      (LOC ROOMS)
      (DESC "Root Cellar")
      (REGION "Flatheadia")
      (LDESC
"This is where food is stored. A stair leads up, and another part of
the cellar lies to the north.")
      (UP TO KITCHEN)
      (NORTH TO WINE-CELLAR)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM CELLAR)
      (ADJECTIVE ROOT)
      (GLOBAL STAIRS)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-8>)>

<BEGIN-SEGMENT 0>

<OBJECT UNOPENED-NUT
	(DESC "unopened walnut")
	(FDESC
"The cellar has been picked clean by the fleeing thousands -- but wait, what's
this in the corner? Ah, an unopened walnut!")
	(SYNONYM SHELL NUTSHELL WALNUT NUT)
	(ADJECTIVE WALNUT UNOPENED)
	(FLAGS VOWELBIT TAKEBIT CONTBIT SEARCHBIT)
	(SIZE 2)
	(ACTION UNOPENED-NUT-F)>

<ROUTINE UNOPENED-NUT-F ()
	 <COND (<VERB? SHAKE>
		<TELL "A nut rattles around within." CR>)
	       (<AND <VERB? OPEN>
		     <PRSI? ,HAMMER>>
		<PERFORM ,V?MUNG ,PRSO ,HAMMER>
		<RTRUE>)
	       (<AND <VERB? OPEN LOOK-INSIDE MUNG KILL>
		     <PRSO? ,UNOPENED-NUT>>
		<COND (<AND <VERB? LOOK-INSIDE EXAMINE>
			    <FSET? ,GOGGLES ,WORNBIT>>
		       <PERFORM ,V?LOOK-INSIDE ,NUT-SHELL>
		       <RTRUE>)
		      (<NOT ,PRSI>
		       <TELL
"This is one tough shell. You can't seem to crack it with your ">
		       <COND (,ALLIGATOR
			      <TELL "paws">)
			     (T
			      <TELL "hands">)>
		       <TELL ,PERIOD-CR>)
		      (<AND <PRSI? ,LOBSTER>
			    <NOT <FSET? ,PRSI ,ANIMATEDBIT>>>
		       <COND (<VISIBLE? ,JESTER>
			      <TELL "The jester watches with interest. ">
			      <SETG NUT-OPENED T>)>
		       <MOVE ,NUT-SHELL <LOC ,UNOPENED-NUT>>
		       <MOVE ,NUT ,NUT-SHELL>
		       <THIS-IS-IT ,NUT>
		       <REMOVE ,UNOPENED-NUT>
		       <TELL
"\"Crack!\" Opening the walnut shell reveals a walnut." CR>)
		      (<AND <VERB? MUNG KILL>
			    <G? <GETP ,PRSI ,P?SIZE> 15>>
		       <REMOVE ,UNOPENED-NUT>
		       <TELL
"This succeeds in crushing the shell (and its contents) to dust." CR>)
		      (T
		       <TELL ,YOU-CANT "open a nutshell with" AR ,PRSI>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,UNOPENED-NUT>
		     <G? <GETP ,PRSO ,P?SIZE> 14>>
		<PERFORM ,V?MUNG ,UNOPENED-NUT ,PRSO>
		<RTRUE>)
	       (<AND <VERB? STAND-ON>
		     <NOT <FSET? ,UNOPENED-NUT ,OPENBIT>>>
		<TELL
"Even your full weight is insufficient to crack the shell
(you lightweight you)." CR>)>>

<OBJECT NUT-SHELL
	(DESC "walnut shell")
	(SYNONYM SHELL NUTSHELL)
	(ADJECTIVE WALNUT)
	(FLAGS TAKEBIT SEARCHBIT CONTBIT OPENBIT)
	(SIZE 1)
	(ACTION NUT-SHELL-F)>

<ROUTINE NUT-SHELL-F ()
	 <COND (<VERB? CLOSE>
		<TELL
,YOU-CANT "reclose the shell! Don't fret, though. Instead, remember that
old Miznian proverb: \"It's no use crying over cracked nutshells.\"" CR>)>>

<OBJECT NUT
	(LOC UNOPENED-NUT)
	(DESC "walnut")
	(SYNONYM WALNUT NUT)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION NUT-F)>

<ROUTINE NUT-F ()
	 <COND (<VERB? EAT>
		<REMOVE ,NUT>
		<COND (<VISIBLE? ,JESTER>
		       <COND (,NUT-SHOWN
			      <SETG NUT-EATEN T>
			      <TELL
"\"I'm very impressed; you passed my test! When you exit from the
West Wing, I'll no longer be molesting.\"">
			      <J-EXITS>
			      <INC-SCORE 20>)
			     (T
			      <TELL
"You swallow the walnut. \"I guess you don't win, place, or show!\" comments
the jester enigmatically." CR>)>)
		      (T
		       <TELL
"The walnut is tasty, but hardly filling." CR>)>)>>

<END-SEGMENT>

<BEGIN-SEGMENT CASTLE>

<ROOM WINE-CELLAR
      (LOC ROOMS)
      (DESC "Wine Cellar")
      (REGION "Flatheadia")
      (LDESC
"Every keg has been removed, and the floor is mottled with purple stains.
Stone stairs lead upward, and the cellar continues to the south.")
      (SOUTH TO ROOT-CELLAR)
      (UP TO SCULLERY)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM CELLAR)
      (ADJECTIVE WINE)
      (GLOBAL STAIRS)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-8>)
      (ICON WINE-CELLAR-ICON)>

<BEGIN-SEGMENT STARTUP>

<GLOBAL PROLOGUE-COUNTER 0>

<GLOBAL PROLOGUE-NOVICE-COUNTER 1>

<CONSTANT NOVICE-MOVES
	<PTABLE
	 ;0 "wait" ;"should be impossible to get this one"
	 ;1 "go northeast"
	 ;2 "walk south"
	 ;3 "go west"
	 ;4 "walk east"
	 ;5 "enter the banquet hall" ;"west"
	 ;6 "examine the gaunt man"
	 ;7 "dive under the table"
	 ;8 "get out from under the table"
	 ;9 "pick up the scrap of parchment"
	;10 "north" ;"only happens if you already went in the wrong direction"
	;11 "southeast" ;"ditto">>

<ROUTINE I-PROLOGUE ()
	 <COND (<NOT <EQUAL? ,HERE ,BANQUET-HALL>>
		<RFALSE>)>
	 <SETG PROLOGUE-COUNTER <+ ,PROLOGUE-COUNTER 1>>
	 <RETURN-FROM-MAP>
	 <TELL "   ">
	 <COND (<EQUAL? ,PROLOGUE-COUNTER 1>
		<FCLEAR ,DIMWIT ,NDESCBIT>
		<TELL
"Dimwit is seated at the dais. His loud voice carries across the crowded hall.
\"Now that the statue is done, we must do something ceremonial. I have it! A
dedication! We'll give everyone in the kingdom a year off and invite them to
the Fublio Valley...\"" CR>)
	       (<EQUAL? ,PROLOGUE-COUNTER 2>
		<TELL
"Dimwit is ranting at his advisors. \"There's not enough in the royal treasury
to build my new continent, Lord Feepness? Then we'll increase the tax levy!
It's only 98%! That still leaves two percent!\"|
   \"With all deference, your Lordship, people are refusing to pay even the
98%. Your decree, 'Anyone withholding payment shall be killed along with
everyone they've ever met' simply isn't working. If you increase it to 100%,
the people...\"" CR>)
	       (<EQUAL? ,PROLOGUE-COUNTER 3>
		<DEQUEUE I-TAKE-OBJECT>
		<DEQUEUE I-GIVE-OBJECT>
		<MOVE ,MEGABOZ ,HERE>
		<SETG PROLOGUE-NOVICE-COUNTER 6>
		<TELL
"\"How about this?\" shouts Dimwit with his mouth full of dragon meat.
\"I'll adopt everyone in the kingdom... and then I'll announce that they've
been naughty and I've cut off their allowance! It's inspired! Lord Feepness,
draw up the proclam...\"|
   Dimwit is interrupted by an explosion of billowing smoke in the center of
the hall. A gaunt, bearded man strides forth from the smoke!" CR>)
	       (<EQUAL? ,PROLOGUE-COUNTER 4>
		<MOVE ,PARCHMENT ,MEGABOZ>
		<SETG PROLOGUE-NOVICE-COUNTER 7>
		<TELL
"\"Show me the one responsible for the statue!\" bellows the newcomer. \"The
statue that now darkens Fublio!\" Every head silently turns toward Dimwit,
whose delight at the pyrotechnics is now tinged by fear. \"Go away,\" orders
Dimwit, waving a shaky hand at the stranger. \"This is a private function.\"|
   Ignoring the order, the newcomer paces forward, until he is standing
almost next to you. A scrap of parchment protrudes from his pocket. \"My
favorite grove of shade trees now lies beneath the toe of that cursed
statue! No man, be he peasant or king, crosses Megaboz the Magnificent!\"
He raises his arms, and every guest who knows how dangerous an angry wizard
can be begins diving under the tables." CR>)
	       (<EQUAL? ,PROLOGUE-COUNTER 5>
		<TELL
"\"Dimwit, thy kingship is a mockery of all worldly values! I curse your
life! I curse your family! And I curse your Empire!\" Sheets of power begin
spewing from his fingertips. \"Frobnitz! Frobnosia! Prob Fset Cond! Zmemqb
Intbl Foo!\" As the last word is spoken, the wizard turns into a vast fireball
which explodes outward, searing everything in its path">
		<COND (<NOT ,UNDER-TABLE>
		       <JIGS-UP
", including you. I guess those people who dove under tables
knew what they were doing.">)
		      (T
		       <REMOVE ,MEGABOZ>
		       <FCLEAR ,PARCHMENT ,NDESCBIT>
		       <MOVE ,PARCHMENT ,HERE>
		       <MOVE ,CAULDRON ,HERE>
		       <SETG PROLOGUE-NOVICE-COUNTER 8>
		       <TELL
". Then, silence.|
   You slowly open your eyes, and where last you saw Megaboz, there now sits
a huge black cauldron, bubbling and roiling and spewing noisome fumes. All
eyes are transfixed on the incredible cauldron; you seem to be the only one
who notices the parchment scrap which Megaboz has dropped on the stone floor,
just beyond your reach." CR>)>)
	       (<EQUAL? ,PROLOGUE-COUNTER 6>
		<SETG PROLOGUE-NOVICE-COUNTER 9>
		<TELL
"Many of the guests are burned and dying. This doesn't seem to bother Dimwit
much, but he does seem concerned by the bubbling cauldron. He summons his
court magicians, who huddle about the cauldron, sampling the brew, casting
exploratory spells, studying the words of Megaboz's spell, and whispering
among themselves.|
    Finally, they seem to reach an agreement. Combining their powers, the
magicians chant a long and mysterious spell. Then, drained of energy, they
turn to Dimwit." CR>)
	       (<EQUAL? ,PROLOGUE-COUNTER 7>
		<TELL
"\"We have done our best, your Lordship,\" begins the chief magician, \"but
the spell of Megaboz is a mighty one indeed. We delayed its effects for 94
years, but after that time, this castle -- in fact, all the eastlands --
will be destroyed.\"|
   Dimwit shrugs. \"Big deal! I won't be around in 94 years!\"|
   \"Truer than you think,\" continues the chief magician. \"There's more to
the Curse. Lordship, you and your eleven siblings are doomed!\"|
   \"Doomed?\" whines Dimwit. \"As in dead? That's not fair! When?\"|
   \"Moonrise, perhaps a bit later...\" The king lurches suddenly and
collapses onto his dinner. \"...perhaps a bit sooner.\"|
   Dimwit's personal physician rushes to the stricken king, and then looks
solemnly at the assembled guests. \"The king is dead!\"" CR>
		<DEQUEUE I-PROLOGUE>
		<SETG MOVES 0>
		<SETG CLOCK-WAIT T> ;"or MOVES updates to 1 before 1st prompt"
		<COND (<IN? ,PARCHMENT ,PROTAGONIST>
		       <MOVE ,PARCHMENT ,GREAT-HALL>)
		      (T
		       <REMOVE ,PARCHMENT>)>
		<STOP> ;"flush commands typed in the prologue"
		<ROB ,PROTAGONIST>
		<REMOVE ,DIMWIT>
		<REMOVE ,HELLHOUND-BONES>
		<REMOVE ,ROC-TERIYAKI>
		<REMOVE ,CAKE>
		<REMOVE ,KEG>
		<REMOVE ,LINEN>
		<MOVE ,UNOPENED-NUT ,ROOT-CELLAR>
		<MOVE ,STRAW ,SCULLERY>
		<MOVE ,CALENDAR ,GREAT-HALL>
		<MOVE ,PROCLAMATION ,ENTRANCE-HALL>
		<FCLEAR ,BANQUET-HALL ,TOUCHBIT>
		<FCLEAR ,SCULLERY ,TOUCHBIT>
		<FCLEAR ,KITCHEN ,TOUCHBIT>
		<FCLEAR ,ROOT-CELLAR ,ONBIT>
		<FCLEAR ,WINE-CELLAR ,ONBIT>
		<SETG UNDER-TABLE <>>
		<REMOVE ,TABLES>
		<MOVE ,CROWN ,TREASURE-CHEST>
		<FSET ,CROWN ,TAKEBIT>
		<FCLEAR ,CROWN ,NDESCBIT>
		<MOVE ,ROBE ,TRUNK>
		<FSET ,ROBE ,TAKEBIT>
		<SETG MID-NAME-NUM <- <RANDOM 12> 1>>
		<SETG DIAL-NUMBER <RANDOM 2400>>
		<SETG HOLEY-SLAB <GET ,SLAB-TABLE <- <RANDOM 7> 1>>>
		<REMOVE ,BANQUET-FOOD>
		<CRLF> <CRLF>
		<HIT-ANY-KEY>
		<TITLE-SCREEN>
		<INPUT 1>
		<MOUSE-INPUT?>
		<SETG CURRENT-SPLIT ,TEXT-WINDOW-PIC-LOC>
		<V-$REFRESH>
		<V-VERSION>
		<HLIGHT ,H-BOLD>
		<TELL CR "94 YEARS LATER" ,ELLIPSIS>
		<HLIGHT ,H-NORMAL>
		<MARGINAL-PIC ,MAIN-LETTER>
		<DIROUT ,D-SCREEN-OFF>
	 	<TELL "Y"> ;"so script doesn't say OU WAKE ON A HARD..."
	 	<DIROUT ,D-SCREEN-ON>
		<TELL
"ou awake on a hard stone floor, sorting the chaotic images from yesterday:
thousands of Flatheadians fleeing the castle, the last of the royal guard
attempting to hold off the looters, pathetic attempts by charlatans to
forestall the Curse, and a rowdy party as the remaining peasants broke into
the wine cellars" ,ELLIPSIS>
		<GOTO ,GREAT-HALL>)>>

<ROUTINE I-TAKE-OBJECT ()
	 <COND (<EQUAL? ,HERE ,BANQUET-HALL>
		<RETURN-FROM-MAP>
		<COND (<IN? ,CAKE ,PROTAGONIST>
		       <REMOVE ,CAKE>
		       <TELL
"   A head waiter relieves you of the huge cake and delivers it to Dimwit,
who claps with delight at his huge private pastry." CR>)
		      (<IN? ,KEG ,PROTAGONIST>
		       <REMOVE ,KEG>
		       <TELL
"   A sommelier grabs the wine keg and bustles across the crowded hall." CR>)>)
	       (<EQUAL? ,HERE ,KITCHEN>
		<RETURN-FROM-MAP>
		<COND (<IN? ,LINEN ,PROTAGONIST>
		       <REMOVE ,LINEN>
		       <TELL
"   \"Finally,\" gasps one of the head servants, snatching the
linen and dashing off." CR>)
		      (<IN? ,ROC-TERIYAKI ,PROTAGONIST>
		       <REMOVE ,ROC-TERIYAKI>
		       <TELL
"   A cook grabs the tray. \"Not well-done enough? Those slobs wouldn't
know good roc teriyaki if it flew up and bit them on the...\" The rest
of the cook's comment is lost amidst the din of the kitchen." CR>)>)
	       (<EQUAL? ,HERE ,SCULLERY>
		<RETURN-FROM-MAP>
		<COND (<IN? ,HELLHOUND-BONES ,PROTAGONIST>
		       <REMOVE ,HELLHOUND-BONES>
		       <TELL
"   A scrubwoman grabs the platter, dumps the bones down a chute, and tosses
the platter into a scrub basin." CR>)>)>>

<ROUTINE I-GIVE-OBJECT ()
	 <RETURN-FROM-MAP>
	 <TELL "   ">
	 <COND (<EQUAL? ,HERE ,BANQUET-HALL>
		<COND (<IN? ,HELLHOUND-BONES ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 1>
		       <TELL
"\"I thought I told you to take that platter into the scullery!\"" CR>)
		      (<IN? ,ROC-TERIYAKI ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 4>
		       <TELL
"\"Well? Get that appetizer back to the kitchen!\"" CR>)
		      (<IN? ,LINEN ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 4>
		       <TELL
"One of the other servants looks appalled and nods you eastward. \"Clean
linen to the kitchen, imbecile!\"" CR>)
		      (<FSET? ,HELLHOUND-BONES ,TOUCHBIT>
		       <MOVE ,ROC-TERIYAKI ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 4>
		       <TELL
"A tray of roc teriyaki is dumped into your arms. \"This appetizer is
undercooked! Bring it back to the kitchen!\" You are nudged eastward." CR>)
		      (T	
		       <MOVE ,HELLHOUND-BONES ,PROTAGONIST>
		       <FSET ,HELLHOUND-BONES ,TOUCHBIT>
		       <THIS-IS-IT ,HELLHOUND-BONES>
		       <SETG PROLOGUE-NOVICE-COUNTER 1>
		       <TELL
"Someone thrusts a platter of hellhound bones into your hands. \"Bring this
to the scullery, servant!\" An insistent finger points northeast." CR>)>)
	       (<EQUAL? ,HERE ,KITCHEN>
		<COND (<OR <IN? ,CAKE ,PROTAGONIST>
			   <IN? ,KEG ,PROTAGONIST>>
		       <SETG PROLOGUE-NOVICE-COUNTER 5>
		       <TELL "\"Why haven't you brought that ">
		       <COND (<IN? ,CAKE ,PROTAGONIST>
			      <TELL "cake">)
			     (T
			      <TELL "keg">)>
		       <TELL
" out to the hall? The royal executioners are never too busy
for an impudent servant...\"" CR>)
		      (<IN? ,HELLHOUND-BONES ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 10>
		       <TELL
"\"No! No! No!\" someone is shouting at you. \"Garbage and soiled dishware
to the scullery!\" A strong arm spins you around to the north." CR>)
		      (<FSET? ,CAKE ,TOUCHBIT>
		       <SETG PROLOGUE-NOVICE-COUNTER 5>
		       <MOVE ,KEG ,PROTAGONIST>
		       <TELL
"A wine steward bounds up the stairs and deposits a huge wine keg onto your
shoulder. \"For the banquet hall!\" he calls over his shoulder." CR>)
		      (T
		       <FSET ,CAKE ,TOUCHBIT>
		       <MOVE ,CAKE ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 5>
		       <TELL
"A baker gives you an enormous cake in the shape of Double Fanucci trebled
fromps. \"To the king's table,\" he orders, aiming you westward." CR>)>)
	       (<EQUAL? ,HERE ,SCULLERY>
		<COND (<OR <IN? ,ROC-TERIYAKI ,PROTAGONIST>
			   <IN? ,CAKE ,PROTAGONIST>
			   <IN? ,KEG ,PROTAGONIST>>
		       <TELL "\"Idiot, that goes to the ">
		       <COND (<IN? ,ROC-TERIYAKI ,PROTAGONIST>
			      <SETG PROLOGUE-NOVICE-COUNTER 2>
			      <TELL "kitchen">)
			     (T
			      <SETG PROLOGUE-NOVICE-COUNTER 11>
			      <TELL "banquet hall">)>
		       <TELL
". Where do we get our servants, the local madhouse?\" An
impatient finger points south">
		       <COND (<NOT <IN? ,ROC-TERIYAKI ,PROTAGONIST>>
			      <TELL "west">)>
		       <TELL ,PERIOD-CR>)
		      (<IN? ,LINEN ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 2>
		       <TELL
"\"When I give an order, servant, I mean NOW!\" The force of the voice
is almost enough to propel you southward." CR>)
		      (T
		       <MOVE ,LINEN ,PROTAGONIST>
		       <SETG PROLOGUE-NOVICE-COUNTER 2>
		       <TELL
"Someone drops a load of monogrammed napkins into your arms and pushes you
toward the south. \"Bring these to the kitchen! They're running low!\"" CR>)>)
	       (T
	 	<JIGS-UP
"\"Servant! You're supposed to be waiting on guests! This is uncalled
for... unheard of... unforgivable!\" Your execution is quick but painful.">)>>

<OBJECT HELLHOUND-BONES
	(OWNER HELLHOUND-BONES)
	(DESC "platter of hellhound bones")
	(SYNONYM BONES PLATTER)
	(ADJECTIVE HELLHOUND)
	(FLAGS TAKEBIT)
	(ACTION SERVANT-ITEM-F)>

<OBJECT ROC-TERIYAKI
	(OWNER ROC-TERIYAKI)
	(DESC "tray of roc teriyaki")
	(SYNONYM TERIYAKI TRAY APPETIZER)
	(ADJECTIVE ROC)
	(FLAGS TAKEBIT)
	(ACTION SERVANT-ITEM-F)>

<OBJECT CAKE
	(DESC "cake")
	(SYNONYM CAKE)
	(FLAGS TAKEBIT)
	(ACTION SERVANT-ITEM-F)>

<OBJECT KEG
	(DESC "wine keg")
	(SYNONYM KEG WINE)
	(ADJECTIVE WINE)
	(FLAGS TAKEBIT)
	(ACTION SERVANT-ITEM-F)>

<OBJECT LINEN
	(DESC "pile of napkins")
	(OWNER LINEN)
	(SYNONYM PILE NAPKINS LINEN)
	(ADJECTIVE MONOGRAMMED)
	(FLAGS TAKEBIT READBIT)
	(TEXT "The napkin is embroidered with a large, flowery \"F.\"")
	(ACTION SERVANT-ITEM-F)>

<ROUTINE SERVANT-ITEM-F ()
	 <COND (<VERB? DROP THROW>
		<TELL
"Recalling yesterday's execution of ninety-seven unsatisfactory
servants, you change your mind." CR>)
	       (<AND <VERB? CUT>
		     <PRSO? ,CAKE>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? EAT BITE DRINK>
		<COND (<PRSO? ,ROC-TERIYAKI>
		       <TELL "But it's undercooked!" CR>)
		      (<PRSO? ,HELLHOUND-BONES>
		       <TELL ,THERES-NOTHING "left but bones." CR>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)>>

<END-SEGMENT>

<BEGIN-SEGMENT 0>

<OBJECT PARCHMENT
	(OWNER PARCHMENT)
	(DESC "scrap of parchment")
	(PLURAL "parchments")
	(SYNONYM PAPER SCRAP PIECE PARCHMENT)
	(ADJECTIVE PARCHMENT)
	(FLAGS NDESCBIT READBIT TAKEBIT BURNBIT)
	(SIZE 1)
	(ACTION PARCHMENT-F)>

<ROUTINE PARCHMENT-F ()
	 <COND (<AND <VERB? WALK-TO>
		     ,UNDER-TABLE>
		<PERFORM ,V?STAND>
		<RTRUE>)
	       (<VERB? READ>
		<COND (<NOT <RUNNING? ,I-PROLOGUE>>
		       <TELL
"The parchment has been in your family for generations, and is now yellowed
with age. Family lore claims this parchment was acquired by an ancestor who
served in Dimwit's court, and dates from the very day that the Curse of
Megaboz was cast! ">)>
		<TELL
"[You can find this scrap of parchment in your ZORK ZERO package.]" CR>)>>

<OBJECT DIMWIT
	(LOC BANQUET-HALL)
	(DESC "Lord Dimwit Flathead the Excessive")
	(LDESC
"Dimwit is seated at the dais, surrounded by his most trusted advisors.")
	(SYNONYM FLATHEAD DIMWIT)
	(ADJECTIVE LORD DIMWIT EXCESSIVE)
	(FLAGS NARTICLEBIT NDESCBIT ACTORBIT CONTBIT OPENBIT SEARCHBIT)
	(GENERIC G-DIMWIT-F)
	(ACTION DIMWIT-F)>

<ROUTINE DIMWIT-F ("OPT" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<TELL
"One of the King's personal attendants gives you a bone-jarring mind-numbing
smack on the side of your head as you attempt to speak to the King." CR>
		<STOP>)
	       (<VERB? RESEARCH>
		<PICTURED-ENTRY ,DIMWIT-ILL
"Lord Dimwit Flathead the Excessive ruled the Great Underground Empire from
770 GUE through 789 GUE. For more information about the life of Dimwit, we
refer the reader to 'The Lives of the Twelve Flatheads' by Boswell Barwell.">)
	       (<VERB? EXAMINE>
		<TELL
"From his gaudy crown to his 369 course meal, Dimwit is the very model of
excessiveness." CR>)
	       (<VERB? KILL KICK MUNG>
		<TELL
"You'd never get past his legion of personal guards." CR>)>>

<ROUTINE G-DIMWIT-F (TBL F)
	 <COND (<EQUAL? <FIND-NOUN .F> ,W?STATUE>
		<COND (<RUNNING? ,I-PROLOGUE>
		       ,DIMWIT-STATUE)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? <FIND-NOUN .F> ,W?PAINTING>
		<RFALSE>)
	       (T
		,DIMWIT)>>

<END-SEGMENT>

<BEGIN-SEGMENT STARTUP>

<OBJECT TABLES
	(LOC BANQUET-HALL)
	(DESC "table")
	(SYNONYM TABLE TABLES)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 100)
	(ACTION TABLES-F)>

<GLOBAL UNDER-TABLE <>>

<ROUTINE TABLES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The tables are slathered with food and bones and dirty platters and puddles
or wine and even a few sleeping bodies. Royal guests don't tend to have the
best manners." CR>)
	       (<VERB? CRAWL-UNDER HIDE>
		<COND (,UNDER-TABLE
		       <TELL ,LOOK-AROUND>)
		      (T
		       <SETG UNDER-TABLE T>
		       <SETG OLD-HERE <>>
		       <TELL "You are now under the table." CR>)>)
	       (<AND <VERB? EXIT>
		     ,UNDER-TABLE>
		<SETG PRSO <>>
		<V-STAND>)>>

<END-SEGMENT>

<BEGIN-SEGMENT CASTLE>

<OBJECT CAULDRON
	(DESC "cauldron")
	(SYNONYM CAULDRON KETTLE)
	(ADJECTIVE BUBBLING ROILING FUMING)
	(FLAGS CONTBIT OPENBIT)
	(ACTION CAULDRON-F)>

<ROUTINE CAULDRON-F ("AUX" CAULDRON-SCORE)
	 <COND (<VERB? CLOSE>
		<TELL "No lid." CR>)
	       (<VERB? EXAMINE>
		<TELL "The cauldron is ">
		<COND (<FSET? ,OUTER-GATE ,OPENBIT>
		       <TELL "cold and empty!">)
		      (,TIME-STOPPED
		       <TELL "surrounded by unmoving clouds of smoke!">)
		      (T
		       <TELL
<GET ,CAULDRON-DESCS </ ,NUMBER-OF-ITEMS 2>> ".">)>
		<CRLF>)
	       (<VERB? SMELL>
		<TELL "Phew!!!" CR>)
	       (<VERB? DRINK DRINK-FROM ENTER>
		<TELL
"As you near the cauldron, acrid fumes drive you back." CR>)
	       (<VERB? LOOK-INSIDE>
		<COND (,TIME-STOPPED
		       <PERFORM ,V?EXAMINE ,CAULDRON>
		       <RTRUE>)
		      (T
		       <TELL "All you can see is churning smoke." CR>)>)
	       (<VERB? SEARCH REACH-IN>
		<TELL
"You feel nothing within the cauldron, but after you withdraw your hand
it tingles maddeningly for a few moments." CR>)
	       (<VERB? PUT>
		<COND (<RUNNING? I-PROLOGUE>
		       <REMOVE ,PRSO>
		       <TELL
"There is no apparent effect as" T ,PRSO " vanishes into the cauldron." CR>
		       <RTRUE>)
		      (,TIME-STOPPED
		       <MOVE ,PRSO ,HERE>
		       <TELL
"As though there were now an invisible bubble around the cauldron," T ,PRSO
" slides away from it and lands on the floor." CR>
		       <RTRUE>)>
		<TELL
"With a puff of magically charged smoke," T ,PRSO " vanishes amidst the
vapors. The cauldron's level of activity seems to increase">
		<COND (<AND <PRSO? ,CUP>
			    <IN? ,POTION ,CUP>>
		       <REMOVE ,POTION>)>
		<SET CAULDRON-SCORE <PUT-ITEM-IN-CAULDRON ,PRSO>>
		<COND (<NOT <FSET? ,PRSO ,MAGICBIT>>
		       <TELL " momentarily">)
		      (<EQUAL? <MOD ,NUMBER-OF-ITEMS 2> 0>
		       <TELL
"; it is now " <GET ,CAULDRON-DESCS </ ,NUMBER-OF-ITEMS 2>>>)>
		<TELL ".">
		<COND (<AND <EQUAL? ,NUMBER-OF-ITEMS 24>
			    <NOT ,CAULDRON-MUNGED>>
		       <DEQUEUE I-JESTER>
		       <FCLEAR ,GUTTERING-TORCH ,ONBIT>
		       <FCLEAR ,GUTTERING-TORCH ,FLAMEBIT>
		       <FCLEAR ,FLICKERING-TORCH ,ONBIT>
		       <FCLEAR ,FLICKERING-TORCH ,FLAMEBIT>
		       <FSET ,CLOSET-REBUS-BUTTON ,TOUCHBIT>
		       <PUTP ,CLOSET-REBUS-BUTTON ,P?SDESC "key-shaped button">
		       <FSET ,BASEMENT-REBUS-BUTTON ,TOUCHBIT>
		       <PUTP ,BASEMENT-REBUS-BUTTON ,P?SDESC
			     "key-shaped button">
		       <FCLEAR ,IRON-MAIDEN ,OPENBIT>
		       <FCLEAR ,SNAKE-PIT ,OPENBIT>
		       <FCLEAR ,WATER-CHAMBER ,OPENBIT>
		       <SETG TIME-STOPPED T>
		       <TELL
" Suddenly, the smoke stops swirling; in fact, everything in sight has
ground to a halt. It is as if time itself has stopped. You don't seem to
be affected, however.">
		       <COND (<IN? ,JESTER ,HERE>
			      <REMOVE-J>
			      <TELL
" In addition, the jester has vanished.">)>)>
		<CRLF>
		<INC-SCORE .CAULDRON-SCORE>)>>

<ROUTINE PUT-ITEM-IN-CAULDRON (OBJ "AUX" X N (CAULDRON-SCORE 0))
	 <SET X <FIRST? .OBJ>>
	 <REPEAT ()
	   <COND (.X
		  <SET N <NEXT? .X>>
		  <COND (<NOT <FSET? .X ,NDESCBIT>> ;"i.e. flask poison"
			 <SET CAULDRON-SCORE
			      <+ .CAULDRON-SCORE <PUT-ITEM-IN-CAULDRON .X>>>)>)
		 (T
		  <RETURN>)>
	   <SET X .N>>
	 <COND (<FSET? .OBJ ,MAGICBIT>
		<REMOVE .OBJ>
		<SETG NUMBER-OF-ITEMS <+ ,NUMBER-OF-ITEMS 1>>
		<SET CAULDRON-SCORE <+ .CAULDRON-SCORE 5>>
		<COND (<EQUAL? <GETP .OBJ ,P?VALUE> 12>
		       ;"it's possible you never took crown, landscape"
		       <SET CAULDRON-SCORE <+ .CAULDRON-SCORE 12>>)>)
	       (T
		<COND (<EQUAL? .OBJ ,LARGE-VIAL>
		       <REMOVE ,LARGE-VIAL-WATER>
		       <SETG LARGE-VIAL-GLOOPS 0>)
		      (<EQUAL? .OBJ ,SMALL-VIAL>
		       <REMOVE ,SMALL-VIAL-WATER>
		       <SETG SMALL-VIAL-GLOOPS 0>)>
		<FCLEAR .OBJ ,ONBIT>
 		<QUEUE I-CAULDRON 3>
		<COND (<NOT <AND <EQUAL? .OBJ ,NUT>
			    	 <IN? ,NUT ,UNOPENED-NUT>>>
		       <MOVE .OBJ ,MEGABOZ>)>
		<COND (<PRSO? ,PERCH>
		       <SETG REMOVED-PERCH-LOC ,MEGABOZ>)>
		<SET CAULDRON-SCORE <- .CAULDRON-SCORE 5>>
		<SETG CAULDRON-MUNGED T>)>
	 <RETURN .CAULDRON-SCORE>>

<GLOBAL CAULDRON-MUNGED <>>

<GLOBAL TIME-STOPPED <>>

<GLOBAL NUMBER-OF-ITEMS 0>

<CONSTANT CAULDRON-DESCS
	<PTABLE
	 ;0 "barely bubbling"
	 ;1 "bubbling quietly"
	 ;2 "bubbling actively"
	 ;3 "bubbling very actively"
	 ;4 "bubbling and churning"
	 ;5 "bubbling, churning, and smoking heavily"
	 ;6 "churning actively and emitting large puffs of smoke"
	 ;7 "violently churning and emitting huge puffs of dark smoke"
	 ;8 "churning very violently and giving off clouds of black smoke"
	 ;9 "churning and roiling beneath a whirlpool of thick black smoke"
	;10 "boiling violently beneath a gathering storm of noisome smoke"
	;11 "boiling with amazing energy, sending steaming geysers shooting
up into the roiling black clouds which swirl around it"
	;12 "almost lost amongst the clouds of dark power and energy which
surround the kettle, glowing and expanding from explosions deep within">>

<ROUTINE I-CAULDRON ("AUX" X (TWO <>))
	 <COND (<NOT <FIRST? ,MEGABOZ>>
		<RFALSE>)
	       (<IN? ,PERCH ,MEGABOZ>
		<SETG REMOVED-PERCH-LOC <>>)>
	 <COND (<EQUAL? ,HERE ,BANQUET-HALL>
		<RETURN-FROM-MAP>
		<TELL
"   With a startling belch of green flame and vile-smelling smoke, the
cauldron regurgitates">
		<COND (<AND <SET X <FIRST? ,MEGABOZ>>
			    <NEXT? .X>>
		       <SET TWO T>)>
		<D-CONTENTS ,MEGABOZ 2>
		<COND (.TWO
		       <TELL " They ">)
		      (T
		       <TELL " It ">)>
		<COND (<AND <PROB 15>
			    <NOT .TWO>
			    <G? <GETP .X ,P?SIZE> 4>>
		       <JIGS-UP
"strikes your head with unnatural force, sending you to an unnatural death.">)
		      (T
		       <COND (.TWO
			      <TELL "whiz">)
			     (T
			      <TELL "whizzes">)>
		       <TELL " past your ear with alarming velocity.">)>)>
	 <ROB ,MEGABOZ ,BANQUET-HALL>
	 <COND (<EQUAL? ,HERE ,BANQUET-HALL>
		<CRLF>)
	       (T
		<RFALSE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT STARTUP ;0>

<OBJECT MEGABOZ
	(DESC "angry wizard")
	(DESCFCN MEGABOZ-F)
	(SYNONYM WIZARD MEGABOZ MAN)
	(ADJECTIVE GAUNT OLD ANGRY)
	(FLAGS VOWELBIT ACTORBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION MEGABOZ-F)>

<ROUTINE MEGABOZ-F ("OPT" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-OBJDESC ,M-OBJDESC?>
		<COND (<EQUAL? .ARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL
"   An angry wizard stands defiantly in the center of the hall.">
		<COND (<IN? ,PARCHMENT ,MEGABOZ>	;"SWG 4-Oct-88"
		       ;<NOT <FSET? ,PARCHMENT ,NDESCBIT>>
		       <TELL
" A scrap of parchment sticks out from a pocket of his robe.">)>
		<RTRUE>)
	       (<OR <EQUAL? .ARG ,M-WINNER>
		    <VERB? TELL>>
		<TELL "Megaboz ignores you." CR>
		<RFATAL>)
	       (<VERB? RESEARCH>
		<PICTURED-ENTRY ,MEGABOZ-ILL ,MEGABOZ-TEXT>)
	       (<VERB? EXAMINE>
		<TELL
"Even the most ignorant lay observer can see that the gaunt man is a powerful
mage. His wizardly robe and cap crackle with magical energy, and his darting
eyes seem to see inside everyone he looks at." CR>)
	       (<AND <VERB? KICK KISS KILL MUNG>
		     <PRSO? ,MEGABOZ>>
		<JIGS-UP
"The wizard casually dispatches you with a shaft of fire, much as you might
casually dispatch a mosquito that was bothering you.">)>>

<BEGIN-SEGMENT CASTLE>

<CONSTANT MEGABOZ-TEXT
"Megaboz was a mysterious wizard who lived a hermit's life in the Fublio
Valley. Some say he cast a Curse which will someday destroy the Empire, but
royal spokesmen have denied all such rumors. Megaboz vanished in 789 GUE;
it is said that the effort of casting the Curse destroyed him.">

<END-SEGMENT>
