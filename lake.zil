"LAKE for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT LAKE>

<ROOM WEST-SHORE
      (LOC ROOMS)
      (DESC "West Shore")
      (REGION "Flatheadia")
      (EAST SORRY "These waters are known for their hungry denizens.")
      (WEST TO ROYAL-ZOO)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (GLOBAL LAKE-FLATHEAD STAIRS)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-3>)
      (ICON WEST-SHORE-ICON)
      (ACTION WEST-SHORE-F)>

<ROUTINE WEST-SHORE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"What's a castle without a lake? Dimwit loved lakes, but hated to go outside,
so he had one constructed in his extensive cellars. Once a lovely lake, teeming
with life, its waters have grown stagnant. The scummy surface stretches off to
the east, and a tunnel leads west.">)>>

<OBJECT WEST-DOCK
	(LOC WEST-SHORE)
	(DESC "yellow dock")
	(SYNONYM DOCK)
	(ADJECTIVE YELLOW WEST)
	(CAPACITY 200)
	(FLAGS NDESCBIT VEHBIT DROPBIT OPENBIT SEARCHBIT CONTBIT SURFACEBIT)
	(ACTION DOCK-F)>

<ROOM NORTH-SHORE
      (LOC ROOMS)
      (DESC "North Shore")
      (REGION "Flatheadia")
      (SOUTH SORRY "These waters are known for their hungry denizens.")
      (NORTH TO PHIL-HALL)
      (NE TO THEATRE)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (GLOBAL LAKE-FLATHEAD STAIRS)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-4>)
      (ICON NORTH-SHORE-ICON)
      (ACTION NORTH-SHORE-F)>

<ROUTINE NORTH-SHORE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Stretching off to the south is an impressive sight: a large lake, completely
contained within the castle. A red dock protrudes into the lake">
		<COND (<IN? ,YACHT ,HERE>
		       <TELL ,YACHT-MOORED>)>
		<TELL ". Tunnels lead north and northeast.">)>>

<OBJECT NORTH-DOCK
	(LOC NORTH-SHORE)
	(DESC "red dock")
	(SYNONYM DOCK)
	(ADJECTIVE RED NORTH)
	(CAPACITY 200)
	(FLAGS NDESCBIT VEHBIT DROPBIT OPENBIT SEARCHBIT CONTBIT SURFACEBIT)
	(ACTION DOCK-F)>

<ROOM EAST-SHORE
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "East Shore")
      (WEST SORRY "These waters are known for their hungry denizens.")
      (EAST TO BASE-OF-MOUNTAIN)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (GLOBAL LAKE-FLATHEAD STAIRS G-U-MOUNTAIN)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-5>)
      (ICON EAST-SHORE-ICON)
      (ACTION EAST-SHORE-F)>

<ROUTINE EAST-SHORE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"A narrow beach lies between the lake, to the west, and a tall mountain,
to the east. It's hard to remember that you're still within the castle.
A blue dock juts out into the lake">
		<COND (<IN? ,YACHT ,HERE>
		       <TELL ,YACHT-MOORED>)>
		<TELL ".">)>>

<OBJECT EAST-DOCK
	(LOC EAST-SHORE)
	(DESC "blue dock")
	(SYNONYM DOCK)
	(ADJECTIVE BLUE EAST)
	(CAPACITY 200)
	(FLAGS NDESCBIT VEHBIT DROPBIT OPENBIT SEARCHBIT CONTBIT SURFACEBIT)
	(ACTION DOCK-F)>

<ROOM SOUTH-SHORE
	(LOC ROOMS)
	(DESC "South Shore")
	(REGION "Flatheadia")
	(NORTH SORRY "These waters are known for their hungry denizens.")
	(SOUTH TO EDGE-OF-DESERT)
	(WEST TO STREAM)
	(FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
	(GLOBAL LAKE-FLATHEAD STAIRS)
	(MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-4>)
	(ICON SOUTH-SHORE-ICON)
	(ACTION SOUTH-SHORE-F)>

<ROUTINE SOUTH-SHORE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The sandy beach on the south side of the lake is very wide -- in fact, it
simply blends into a wide desert to the south. To the north, a green dock
extends into the lake">
		<COND (<IN? ,YACHT ,HERE>
		       <TELL ,YACHT-MOORED>)>
		<TELL ". The shore curves around toward the west.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,PROTAGONIST ,CAMEL>
		     <NOT <FSET? ,CAMEL ,TOUCHBIT>>
		     ,CAMEL-THIRSTY>
		<FSET ,CAMEL ,TOUCHBIT>
		<RETURN-FROM-MAP>
		<TELL
"   The camel takes one look at the scummy water and wheezes mournfully through
parched lips." CR>)>>

<OBJECT SOUTH-DOCK
	(LOC SOUTH-SHORE)
	(DESC "green dock")
	(SYNONYM DOCK)
	(ADJECTIVE GREEN SOUTH)
	(CAPACITY 200)
	(FLAGS NDESCBIT VEHBIT DROPBIT OPENBIT SEARCHBIT CONTBIT SURFACEBIT)
	(ACTION DOCK-F)>

<ROUTINE DOCK-F ("OPTIONAL" (VARG <>))
	 <COND (<AND <VERB? ENTER>
		     <IN? ,BEDBUG ,HERE>
		     <NOT ,TIME-STOPPED>>
		<DO-WALK ,P?NORTH>)>>

<OBJECT YACHT
	(LOC WEST-SHORE)
	(DESC "royal yacht")
	(LDESC
"The royal yacht sits by the dock, bobbing gently in the swell of the lake.")
	(SYNONYM YACHT BOAT)
	(ADJECTIVE ROYAL)
	(CAPACITY 200)
	(FLAGS VEHBIT DROPBIT OPENBIT SEARCHBIT CONTBIT SURFACEBIT)
	(ACTION YACHT-F)>

<ROUTINE YACHT-F ("OPTIONAL" (VARG <>))
	 <COND (.VARG
		<COND (<NOT <EQUAL? .VARG ,M-ENTER>>
		       <RFALSE>)
		      (<FSET? ,PRSO ,TOUCHBIT>
		       <SETG COMPASS-CHANGED T>
		       <RFALSE>)
		      (T
		       <SETG COMPASS-CHANGED T>
		       <TELL
" The controls seem worthy of closer
examination. A gangway leads belowdecks." CR>)>)
	       (<AND <VERB? ENTER>
		     <IN? ,PROTAGONIST ,HERE>>
		<TELL "You can only board the yacht from the dock." CR>)
	       (<VERB? EXIT>
		<COND (<EQUAL? ,HERE ,LAKE-FLATHEAD>
		       <PERFORM ,V?ENTER ,LAKE-FLATHEAD>
		       <RTRUE>)>
		<MOVE ,PROTAGONIST
		      <COND (<EQUAL? ,HERE ,WEST-SHORE> ,WEST-DOCK)
			    (<EQUAL? ,HERE ,NORTH-SHORE> ,NORTH-DOCK)
			    (<EQUAL? ,HERE ,EAST-SHORE> ,EAST-DOCK)
			    (T ,SOUTH-DOCK)>>
		<SETG OLD-HERE <>>
		<SETG COMPASS-CHANGED T>
		<TELL "You step off the boat, onto the dock." CR>
		<COND (<EQUAL? ,VERBOSITY 1>
		       <CRLF> <SAY-HERE> <CRLF>)
		      (<EQUAL? ,VERBOSITY 2>
		       <CRLF> <V-LOOK>)>
		<RTRUE>)
	       (<VERB? SINK>
		<SETG AWAITING-REPLY 1>
	 	<QUEUE I-REPLY 2>
		<TELL "You have a torpedo, maybe?" CR>)
	       (<AND <VERB? SET>
		     <EQUAL? ,P-PRSA-WORD ,W?STEER>>
		<TELL "There's no wheel." CR>)
	       (<AND <VERB? THROW-FROM>
		     <PRSI? ,YACHT>>
		<PERFORM ,V?PUT ,PRSO ,WATER>
		<RTRUE>)>>

<OBJECT YACHT-CONTROLS
	(LOC YACHT)
	(DESC "controls")
	(SYNONYM CONTROL CONTROLS ROSE COMPASS)
	(ADJECTIVE COMPASS)
	(FLAGS NDESCBIT NARTICLEBIT PLURALBIT)
	(ACTION YACHT-CONTROLS-F)>

<ROUTINE YACHT-CONTROLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The controls are quite simple, consisting of a small brass plaque and an
ornate compass rose. There are buttons on the four cardinal points of the
rose: a red button at the north point, blue at the east, green south, and
yellow west. A fifth button, white, is at the center of the rose." CR>)>>

<OBJECT YACHT-PLAQUE
	(LOC YACHT)
	(DESC "brass plaque")
	(SYNONYM PLAQUE)
	(ADJECTIVE SMALL BRASS)
	(FLAGS READBIT NDESCBIT)
	(TEXT "\"Made by the Frobozz Magic Royal Yacht Company.\"")>

<OBJECT RED-BUTTON
	(LOC YACHT)
	(DESC "red button")
	(SYNONYM BUTTON)
	(ADJECTIVE RED)
	(FLAGS NDESCBIT)
	(ACTION YACHT-BUTTON-F)>

<OBJECT BLUE-BUTTON
	(LOC YACHT)
	(DESC "blue button")
	(SYNONYM BUTTON)
	(ADJECTIVE BLUE)
	(FLAGS NDESCBIT)
	(ACTION YACHT-BUTTON-F)>

<OBJECT GREEN-BUTTON
	(LOC YACHT)
	(DESC "green button")
	(SYNONYM BUTTON)
	(ADJECTIVE GREEN)
	(FLAGS NDESCBIT)
	(ACTION YACHT-BUTTON-F)>

<OBJECT YELLOW-BUTTON
	(LOC YACHT)
	(DESC "yellow button")
	(SYNONYM BUTTON)
	(ADJECTIVE YELLOW)
	(FLAGS NDESCBIT)
	(ACTION YACHT-BUTTON-F)>

<OBJECT WHITE-BUTTON
	(LOC YACHT)
	(DESC "white button")
	(SYNONYM BUTTON)
	(ADJECTIVE WHITE FIFTH CENTER MIDDLE)
	(FLAGS NDESCBIT)
	(ACTION YACHT-BUTTON-F)>

<ROUTINE YACHT-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<OR <FSET? ,OUTER-GATE ,OPENBIT>
			   ,TIME-STOPPED>
		       <TELL ,NOTHING-HAPPENS>)
		      (<NOT <FSET? ,SEAMANS-CAP ,WORNBIT>>
		       <TELL
"You meet an invisible resistance. A peal of laughter from behind turns out
to be the jester. \"The button may seem like a demon, telling landlubber from
seaman; but the truth's not so queer -- you need nautical gear!\"">
		       <J-EXITS>)
		      (<PRSO? ,WHITE-BUTTON>
		       <COND (<EQUAL? ,HERE ,LAKE-FLATHEAD>
			      <DEQUEUE I-YACHT>
			      <TELL ,NOTHING-HAPPENS>)
			     (T
			      <SETG YACHT-DESTINATION ,LAKE-FLATHEAD>
			      <I-YACHT T>)>)
		      (<NOT <IN? ,DB ,HOLD>>
		       <TELL
"A message flashes: \"Warning -- diving bell lowered!\"" CR>)
		      (<PRSO? ,RED-BUTTON>
		       <COND (<EQUAL? ,HERE ,NORTH-SHORE>
			      <TELL ,NOTHING-HAPPENS>)
			     (T
			      <SETG YACHT-DESTINATION ,NORTH-SHORE>
			      <I-YACHT T>)>)
		      (<PRSO? ,GREEN-BUTTON>
		       <COND (<EQUAL? ,HERE ,SOUTH-SHORE>
			      <TELL ,NOTHING-HAPPENS>)
			     (T
			      <SETG YACHT-DESTINATION ,SOUTH-SHORE>
			      <I-YACHT T>)>)
		      (<PRSO? ,BLUE-BUTTON>
		       <COND (<EQUAL? ,HERE ,EAST-SHORE>
			      <TELL ,NOTHING-HAPPENS>)
			     (T
			      <SETG YACHT-DESTINATION ,EAST-SHORE>
			      <I-YACHT T>)>)
		      (T
		       <COND (<EQUAL? ,HERE ,WEST-SHORE>
			      <TELL ,NOTHING-HAPPENS>)
			     (T
			      <SETG YACHT-DESTINATION ,WEST-SHORE>
			      <I-YACHT T>)>)>
		<RTRUE>)>>

<GLOBAL YACHT-DESTINATION <>>

<ROUTINE I-YACHT ("OPTIONAL" (CALLED-BY-BUTTON-F <>))
	 <COND (.CALLED-BY-BUTTON-F
		<QUEUE I-YACHT 2>
		<COND (<AND <EQUAL? ,HERE ,LAKE-FLATHEAD>
			    <NOT <EQUAL? ,YACHT-DESTINATION ,LAKE-FLATHEAD>>>
		       <TELL
"The boat heads for the " D ,YACHT-DESTINATION ,PERIOD-CR>)
		      (T
		       <TELL
"The yacht moves away from the dock, toward the middle of the lake." CR CR>)>)>
	 <COND (<IN? ,YACHT ,LAKE-FLATHEAD>
		<MOVE ,YACHT ,YACHT-DESTINATION>
		<RETURN-FROM-MAP>
		<COND (<IN? ,PROTAGONIST ,YACHT> ;"not in Hold"
		       <TELL
"   The yacht reaches the " D ,YACHT-DESTINATION " and docks magically." CR CR>
		       <GOTO ,YACHT>)>)
	       (T
		<MOVE ,YACHT ,LAKE-FLATHEAD>
		<COND (<IN? ,PROTAGONIST ,YACHT> ;"not in Hold"
		       <RETURN-FROM-MAP>
		       <GOTO ,YACHT>
		       <TELL "   The boat reaches the middle of the lake">
		       <COND (<EQUAL? ,YACHT-DESTINATION ,LAKE-FLATHEAD>
			      <TELL ", slows, and stops">)
			     (T
			      <TELL
" and heads straight for the dock on the " D ,YACHT-DESTINATION>)>
		       <TELL ,PERIOD-CR>)>)>
	 <COND (<IN? ,YACHT ,YACHT-DESTINATION>
		<DEQUEUE I-YACHT>)>
	 <RTRUE>>

<ROOM HOLD
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Hold")
      (LDESC
"You are in a cabin under the deck of the royal yacht. A steep gangway leads
upward.")
      (UP PER YACHT-ENTER-F)
      (IN PER DB-ENTER-F)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (GLOBAL STAIRS)
      (SYNONYM HOLD)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-1>)
      (ICON HOLD-ICON)>

<ROUTINE YACHT-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RFALSE>)>
	 <GOTO ,YACHT>
	 <RFALSE>>

