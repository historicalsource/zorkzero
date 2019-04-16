"FENSHIRE for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT FENSHIRE>

;"the dirigible"

<ROOM DIRIGIBLE-HANGAR
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Dirigible Hangar")
      (LDESC
"Even after becoming accustomed to the oversized scale of the castle,
this hangar seems tremendous. The only exit on foot is to the east.")
      (EAST TO WEST-WING)
      (OUT TO WEST-WING)
      (IN PER DIRIGIBLE-ENTER-F)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM HANGAR)
      (ADJECTIVE DIRIGIBLE LARGE)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-1>)
      (GLOBAL GONDOLA)
      (ACTION DIRIGIBLE-HANGAR-F)>

<ROUTINE DIRIGIBLE-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<IN? ,DIRIGIBLE ,HERE>
		,GONDOLA)
	       (T
		<COND (<NOT .RARG>
		       <V-WALK-AROUND>)>
		<RFALSE>)>>

<ROUTINE DIRIGIBLE-HANGAR-F ("OPT" (RARG <>))
	 <COND (<AND ,DEMO-VERSION? <EQUAL? .RARG ,M-END>>
		<END-DEMO>)>>

<OBJECT DIRIGIBLE
	(LOC DIRIGIBLE-HANGAR)
	(DESC "dirigible")
	(LDESC
"A tremendous dirigible is moored here. The gondola is just a few inches
off the ground.")
	(SYNONYM DIRIGIBLE)
	(FLAGS VEHBIT) ;"so GET IN finds the dirigible"
	(ACTION DIRIGIBLE-F)>

<ROUTINE DIRIGIBLE-F ()
	 <COND (<AND <VERB? THROW-FROM PUT-THROUGH>
		     <PRSI? ,DIRIGIBLE>>
		<PERFORM-PRSA ,PRSO ,GONDOLA>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,GONDOLA>
		       <V-LOOK>)
		      (T
		       <TELL <GETP ,DIRIGIBLE ,P?LDESC> CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,GONDOLA>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <TELL "You can't see much from out here." CR>)>)
	       (<VERB? ENTER>
		<GOTO ,GONDOLA>)>>

<ROOM GONDOLA
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Gondola")
      (OUT PER GONDOLA-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM GONDOLA)
      (GLOBAL WINDOW DIRIGIBLE DIRIGIBLE-HANGAR SMALLER-HANGAR)
      (MAP-LOC ;"not a PTABLE because the info changes during dirigible trip"
       <TABLE MAIN-MAP-NUM GONDOLA-AT-FLATHEADIA-LOC MAP-GEN-X-1>)
      (ICON GONDOLA-ICON)
      (ACTION GONDOLA-F)>

<ROUTINE GONDOLA-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the luxurious gondola of the dirigible. A window wraps completely
around the gondola. " ,GONDOLA-CONTROLS-DESC>)
	       (.RARG
		<RFALSE>)
	       (<VERB? EXAMINE>
		<PERFORM-PRSA ,DIRIGIBLE>)
	       (<AND <VERB? ENTER>
		     <NOT <EQUAL? ,HERE ,GONDOLA>>>
		<DO-WALK ,P?IN>)
	       (<AND <VERB? LEAP-OFF EXIT>
		     <EQUAL? ,HERE ,GONDOLA>>
		<DO-WALK ,P?OUT>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM-PRSA ,DIRIGIBLE>)
	       (<AND <VERB? THROW-FROM PUT-THROUGH>
		     <PRSI? ,GONDOLA ,GLOBAL-HERE>>
		<COND (<OR <IN? ,DIRIGIBLE ,DIRIGIBLE-HANGAR>
			   <IN? ,DIRIGIBLE ,SMALLER-HANGAR>>
		       <MOVE ,PRSO <LOC ,DIRIGIBLE>>)
		      (T
		       <COND (<OR <PRSO? ,PERCH>
				  <ULTIMATELY-IN? ,PERCH ,PRSO>>
			      <SETG REMOVED-PERCH-LOC ,GROUND>)>
		       <REMOVE ,PRSO>)>
		<TELL "You fling" T ,PRSO " out of the gondola." CR>)>>

<CONSTANT GONDOLA-CONTROLS-DESC
"The controls consist of merely two buttons: the left button
is marked \"Flatheadia\" and the right button is marked \"Fenshire.\"">

<OBJECT GONDOLA-CONTROLS
	(LOC GONDOLA)
	(DESC "controls")
	(SYNONYM CONTROL CONTROLS)
	(FLAGS NDESCBIT)
	(ACTION GONDOLA-CONTROLS-F)>

<ROUTINE GONDOLA-CONTROLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL ,GONDOLA-CONTROLS-DESC CR>)>>

<OBJECT LEFT-GONDOLA-BUTTON
	(LOC GONDOLA)
	(DESC "left button")
	(SYNONYM BUTTON)
	(ADJECTIVE LEFT)
	(FLAGS NDESCBIT)
	(ACTION GONDOLA-BUTTON-F)>

<OBJECT RIGHT-GONDOLA-BUTTON
	(LOC GONDOLA)
	(DESC "right button")
	(SYNONYM BUTTON)
	(ADJECTIVE RIGHT)
	(FLAGS NDESCBIT)
	(ACTION GONDOLA-BUTTON-F)>

<ROUTINE GONDOLA-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<OR ,TIME-STOPPED
			   <FSET? ,OUTER-GATE ,OPENBIT>
			   <G? ,DIRIGIBLE-COUNTER 0>
			   <AND <PRSO? ,LEFT-GONDOLA-BUTTON>
				<IN? ,DIRIGIBLE ,DIRIGIBLE-HANGAR>>
			   <AND <PRSO? ,RIGHT-GONDOLA-BUTTON>
				<IN? ,DIRIGIBLE ,SMALLER-HANGAR>>>
		       <TELL ,NOTHING-HAPPENS>)
		      (T
		       <QUEUE I-DIRIGIBLE -1>
		       <SETG DIRIGIBLE-COUNTER 1>
		       <COND (<AND ,BORDER-ON
				   <NOT <EQUAL? <LOWCORE INTID> ,DEC-20>>>
			      <CLEAR-BORDER>
			      <INIT-STATUS-LINE T>)>
		       <TELL
"The dirigible rises out of the hangar and sails ">
		       <COND (<IN? ,DIRIGIBLE ,DIRIGIBLE-HANGAR>
			      <SETG DESTINATION ,SMALLER-HANGAR>
			      <TELL "ea">)
			     (T
			      <SETG DESTINATION ,DIRIGIBLE-HANGAR>
			      <TELL "we">)>
		       <PUTP ,GONDOLA ,P?REGION "In the Air">
		       <PUT <GETP ,GONDOLA ,P?MAP-LOC> 0 <>>
		       <FSET ,DIRIGIBLE ,NDESCBIT>
		       <MOVE ,DIRIGIBLE ,GONDOLA>
		       <TELL "stward." CR>)>)>>

<ROUTINE GONDOLA-EXIT-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<G? ,DIRIGIBLE-COUNTER 0>
		<COND (.RARG
		       <RFALSE>)
		      (T
		       <JIGS-UP
"The experience is exhilarating, but you don't have much time to
enjoy it. Not as much time as you would've had if, for instance,
you'd worn a parachute.">)>) 
	       (T
		<RETURN <LOC ,DIRIGIBLE>>)>>

<GLOBAL DESTINATION <>>

<GLOBAL DIRIGIBLE-COUNTER 0>

<ROUTINE I-DIRIGIBLE ("AUX" TBL)
	 <COND (<EQUAL? ,HERE ,GONDOLA>
		<RETURN-FROM-MAP>
		<TELL "   ">)>
	 <COND (<EQUAL? ,DIRIGIBLE-COUNTER 5>
		<SET TBL <GETP ,GONDOLA ,P?MAP-LOC>>
		<COND (<EQUAL? ,DESTINATION ,SMALLER-HANGAR>
		       <PUT .TBL 0 ,FENSHIRE-MAP-NUM>
		       <PUT .TBL 1 ,GONDOLA-AT-FENSHIRE-LOC>
		       <PUT .TBL 2 ,MAP-GEN-X-2>
		       <PUTP ,GONDOLA ,P?REGION "Fenshire">)
		      (T
		       <PUT .TBL 0 ,MAIN-MAP-NUM>
		       <PUT .TBL 1 ,GONDOLA-AT-FLATHEADIA-LOC>
		       <PUT .TBL 2 ,MAP-GEN-X-1>
		       <PUTP ,GONDOLA ,P?REGION "Flatheadia">)>
		<MOVE ,DIRIGIBLE ,DESTINATION>
		<FCLEAR ,DIRIGIBLE ,NDESCBIT>
		<DEQUEUE I-DIRIGIBLE>
		<SETG DIRIGIBLE-COUNTER 0>
		<COND (<AND ,BORDER-ON
			    <EQUAL? ,HERE ,GONDOLA>
			    <NOT <EQUAL? <LOWCORE INTID> ,DEC-20>>>
		       <CLEAR-BORDER>
		       <SETG CURRENT-BORDER ,CASTLE-BORDER>
		       <SCREEN ,S-FULL>
		       <INIT-STATUS-LINE T>
		       <SCREEN ,S-TEXT>)>
		<COND (<EQUAL? ,HERE ,GONDOLA>
		       <TELL
"The dirigible descends into a hangar and comes to a stop.">)
		      (<EQUAL? ,HERE ,DESTINATION>
		       <RETURN-FROM-MAP>
		       <TELL "   A dirigible descends into the hangar.">)
		      (T
		       <RFALSE>)>)
	       (<NOT <EQUAL? ,HERE ,GONDOLA>>
		<SETG DIRIGIBLE-COUNTER <+ ,DIRIGIBLE-COUNTER 1>>
		<RFALSE>)
	       (T
	 	<RETURN-FROM-MAP>
		<TELL "The dirigible continues to glide along. ">
		<COND (<EQUAL? ,DESTINATION ,DIRIGIBLE-HANGAR>
		       <TELL
<GET ,DIRIGIBLE-TRIP-DESCS <- 4 ,DIRIGIBLE-COUNTER>>>)
		      (T
		       <TELL
<GET ,DIRIGIBLE-TRIP-DESCS <- ,DIRIGIBLE-COUNTER 1>>>)>
		<SETG DIRIGIBLE-COUNTER <+ ,DIRIGIBLE-COUNTER 1>>)>
	 <CRLF>>

<CONSTANT DIRIGIBLE-TRIP-DESCS
	<PTABLE
"It is now passing over a thickly tangled woods, stretching for miles in every
direction."
"You are now above the Frigid River. Cliffs crowd the river on both sides. To
the south, you can just make out the spray of Aragain Falls."
"The dirigible rises even higher as it crosses the Flathead Mountains. Jagged,
snow-topped peaks slide by below."
"Below you are vast square bloits of dismal swampland: the endless marshes of
Fenshire.">>

;"the summer castle"

<ROOM SMALLER-HANGAR
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Smaller Hangar")
      (LDESC
"This hangar, though still large, is smaller than the one in Flatheadia.
The only exit is south.")
      (SOUTH TO DESERTED-CASTLE)
      (IN PER DIRIGIBLE-ENTER-F)
      (OUT TO DESERTED-CASTLE)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM HANGAR)
      (ADJECTIVE SMALLER)
      (GLOBAL GONDOLA)
      (VALUE 6)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-2>)
      (ACTION 0)	;"filled in by SLIDE-SHOW">

<ROUTINE SMALLER-HANGAR-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,SMALLER-HANGAR ,TOUCHBIT>>>
		<QUEUE I-FOX -1>)>>

<ROOM DESERTED-CASTLE
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Deserted Castle")
      (LDESC
"The summer palace of the Kings of Quendor now lies in ruins, unoccupied
and uncared for, forgotten for many years. What's left of the castle can
be entered to the east, and a hangar lies to the north.")
      (NORTH TO SMALLER-HANGAR)
      (EAST TO RUINED-HALL)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL SMALLER-HANGAR)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-2>)
      (ACTION 0)	;"filled in by SLIDE-SHOW">

<ROUTINE DESERTED-CASTLE-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,DESERTED-CASTLE ,TOUCHBIT>>>
		<QUEUE I-ROOSTER -1>)>>