<ROUTINE DB-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RFALSE>)
	       (<FSET? ,DB ,OPENBIT>
		<PERFORM ,V?ENTER ,DB>)
	       (T
		<RETURN-FROM-MAP>
		<THIS-IS-IT ,DB>
		<DO-FIRST "open the bathysphere">)>
	 <RFALSE>>

<OBJECT DB
	(LOC HOLD)
	(DESC "bathysphere")
	(SYNONYM SPHERE BATHYSPHERE DOOR HATCH BELL)
	(ADJECTIVE DIVING)
	(CAPACITY 200)
	(FLAGS VEHBIT INBIT DROPBIT CONTBIT SEARCHBIT TRANSBIT)
	(ACTION DB-F)>

<GLOBAL DB-CONTROLS-DESCRIBED <>>

<ROUTINE DB-F ("OPTIONAL" (VARG <>))
	 <COND (<AND .VARG
		     <NOT <EQUAL? .VARG ,M-ENTER>>>
		<RFALSE>)
	       (.VARG
		<COND (,DB-CONTROLS-DESCRIBED
		       <RFALSE>)
		      (T
		       <SETG DB-CONTROLS-DESCRIBED T>
		       <TELL " ">
		       <PERFORM ,V?EXAMINE ,DB>
		       <RTRUE>)>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,PROTAGONIST ,DB>
		       <TELL "This is a cramped diving bell. The door is ">
		       <OPEN-CLOSED ,DB>
		       <TELL
". A brass plaque is mounted next to a small porthole. You may want to
examine the controls." CR>)
		      (T
		       <TELL "The diving bell is ">
		       <OPEN-CLOSED ,DB>
		       <TELL
". Mounted on the outside of it is a claw-like waldo." CR>)>)
	       (<AND <VERB? ENTER>
		     <NOT <IN? ,PROTAGONIST ,DB>>
		     <NOT <FSET? ,DB ,OPENBIT>>>
		<DO-WALK ,P?IN>)
	       (<AND <VERB? EXIT>
		     <IN? ,PROTAGONIST ,DB>>
		<COND (,HAND-IN-WALDO
		       <DO-FIRST "remove your hand from the waldo">)
		      (<NOT <FSET? ,DB ,OPENBIT>>
		       <THIS-IS-IT ,DB>
		       <DO-FIRST "open the bathysphere">)
		      (<IN? ,RUBY ,WALDO>
		       <FCLEAR ,RUBY ,TRYTAKEBIT>
		       <RFALSE>)>)
	       (<VERB? RAISE LOWER>
		<COND (<IN? ,PROTAGONIST ,DB>
		       <TELL ,YOULL-HAVE-TO "use the controls." CR>)
		      (T
		       <TELL "You can't do that from out here." CR>)>)
	       (<AND <VERB? OPEN>
		     <NOT <EQUAL? ,HERE ,HOLD>>>
		<JIGS-UP "Having thus flooded the bathysphere, you drown.">)>>

<OBJECT DB-CONTROLS
	(LOC DB)
	(DESC "controls")
	(SYNONYM CONTROL CONTROLS)
	(FLAGS NDESCBIT NARTICLEBIT PLURALBIT)
	(GENERIC G-DB-HOLE-F)
	(ACTION DB-CONTROLS-F)>

<ROUTINE DB-CONTROLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The controls seem simple enough: an up-down lever, an exterior light,
and a hand-hole for controlling the exterior waldo." CR>)>>

<OBJECT DB-PLAQUE
	(LOC DB)
	(DESC "brass plaque")
	(SYNONYM PLAQUE)
	(ADJECTIVE SMALL BRASS)
	(FLAGS READBIT NDESCBIT)
	(TEXT
"\"A product of the Frobozz Magic Bathysphere Company, designed by
Jacques Yves Flathead.\"")>

<ROUTINE G-DB-HOLE-F (TBL F)
	 <COND (<EQUAL? <FIND-NOUN .F> ,W?CONTROL>
		;"confusion is between hand-hole and controls"
		,DB-CONTROLS)
	       (T ;"confusion is between hand-hole and porthole"
		,HAND-HOLE)>>

<OBJECT PORTHOLE
	(LOC DB)
	(DESC "porthole")
	(SYNONYM PORTHOLE PORT HOLE)
	(ADJECTIVE PORT)
	(FLAGS NDESCBIT)
	(GENERIC G-DB-HOLE-F)
	(ACTION PORTHOLE-F)>

<ROUTINE PORTHOLE-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<V-LOOK>)>>

<OBJECT RUBY
	(LOC LAKE-BOTTOM)
	(DESC "moby ruby")
	(PLURAL "rubies")
	(FDESC "A ruby of incredible size and beauty is buried in the sand.")
	(SYNONYM RUBY JEWEL)
	(ADJECTIVE RED MOBY LARGE BEAUTIFUL)
	(FLAGS TRYTAKEBIT TAKEBIT READBIT)
	(VALUE 25)
	(SIZE 3)
	(TEXT "This ruby must surely be the largest jewel in the land.")>

<OBJECT EXTERIOR-LIGHT
	(LOC DB)
	(DESC "exterior light")
	(SYNONYM LIGHT LIGHTS)
	(ADJECTIVE EXTERIOR)
	(FLAGS LIGHTBIT NDESCBIT VOWELBIT)>

<OBJECT WALDO
	(LOC HOLD)
	(DESC "waldo")
	(SYNONYM WALDO)
	(ADJECTIVE EXTERIOR)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT OPENBIT)
	(ACTION WALDO-F)>

<ROUTINE WALDO-F ()
	 <COND (<AND <NOT <FSET? ,EXTERIOR-LIGHT ,ONBIT>>
		     <NOT <EQUAL? ,HERE ,HOLD>>
		     <HANDLE ,WALDO>>
		<CANT-SEE ,WALDO>)
	       (<AND <VERB? REACH-IN>
		     <IN? ,PROTAGONIST ,DB>>
		<PERFORM ,V?REACH-IN ,HAND-HOLE>
		<RTRUE>)
	       (<VERB? DROP> ;"IDROP lets it pass if your hand is in the hole"
		<TELL
"Although you can manipulate the waldo, you aren't holding it. [If you want
to remove your hand, try REMOVE HAND.]" CR>)
	       (<VERB? PUT>
		<MOVE ,PRSO ,HERE>
	        <TELL
,YOU-CANT "budge the waldo's claw, so" T ,PRSO " falls right out." CR>)
	       (<VERB? OPEN CLOSE>
		<COND (,HAND-IN-WALDO
		       <COND (<FIRST? ,WALDO>
			      <COND (<VERB? OPEN>
				     <PERFORM ,V?DROP <FIRST? ,WALDO>>
			      	     <RTRUE>)
				    (T
				     <TELL
"The waldo IS closed! It's holding" AR <FIRST? ,WALDO>>)>)
			     (T
			      <TELL
"The claws of the waldo open and close." CR>)>)
		      (T
		       <TELL "The claws of the waldo won't budge." CR>)>)
	       (<AND <VERB? TAKE-WITH>
		     <PRSI? ,WALDO>>
		<COND (<PRSO? ,DB ,WALDO>
		       <IMPOSSIBLES>)
		      (,HAND-IN-WALDO
		       <SETG PRSI <>>
		       <PERFORM ,V?TAKE ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "Your hand isn't in the hand-hole!" CR>)>)>>

<GLOBAL HAND-IN-WALDO <>>