<ROOM RUINED-HALL
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Ruined Hall")
      (NORTH TO MARSH IF ARCHWAY-OPEN ELSE "That archway has crumbled!")
      (SOUTH TO HOTHOUSE)
      (WEST TO DESERTED-CASTLE)
      (EAST TO SECRET-ROOM IF SECRET-ROOM-REVEALED)
      (UP SORRY "The stairs have crumbled beyond use.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-3>)
      (ICON RUINED-HALL-ICON)
      (ACTION RUINED-HALL-F)>

<ROUTINE RUINED-HALL-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The entrance hall of the summer castle retains but a shadow of its former
elegance; the ceiling has partially collapsed, and myriad weeds grow amongst
the debris that covers the floor. A fireplace is choked with the rubble of its
collapsed chimney. Above the fireplace is a faded fresco, and next to that,
a tiny vase is mounted on the wall. Arched openings lead ">
		<COND (,ARCHWAY-OPEN
		       <TELL "north, ">)>
		<TELL "south and west. ">
		<COND (<NOT ,ARCHWAY-OPEN>
		       <TELL "The archway to the north">
		       <COND (<NOT <IN? ,HEXAGONAL-BLOCK ,LOCAL-GLOBALS>>
			      <SETG ARCHWAY-OPEN T>
			      <TELL
", which had earlier crumbled, seems restored to its
former condition: decayed but passable! ">)
			     (T
			      <TELL " has crumbled to rubble. ">)>)>
		<COND (,SECRET-ROOM-REVEALED
		       <TELL "In addition, a dusty passage leads east. ">)>
		<TELL
"A stairway once led upwards, but there's little left of it.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,ARCHWAY-OPEN>
		     <NOT <IN? ,HEXAGONAL-BLOCK ,LOCAL-GLOBALS>>>
		<SETG ARCHWAY-OPEN T>)>>

<OBJECT FIREPLACE
	(LOC RUINED-HALL)
	(DESC "fireplace")
	(SYNONYM FIREPLACE)
	(ADJECTIVE CHOKED)
	(FLAGS NDESCBIT)
	(ACTION FIREPLACE-F)>

<ROUTINE FIREPLACE-F ()
	 <COND (<VERB? ENTER>
		<DO-FIRST "clear out all the rubble">)
	       (<VERB? CLEAN>
		<TELL
"Not a chance (unless you're actually a team of thirty people,
in disguise)." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Rubble. Lots of rubble." CR>)>>

<OBJECT FRESCO
	(LOC RUINED-HALL)
	(DESC "fresco")
	(SYNONYM FRESCO)
	(ADJECTIVE FADED)
	(FLAGS NDESCBIT)
	(ACTION FRESCO-F)>

<ROUTINE FRESCO-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The fresco depicts the death of Duncanthrax. His spirit is ascending to
heaven on a tremendous ladder, surrounded by a host of angels." CR>)>>

<OBJECT VASE
	(LOC RUINED-HALL)
	(DESC "vase")
	(SYNONYM VASE)
	(ADJECTIVE SMALL)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT OPENBIT TRYTAKEBIT)
	(ACTION VASE-F)>

<ROUTINE VASE-F ()
	 <COND (<VERB? CLOSE OPEN>
		<TELL ,HUH>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,VASE>>
		<TELL "The vase is affixed to the wall." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,FLOWER>
		     <NOT ,SECRET-ROOM-REVEALED>>
		<SETG SECRET-ROOM-REVEALED T>
		<SETG COMPASS-CHANGED T>
		<MOVE ,FLOWER ,VASE>
		<TELL
"The flower seems to grow fuller, its colors richer. You hear a noise,
and turn to see a passageway opening to the east!" CR>
		<INC-SCORE 16>)>>

<GLOBAL SECRET-ROOM-REVEALED <>>

<ROOM SECRET-ROOM
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Secret Room")
      (LDESC
"You are the first person to breathe the air of this room in uncounted years.
The only exit is west.")
      (WEST TO RUINED-HALL)
      (OUT TO RUINED-HALL)
      (FLAGS RLANDBIT)
      (SYNONYM ROOM)
      (ADJECTIVE SECRET)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-4>)
      (ICON SECRET-ROOM-ICON)>

;<BEGIN-SEGMENT 0>

<OBJECT LADDER
	(LOC SECRET-ROOM)
	(DESC "ladder")
	(FDESC
"This room was probably intended as a hiding place for the royal family
in the event of a revolution, and may have once been well-stocked with
supplies. Now, however, the only item here is a small stepladder.")
	;(LDESC "A small stepladder is standing here.")
	(SYNONYM LADDER STEPLADDER)
	(ADJECTIVE SMALL)
	(CAPACITY 20)
	(SIZE 20)
	(FLAGS TAKEBIT VEHBIT CONTBIT SEARCHBIT SURFACEBIT)
	(ACTION LADDER-F)>

<BEGIN-SEGMENT 0>

<ROUTINE LADDER-F ("OPTIONAL" (VARG <>))
	 <COND (.VARG
		<RFALSE>)
	       (<VERB? OPEN CLOSE EXAMINE>
		<TELL
"The stepladder seems to be stuck in the open position." CR>)
	       (<AND <VERB? PUT-UNDER>
		     <PRSO? ,MEGABOZ-TRAP-DOOR>>
		<TELL "The ladder is now standing beneath the trap door." CR>)
	       (<VERB? STAND-ON CLIMB CLIMB-ON>
		<PERFORM ,V?ENTER ,LADDER>
		<RTRUE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT FENSHIRE>

<GLOBAL ARCHWAY-OPEN T>

<GLOBAL STEPPING-STONES-VISIBLE <>>

<ROOM MARSH
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Marsh")
      (SOUTH TO RUINED-HALL IF ARCHWAY-OPEN ELSE
       "The archway has collapsed; that way is now impassable.")
      (NORTH PER STEPPING-STONES-F)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL SWAMP ARCH)
      (ICON MARSH-ICON)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-3>)
      (ACTION MARSH-F)>

<ROUTINE MARSH-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The swamps of Fenshire have encroached on this once-beautiful garden. The
garden wall is now just a pile of mossy stones, and the garden terraces are
ankle-deep with squishy mud. A c">
		<COND (,ARCHWAY-OPEN
		       <TELL "rumbling archway leads">)
		      (T
		       <TELL "ollapsed archway blocks the exit to the">)>
		<TELL " south. To the north">
		<COND (,STEPPING-STONES-VISIBLE
		       <TELL
", stepping stones lead across a field of quicksand.">)
		      (T
		       <TELL " is a wide expanse of fetid quicksand.">)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <IN? ,JESTER ,HERE>
			    <VISIBLE? ,ROOSTER>
			    <FSET? ,ROOSTER ,ANIMATEDBIT>
			    <VISIBLE? ,FOX>
			    <FSET? ,FOX ,ANIMATEDBIT>
			    <VISIBLE? ,WORM>
			    <FSET? ,WORM ,ANIMATEDBIT>>
		       <MOVE ,JESTER ,NICE-LUNCH-SPOT>
		       <MOVE ,COOKPOT ,NICE-LUNCH-SPOT>
		       <MOVE ,COOKFIRE ,NICE-LUNCH-SPOT>
		       <SETG ARCHWAY-OPEN <>>
		       <SETG STEPPING-STONES-VISIBLE T>
		       <SETG COMPASS-CHANGED T>
		       <FSET ,RUINED-HALL ,REDESCBIT>
		       <RETURN-FROM-MAP>
		       <TELL
"   The jester looks delighted. \"Sacre bleu! At last! All zee ingredients for
Borphbelly Stew! But zee ambience here eesn't quite right.\" He picks up his
cookpot AND his cookfire, and dashes across the quicksand to the north, using
a series of stepping stones which you'd swear weren't there a minute ago. This
flurry of activity seems to have been too much for the archway behind you; it
crumbles into a pile of rubble, blocking the exit to the south.|
   The jester, out of sight amongst the reeds to the north, shouts, \"Yoo hoo!
I've found a lovely spot for lunch! Bring over zee ingredients!\"" CR>)
		      (<AND <NOT <IN? ,JESTER ,HERE>>
			    <IN? ,HEXAGONAL-BLOCK ,LOCAL-GLOBALS>
			    ,ARCHWAY-OPEN>
		       <DEQUEUE I-JESTER>
		       <THIS-IS-IT ,JESTER>
		       <MOVE ,JESTER ,HERE>
		       <MOVE ,COOKPOT ,HERE>
		       <MOVE ,COOKFIRE ,HERE>
		       <TELL
"   A string of eloquent cursing in a foreign tongue assaults you, and you spy
the jester " ,COOK-DESC " He is stirring a cookpot which sits upon a roaring
cookfire. \"Impossible!\" he shrieks, switching to a more familiar language.
\"Eet is impossible to cook a Borphbelly Stew weethout zee proper ingredients!
Impossible, impossible, impossible!\"" CR>)>)>>

<ROUTINE STEPPING-STONES-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<NOT ,STEPPING-STONES-VISIBLE>
		<COND (<NOT .RARG>
		       <TELL "You'd be sucked into the quicksand!" CR>)>
		<RFALSE>)
	       (<G? <CCOUNT ,PROTAGONIST> 1>
		<COND (<NOT .RARG>
		       <TELL
"It's difficult to balance on the stepping stones with all you're carrying.
You try, but after almost falling into the quicksand, you give up." CR>)>
		<RFALSE>)
	       (<EQUAL? ,HERE ,MARSH>
		,NICE-LUNCH-SPOT)
	       (T
		,MARSH)>>

<ROOM NICE-LUNCH-SPOT
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Nice Lunch Spot")
      (LDESC
"Maybe the jester likes the ambience here, but to you it just looks like
a slightly drier spot amidst a reedy marsh. The reeds are impassably thick
in every direction, except to the south where a series of stepping stones
offers a way to cross a malodorous patch of quicksand.")
      (SOUTH TO MARSH)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-3>)
      (ACTION NICE-LUNCH-SPOT-F)>

<ROUTINE NICE-LUNCH-SPOT-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <VISIBLE? ,ROOSTER>
		     <FSET? ,ROOSTER ,ANIMATEDBIT>
		     <VISIBLE? ,FOX>
		     <FSET? ,FOX ,ANIMATEDBIT>
		     <VISIBLE? ,WORM>
		     <FSET? ,WORM ,ANIMATEDBIT>>
		<MOVE ,HEXAGONAL-BLOCK ,SMALLER-HANGAR>
		<FSET ,SMALLER-HANGAR ,REDESCBIT>
		<FSET ,RUINED-HALL ,REDESCBIT>
		<REMOVE ,WORM>
		<REMOVE ,FOX>
		<REMOVE ,ROOSTER>
		<REMOVE ,COOKPOT>
		<REMOVE ,COOKFIRE>
		<DEQUEUE I-FOX>
		<DEQUEUE I-ROOSTER>
		<RETURN-FROM-MAP>
		<TELL
"   The jester says, \"Excellent! Zee ingredients for Borphbelly Stew and a "
D ,HERE " to enjoy eet!\" He tosses the animals into the cookpot, and begins
dishing out two generous portions of stew. Before you can eat it, a tremendous
weariness comes over you. The last thing you hear is the jester saying,
\"Waiter? Check, please!\"|
|
You awake from a deep sleep and struggle to your feet. As your head clears
you realize that you're not where you were when you fell asleep" ,ELLIPSIS>
		<GOTO ,SMALLER-HANGAR>
		<INC-SCORE 9>)>>

<BEGIN-SEGMENT 0> 

<OBJECT HEXAGONAL-BLOCK
	(LOC LOCAL-GLOBALS)
	(DESC "hexagonal block")
	(SYNONYM BLOCK ROCK)
	(ADJECTIVE SMALL ELONGATED HEXAGONAL HEXAGON-SHAPED)
	(FLAGS TAKEBIT)
	(SIZE 3)
	(ACTION HEXAGONAL-BLOCK-F)>

<ROUTINE HEXAGONAL-BLOCK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's just a small rock which has been neatly carved into the shape of an
elongated hexagon." CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT FENSHIRE>

<ROOM HOTHOUSE
      (LOC ROOMS)
      (REGION "Fenshire")
      (DESC "Hothouse")
      (LDESC
"This enclosed arboretum must have been a breathtaking room at one time. Now,
much of the glass is broken and the foliage has run wild, nearly obscuring the
exit to the north. Despite the broken glass, it's stiflingly hot in here.")
      (NORTH TO RUINED-HALL)
      (OUT TO RUINED-HALL)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM HOTHOUSE GREENHOUSE ARBORETUM)
      (GLOBAL WINDOW)
      (MAP-LOC <PTABLE FENSHIRE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-3>)
      (ICON HOTHOUSE-ICON)
      (ACTION HOTHOUSE-F)>