<OBJECT HAND-HOLE
	(LOC DB)
	(DESC "hand-hole")
	(SYNONYM HOLE HAND-HOLE CONTROL)
	(ADJECTIVE HAND WALDO)
	(FLAGS NDESCBIT)
	(GENERIC G-DB-HOLE-F)
	(ACTION HAND-HOLE-F)>

<ROUTINE HAND-HOLE-F ()
	 <COND (<NOT <IN? ,PROTAGONIST ,DB>>
		<CANT-REACH ,HAND-HOLE>)
	       (<VERB? REACH-IN>
		<TELL "Your hand is ">
		<COND (,HAND-IN-WALDO
		       <TELL "already in the hand-hole!" CR>)
		      (T
		       <SETG HAND-IN-WALDO T>
		       <TELL "now in the hand-hole">
		       <COND (<NOT <FSET? ,WALDO ,TOUCHBIT>>
			      <FSET ,WALDO ,TOUCHBIT>
			      <TELL
". The waldo feels like an extension of your own hand.
You flex your fingers a few times">
			      <COND (<OR <FSET? ,EXTERIOR-LIGHT ,ONBIT>
					 <EQUAL? ,HERE ,HOLD>>
				     <TELL
", and through the viewport, you see the waldo flex correspondingly">)>)>
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (,HAND-IN-WALDO
		       <TELL "Your hand is in the hole." CR>)
		      (T
		       <TELL ,ONLY-BLACKNESS>)>)>>

<ROUTINE WALDO-TAKE ()
	 <COND (<PRSI? ,WALDO>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?REMOVE>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T
		       <CANT-REACH ,PRSO>)>)
	       (<FIRST? ,WALDO>
		<TELL
"There's already" A <FIRST? ,WALDO> " in the waldo." CR>)
	       (<AND <EQUAL? ,HERE ,LAKE-BOTTOM>
		     <NOT <IN? ,SQUID-REPELLENT ,LAKE-BOTTOM>>>
		<TELL
"Before the waldo can grab" T ,PRSO ", a baby squid swims into view and
snatches" T ,PRSO ". The squid playfully squirts black ink toward the
porthole, and by the time the view clears, the squid is gone">
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <TELL
" and" T ,PRSO " is lying right where it was before">)>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<MOVE ,PRSO ,WALDO>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "You pick up" T ,PRSO " in the waldo." CR>)
	       (<PRSO? ,SPENSEWEED>
		<TELL ,DEEPLY-ROOTED>)
	       (<PRSO? ,JESTER ,J-HAT ,J-POCKET ,J-SHOE>
		<TELL
"Your attempt ends up giving the jester a pinch with the waldo. \"Please!\" he
exclaims. \"I'm not that sort of jester!\"" CR>)
	       (T
		<YUKS>)>>

<OBJECT LEVER
	(LOC DB)
	(DESC "up-down lever")
	(SYNONYM LEVER)
	(ADJECTIVE UP-DOWN)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION LEVER-F)>

<GLOBAL DB-DIRECTION 0> ;"1 = ascending, -1 = descending"

<GLOBAL DB-DEPTH 0>

<GLOBAL PIECE-DROWNED 0>

<ROUTINE LEVER-F ("AUX" X)
	 <COND (<VERB? EXAMINE>
		<TELL "The lever is in the ">
		<COND (<EQUAL? ,DB-DIRECTION 1>
		       <TELL "up">)
		      (<EQUAL? ,DB-DIRECTION -1>
		       <TELL "down">)
		      (T
		       <TELL "neutral">)>
		<TELL " position">
		<COND (<EQUAL? ,DB-DIRECTION 0>
		       <TELL ", from which it can be raised or lowered." CR>)
		      (T
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? RAISE>
		<COND (<EQUAL? ,DB-DIRECTION 1>
		       <TELL "The lever is already raised." CR>)
		      (<EQUAL? ,HERE ,HOLD>
		       <TELL ,NOTHING-HAPPENS>)
		      (T
	 	       <SETG DB-DIRECTION 1>
		       <QUEUE I-DB 2>
		       <TELL "The bathysphere ascends.">
		       <COND (<EQUAL? ,HERE ,LAKE-BOTTOM>
			      <SETG DB-DEPTH 4>
			      <MOVE ,DB ,UNDERWATER>
			      <MOVE ,WALDO ,UNDERWATER>
			      <GLANCE>)
			     (T
			      <CRLF>)>)>)
	       (<VERB? LOWER>
		<COND (<EQUAL? ,DB-DIRECTION -1>
		       <TELL "The lever is already lowered." CR>)
		      (<OR <EQUAL? ,DB-DEPTH 4>
			   <NOT <IN? ,YACHT ,LAKE-FLATHEAD>>>
		       <TELL ,NOTHING-HAPPENS>)
                      (<AND <SET X <FIRST? ,WALDO>>
			    <EQUAL? .X ,FOX ,FLAMINGO ,ROOSTER ,SNAKE>>
		       <TELL "You'd drown the poor ">
		       <PRINTD .X>
		       <TELL "!" CR>)
		      (<FSET? ,DB ,OPENBIT>
		       <JIGS-UP
"The bathysphere descends, filling with water through its open door.
As you are not a fish, this is fatal.">)
		      (T
		       <SETG DB-DIRECTION -1>
		       <QUEUE I-DB 2>
		       <TELL
"The bathysphere descends into the waters of the lake">
		       <COND (<SET X <FIND-IN ,WALDO ,FLAMEBIT>>
			      <FCLEAR .X ,ONBIT>
			      <FCLEAR .X ,FLAMEBIT>
			      <COND (<VISIBLE? .X>
				     <TELL ", extinguishing" T .X>)>)>
		       <TELL ".">
		       <COND (<EQUAL? ,HERE ,HOLD>
			      <SETG DB-DEPTH 0>
			      <MOVE ,DB ,UNDERWATER>
			      <MOVE ,WALDO ,UNDERWATER>
			      <GLANCE>)
			     (T
			      <CRLF>)>)>)>>

<ROUTINE GLANCE ()
	 <TELL " You glance out the porthole" ,ELLIPSIS>
	 <GOTO ,DB>>

<ROUTINE I-DB ()
	 <QUEUE I-DB -1>
	 <SETG DB-DEPTH <- ,DB-DEPTH ,DB-DIRECTION>>
	 <COND (<IN? ,PROTAGONIST ,DB>
		<RETURN-FROM-MAP>
		<TELL "   The bathysphere ">)>
	 <COND (<L? ,DB-DEPTH 1>
		<DEQUEUE I-DB>
		<SETG DB-DIRECTION 0>
		<MOVE ,DB ,HOLD>
	 	<MOVE ,WALDO ,HOLD>
		<COND (<IN? ,PROTAGONIST ,DB>
		       <TELL "rises into the yacht's hold and stops.">
		       <GLANCE>)
		      (<EQUAL? ,HERE ,HOLD>
		       <RETURN-FROM-MAP>
		       <TELL "   A diving bell rises into the Hold." CR>)
		      (T
		       <RFALSE>)>)
	       (<G? ,DB-DEPTH 3>
		<DEQUEUE I-DB>
		<SETG DB-DIRECTION 0>
		<MOVE ,DB ,LAKE-BOTTOM>
		<MOVE ,WALDO ,LAKE-BOTTOM>
		<COND (<IN? ,PROTAGONIST ,DB>
		       <TELL "bumps against the bottom of the lake.">
		       <GLANCE>)
		      (T
		       <RFALSE>)>)
	       (<NOT <IN? ,PROTAGONIST ,DB>>
		<RFALSE>)
	       (T
		<TELL "continues to ">
		<COND (<EQUAL? ,DB-DIRECTION -1>
		       <TELL "de">)
		      (<EQUAL? ,DB-DIRECTION 1>
		       <TELL "a">)>
		<TELL "scend." CR>
		<COND (<G? ,PIECE-DROWNED 0>
		       <COND (<PROB ,PIECE-DROWNED>
			      <SETG PIECE-DROWNED 1>
			      <TELL
"   The drowned carcass of a chess piece drifts momentarily through the
beam of the exterior light." CR>)
			     (T
			      <SETG PIECE-DROWNED <+ ,PIECE-DROWNED 10>>)>)>)>
	 <RTRUE>>

<ROOM LAKE-FLATHEAD
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Lake Flathead")
      (LDESC
"You are in the center of a once-handsome lake, lit from the roof high
overhead. On the distant shores, you can spot docks in all four
cardinal directions.")
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT NARTICLEBIT WATERBIT)
      (SYNONYM LAKE FLATHEAD)
      (ADJECTIVE FLATHEAD LAKE PLACID CLEAR CRYSTAL)
      (VALUE 18)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-4>)
      (GLOBAL STAIRS)
      (ICON LAKE-FLATHEAD-ICON)
      (RESEARCH
"\"This large and handsome lake lies entirely within the royal castle at
Flatheadia.\"")
      (ACTION LAKE-FLATHEAD-F)>

<ROUTINE LAKE-FLATHEAD-F ("OPTIONAL" (RARG <>))
	 <COND (.RARG
		<RFALSE>)
	       (<VERB? DRINK DRINK-FROM ENTER LOOK-UNDER REACH-IN>
		<PERFORM-PRSA ,WATER ,PRSI>)
	       (<AND <VERB? FILL PUT>
		     <PRSI? ,GLOBAL-HERE>>
		<PERFORM-PRSA ,PRSO ,WATER>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The water is scummy and murky." CR>)>>

<ROOM UNDERWATER
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Underwater")
      (LDESC
"Here, between the surface and floor of Lake Flathead, the water is somewhat
clearer.")
      ;(UP SORRY "Use the bathysphere controls.")
      ;(DOWN SORRY "Use the bathysphere controls.")
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (GLOBAL LAKE-FLATHEAD)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-1>)
      (ICON UNDERWATER-ICON)>

<ROOM LAKE-BOTTOM
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Lake Bottom")
      (LDESC
"You have reached the sandy bottom at the deepest point of Lake Flathead.
Beautiful freshwater fish swim among slowly waving spenseweeds.")
      ;(UP SORRY "Use the bathysphere controls.")
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (GLOBAL LAKE-FLATHEAD)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-1>)
      (ICON LAKE-BOTTOM-ICON)
      (ACTION LAKE-BOTTOM-F)>

<ROUTINE LAKE-BOTTOM-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,SPENSEWEED ,HERE>
		<FSET ,SPENSEWEED ,NDESCBIT>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,WORM ,WALDO>>
		<REMOVE ,WORM>
		<RETURN-FROM-MAP>
		<TELL
"   A fish snatches the worm from the waldo and swims away with it." CR>)>>

<OBJECT LAKE-BOTTOM-FISH
	(LOC LAKE-BOTTOM)
	(DESC "freshwater fish")
	(SYNONYM FISH)
	(ADJECTIVE BEAUTIFUL FRESHWATER)
	(FLAGS NDESCBIT)
	(ACTION LAKE-BOTTOM-FISH-F)>

<ROUTINE LAKE-BOTTOM-FISH-F ()
	 <COND (<TOUCHING? ,LAKE-BOTTOM-FISH>
		<CANT-REACH ,LAKE-BOTTOM-FISH>)>>

<ROOM BASE-OF-MOUNTAIN
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Base of Mountain")
      (LDESC
"In a rare moment of restraint, Dimwit scaled back his plans for putting
an entire mountain range in the castle, settling for merely a single mountain.
A difficult trail leads east up the mountain; easier paths head north, west,
and south.")
      (NORTH TO STABLE)
      (SOUTH TO G-U-WOODS)
      (WEST TO EAST-SHORE)
      (EAST PER G-U-MOUNTAIN-ENTER-F)
      (UP PER G-U-MOUNTAIN-ENTER-F)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (GLOBAL G-U-MOUNTAIN)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-6>)
      (ICON BASE-OF-MT-ICON)>

<ROUTINE G-U-MOUNTAIN-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<IN? ,PROTAGONIST ,CAMEL>
		<COND (<NOT .RARG>
		       <RETURN-FROM-MAP>
		       <TELL
"Like most camels, this one isn't very good at mountain climbing." CR>)>
		<RFALSE>)
	       (T
		,G-U-MOUNTAIN)>>

<ROOM STABLE
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Stable")
      (LDESC
"The stalls here once held thousands of royal mounts. The only exit is south.")
      (SOUTH TO BASE-OF-MOUNTAIN)
      (OUT TO BASE-OF-MOUNTAIN)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (SYNONYM STABLE)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-6>)
      (ICON STABLE-ICON)
      (THINGS <> STALL STALL-PS)
      (ACTION STABLE-F)>