<ROUTINE HOTHOUSE-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <FSET? ,FAN ,TRYTAKEBIT>>
		<QUEUE I-SN 1>)>>

<CONSTANT SN-PICSET-TBL
	  <TABLE BOX-1
		 BOX-2
		 BOX-3
		 BOX-4
		 BOX-5
		 BOX-6
		 BOX-7
		 BOX-8
		 BOX-9
		 DIM-BOX-1
		 DIM-BOX-2
		 DIM-BOX-3
		 DIM-BOX-4
		 DIM-BOX-5
		 DIM-BOX-6
		 DIM-BOX-7
		 DIM-BOX-8
		 DIM-BOX-9
		 PILE-OF-0
		 PILE-OF-1
		 PILE-OF-2
		 PILE-OF-3
		 PILE-OF-4
		 PILE-OF-5
		 PILE-OF-6
		 PILE-OF-7
		 PILE-OF-8
		 PILE-OF-9
		 R-FLOWERS-0
		 R-FLOWERS-1
		 R-FLOWERS-2
		 R-FLOWERS-3
		 R-FLOWERS-4
		 R-FLOWERS-5
		 R-FLOWERS-6
		 R-FLOWERS-7
		 R-FLOWERS-8
		 R-FLOWERS-9
		 L-FLOWERS-0
		 L-FLOWERS-1
		 L-FLOWERS-2
		 L-FLOWERS-3
		 L-FLOWERS-4
		 0>>

<ROUTINE I-SN ()
	 <COND (<NOT <EQUAL? ,HERE ,HOTHOUSE>>
		<RFALSE>)
	       (,ALLIGATOR
		<QUEUE I-SN 1>
		<RFALSE>)>
	 <RETURN-FROM-MAP>
	 <UPDATE-STATUS-LINE>
	 <TELL
"   The jester steps out from behind some tropical vines, fanning himself with
a dainty paper fan. \"Hot enough for you? I know just the thing to take your
mind off this heat! It's one of my favorite games, Snarfem.|
   \"The rules: I'll produce four piles of pebbles. Each of us, starting with
you, will remove as many pebbles as we feel like -- as long as they come from
the same pile. You must take at least one pebble each turn. The player who
takes the last pebble wins. It's that simple!\"" CR CR>
	 <HIT-ANY-KEY "Snarfem">
	 <SPLIT-BY-PICTURE ,SN-SPLIT T>
	 <ADJUST-TEXT-WINDOW ,SN-BOTTOM>
	 <REPEAT ()
		 ;"All four piles should contain different numbers of pebbles,
 		   such as 1-4-5-9 rather than 1-4-4-9. Also, the opening
	 	   position can't be a 'safe' position, or you can't win."
		 <PUT ,PILE-TABLE 1 <RANDOM 9>>
	 	 <REPEAT ()
			 <PUT ,PILE-TABLE 2 <RANDOM 9>>
			 <COND (<EQUAL? <GET ,PILE-TABLE 2>
					<GET ,PILE-TABLE 1>>
				<PUT ,PILE-TABLE 2 <+ <GET ,PILE-TABLE 2> 1>>
				<COND (<EQUAL? <GET ,PILE-TABLE 2> 10>
				       <PUT ,PILE-TABLE 2 1>)>)
			       (T
				<RETURN>)>>
		 <REPEAT ()
			 <PUT ,PILE-TABLE 3 <RANDOM 9>>
			 <COND (<EQUAL? <GET ,PILE-TABLE 3>
					<GET ,PILE-TABLE 2>
					<GET ,PILE-TABLE 1>>
				<PUT ,PILE-TABLE 3 <+ <GET ,PILE-TABLE 3> 1>>
				<COND (<EQUAL? <GET ,PILE-TABLE 3> 10>
				       <PUT ,PILE-TABLE 3 1>)>)
			       (T
				<RETURN>)>>
		 <REPEAT ()
			 <PUT ,PILE-TABLE 4 <RANDOM 9>>
			 <COND (<EQUAL? <GET ,PILE-TABLE 4>
					<GET ,PILE-TABLE 3>
					<GET ,PILE-TABLE 2>
					<GET ,PILE-TABLE 1>>
				<PUT ,PILE-TABLE 4 <+ <GET ,PILE-TABLE 4> 1>>
				<COND (<EQUAL? <GET ,PILE-TABLE 4> 10>
				       <PUT ,PILE-TABLE 4 1>)>)
			       (T
				<RETURN>)>>
		 <COND (<NOT <SAFE-NUMBER? ,PILE-TABLE>>
			<RETURN>)>>
	 <SETUP-SN>
	 <CRLF>
	 <SNARFEM>
	 <INIT-SL-WITH-SPLIT ,TEXT-WINDOW-PIC-LOC>
	 <COND (<FSET? ,FAN ,TRYTAKEBIT>
		<TELL
"The jester claps you on the back and says, \"He who wins and
runs away, returns to let you win another day!\"">
		<J-EXITS>)
	       (T
		<MOVE ,FAN ,HERE>
		<REMOVE-J>
		<TELL
"\"You're undoubtedly not a flash in the pan; you've turned me into your
biggest fan!\" The jester is suddenly wearing a cap and sweater bearing your
initials, and waving a pennant with your name on it. Still chanting a cheer,
he vanishes, and you notice a delicate paper fan lying at your feet." CR>
		<INC-SCORE 12>)>>

<ROUTINE SETUP-SN ()
	 <SCREEN ,S-FULL>
	 <DISPLAY ,SN-BORDER 1 1>
	 <SCREEN ,S-WINDOW>
	 <PICSET ,SN-PICSET-TBL>
	 <DRAW-PILE 1>
	 <DRAW-PILE 2>
	 <DRAW-PILE 3>
	 <DRAW-PILE 4>
	 <DRAW-FLOWERS>>

<ROUTINE DRAW-SN-BOXES ("OPTIONAL" (PILE <>) "AUX" X Y SPACE (CNT 1) TBL)
	 <SCREEN ,S-WINDOW>
	 <PICINF-PLUS-ONE ,BOX-1-LOC>
	 <SET Y <GET ,PICINF-TBL 0>>
	 <SET X <GET ,PICINF-TBL 1>>
	 <PICINF ,SN-BOX-SPACE ,PICINF-TBL>
	 <SET SPACE <GET ,PICINF-TBL 1>>
	 <REPEAT ()
	   <SET TBL <COND (<NOT .PILE>
			   <COND (<G? .CNT 4> ,DIM-BOX-TBL)
				 (<EQUAL? <GET ,PILE-TABLE .CNT> 0>
				  	  ,DIM-BOX-TBL)
				 (T ,BOX-TBL)>)
			  (<G? .CNT <GET ,PILE-TABLE .PILE>> ,DIM-BOX-TBL)
			  (T ,BOX-TBL)>>
	   <DISPLAY <GET .TBL .CNT> .Y .X>
	   <COND (<EQUAL? .CNT 9>
		  <RETURN>)
		 (T
		  <SET X <+ .X .SPACE>>
		  <SET CNT <+ .CNT 1>>)>>
	 <SCREEN ,S-TEXT>>

<CONSTANT BOX-TBL
	  <PTABLE 0 BOX-1 BOX-2 BOX-3 BOX-4 BOX-5 BOX-6 BOX-7 BOX-8 BOX-9>>

<CONSTANT DIM-BOX-TBL
	  <PTABLE 0 DIM-BOX-1 DIM-BOX-2 DIM-BOX-3 DIM-BOX-4 DIM-BOX-5
  		  DIM-BOX-6 DIM-BOX-7 DIM-BOX-8 DIM-BOX-9>>

<CONSTANT PILE-TABLE
	<TABLE 0 0 0 0 0> ;"first element not used">

<ROUTINE DRAW-PILE (PILE "AUX" NUM PIC)
	 <SCREEN ,S-WINDOW>
	 <SET NUM <GET ,PILE-TABLE .PILE>>
	 <PICINF-PLUS-ONE <COND (<EQUAL? .PILE 1> ,PILE-1-PIC-LOC)
				(<EQUAL? .PILE 2> ,PILE-2-PIC-LOC)
				(<EQUAL? .PILE 3> ,PILE-3-PIC-LOC)
				(T ,PILE-4-PIC-LOC)>>
	 <SET PIC <COND (<EQUAL? .NUM 0> ,PILE-OF-0)
			(<EQUAL? .NUM 1> ,PILE-OF-1)
			(<EQUAL? .NUM 2> ,PILE-OF-2)
			(<EQUAL? .NUM 3> ,PILE-OF-3)
			(<EQUAL? .NUM 4> ,PILE-OF-4)
			(<EQUAL? .NUM 5> ,PILE-OF-5)
			(<EQUAL? .NUM 6> ,PILE-OF-6)
			(<EQUAL? .NUM 7> ,PILE-OF-7)
			(<EQUAL? .NUM 8> ,PILE-OF-8)
			(T ,PILE-OF-9)>>
	 <DISPLAY .PIC <GET ,PICINF-TBL 0> <GET ,PICINF-TBL 1>>
	 <SCREEN ,S-TEXT>>

<ROUTINE DRAW-FLOWERS ("AUX" (PILE 1) (NUM 1) LEFT RIGHT)
	 <COND (<SAFE-NUMBER? ,PILE-TABLE>
		<SET LEFT ,L-FLOWERS-0>
		<SET RIGHT ,R-FLOWERS-0>)
	       (T
		<REPEAT ()
		      <COPYT <REST ,PILE-TABLE 2> <REST ,TEMP-TABLE 2> 8>
		      <COND (<EQUAL? <GET ,PILE-TABLE .PILE> 0>
			     <SET PILE <+ .PILE 1>>)
			    (<EQUAL? <+ <GET ,PILE-TABLE 1> <GET ,PILE-TABLE 2>
				       <GET ,PILE-TABLE 3> <GET ,PILE-TABLE 4>>
				     <GET ,PILE-TABLE .PILE>>
			     ;"case where three piles are empty"
			     <SET NUM <GET ,PILE-TABLE .PILE>>
			     <RETURN>)
			    (T
			     <PUT ,TEMP-TABLE .PILE
				  <- <GET ,TEMP-TABLE .PILE> .NUM>>
			     <COND (<SAFE-NUMBER? ,TEMP-TABLE>
				    <RETURN>)
				   (<EQUAL? <- <GET ,PILE-TABLE .PILE> .NUM> 0>
				    <SET NUM 1>
				    <SET PILE <+ .PILE 1>>)
				   (T
				    <SET NUM <+ .NUM 1>>)>)>>
		<SET LEFT <COND (<EQUAL? .PILE 1> ,L-FLOWERS-1)
				(<EQUAL? .PILE 2> ,L-FLOWERS-2)
				(<EQUAL? .PILE 3> ,L-FLOWERS-3)
				(<EQUAL? .PILE 4> ,L-FLOWERS-4)>>
		<SET RIGHT <COND (<EQUAL? .NUM 1> ,R-FLOWERS-1)
				 (<EQUAL? .NUM 2> ,R-FLOWERS-2)
				 (<EQUAL? .NUM 3> ,R-FLOWERS-3)
				 (<EQUAL? .NUM 4> ,R-FLOWERS-4)
				 (<EQUAL? .NUM 5> ,R-FLOWERS-5)
				 (<EQUAL? .NUM 6> ,R-FLOWERS-6)
				 (<EQUAL? .NUM 7> ,R-FLOWERS-7)
				 (<EQUAL? .NUM 8> ,R-FLOWERS-8)
				 (<EQUAL? .NUM 9> ,R-FLOWERS-9)>>)>
	 <SCREEN ,S-WINDOW>
	 <PICINF-PLUS-ONE ,L-FLOWERS-PIC-LOC>
	 <DISPLAY .LEFT <GET ,PICINF-TBL 0> <GET ,PICINF-TBL 1>>
	 <PICINF-PLUS-ONE ,R-FLOWERS-PIC-LOC>
	 <DISPLAY .RIGHT <GET ,PICINF-TBL 0> <GET ,PICINF-TBL 1>>
	 <SCREEN ,S-TEXT>>