<ROUTINE STABLE-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,STABLE ,TOUCHBIT>>>
		<QUEUE I-ROOSTER -1>)>>

<ROUTINE STALL-PS ()
	 <COND (<VERB? EXAMINE ENTER>
		<TELL "The stalls are all empty." CR>)>>

<OBJECT SADDLE
	(LOC STABLE)
	(DESC "saddle")
	(FDESC
"A well-worn unicorn saddle, of military style, is hanging at the far
end of the stable.")
	(SYNONYM SADDLE)
	(ADJECTIVE WELL-WORN UNICORN MILITARY)
	(FLAGS TAKEBIT MAGICBIT READBIT)
	(SIZE 15)
	(VALUE 12)
	(TEXT "You can barely make out the name \"Wilma.\"")
	(ACTION SADDLE-F)>

<BEGIN-SEGMENT 0>

<ROUTINE SADDLE-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSO? ,SADDLE>>
		<TELL
"You'd be kicked out of riding school -- imagine, trying to saddle"
A ,PRSI "!" CR>)>>

<OBJECT ROOSTER
	(LOC STABLE)
	(DESC "rooster")
	(FDESC
"There's not a horse in sight. However, there is a rooster here, strutting
back and forth between the stalls.")
	(SYNONYM ROOSTER BIRD VANE)
	(ADJECTIVE WEATHER)
	(FLAGS TAKEBIT TRYTAKEBIT ANIMATEDBIT)
	(INANIMATE-DESC "weather vane")
	(WAND-TEXT
"The rooster stops moving and takes on the complexion of wrought iron.")
	(ANIMATE-ROUTINE I-W-ROOSTER)
	(SIZE 10)
	(ACTION ROOSTER-F)>

<ROUTINE ROOSTER-F ()
	 <COND (<AND <VERB? RESEARCH>
		     <NOUN-USED? ,ROOSTER ,W?ROOSTER>>
		<TELL "\"A common barnyard animal.\"" CR>)
	       (<NOT <FSET? ,ROOSTER ,ANIMATEDBIT>>
		<RFALSE>)
	       (<VERB? EAT>
		<COND (<EQUAL? ,TURNED-INTO ,FOX>
		       <GOOD-MEAL ,ROOSTER>)
		      (T
		       <TELL
"Unfortunately, you have no training in the butchering and culinary
techniques involved in turning live poultry into edible meals." CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"It is a handsome, mature rooster, with a full red comb." CR>)
	       (<VERB? TOUCH>
		<TELL "The bird pecks at your hand." CR>)
	       (<AND <VERB? TAKE>
		     <FSET? ,ROOSTER ,ANIMATEDBIT>>
		<COND (<EQUAL? <ITAKE T> ,M-FATAL>
		       <RTRUE>)
		      (T
		       <MOVE ,ROOSTER ,PROTAGONIST>
		       <TELL
"The bird flaps angrily, but you manage to pick it up." CR>)>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,WORM>>
		<REMOVE ,WORM>
		<TELL
"The bird sucks down the worm and crows happily." CR>)
	       (<AND <VERB? FEED>
		     <ULTIMATELY-IN? ,WORM>>
		<WOULDNT-MIND ,ROOSTER ,WORM>)>>

<ROUTINE I-W-ROOSTER ("AUX" (L <LOC ,ROOSTER>))
	 <FSET ,ROOSTER ,ANIMATEDBIT>
	 <COND (<IN? ,ROOSTER ,LAKE-BOTTOM>
		<REMOVE ,ROOSTER>)
	       (<EQUAL? <META-LOC ,ROOSTER> ,HERE>
		<RETURN-FROM-MAP>
		<TELL
"   The air is split by a loud \"Cock-a-doodle-doo!\" as the weather
vane once again becomes a rooster">
		<COND (<AND <NOT <EQUAL? .L ,PROTAGONIST ,HERE>>
			    <NOT <FSET? .L ,DROPBIT>>>
		       <MOVE ,ROOSTER ,HERE>
		       <FSET .L ,OPENBIT>
		       <TELL " and pops out of" T .L>)>
		<TELL ,PERIOD-CR>)
	       (T
		<MOVE ,ROOSTER <META-LOC ,ROOSTER>>
		<RFALSE>)>>

<GLOBAL ROOSTER-PROB 100>

<GLOBAL ROOSTER-BURP <>>

<ROUTINE I-ROOSTER ("AUX" L)
	 <COND (<NOT <FSET? ,ROOSTER ,ANIMATEDBIT>>
		<RFALSE>)
	       (<NOT <VISIBLE? ,ROOSTER>>
		<COND (<AND <SET L <LOC ,ROOSTER>>
			    <EQUAL? .L <LOC ,WORM>>
			    <FSET? ,WORM ,ANIMATEDBIT>
			    <NOT <FSET? .L ,ACTORBIT>>>
		       <SETG ROOSTER-BURP T>
		       <REMOVE ,WORM>)>
		<RFALSE>)
	       (,ROOSTER-BURP
		<SETG ROOSTER-BURP <>>
		<RETURN-FROM-MAP>
		<TELL "   The rooster fails to hide a satisfied burp." CR>)
	       (<OR <NOT <VISIBLE? ,WORM>>
		    <NOT <FSET? ,WORM ,ANIMATEDBIT>>>
		<RFALSE>)
	       (<PROB ,ROOSTER-PROB>
		<RETURN-FROM-MAP>
		<SETG ROOSTER-PROB 0>
		<TELL "   The rooster hungrily eyes the worm." CR>)
	       (T
		<SETG ROOSTER-PROB <+ ,ROOSTER-PROB 10>>
		<RFALSE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LAKE>

<ROOM G-U-MOUNTAIN
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Great Underground Mountain")
      (WEST TO BASE-OF-MOUNTAIN)
      (DOWN TO BASE-OF-MOUNTAIN)
      (NORTH PER CAVE-ENTER-F)
      (IN PER CAVE-ENTER-F)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (SYNONYM MOUNTAIN)
      (ADJECTIVE GREAT UNDERGROUND)
      (RESEARCH
"\"One of the many awe-inspiring features of Dimwit's castle in Flatheadia.\"")
      (GLOBAL LAKE-FLATHEAD)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-7>)
      (ICON G-U-MOUNTAIN-ICON)
      (ACTION G-U-MOUNTAIN-F)>

<ROUTINE G-U-MOUNTAIN-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <G? ,ORACLE-EXIT-NUMBER 4>>
		<SETG ORACLE-EXIT-NUMBER <- <RANDOM 5> 1>>
		<QUEUE I-AMULET 4>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The mountain crests with a tiny plateau. The view is inspiring; it's easy
to see why Dimwit climbed this mountain with such frequency. (Some quibblers
insisted that it's hardly \"mountain climbing\" to be carried up in a plush
sedan chair, but those quibblers were all tortured to death years ago.) Off
to the west are the placid waters of Lake Flathead; to the southwest is a
vast indoor desert; to the south spreads a verdant forest. The ceiling of
the castle is just a few feet above your head. ">
		<COND (<IN? ,BOULDER ,HERE>
		       <TELL
"An enormous boulder is balanced precariously at the
western edge of the plateau">)
		      (T
		       <TELL "A small cave opens to the north">)>
		<TELL ". A trail leads down the mountain to the west.">)>>

<ROUTINE CAVE-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<IN? ,BOULDER ,HERE>
		<COND (<NOT .RARG>
		       <CANT-GO>)>
		<RFALSE>)
	       (T
		,GROTTO)>>

<OBJECT BOULDER
	(LOC G-U-MOUNTAIN)
	(DESC "boulder")
	(SYNONYM BOULDER ROCK)
	(ADJECTIVE LARGE)
	(FLAGS NDESCBIT)
	(ACTION BOULDER-F)>

<ROUTINE BOULDER-F ()
	 <COND (<VERB? PUSH MOVE KICK ROLL>
		<REMOVE ,BOULDER>
		<SETG COMPASS-CHANGED T>
		<MOVE ,CAVE-OBJECT ,HERE>
		<TELL
"You give the boulder a shove. It lurches and begins careening down the
mountain. Picking up speed, it flattens several trees, hits an outcropping,
and shoots into the air, toward the lake. It lands ">
		<COND (<IN? ,YACHT ,EAST-SHORE>
		       <TELL "right on the yacht">)
		      (T
		       <TELL
"in the lake with a tremendous splash, just missing the blue dock">)>
		<TELL "! The rock ">
		<COND (<IN? ,YACHT ,EAST-SHORE>
		       <REMOVE ,YACHT>
		       <COND (<OR <ULTIMATELY-IN? ,PERCH ,YACHT>
				  <ULTIMATELY-IN? ,PERCH ,HOLD>>
			      <SETG REMOVED-PERCH-LOC ,WATER>
			      <REMOVE ,PERCH>)>
		       <TELL "and the yacht vanish">)
		      (T
		       <TELL "disappears">)>
		<TELL
" beneath the water, leaving only a series of widening ripples. As you
recuperate from the excitement, you notice a feature that was formerly
blocked by the boulder: a small cave leading north into the mountain." CR>
		<INC-SCORE 6>)
	       (<AND <VERB? LOWER>
		     <EQUAL? ,P-PRSA-WORD ,W?PUSH>>
		<PERFORM ,V?PUSH ,BOULDER>
		<RTRUE>)
	       (<AND <VERB? PUSH-DIR>
		     <PRSI? ,INTDIR>
		     <NOUN-USED? ,INTDIR ,W?WEST>>
		<PERFORM ,V?PUSH ,BOULDER>
		<RTRUE>)>>

<OBJECT CAVE-OBJECT
	(DESC "cave")
	(SYNONYM CAVE)
	(ADJECTIVE TINY)
	(FLAGS NDESCBIT)
	(ACTION CAVE-OBJECT-F)>

<ROUTINE CAVE-OBJECT-F ()
	 <COND (<VERB? ENTER>
		<GOTO ,GROTTO>)>>

<ROOM GROTTO
	(LOC ROOMS)
	(REGION "Region:  Unknown")
	(DESC "Grotto")
	(LDESC
"You are in a damp grotto near the peak of the Great Underground Mountain.
Slimy moss covers the irregular rock walls. Winding passages lead south and
northeast, and a steep gravelly passage leads downward at an alarming angle.")
	(SOUTH TO G-U-MOUNTAIN)
	(NE TO SHRINE)
	(DOWN PER LOWEST-HALL-ENTER-F)
	(WEST PER LOWEST-HALL-ENTER-F)
	(FLAGS RLANDBIT UNDERGROUNDBIT)
	(SYNONYM GROTTO)
	(MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-7>)>P

<OBJECT GROTTO-REBUS-BUTTON
	(LOC GROTTO)
	(SDESC "blinking key-shaped button")
	(FDESC
"Imbedded in the rocky wall is a blinking button in the shape of a key.")
	(SYNONYM BUTTON)
	(ADJECTIVE KEY-SHAPED BLINKING)
	(ACTION REBUS-BUTTON-F)>

<ROUTINE LOWEST-HALL-ENTER-F
	 ("OPT" (RARG <>) "AUX" (CURRENT-GRAVEL <>) (SPILL <>))
	 <COND (.RARG
	        <RETURN ,LOWEST-HALL>)>
	 <RETURN-FROM-MAP>
	 <TELL
"You lose your footing on the gravel, drop your possessions, and begin sliding
down the dark tunnel! Finally, you land on a hard floor">
	 <COND (<OR <AND <IN? ,GRAVEL ,LOCAL-GLOBALS>
			 <SET CURRENT-GRAVEL ,GRAVEL>>
		    <AND <IN? ,MORE-GRAVEL ,LOCAL-GLOBALS>
			 <SET CURRENT-GRAVEL ,MORE-GRAVEL>>
		    <AND <IN? ,EVEN-MORE-GRAVEL ,LOCAL-GLOBALS>
			 <SET CURRENT-GRAVEL ,EVEN-MORE-GRAVEL>>>
		<TELL "; a shower of gravel lands on top of you">)>
	 <COND (<AND <ULTIMATELY-IN? ,LARGE-VIAL>
		     <G? ,LARGE-VIAL-GLOOPS 0>>
		<SETG LARGE-VIAL-GLOOPS 0>
		<REMOVE ,LARGE-VIAL-WATER>
		<SET SPILL T>)>
	 <COND (<AND <ULTIMATELY-IN? ,SMALL-VIAL>
		     <G? ,SMALL-VIAL-GLOOPS 0>>
		<SETG SMALL-VIAL-GLOOPS 0>
		<REMOVE ,SMALL-VIAL-WATER>
		<SET SPILL T>)>
	 <COND (<AND <ULTIMATELY-IN? ,CUP>
		     <IN? ,POTION ,CUP>>
		<REMOVE ,POTION>
		<SET SPILL T>)>
	 <COND (.SPILL
		<TELL ". You seem to have spilled something, also">)>
	 <TELL ".">
	 <COND (.CURRENT-GRAVEL
		;"if no chess piece present, it'll end up on floor.
		  if chess piece present, he'll pick up the gravel in ROB"
		<MOVE .CURRENT-GRAVEL ,PROTAGONIST>)>
	 <SETG HERE ,LOWEST-HALL>
	 ;"so that ROB properly describes chesspiece taking pigeon"
	 <ROB ,PROTAGONIST ,LOWEST-HALL T>
	 <CRLF> <CRLF>
	 ,LOWEST-HALL>

<OBJECT GRAVEL
	(LOC LOCAL-GLOBALS)
	(DESC "gravel")
	(PLURAL "gravel")
	(SYNONYM GRAVEL)
	(GENERIC G-GRAVEL-F)
	(FLAGS TAKEBIT NARTICLEBIT)
	(ACTION GRAVEL-F)>

<OBJECT MORE-GRAVEL
	(LOC LOCAL-GLOBALS)
	(DESC "more gravel")
	(PLURAL "gravel")
	(SYNONYM GRAVEL)
	(ADJECTIVE MORE)
	(GENERIC G-GRAVEL-F)
	(FLAGS TAKEBIT NARTICLEBIT)
	(ACTION GRAVEL-F)>

<OBJECT EVEN-MORE-GRAVEL
	(LOC LOCAL-GLOBALS)
	(DESC "even more gravel")
	(PLURAL "gravel")
	(SYNONYM GRAVEL)
	(ADJECTIVE EVEN MORE)
	(GENERIC G-GRAVEL-F)
	(FLAGS TAKEBIT NARTICLEBIT)
	(ACTION GRAVEL-F)>

<BEGIN-SEGMENT 0>

<ROUTINE G-GRAVEL-F (TBL LEN)
	 <COND (<INTBL? ,GRAVEL <REST-TO-SLOT .TBL FIND-RES-OBJ1>
				<FIND-RES-COUNT .TBL>>
		,GRAVEL)
	       (T ;"the two confused objs must be MORE-GRAV and EVEN-MORE-GRAV"
		,MORE-GRAVEL)>>

<ROUTINE GRAVEL-F ()
	 <COND (<VERB? TAKE>
		<ORDER-GRAVEL ,PROTAGONIST>
		<RFALSE>)
	       (<VERB? DROP>
		<ORDER-GRAVEL ,HERE>
		<RFALSE>)
	       (<VERB? EXAMINE MEASURE COUNT>
		<TELL "It's about a handful." CR>)
	       (<AND <VERB? POUR>
		     <PRSO? ,GRAVEL ,MORE-GRAVEL ,EVEN-MORE-GRAVEL>>
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LAKE>

<ROOM SHRINE
      (LOC ROOMS)
      (DESC "Shrine")
      (REGION "Region:  Unknown")
      (LDESC
"You have stumbled upon a long-hidden shrine to Saint Foobus of Galepath.
An idol of Foobus is carved from the very rock that forms this cave. The only
exit is southwest.")
      (SW TO GROTTO)
      (OUT TO GROTTO)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-8>)
      (ICON SHRINE-ICON)>

<OBJECT IDOL
	(LOC SHRINE)
	(DESC "idol")
	(SYNONYM ST SAINT IDOL FOOBUS GALEPATH SHRINE)
	(ADJECTIVE SAINT ST)
	(FLAGS NDESCBIT VOWELBIT)
	(RESEARCH
"\"The legendary Saint Foobus was said to have power over lowly insects.\"")
	(ACTION IDOL-F)>

<ROUTINE IDOL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The idol has been carved into the cave wall by the hand of a master sculptor
(who obviously spent far more time on the project than a saint of Foobus'
stature deserves)." CR>)>>

<OBJECT BOWL
	(LOC SHRINE)
	(DESC "bowl")
	(LDESC
"Sitting before the idol is a translucent bowl, extremely tall and narrow,
like a carafe.")
	(SYNONYM BOWL CARAFE)
	(ADJECTIVE TRANSLUCENT TALL NARROW)
	(FLAGS TRYTAKEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 25)
	(ACTION BOWL-F)>

<ROUTINE BOWL-F (CNT)
	 <SET CNT <GRAVEL-COUNT>>
	 <COND (<VERB? CLOSE>
		<TELL ,HUH>)
	       (<VERB? EXAMINE>
		<TELL
"The bowl is tall and narrow, like a large drinking glass. ">
		<PERFORM ,V?LOOK-INSIDE ,BOWL>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "It is ">
		<COND (<EQUAL? .CNT 0>
		       <TELL "less than a quarter">)
		      (<EQUAL? .CNT 1>
		       <TELL "more than a quarter">)
		      (<EQUAL? .CNT 2>
		       <TELL "less than half">)
		      (T
		       <TELL "more than half">)>
		<TELL " full with a milky elixir." CR>)
	       (<VERB? REACH-IN>
		<COND (<EQUAL? .CNT 3>
		       <TELL
"Your fingers are just long enough to touch the elixir. ">
		       <TOUCH-ELIXIR>)
		      (T
		       <TELL
"Because the bowl is so narrow, you can only get your fingers
halfway to the bottom, ">
		       <COND (<EQUAL? .CNT 0>
			      <TELL "well">)
			     (<EQUAL? .CNT 1>
			      <TELL "somewhat">)
			     (<EQUAL? .CNT 2>
			      <TELL "a smidgeon">)>
		       <TELL " short of the elixir." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,BOWL>>
		<COND (<PRSO? ,GRAVEL ,MORE-GRAVEL ,EVEN-MORE-GRAVEL>
		       <MOVE ,PRSO ,BOWL>
		       <FCLEAR ,PRSO ,TAKEBIT>
	               <TELL
"The gravel sinks to the bottom of the bowl, thus raising the level
of the elixir. It is now ">
		       <SET CNT <+ .CNT 1>>
		       <COND (<EQUAL? .CNT 1>
			      <TELL "somewhat more than one-quarter">)
			     (<EQUAL? .CNT 2>
			      <TELL "just less than half">)
			     (T
			      <TELL "a bit over half">)>
		       <TELL "way to the brim." CR>)
		      (<PRSO? ,STRAW>
		       <MOVE ,STRAW ,BOWL>
		       <TELL
"The straw extends just above the rim of the bowl." CR>)
		      (<PRSO? ,RING ,ZORKMID-COIN ,EAST-KEY ,WEST-KEY
			      ,RUSTY-KEY ,SQUID-REPELLENT ,UNOPENED-NUT
			      ,NUT-SHELL ,NUT ,RUBY ,SAPPHIRE>
		       <MOVE ,PRSO ,BOWL>
		       <FCLEAR ,PRSO ,TAKEBIT>
		       <TELL
"With a tiny splash," T ,PRSO " sinks to the bottom of the bowl. It's not
clear how you'll ever get it out again..." CR>)
		      (T
		       <TELL "The rim of the bowl is too narrow." CR>)>)
	       (<AND <VERB? TAKE MOVE TIP TIP-OVER>
		     <PRSO? ,BOWL>>
		<TELL "The bowl is affixed to the cave floor." CR>)>>

<ROUTINE GRAVEL-COUNT ("AUX" CNT)
	 <SET CNT 0>
	 <COND (<IN? ,GRAVEL ,BOWL>
		<SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,MORE-GRAVEL ,BOWL>
		<SET CNT <+ .CNT 1>>)>
	 <COND (<IN? ,EVEN-MORE-GRAVEL ,BOWL>
		<SET CNT <+ .CNT 1>>)>
	 .CNT>

<OBJECT ELIXIR
	(LOC BOWL)
	(DESC "elixir")
	(SYNONYM ELIXIR LIQUID)
	(ADJECTIVE MILKY)
	(FLAGS VOWELBIT)
	(ACTION ELIXIR-F)>

<ROUTINE ELIXIR-F ()
	 <COND (<VERB? TOUCH REACH-IN>
		<PERFORM ,V?REACH-IN ,BOWL>
		<RTRUE>)
	       (<VERB? DRINK TASTE>
		<COND (<IN? ,STRAW ,BOWL>
		       <PERFORM ,V?DRINK-WITH ,ELIXIR ,STRAW>
		       <RTRUE>)
		      (T
		       <TELL
"The elixir is at the bottom of a bowl which is
affixed to the cave floor." CR>)>)
	       (<AND <VERB? CLEAN>
		     <EQUAL? ,P-PRSA-WORD ,W?SOAK>
		     <PRSI? ,ELIXIR>>
		<PERFORM ,V?PUT ,PRSO ,ELIXIR>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,ELIXIR>>
		<PERFORM ,V?PUT ,PRSO ,BOWL>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The milky liquid swirls with secret energies." CR>)
	       (<AND <VERB? FILL>
		     <PRSI? ,ELIXIR>>
		<COND (<PRSO? ,STRAW>
		       <TELL
"You'll have to be more specific about how you propose to do that." CR>)
		      (T
		       <TELL
"The bowl's narrowness prevents you from filling" TR ,PRSO>)>)>>

<ROOM BATS-LAIR
      (LOC ROOMS)
      (DESC "Bat's Lair")
      (REGION "Region:  Unknown")
      (LDESC
"Only a deranged bat would live in this disgusting nesting space, caked with
layer upon layer of dried guano. A precarious path leads down to the west;
there's little chance you'd be able to climb back.")
      (DOWN PER LAIR-EXIT-F)
      (OUT PER LAIR-EXIT-F)
      (WEST PER LAIR-EXIT-F)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (SYNONYM LAIR)
      (ADJECTIVE BAT\'S)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-7>)
      (ICON BATS-LAIR-ICON)>

<ROUTINE LAIR-EXIT-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<OR .RARG
		    <EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>>
		<RETURN ,G-U-WOODS>)>
	 <TELL
"You lose your footing on the treacherous path, and tumble painfully down
a steep incline. ">
	 <COND (<FIRST? ,PROTAGONIST>
		<TELL "Amazingly, you hold on to everything you have. ">)>
	 <TELL
"You roll to a stop as dim green light filters around you" ,ELLIPSIS>
	 ,G-U-WOODS>

<ROOM G-U-WOODS
      (LOC ROOMS)
      (DESC "Great Underground Woods")
      (REGION "Flatheadia")
      (LDESC
"You are surrounded by tall oaks and wide pines. Birds chirp in the distance.
Trails wind north and southwest among the trees.")
      (NORTH TO BASE-OF-MOUNTAIN)
      (SW TO G-U-SAVANNAH)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (SYNONYM WOODS)
      (ADJECTIVE GREAT UNDERGROUND)
      (RESEARCH
"\"One of the many awe-inspiring features of Dimwit's castle in Flatheadia.\"")
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-6>)
      (THINGS TALL OAK TREE-PS
       	      WIDE PINE TREE-PS
	      PINE TREE TREE-PS
	      OAK TREE TREE-PS)
      (ACTION G-U-WOODS-F)>

<ROUTINE G-U-WOODS-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,G-U-WOODS ,TOUCHBIT>>>
		<QUEUE I-FOX -1>)>>

<BEGIN-SEGMENT 0>

<OBJECT FOX
	(LOC G-U-WOODS)
	(DESC "fox")
	(PLURAL "foxes")
	(FDESC "A fox is leaning against a nearby tree, looking sly.")
	(SYNONYM FOX STOLE)
	(ADJECTIVE FOX)
	(FLAGS TAKEBIT TRYTAKEBIT ANIMATEDBIT)
	(INANIMATE-DESC "fox stole")
	(WAND-TEXT "The fox's eyes turn glassy.")
	(ANIMATE-ROUTINE I-W-FOX)
	(SIZE 15)
	(ACTION FOX-F)>

<ROUTINE FOX-F ()
	 <COND (<AND <VERB? RESEARCH>
		     <NOUN-USED? ,FOX ,W?FOX>>
		<TELL "\"A common animal.\"" CR>)
	       (<NOT <FSET? ,FOX ,ANIMATEDBIT>>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <FSET? ,FOX ,ANIMATEDBIT>>
		<COND (<EQUAL? <ITAKE T> ,M-FATAL>
		       <RTRUE>)
		      (T
		       <MOVE ,FOX ,PROTAGONIST>
		       <TELL
"The fox slyly allows himself to be picked up." CR>)>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,ROOSTER>>
		<REMOVE ,ROOSTER>
		<TELL
"The fox must be thinking that you're Santa Claus and this is Christmas
(but of course he's too sly to let you see that he's thinking that). After
a few messy moments, the rooster is history." CR>)
	       (<AND <VERB? FEED>
		     <ULTIMATELY-IN? ,ROOSTER>>
		<WOULDNT-MIND ,FOX ,ROOSTER>)>>

<ROUTINE WOULDNT-MIND (EATER EATEE)
	 <TELL
"The " D .EATER " looks as though he wouldn't mind eating the "
D .EATEE "..." CR>>

<ROUTINE I-W-FOX ("AUX" (L <LOC ,FOX>))
	 <FSET ,FOX ,ANIMATEDBIT>
	 <FCLEAR ,FOX ,WEARBIT>
	 <FCLEAR ,FOX ,WORNBIT>
	 <COND (<IN? ,FOX ,LAKE-BOTTOM>
		<REMOVE ,FOX>)
	       (<EQUAL? <META-LOC ,FOX> ,HERE>
		<RETURN-FROM-MAP>
		<TELL "   The fox suddenly ">
		<COND (<AND <NOT <EQUAL? .L ,PROTAGONIST ,HERE>>
			    <NOT <FSET? .L ,DROPBIT>>>
		       <MOVE ,FOX ,HERE>
		       <FSET .L ,OPENBIT>
		       <TELL "pops out of" T .L " and ">)>
		<TELL "shakes its bushy tail." CR>)
	       (T
		<MOVE ,FOX <META-LOC ,FOX>>
		<RFALSE>)>>

<GLOBAL FOX-PROB 100>

<GLOBAL FOX-BURP <>>

<ROUTINE I-FOX ("AUX" L)
	 <COND (<NOT <FSET? ,FOX ,ANIMATEDBIT>>
		<RFALSE>)
	       (<NOT <VISIBLE? ,FOX>>
		<COND (<AND <SET L <LOC ,FOX>>
			    <EQUAL? .L <LOC ,ROOSTER>>
			    <FSET? ,ROOSTER ,ANIMATEDBIT>
			    <NOT <FSET? .L ,ACTORBIT>>>
		       <SETG FOX-BURP T>
		       <REMOVE ,ROOSTER>)>
		<RFALSE>)
	       (,FOX-BURP
		<SETG FOX-BURP <>>
		<RETURN-FROM-MAP>
		<TELL "   The fox produces a deep and very sly burp." CR>)
	       (<OR <NOT <VISIBLE? ,ROOSTER>>
		    <NOT <FSET? ,ROOSTER ,ANIMATEDBIT>>>
		<RFALSE>)
	       (<PROB ,FOX-PROB>
		<SETG FOX-PROB 0>
		<RETURN-FROM-MAP>
		<TELL
"   The fox stares at the rooster and smacks its lips." CR>)
	       (T
		<SETG FOX-PROB <+ ,FOX-PROB 10>>
		<RFALSE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LAKE>

<ROOM G-U-SAVANNAH
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Great Underground Savannah")
      (LDESC
"Dimwit's mania for including every conceivable ecosystem under his roof
continues here. This flat grassland ends at woods to the northeast, and
at a desert to the west. A herd of unicorns is grazing nearby.")
      (NE TO G-U-WOODS)
      (WEST TO EDGE-OF-DESERT)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (SYNONYM SAVANNAH)
      (ADJECTIVE GREAT UNDERGROUND)
      (RESEARCH
"\"One of the many awe-inspiring features of Dimwit's castle in Flatheadia.\"")
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-5>)
      (ICON G-U-SAVANNAH-ICON)
      (ACTION FLY-ROOM-F)>

<OBJECT UNICORNS
	(LOC G-U-SAVANNAH)
	(OWNER UNICORNS)
	(DESC "herd of unicorns")
	(SYNONYM UNICORN UNICORNS HERD)
	(ADJECTIVE GRAZING)
	(FLAGS NDESCBIT)
	(RESEARCH "\"A magical beast, sometimes used as a combat mount.\"")
	(ACTION UNICORNS-F)>

<ROUTINE UNICORNS-F ()
	 <COND (<VERB? ENTER CLIMB-ON SIT>
		<TELL
"As you approach, the unicorns move gracefully away." CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,SADDLE>>
		<PERFORM ,V?ENTER ,UNICORNS>
		<RTRUE>)>>

<ROOM STREAM
      (LOC ROOMS)
      (DESC "Stream")
      (REGION "Flatheadia")
      (EAST TO SOUTH-SHORE)
      (WEST PER BRIDGE-ENTER-F)
      (FLAGS RLANDBIT ONBIT UNDERGROUNDBIT)
      (GLOBAL LAKE-FLATHEAD)
      (RIDDLE "|
  'One night four men sat down to play;|
     They played and played till break of day.|
       They played for money; not for fun,|
         With separate scores for every one.|
           And when time came to square accounts,|
             They all had made quite nice amounts!'|
What were the men playing?\" As the jester awaits your answer, you notice
that he is holding the framed document.")
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-3>)
      (ACTION CAMEL-DRINK-ROOM-F)>

<OBJECT BRIDGE
	(LOC STREAM)
	(DESC "odd green bridge")
	(SYNONYM BRIDGE)
	(ADJECTIVE STRANGE ODD UNUSUAL GREEN)
	(FLAGS VOWELBIT NDESCBIT)
	(ACTION BRIDGE-F)>

<ROUTINE BRIDGE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The bridge looks odd, perhaps because of its unusual green color." CR>)
	       (<VERB? CROSS ENTER STAND-ON>
		<DO-WALK ,P?WEST>)>>

<ROUTINE BRIDGE-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RFALSE>)
	       (<IN? ,BRIDGE ,HERE>
		<COND (<IN? ,PROTAGONIST ,CAMEL>
		       <RETURN-FROM-MAP>
		       <TELL
"The bridge is too small for the huge, lumbering camel." CR>)
		      (T
		       <RETURN-FROM-MAP>
		       <REMOVE ,BRIDGE>
		       <DEQUEUE I-JESTER>
		       <MOVE ,JESTER ,HERE>
		       <THIS-IS-IT ,JESTER>
		       <MOVE ,DIPLOMA ,JESTER>
		       <FCLEAR ,DIPLOMA ,NDESCBIT>
		       <SETUP-ORPHAN "answer">
		       <TELL
"As you step onto the bridge, it begins transforming and withdrawing from
the opposite bank of the stream. When the transformation ends, the bridge
has become the jester, who is on all fours, and you are standing in the
center of his back! With clumsy haste and muttered apologies, you dismount.
The jester straightens up, and laughs, \"No hard feelings! I'll be fit as
a fiddle, once you answer this riddle:" <GETP ,STREAM ,P?RIDDLE> CR>)>)
	       (T
		<TELL "Without a bridge, the stream is uncrossable." CR>)>
	 <RFALSE>>

<OBJECT MUSIC
	(LOC GLOBAL-OBJECTS)
	(DESC "music")
	(SYNONYM MUSIC INSTRUMENTS)
	(ADJECTIVE MUSICAL)
	(FLAGS NARTICLEBIT)
	(ACTION MUSIC-F)>

<ROUTINE MUSIC-F ()
	 <COND (<VERB? PLAY>
		<PERFORM-PRSA ,LULLABY>)
	       (<VERB? LISTEN>
		<TELL "[You can't hear any music right here!]" CR>)>>

<OBJECT STREAM-OBJECT
	(LOC STREAM)
	(DESC "stream")
	(SYNONYM STREAM)
	(FLAGS NDESCBIT WATERBIT)
	(ACTION STREAM-OBJECT-F)>

<ROUTINE STREAM-OBJECT-F ()
	 <COND (<VERB? CROSS>
		<DO-WALK ,P?WEST>)>>

<ROUTINE CAMEL-DRINK-ROOM-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<EQUAL? ,HERE ,OASIS>
		       <TELL
"An underground spring bubbles up through the sands, forming a pool of clear,
cold water. A hot wind blows off the desert to the southwest.">)
		      (T
		       <TELL
"A wide stream gurgles out of the rocks, feeding the waters of the lake. ">
		       <COND (<FSET? ,DIPLOMA ,NDESCBIT>
			      <TELL
"A strange green bridge spans the stream to the west. At the far end of the
bridge, you can see a framed document of some sort. ">)>
		       <TELL "A path follows the shoreline to the east.">)>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <EQUAL? ,HERE ,STREAM>
		     <FSET? ,DIPLOMA ,TRYTAKEBIT>>
		<MOVE ,BRIDGE ,HERE>
		<FSET ,DIPLOMA ,NDESCBIT>
		<MOVE ,DIPLOMA ,HERE>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <EQUAL? ,HERE ,STREAM>
			    <IN? ,JESTER ,HERE>
			    <FSET? ,DIPLOMA ,TRYTAKEBIT>> 
		       <SETUP-ORPHAN "answer">)>
		<COND (<AND
			<IN? ,CAMEL ,HERE>
			<FSET? ,CAMEL ,ANIMATEDBIT>
			,CAMEL-THIRSTY>
		       <SETG CAMEL-THIRSTY <>>
		       <RETURN-FROM-MAP>
		       <TELL "   The camel lumbers over to the ">
		       <COND (<EQUAL? ,HERE ,OASIS>
			      <TELL "oasis">)
			     (T
			      <TELL "stream">)>
		       <TELL " and takes an amazingly long sip." CR>)>)>>

<OBJECT DIPLOMA
	(LOC STREAM)
	(DESC "diploma"	)
	(SYNONYM DIPLOMA DOCUMENT)
	(ADJECTIVE FRAMED)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT NDESCBIT MAGICBIT)
	(VALUE 0) ;"12 points given elsewhere"
	(TEXT
"The diploma is from the Borphee Business School, but the name of the
recipient is too faded to read.")
	(SIZE 2)
	(ACTION DIPLOMA-F)>

<BEGIN-SEGMENT 0>

<ROUTINE DIPLOMA-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,DIPLOMA ,TRYTAKEBIT>>
		<COND (<IN? ,DIPLOMA ,JESTER>
		       <TELL ,ANSWER-MY-RIDDLE>)
		      (T
		       <DO-FIRST "cross the bridge">)>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LAKE>

<ROOM EDGE-OF-DESERT
      (LOC ROOMS)
      (DESC "Edge of Desert")
      (REGION "Flatheadia")
      (LDESC
"Dimwit wanted a sandbox, but thanks to his lack of perspective he ended up
with a desert. The bulk of the desert lies to the south; paths lead in the
other cardinal directions.")
      (NORTH TO SOUTH-SHORE)
      (NE SORRY "Sand dunes block your way.")
      (EAST TO G-U-SAVANNAH)
      (SE SORRY "Sand dunes block your way.")
      (WEST TO RING-OF-DUNES)
      (SW SORRY "Sand dunes block your way.")
      (SOUTH PER DESERT-ENTER-F)
      (NW SORRY "Sand dunes block your way.")
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-4>)
      (ACTION DESERT-ROOM-F)>

<ROOM RING-OF-DUNES
      (LOC ROOMS)
      (DESC "Ring of Dunes")
      (REGION "Flatheadia")
      (LDESC "You are surrounded by sand dunes on all sides but the east.")
      (NORTH SORRY "Sand dunes block your way.")
      (NE SORRY "Sand dunes block your way.")
      (EAST TO EDGE-OF-DESERT)
      (SE SORRY "Sand dunes block your way.")
      (SOUTH SORRY "Sand dunes block your way.")
      (SW SORRY "Sand dunes block your way.")
      (WEST SORRY "Sand dunes block your way.")
      (NW SORRY "Sand dunes block your way.")
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-3>)
      (ICON RING-OF-DUNES-ICON)
      (ACTION DESERT-ROOM-F)>

<OBJECT CAMEL
	(LOC RING-OF-DUNES)
	(DESC "camel")
	(SYNONYM CAMEL FIXTURE)
	(ADJECTIVE MERRY-GO-ROUND)
	(FLAGS ACTORBIT VEHBIT SEARCHBIT OPENBIT ANIMATEDBIT)
	(RESEARCH "\"A desert animal.\"")
	(GENERIC G-CAMEL-F)
	(INANIMATE-DESC "merry-go-round fixture")
	(WAND-TEXT
"The camel, never a speed demon to begin with, becomes still. His coloring
grows gaudier, and a few bars of honky-tonk music drift through the air.")
	(ANIMATE-ROUTINE I-W-CAMEL)
	(ACTION CAMEL-F)>

<ROUTINE G-CAMEL-F (X Y) ;"other camel is the flattened rebus camel"
	 ,CAMEL>

<GLOBAL CAMEL-THIRSTY T>

<ROUTINE CAMEL-F ("OPTIONAL" (VARG <>))
	 <COND (<NOT <FSET? ,CAMEL ,ANIMATEDBIT>>
	        <RFALSE>)
	       (<EQUAL? .VARG ,M-WINNER>
		<COND (<VERB? WALK>
		       <COND (<IN? ,PROTAGONIST ,CAMEL>
			      <SETG WINNER ,PROTAGONIST>
			      <DO-WALK ,PRSO>
			      <SETG WINNER ,CAMEL>
			      <RTRUE>)
			     (T
			      <TELL
"Perhaps if you were ON the camel..." CR>)>)
		      (<AND <VERB? DRINK>
			    <PRSO? ,WATER ,LAKE-FLATHEAD>
			    <EQUAL? ,HERE ,SOUTH-SHORE ,EAST-SHORE>>
		       <TELL
"You can lead a camel to water, but you can't make him drink." CR>)
		      (<PROB 33>
		       <TELL"\"Snort.\"" CR>)
		      (<PROB 50>
		       <TELL "\"Grunt.\"" CR>)
		      (T
		       <TELL "\"Groan.\"" CR>)>
		<STOP>)
	       (.VARG
		<RFALSE>)
	       (<AND <VERB? TOUCH>
		     <EQUAL? ,P-PRSA-WORD ,W?PAT ,W?PET>>
		<TELL "The camel emits an (almost) endearing bray." CR>)
	       (<VERB? EXAMINE>
		<TELL "The camel looks ">
		<COND (,CAMEL-THIRSTY
		       <TELL "thirsty">)
		      (T
		       <TELL "sated">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Never look a gift camel in the mouth." CR>)>>

<ROUTINE I-W-CAMEL ()
	 <COND (,TIME-STOPPED
		<QUEUE I-W-CAMEL 3>
		<RFALSE>)>
	 <FSET ,CAMEL ,ANIMATEDBIT>
	 <FSET ,CAMEL ,ACTORBIT>
	 <COND (<VISIBLE? ,CAMEL>
		<RETURN-FROM-MAP>
		<TELL
"   The camel's garish colors fade once again to the color of sand. His tail
begins swishing around, and he emits a forlorn bray." CR>)
	       (T
		<RFALSE>)>>

<ROUTINE DESERT-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RETURN ,G-U-DESERT>)
	       (<AND <IN? ,PROTAGONIST ,CAMEL>
		     ,CAMEL-THIRSTY>
		<RETURN-FROM-MAP>
		<TELL
"The camel takes one look at the vast desert, gives a dry croak,
and refuses to budge." CR>
		<RFALSE>)
	       (T
		<COND (<IN? ,PROTAGONIST ,CAMEL>
		       <SETG CAMEL-THIRSTY T>)>
		,G-U-DESERT)>>

<ROOM G-U-DESERT
      (LOC ROOMS)
      (DESC "Great Underground Desert")
      (REGION "Flatheadia")
      (LDESC
"You are in the midst of a searingly hot desert. Trails snake amongst
the dunes in many directions.")
      (NORTH TO EDGE-OF-DESERT)
      (NE SORRY "Sand dunes block your way.")
      (EAST SORRY "Sand dunes block your way.")
      (SE SORRY "Sand dunes block your way.")
      (SOUTH TO CACTUS-PATCH)
      (SW TO WINDBLOWN-SANDS)
      (WEST SORRY "Sand dunes block your way.")
      (NW SORRY "Sand dunes block your way.")
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (SYNONYM DESERT)
      (ADJECTIVE GREAT UNDERGROUND)
      (RESEARCH
"\"One of the many awe-inspiring features of Dimwit's castle in Flatheadia.\"")
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-6>)
      (ACTION DESERT-ROOM-F)>

<ROOM WINDBLOWN-SANDS
      (LOC ROOMS)
      (DESC "Windblown Sands")
      (REGION "Flatheadia")
      (LDESC
"You are in the midst of a searingly hot desert. Trails snake amongst
the dunes in many directions.")
      (NORTH SORRY "Sand dunes block your way.")
      (NE TO G-U-DESERT)
      (EAST TO CACTUS-PATCH)
      (SE TO DESERT-PLAIN)
      (SOUTH SORRY "Sand dunes block your way.")
      (SW SORRY "Sand dunes block your way.")
      (WEST SORRY "Sand dunes block your way.")
      (NW SORRY "Sand dunes block your way.")
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-5>)
      (ACTION DESERT-ROOM-F)>

<ROOM CACTUS-PATCH
      (LOC ROOMS)
      (DESC "Cactus Patch")
      (REGION "Flatheadia")
      (LDESC
"You are in the midst of a searingly hot desert. Trails snake amongst
the dunes in many directions.")
      (NORTH TO G-U-DESERT)
      (NE SORRY "Sand dunes block your way.")
      (EAST SORRY "Sand dunes block your way.")
      (SE SORRY "Sand dunes block your way.")
      (SOUTH SORRY "Sand dunes block your way.")
      (SW SORRY "Sand dunes block your way.")
      (WEST TO WINDBLOWN-SANDS)
      (NW SORRY "Sand dunes block your way.")
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-6>)
      (ICON CACTUS-PATCH-ICON)
      (ACTION DESERT-ROOM-F)>

<OBJECT CACTI
	(LOC CACTUS-PATCH)
	(DESC "cactus")
	(SYNONYM CACTUS CACTI)
	(FLAGS NDESCBIT PLANTBIT)
	(ACTION CACTI-F)>

<ROUTINE CACTI-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "All the cacti look particularly prickly." CR>)
	       (<AND <VERB? LISTEN>
		     ,PLANT-TALKER>
		<TELL
"The cacti, in parched voices, are exchanging wry witticisms. It seems
that all cacti have a very dry sense of humor." CR>)
	       (<TOUCHING? ,CACTI>
		<TELL "Youch! Nasty cactus pricks!" CR>)>>

<ROOM DESERT-PLAIN
      (LOC ROOMS)
      (DESC "Desert Plain")
      (REGION "Flatheadia")
      (LDESC
"You are in the midst of a searingly hot desert. Trails snake amongst
the dunes in many directions.")
      (NORTH SORRY "Sand dunes block your way.")
      (NE SORRY "Sand dunes block your way.")
      (EAST TO TALL-DUNES)
      (SE TO RIPPLED-SANDS)
      (SOUTH SORRY "Sand dunes block your way.")
      (SW SORRY "Sand dunes block your way.")
      (WEST SORRY "Sand dunes block your way.")
      (NW TO WINDBLOWN-SANDS)
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-6>)
      (ACTION DESERT-ROOM-F)>

<ROOM TALL-DUNES
      (LOC ROOMS)
      (DESC "Tall Dunes")
      (REGION "Flatheadia")
      (LDESC
"You are in the midst of a searingly hot desert. Trails snake amongst
the dunes in many directions.")
      (NORTH SORRY "Sand dunes block your way.")
      (NE SORRY "Sand dunes block your way.")
      (EAST SORRY "Sand dunes block your way.")
      (SE SORRY "Sand dunes block your way.")
      (SOUTH TO RIPPLED-SANDS)
      (SW SORRY "Sand dunes block your way.")
      (WEST TO DESERT-PLAIN)
      (NW SORRY "Sand dunes block your way.")
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-7>)
      (ICON TALL-DUNES-ICON)
      (ACTION DESERT-ROOM-F)>

<ROOM RIPPLED-SANDS
      (LOC ROOMS)
      (DESC "Rippled Sands")
      (REGION "Flatheadia")
      (LDESC
"You are in the midst of a searingly hot desert. Trails snake amongst
the dunes in many directions.")
      (NORTH TO TALL-DUNES)
      (NE TO OASIS)
      (EAST SORRY "Sand dunes block your way.")
      (SE SORRY "Sand dunes block your way.")
      (SOUTH SORRY "Sand dunes block your way.")
      (SW SORRY "Sand dunes block your way.")
      (WEST SORRY "Sand dunes block your way.")
      (NW TO DESERT-PLAIN)
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-7>)
      (ACTION DESERT-ROOM-F)>

<GLOBAL DESERT-DEATH 0>

<ROUTINE DESERT-ROOM-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <IN? ,PROTAGONIST ,CAMEL>>>
		<SETG DESERT-DEATH <+ ,DESERT-DEATH 1>>
		<QUEUE I-DESERT-RESET -1>
		<RETURN-FROM-MAP>
		<TELL
"You trudge along beneath the searing gaze of an artificial desert sun">
		<COND (<EQUAL? ,DESERT-DEATH 4>
		       <TELL ". Wavering dizziness threatens your every step">)
		      (<EQUAL? ,DESERT-DEATH 3>
		       <TELL ". You won't last much longer in this dry heat">)>
		<TELL ,ELLIPSIS>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <EQUAL? ,DESERT-DEATH 5>>
		<RETURN-FROM-MAP>
		<JIGS-UP
"   As with so many unprepared travellers before you, you succumb to the
merciless justice of the desert.">)>>

<ROUTINE I-DESERT-RESET ()
	 <COND (<NOT <FSET? ,HERE ,DESERTBIT>>
		<SETG DESERT-DEATH 0>
		<DEQUEUE I-DESERT-RESET>)>
	 <RFALSE>>

<ROOM OASIS
      (LOC ROOMS)
      (DESC "Great Underground Oasis")
      (REGION "Flatheadia")
      (SW TO RIPPLED-SANDS)
      (FLAGS RLANDBIT ONBIT DESERTBIT UNDERGROUNDBIT)
      (GLOBAL G-U-DESERT)
      (VALUE 8)
      (MAP-LOC <PTABLE DESERT-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-8>)
      (ICON G-U-OASIS-ICON)
      (ACTION CAMEL-DRINK-ROOM-F)>

<OBJECT OASIS-OBJECT
	(LOC OASIS)
	(DESC "oasis")
	(SYNONYM OASIS POOL SPRING)
	(ADJECTIVE GREAT UNDERGROUND INCREDIBLY CLEAR COLD)
	(FLAGS VOWELBIT NDESCBIT WATERBIT)>

<ROOM PHIL-HALL
      (LOC ROOMS)
      (DESC "Frobozz Philharmonic Hall")
      (REGION "Flatheadia")
      (NORTH PER FR-BASEMENT-ENTER-F)
      (SOUTH TO NORTH-SHORE)
      (EAST TO THEATRE)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM HALL ORCHESTRA)
      (ADJECTIVE FROBOZZ PHILHARMONIC)
      (RESEARCH
"\"Frobozz Philharmonic Hall is the home of the renowned Frobozz Philharmonic
Orchestra.\"")
      (GLOBAL FR-BLDG)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-4>)
      (ACTION PHIL-HALL-F)
      (THINGS LONE SPOTLIGHT SPOTLIGHT-PS
       	      <> SHADOW PHIL-SHADOW-PS)>

<ROUTINE PHIL-HALL-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This was the visually impressive but acoustically abysmal home of the royal
orchestra, but the musicians (like everyone else) have fled the eastlands.
Uncountable rows of velvet-covered seats extend into the shadows beyond your
light. Gilt-trimmed balconies hang above the huge wooden stage. ">
		<COND (<IN? ,CONDUCTOR-STAND ,HERE> ;"thanks to pigeon/perch"
		       <TELL
"A lone spotlight illuminates the conductor's stand. ">)>
		<TELL "Passages lead east, north and south.">)>>

<ROUTINE PHIL-SHADOW-PS ()
	 <COND (<VERB? EXAMINE>
		<TELL "Like most shadows, a little creepy." CR>)>>

<ROUTINE SPOTLIGHT-PS ()
	 <COND (<AND <VERB? EXAMINE>
		     <IN? ,CONDUCTOR-STAND ,HERE> ;"thanks to pigeon/perch">
		<TELL
"The spotlight bathes the conductor's stand in a circle of light." CR>)
	       (<VERB? ENTER>
		<COND (<IN? ,PROTAGONIST ,CONDUCTOR-STAND>
		       <TELL ,LOOK-AROUND>)
		      (<IN? ,CONDUCTOR-STAND ,HERE>
		       <PERFORM ,V?ENTER ,CONDUCTOR-STAND>
		       <RTRUE>)
		      (T
		       <TELL
"You stand in the center of the circle of light, to little effect." CR>)>)>>

<OBJECT CONDUCTOR-STAND
	(LOC PHIL-HALL)
	(DESC "conductor's stand")
	(SYNONYM STAND PLATFORM)
	(ADJECTIVE CONDUCTOR RECTANGULAR)
	(CAPACITY 50)
	(FLAGS NDESCBIT VEHBIT CONTBIT OPENBIT SURFACEBIT SEARCHBIT)
	(ACTION CONDUCTOR-STAND-F)>

<ROUTINE CONDUCTOR-STAND-F ("OPTIONAL" (OARG <>))
	<COND (.OARG
	       <RFALSE>)
	      (<AND <VERB? ENTER STAND-ON>
		    <NOT ,TIME-STOPPED>>
	       <TELL "The " D ,CONDUCTOR-STAND " plunges ">
	       <COND (<EQUAL? ,HERE ,CONDUCTOR-PIT>
		      <TELL "up">)
		     (T
		      <TELL "down">)>
	       <TELL "ward, and you along with it" ,ELLIPSIS>
	       <MOVE ,CONDUCTOR-STAND
		     <COND (<EQUAL? ,HERE ,CONDUCTOR-PIT>
			    <FSET ,CONDUCTOR-STAND ,NDESCBIT>
			    ,PHIL-HALL)
			   (T
			    <FCLEAR ,CONDUCTOR-STAND ,NDESCBIT>
			    ,CONDUCTOR-PIT)>>
	       <GOTO ,CONDUCTOR-STAND>)
	      (<VERB? EXAMINE>
	       <TELL "The stand is a rectangular platform about a foot high.">
	       <COND (<FIRST? ,CONDUCTOR-STAND>
		      <TELL " ">
		      <RFALSE>)
		     (T
		      <CRLF>)>)>>

<ROOM CONDUCTOR-PIT
      (LOC ROOMS)
      (DESC "Conductor's Pit")
      (REGION "Flatheadia")
      (LDESC
"You are in a tiny space beneath the stage. There are no visible exits.")
      (OUT SORRY "There are no visible exits.")
      (UP SORRY "There are no visible exits.")
      (FLAGS RLANDBIT)
      (SYNONYM PIT)
      (ADJECTIVE CONDUCTOR)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-3>)
      (ACTION CONDUCTOR-PIT-F)>

<ROUTINE CONDUCTOR-PIT-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <IN? ,CONDUCTOR-STAND ,CONDUCTOR-PIT>>>
		;"if you pigeon your way into the pit"
		<FSET ,VIOLIN ,TOUCHBIT>)>>

<OBJECT VIOLIN
	(LOC CONDUCTOR-PIT)
	(DESC "fancy violin")
	(FDESC
"Sitting by the edge of the stand is a beautiful, handmade violin; possibly
a Stradivarius.")
	(SYNONYM STRADIVARIUS VIOLIN)
	(ADJECTIVE FANCY BEAUTIFUL HANDMADE STRADIVARIUS)
	(FLAGS TAKEBIT BURNBIT MAGICBIT)
	(SIZE 10)
	(VALUE 12)
	(ACTION VIOLIN-F)>

<BEGIN-SEGMENT 0>

<ROUTINE VIOLIN-F ()
	 <COND (<VERB? PLAY>
	        <TELL
"An amazingly offensive noise issues from the violin." CR>)
	       (<VERB? EXAMINE>
		<TELL
"This is a beautiful instrument which, in the right hands, would
certainly produce magnificent music." CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LAKE>

<ROOM THEATRE
      (LOC ROOMS)
      (DESC "Theatre")
      (REGION "Flatheadia")
      (LDESC
"This twenty-thousand-seat theatre was renowned for its terrible acoustics,
although Dimwit always claimed he could \"hear things great\" from his box
in the front of the theatre. Exits lead west and southwest.")
      (WEST TO PHIL-HALL)
      (SW TO NORTH-SHORE)
      (FLAGS RLANDBIT ONBIT)
      (SYNONYM THEATRE THEATER)
      (MAP-LOC <PTABLE LAKE-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-5>)
      (THINGS DIMWIT\'S BOX DIMWIT-BOX-PS)>

<ROUTINE DIMWIT-BOX-PS ()
	 <COND (<VERB? EXAMINE>
		<TELL "Plush. Very plush." CR>)
	       (<VERB? SEARCH LOOK-INSIDE>
		<PERFORM ,V?SEARCH ,GLOBAL-HERE>
		<RTRUE>)
	       (<VERB? PUT>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? ENTER CLIMB-ON>
		<TELL "Why bother? No show tonight." CR>)>>

<END-SEGMENT>