<ROUTINE SNARFEM ("AUX" X NUM (PILE <>) (STOP-SN <>))
	 <REPEAT ()
		 <COND (.STOP-SN
			<RETURN>)
		       (.PILE
			<CLEAR ,S-TEXT>
			<COND (,ACTIVE-MOUSE
			       <DRAW-SN-BOXES .PILE>)>
			<TELL "Type a number ">
			<COND (,ACTIVE-MOUSE
			       <TELL
"(or click on one of the numbered boxes with your mouse) ">)>
			<TELL
"to indicate how many pebbles you want to remove from Pile #" N .PILE ".">
			<REPEAT ()
				<SET X <INPUT X>>
				<MOUSE-INPUT?>
				<COND (<EQUAL? .X ,CLICK1 ,CLICK2>
				       <SET X <SN-CLICK T>>)
				      (<AND <G? .X 144>
					    <L? .X 155>>
				       ;"numeric keypad, 0=145, 1=146, etc."
				       <SET .X <- .X 145>>)
				      (T
				       ;"normal # keys, 1 = 49, 2 = 50, etc."
				       <SET X <- .X 48>>)>
				<COND (<OR <G? .X 9>
					   <L? .X 1>>
				       <CLEAR ,S-TEXT>
				       <TELL ,TYPE-A-NUMBER "9">
				       <COND (,ACTIVE-MOUSE
					      <TELL
" (or click on one of the numbered boxes with your mouse)">)>
				       <TELL ".">)
				      (<G? .X .NUM>
				       <CLEAR ,S-TEXT>
				       <TELL "There ">
				       <COND (<EQUAL? .NUM 1>
					      <TELL "is">)
					     (T
					      <TELL "are">)>
				       <TELL " only " N .NUM " pebble">
				       <COND (<NOT <EQUAL? .NUM 1>>
					      <TELL "s">)>
				       <TELL " in Pile #" N .PILE ".">)
				      (T
				       <CLEAR ,S-TEXT>
				       <TELL "You remove " N .X " pebble">
				       <COND (<NOT <EQUAL? .X 1>>
					      <TELL "s">)>
				       <TELL " from Pile #" N .PILE ".">
				       <COUNTDOWN-PILE .PILE .NUM .X>
				       <DRAW-FLOWERS>
				       <SET PILE <>>
				       <COND (<END-SN?>
					      <SET STOP-SN T>
					      <FCLEAR ,FAN ,TRYTAKEBIT>
					      <CRLF> <CRLF>
					      <HIT-ANY-KEY>
					      <RETURN>)
					     (T
					      <TELL CR "   ">)>
				       <J-MOVE>
				       <COND (<END-SN?>
					      <SET STOP-SN T>
					      <CRLF> <CRLF>
					      <HIT-ANY-KEY>)
					     (T
					      <TELL CR "   ">)>
				       <RETURN>)>>)
		       (T
			<COND (,ACTIVE-MOUSE
			       <DRAW-SN-BOXES>)>
			<TELL "Type a number ">
			<COND (,ACTIVE-MOUSE
			       <TELL
"(or click on one of the numbered boxes with your mouse) ">)>
			<TELL
"to select the pile from which you'd like to remove a pebble or pebbles.">
			<REPEAT ()
				<SET X <INPUT X>>
				<MOUSE-INPUT?>
				<COND (<EQUAL? .X ,CLICK1 ,CLICK2>
				       <SET X <SN-CLICK>>)
				      (<AND <G? .X 144>
					    <L? .X 155>>
				       ;"numeric keypad, 0=145, 1=146, etc."
				       <SET .X <- .X 145>>)
				      (T
				       ;"normal # keys, 1 = 49, 2 = 50, etc."
				       <SET X <- .X 48>>)>
				<COND (<OR <G? .X 4>
					   <L? .X 1>>
				       <CLEAR ,S-TEXT>
				       <TELL ,TYPE-A-NUMBER "4">
				       <COND (,ACTIVE-MOUSE
					      <TELL
" (or click on one of the numbered boxes with your mouse)">)>
				       <TELL ".">)
				      (<EQUAL? <GET ,PILE-TABLE .X> 0>
				       <CLEAR ,S-TEXT>
				       <TELL
"There are no longer any pebbles in Pile #" N .X ".">)
				      (T
				       <SET PILE .X>
				       <SET NUM <GET ,PILE-TABLE .PILE>>
				       <RETURN>)>>)>>>

<ROUTINE SN-CLICK ("OPT" (ALREADY-PICKED-PILE <>)
	 "AUX" TL-X TL-Y BR-X BR-Y BOX-WIDTH BOX-HEIGHT (CNT 1) (HIT-SPOT <>))
	 <PICINF ,BOX-1 ,PICINF-TBL>
	 <SET BOX-WIDTH <GET ,PICINF-TBL 1>>
	 <SET BOX-HEIGHT <GET ,PICINF-TBL 0>>
	 <PICINF-PLUS-ONE ,BOX-1-LOC>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET TL-Y <GET ,PICINF-TBL 0>>
	 <SET BR-Y <+ .TL-Y .BOX-HEIGHT>>
	 <PICINF ,SN-BOX-SPACE ,PICINF-TBL>
	 <REPEAT ()
		 <SET BR-X <+ .TL-X .BOX-WIDTH>>
		 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
			<SET HIT-SPOT T>
			<RETURN>)
		       (<EQUAL? .CNT 9>
			<RETURN>)
		       (T
			<SET CNT <+ .CNT 1>>
			<SET TL-X <+ .TL-X <GET ,PICINF-TBL 1>>>)>>
	 <COND (.HIT-SPOT
		<RETURN .CNT>)
	       (.ALREADY-PICKED-PILE
		<RFALSE>)>
	 <PICINF-PLUS-ONE ,PILE-OF-1>
	 <SET BOX-WIDTH <GET ,PICINF-TBL 1>>
	 <SET BOX-HEIGHT <GET ,PICINF-TBL 0>>
	 <PICINF-PLUS-ONE ,PILE-1-PIC-LOC>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET TL-Y <GET ,PICINF-TBL 0>>
	 <SET BR-X <+ .TL-X .BOX-WIDTH>>
	 <SET BR-Y <+ .TL-Y .BOX-HEIGHT>>
	 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		<SET CNT 1>
		<SET HIT-SPOT T>)>
	 <COND (<NOT .HIT-SPOT>
		<PICINF-PLUS-ONE ,PILE-2-PIC-LOC>
	 	<SET TL-X <GET ,PICINF-TBL 1>>
	 	<SET TL-Y <GET ,PICINF-TBL 0>>
	 	<SET BR-X <+ .TL-X .BOX-WIDTH>>
		<SET BR-Y <+ .TL-Y .BOX-HEIGHT>>
		<COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		       <SET CNT 2>
		       <SET HIT-SPOT T>)>)>
	 <COND (<NOT .HIT-SPOT>
		<PICINF-PLUS-ONE ,PILE-3-PIC-LOC>
	 	<SET TL-X <GET ,PICINF-TBL 1>>
	 	<SET TL-Y <GET ,PICINF-TBL 0>>
	 	<SET BR-X <+ .TL-X .BOX-WIDTH>>
		<SET BR-Y <+ .TL-Y .BOX-HEIGHT>>
		<COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		       <SET CNT 3>
		       <SET HIT-SPOT T>)>)>
	 <COND (<NOT .HIT-SPOT>
		<PICINF-PLUS-ONE ,PILE-4-PIC-LOC>
	 	<SET TL-X <GET ,PICINF-TBL 1>>
	 	<SET TL-Y <GET ,PICINF-TBL 0>>
	 	<SET BR-X <+ .TL-X .BOX-WIDTH>>
		<SET BR-Y <+ .TL-Y .BOX-HEIGHT>>
		<COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		       <SET CNT 4>
		       <SET HIT-SPOT T>)>)>
	 <COND (.HIT-SPOT
		<RETURN .CNT>)
	       (T
		<RFALSE>)>>

<ROUTINE COUNTDOWN-PILE (PILE NUM X)
	 <REPEAT ()
		 <PUT ,PILE-TABLE .PILE <- <GET ,PILE-TABLE .PILE> 1>>
		 <DRAW-PILE .PILE>
		 <SET X <- .X 1>>
		 <COND (<EQUAL? .X 0>
			<RETURN>)>>>

<CONSTANT BINARY-TABLE
	<PTABLE 0 1 10 11 100 101 110 111 1000 1001>>

<ROUTINE SAFE-NUMBER? (TBL "AUX" X)
	 <SET X <+ <GET ,BINARY-TABLE <GET .TBL 1>>
		   <GET ,BINARY-TABLE <GET .TBL 2>>
		   <GET ,BINARY-TABLE <GET .TBL 3>>
		   <GET ,BINARY-TABLE <GET .TBL 4>>>>
	 <COND (<AND <EQUAL? <MOD .X 2> 0>
		     <EQUAL? <MOD </ .X 10> 2> 0>
		     <EQUAL? <MOD </ .X 100> 2> 0>
		     <EQUAL? <MOD </ .X 1000> 2> 0>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<CONSTANT TEMP-TABLE
	<TABLE 0 0 0 0 0>>

<ROUTINE J-MOVE ("AUX" (PILE 1) (NUM 1))
	 <TELL "The jester peruses the piles, considering his move." CR CR>
	 <HIT-ANY-KEY>
	 <CLEAR ,S-TEXT>
	 <COND (<SAFE-NUMBER? ,PILE-TABLE>
		<REPEAT () ;"pick a random pile, but make sure it isn't empty"
			<SET PILE <RANDOM 4>>
			<COND (<EQUAL? <GET ,PILE-TABLE .PILE> 0>
			       <COND (<EQUAL? .PILE 4>
				      <SET PILE 0>)
				     (T
				      <SET PILE <+ .PILE 1>>)>)
			      (T
			       <RETURN>)>>
		;"now take a random number of pebbles between 1 and all of 'em"
		<SET NUM <RANDOM <GET ,PILE-TABLE .PILE>>>)
	       (T
		<REPEAT ()
		      <COPYT <REST ,PILE-TABLE 2> <REST ,TEMP-TABLE 2> 8>
		      <COND (<EQUAL? <GET ,PILE-TABLE .PILE> 0>
			     <SET PILE <+ .PILE 1>>)
			    (<EQUAL? <+ <GET ,PILE-TABLE 1> <GET ,PILE-TABLE 2>
				       <GET ,PILE-TABLE 3> <GET ,PILE-TABLE 4>>
				     <GET ,PILE-TABLE .PILE>>
			     ;"case where three piles are empty"
			     <SET NUM <GET ,PILE-TABLE .PILE>>
			     <RETURN>)
			    (T
			     <PUT ,TEMP-TABLE .PILE
				  <- <GET ,TEMP-TABLE .PILE> .NUM>>
			     <COND (<SAFE-NUMBER? ,TEMP-TABLE>
				    <RETURN>)
				   (<EQUAL? <- <GET ,PILE-TABLE .PILE> .NUM> 0>
				    <SET NUM 1>
				    <SET PILE <+ .PILE 1>>)
				   (T
				    <SET NUM <+ .NUM 1>>)>)>>)>
	 <TELL "The jester removes " N .NUM " pebble">
	 <COND (<NOT <EQUAL? .NUM 1>>
		<TELL "s">)>
	 <TELL " from Pile #" N .PILE ".">
	 <COUNTDOWN-PILE .PILE <GET ,PILE-TABLE .PILE> .NUM>
	 <DRAW-FLOWERS>>

<ROUTINE END-SN? ()
	 <COND (<AND <EQUAL? <GET ,PILE-TABLE 1> 0>
		     <EQUAL? <GET ,PILE-TABLE 2> 0>
		     <EQUAL? <GET ,PILE-TABLE 3> 0>
		     <EQUAL? <GET ,PILE-TABLE 4> 0>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FAN
	(DESC "fan")
	(SYNONYM FAN)
	(ADJECTIVE DELICATE DAINTY PAPER)
	(FLAGS TAKEBIT TRYTAKEBIT MAGICBIT)
	(VALUE 0) ;"12 points given elsewhere"
	(ACTION FAN-F)>

<ROUTINE FAN-F ()
	 <COND (<AND <VERB? POINT>
		     <EQUAL? ,P-PRSA-WORD ,W?WAVE>>
		<TELL "You produce a light breeze." CR>)>>

<END-SEGMENT>
