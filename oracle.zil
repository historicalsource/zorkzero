"ORACLE for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT SECRET>

<INCLUDE "BASEDEFS" "PDEFS"> ;"needed for G-VIAL-F, for some reason"

<ROOM ORACLE
      (LOC ROOMS)
      (DESC "Oracle")
      (REGION "Region:  Unknown")
      (UP TO CRYPT)
      (OUT TO CRYPT)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (GLOBAL SLIME)
      (VALUE 10)
      (ICON ORACLE-ICON)
      (MAP-LOC <PTABLE SECRET-WING-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-10>)
      (THINGS <> SHADOW PHIL-SHADOW-PS)
      (ACTION ORACLE-F)>

<ROUTINE ORACLE-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <G? ,ORACLE-EXIT-NUMBER 4>>
		<SETG ORACLE-EXIT-NUMBER <- <RANDOM 5> 1>>
		<QUEUE I-AMULET 4>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in an irregularly shaped chamber, hewn out of bedrock by untold ages
of trickling waters. The walls are slimy, and shadows dance in the unlit
crevices. A stream of slime drips sluggishly down an uneven tunnel which heads
roughly upwards." CR "   ">
		<D-ORACLE>)>>

<END-SEGMENT>
<BEGIN-SEGMENT CASTLE>

<OBJECT ORACLE-OBJECT
	(LOC ORACLE)
	(DESC "oracle")
	(SYNONYM ORACLE BARGTH MOUTH HEAD)
	(ADJECTIVE HUGE ORACLE\'S SERPENT\'S)
	(FLAGS NDESCBIT VOWELBIT VEHBIT INBIT CONTBIT
	       OPENBIT SEARCHBIT DROPBIT)
	(CAPACITY 100)
	(OWNER ORACLE-OBJECT)
	(RESEARCH
"The encyclopedia scoffs at this silly little legend about an oracle which
offered bits of wisdom and could transport believers to distant regions.")
	(ACTION ORACLE-OBJECT-F)>

<END-SEGMENT>
<BEGIN-SEGMENT SECRET>

<ROUTINE ORACLE-OBJECT-F ("OPTIONAL" (VARG <>) "AUX" TAKER RM)
	 <COND (.VARG
		<RFALSE>)
	       (<AND <VERB? ASK-ABOUT PRAY TELL>
		     <PRSO? ,ORACLE-OBJECT>>
		<TELL
"The oracle stares at the far wall of the cave, impassive and unresponsive.">
		<COND (<NOT ,ORACLE-USED>
		       <TELL
" It appears that the ancient claims of the oracle's amazing abilities
were just wild fictions.">)>
		<CRLF>
		<STOP>)
	       (<VERB? EXAMINE>
		<D-ORACLE>
	        <COND (<FIRST? ,ORACLE-OBJECT>
		       <TELL " Sitting in the mouth of the oracle is">
		       <D-NOTHING>)
		      (T
		       <CRLF>)>)
	       (<AND <VERB? LOOK-INSIDE>
		     <NOUN-USED? ,ORACLE-OBJECT ,W?MOUTH>
		     <NOT <IN? ,PROTAGONIST ,ORACLE-OBJECT>>>
		<TELL "The wide-open mouth is larger than you!" CR>)
	       (<AND <VERB? PUT THROW>
		     <PRSI? ,ORACLE-OBJECT>>
		<TELL "You ">
		<COND (<VERB? THROW>
		       <TELL "toss">)
		      (T
		       <TELL "place">)>
		<TELL T ,PRSO " into the mouth of the oracle">
		<COND (<IN? ,RUBY ,DEPRESSION>
		       <MOVE ,PRSO
			     <SET RM <GET ,ORACLE-TABLE ,ORACLE-EXIT-NUMBER>>>
		       <TELL ", and it instantly vanishes!" CR>
		       <COND (<OR <SET TAKER <FIND-IN .RM ,WHITEBIT>>
				  <SET TAKER <FIND-IN .RM ,BLACKBIT>>>
			      <MOVE ,PRSO .TAKER>
			      <COND (<PRSO? ,PIGEON>
				     <MOVE-TO-PERCH .TAKER>)>)>
		       <NOW-DARK?>)
		      (T
		       <MOVE ,PRSO ,ORACLE-OBJECT>
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? ENTER>
		<COND (<NOT ,LIT>
		       <TELL ,TOO-DARK CR>)
		      (<AND <IN? ,BEDBUG ,HERE>
			    <NOT ,TIME-STOPPED>>
		       <DO-WALK ,P?UP>)
		      (<IN? ,RUBY ,DEPRESSION>
		       <COND (,ORACLE-USED
		       	      <TELL "D">)
		      	     (T
			      <SPLIT-BY-PICTURE ,TEXT-WINDOW-PIC-LOC T>
			      <SCREEN ,S-TEXT>
			      <CRLF>
			      <MARGINAL-PIC ,TELEPORT-LETTER>
			      <DIROUT ,D-SCREEN-OFF>
	 		      <TELL "D"> ;"so script doesn't say ARKNESS..."
	 		      <DIROUT ,D-SCREEN-ON>)>
		       <TELL "arkness envelopes you">
		       <COND (<NOT ,ORACLE-USED>
			      <TELL
" with a giant hand swathed in a glove of black velvet. You feel disembodied;
there is no up and down. You are motionless in time and space. A moment drags
out for a century -- or is it a century that has flown by in a moment? After
an immeasurable time, you notice">)
			     (T
			      <TELL ". You feel">)>
		       <TELL
" a stabbing pain... swirling lights... dizziness" ,ELLIPSIS>
		       <COND (<NOT ,BORDER-ON>
			      <INIT-STATUS-LINE T>)>
		       <GOTO <GET ,ORACLE-TABLE ,ORACLE-EXIT-NUMBER>>
		       <SETG ORACLE-USED T>)>)>>

<ROUTINE D-ORACLE ()
	 <COND (<IN? ,PROTAGONIST ,ORACLE-OBJECT>
		<TELL "Surrounding you is">)
	       (T
		<TELL "Before you sits">)>
	 <TELL
" the legendary Oracle of Bargth. Shaped like an enormous serpent's head,
its huge mouth hangs open in an expression of insatiable hunger; its four ">
	 <COND (<IN? ,RUBY ,DEPRESSION>
		<TELL "glowing">)
	       (T
		<TELL "dark">)>
	 <TELL
" eyes seem fixed upon you. In the center of the serpent's forehead is a">
	 <COND (<IN? ,RUBY ,DEPRESSION>
		<TELL "n enormous ruby.">)
	       (T
		<TELL " depression.">)>>

<OBJECT DEPRESSION
	(LOC ORACLE)
	(DESC "depression")
	(SYNONYM DEPRESSION)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION DEPRESSION-F)>

<ROUTINE DEPRESSION-F () 
	 <COND (<VERB? EXAMINE>
		<TELL "The semi-spherical depression is a few inches across.">
		<COND (<IN? ,RUBY ,DEPRESSION>
		       <TELL " A huge ruby rests in the depresssion.">)>
		<CRLF>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,RUBY>
		     <FSET? ,RUBY ,NDESCBIT>>
		<COND (<EQUAL? <ITAKE T> ,M-FATAL <>>
		       <RTRUE>)
		      (T
		       <FCLEAR ,RUBY ,NDESCBIT>
		       <FCLEAR ,RUBY ,NALLBIT>
		       <TELL "Taken." CR>)>)
	       (<VERB? PUT>
		<COND (<PRSO? ,SAPPHIRE>
		       <MOVE ,SAPPHIRE ,HERE>
		       <TELL
"The sapphire is a bit smaller than the depression; it stays for a
moment but then drops to the ground." CR>)
		      (<PRSO? ,RUBY>
		       <MOVE ,RUBY ,DEPRESSION>
		       <FSET ,RUBY ,NDESCBIT>
		       <FSET ,RUBY ,NALLBIT>
		       <TELL
"The moby ruby fits perfectly into the depression. As it sinks into place,
the eyes of the oracle begin to glow.">
		       <COND (<FIRST? ,ORACLE-OBJECT>
			      <ROB ,ORACLE-OBJECT
				   <GET ,ORACLE-TABLE ,ORACLE-EXIT-NUMBER>>
			      <TELL
" Everything in the oracle's mouth suddenly vanishes!">)>
		       <CRLF>
		       <INC-SCORE ,ORACLE-SCORE>
		       <SETG ORACLE-SCORE 0>
		       <RTRUE>)
		      (T
		       <TELL "It doesn't fit the depression." CR>)>)>>

<GLOBAL ORACLE-USED <>>

<GLOBAL ORACLE-SCORE 9>

<CONSTANT ORACLE-TABLE
	<PTABLE CRAG GLACIER DELTA-1 FOOT-OF-STATUE MINE-ENTRANCE>>

<END-SEGMENT>

<BEGIN-SEGMENT 0>

<OBJECT AMULET
	(LOC G-U-MOUNTAIN)
	(DESC "amulet")
	(SYNONYM AMULET)
	(FLAGS TAKEBIT WEARBIT VOWELBIT)
	(ACTION AMULET-F)>

<ROUTINE AMULET-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The amulet is in the shape of a serpent's head. ">
		<COND (<FSET? ,HERE ,BEYONDBIT>
		       <TELL "It seems to be glowing slightly">)
		      (T
		       <TELL
<GET ,EYE-TABLE ,ORACLE-EXIT-NUMBER> " of its four eyes ">
		       <COND (<EQUAL? ,ORACLE-EXIT-NUMBER 1>
			      <TELL "is">)
			     (T
			      <TELL "are">)>
		       <TELL " open">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? TOUCH>
		<COND (<FSET? ,HERE ,BEYONDBIT>
		       <CAST-HUNGER-SPELL>
		       <TELL
"A stream of light undulates slowly from the amulet ">
		       <COND (<FSET? ,AMULET ,WORNBIT>
			      <TELL
"and envelops you like a mist. After a moment, the mist clears" ,ELLIPSIS>
		       	      <GOTO ,G-U-MOUNTAIN>)
			     (T
			      <TELL "but then quickly fades." CR>)>)
		      (<NOT ,TIME-STOPPED>
		       <TELL
"The amulet, for one brief moment, glows from deep within." CR>)>)>>

<GLOBAL ORACLE-EXIT-NUMBER 5>

<CONSTANT EYE-TABLE
	<PTABLE "None" "One" "Two" "Three" "All">>

<ROUTINE I-AMULET ()
	 <QUEUE I-AMULET 4>
	 <SETG ORACLE-EXIT-NUMBER <+ ,ORACLE-EXIT-NUMBER 1>>
	 <COND (<G? ,ORACLE-EXIT-NUMBER 4>
		<SETG ORACLE-EXIT-NUMBER 0>)>
	 <COND (<AND <EQUAL? ,HERE ,ORACLE>
		     <IN? ,RUBY ,DEPRESSION>
		     ,LIT>
		<RETURN-FROM-MAP>
		<TELL "   The oracle seems to blink for a moment." CR>)
	       (T
		<RFALSE>)>>

<END-SEGMENT>
\
<BEGIN-SEGMENT ORACLE>

<OBJECT FLATHEAD-MOUNTAINS
	(LOC LOCAL-GLOBALS)
	(DESC "Flathead Mountains")
	(SYNONYM MOUNTAIN MOUNTAINS)
	(ADJECTIVE FLATHEAD)
	(RESEARCH
"\"This towering range runs north to south, forming the eastern border of the
Frigid River Valley. Beyond the mountains, uninhabitable swamps extend to the
edge of the world. Near the southern end of the range, the Zorbel Pass permits
passage to the Fublio Valley.\"")
	(ACTION FLATHEAD-MOUNTAINS-F)>

<ROUTINE FLATHEAD-MOUNTAINS-F ()
	 <COND (<VERB? ENTER CLIMB CLIMB-UP CLIMB-DOWN>
		<V-WALK-AROUND>)>>

<ROOM CRAG
      (LOC ROOMS)
      (DESC "Crag")
      (REGION "Flathead Mountains")
      (LDESC
"You are high in the mountains, surrounded by jagged, rocky peaks. Paths
squeeze northeast, southeast, and southwest, and it looks like you could
also climb down.")
      (SW TO HOLLOW)
      (DOWN TO UPPER-LEDGE)
      (NE TO NATURAL-ARCH)
      (SE TO NATURAL-ARCH)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (SYNONYM CRAG)
      (VALUE 10)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-4>)
      (ICON CRAG-ICON)>

<OBJECT CRAG-REBUS-BUTTON
	(LOC CRAG)
	(SDESC "blinking key-shaped button")
	(FDESC
"Imbedded in the rocky wall is a blinking button in the shape of a key.")
	(SYNONYM BUTTON)
	(ADJECTIVE KEY-SHAPED BLINKING)
	(ACTION REBUS-BUTTON-F)>

<ROOM HOLLOW
      (LOC ROOMS)
      (DESC "Hollow")
      (REGION "Flathead Mountains")
      (NE TO CRAG)
      (SOUTH TO IRON-MINE IF IRON-MINE-OPEN)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-3>)
      (THINGS IRON MINE IRON-MINE-PS)
      (ACTION HOLLOW-F)>

<ROUTINE HOLLOW-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a chamber, open to the sky, formed by cliff-like mountain walls.
Strange and frightening runes have been carved into the cliff wall to the
south, next to a ">
	        <COND (,IRON-MINE-OPEN
		       <TELL "dark cave entrance">)
		      (T
		       <TELL "six-sided hole">)>
		<TELL ". The only ">
		<COND (,IRON-MINE-OPEN
		       <TELL "other">)
		      (T
		       <TELL "apparent">)>
		<TELL " exit is northeast.">)>>

<GLOBAL IRON-MINE-OPEN <>>

<OBJECT RUNES
	(LOC HOLLOW)
	(DESC "runes")
	(SYNONYM RUNES)
	(ADJECTIVE STRANGE FRIGHTENING)
	(FLAGS READBIT NDESCBIT NARTICLEBIT)
	(TEXT
"The runes are in an ancient and unfamiliar language; you can translate only
a handful of phrases: \"accursed sapphire\" and \"sealed their tomb\" and
\"death awaits.\"")>

<OBJECT HEXAGONAL-HOLE
	(LOC HOLLOW)
	(DESC "six-sided hole")
	(SYNONYM HOLE)
	(ADJECTIVE SMALL SIX-SIDED HEXAGONAL)
	(FLAGS NDESCBIT)
	(ACTION HEXAGONAL-HOLE-F)>

<ROUTINE HEXAGONAL-HOLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The small, six-sided hole has been neatly carved into the cliff wall." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)
	       (<VERB? REACH-IN>
		<TELL
"Your hand is about the same size as the hole, and since your hand isn't
hexagonal, it doesn't fit." CR>)
	       (<VERB? PUT>
		<COND (<PRSO? ,HEXAGONAL-BLOCK>
		       <SETG IRON-MINE-OPEN T>
		       <SETG COMPASS-CHANGED T>
		       <REMOVE ,HEXAGONAL-BLOCK>
		       <REMOVE ,HEXAGONAL-HOLE>
		       <TELL
"A seam appears in the cliff wall, and a huge slab of rock slides silently
aside! A breeze of stale, dusty air caresses you as the dark opening to the
south beckons ominously." CR>
		       <INC-SCORE 14>)
		      (T
		       <TELL "It doesn't fit." CR>)>)>>

<OBJECT BIRCH
	(LOC HOLLOW)
	(DESC "birch tree")
	(FDESC
"A stubborn birch tree has been eking out an existence in this rocky hollow
for, judging by its size, fifty to a hundred years -- though, in this barren
spot, who can guess the growth rate of a tree?")
	(SYNONYM TREE BIRCH)
	(ADJECTIVE BIRCH)
	(FLAGS PLANTBIT)
	(ACTION BIRCH-F)>

<ROUTINE BIRCH-F ("OPTIONAL" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<PLANT-STUNNED>)
	       (<VERB? CLIMB CLIMB-UP>
		<TELL ,POORLY-CONFIGURED>)
	       (<VERB? GET-NEAR>
		<PERFORM-PRSA ,SMALL-ELM>)
	       (<AND <VERB? LISTEN>
		     ,PLANT-TALKER>
		<TELL
"The birch is poignantly bemoaning that none of its seedlings has
ever taken root in this barren, rocky place." CR>)>>

<ROOM IRON-MINE
      (LOC ROOMS)
      (DESC "Iron Mine")
      (REGION "Flathead Mountains")
      (LDESC
"This appears to have been a mine for the excavation of iron ore, possibly
dating to the earliest days of recorded history. There seems to have been a
struggle here, in the distant past: two decayed skeletons locked in vicious
combat. The rusty strips of metal by their side may have once been weapons.")
      (NORTH TO HOLLOW)
      (OUT TO HOLLOW)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (SYNONYM MINE)
      (ADJECTIVE IRON)
      (GLOBAL BONES BODIES FLATHEAD-MOUNTAINS)
      (THINGS IRON MINE IRON-MINE-PS
       	      <> IRON IRON-PS
	      IRON ORE IRON-PS)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-3>)
      (ICON IRON-MINE-ICON)>

<ROUTINE IRON-PS ()
	 <COND (<EQUAL? ,HERE ,IRON-MINE>
		<TELL
"There's no iron ore here. The vein is played out; the mine abandoned." CR>)>>

<ROUTINE IRON-MINE-PS ()
	 <COND (<AND <VERB? ENTER>
		     <EQUAL? ,HERE ,HOLLOW>>
		<DO-WALK ,P?IN>)
	       (T
		<PERFORM-PRSA ,GLOBAL-HERE>)>>

;<BEGIN-SEGMENT 0>
<BEGIN-SEGMENT CASTLE>
;<BEGIN-SEGMENT ORACLE>

<OBJECT SAPPHIRE
	(LOC IRON-MINE)
	(DESC "sapphire")
	(FDESC
"In the bony hand of one of the skeletons, locked in its death grip, is
a stunningly beautiful sapphire.")
	(SYNONYM SAPPHIRE JEWEL JERRIMORE)
	(ADJECTIVE STUNNING STUNNINGLY BEAUTIFUL CURSED ACCURSED)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 3)
	(OWNER SAPPHIRE)
	(RESEARCH
"\"The legend of the accursed Jewel of Jerrimore can trace its origins to
the third century B.E. in the northlands of Frobozz. This jewel, which in
most versions of the legend is a star sapphire, is said to have been cursed
by the Mage of Jerrimore as he lay upon his deathbed.|
   As he sickened, this powerful but twisted wizard became convinced that
his enemies had poisoned him to gain possession of his greatest treasure,
the Jewel of Jerrimore. With his dying breath, he loosed a great and evil
curse upon the Jewel and all who would possess it.|
   After the Mage's death, each of his heirs took possession of the jewel;
each held it jealously, mistrusting any who might look upon it; each became
obsessed with the greed and treachery they perceived around them; and each
came to early and horrible deaths. Thus grew the legend of the cursed Jewel.|
   Although the legends vary, all versions say that the Jewel travelled
through many lands, always leaving a wake of misery and death, and finally
became lost in a forgotten iron mine.\"")
	(ACTION SAPPHIRE-F)>

<ROUTINE SAPPHIRE-F ()
	 <COND (<AND <VERB? TAKE>
		     <PRSO? ,SAPPHIRE>
		     <FSET? ,SAPPHIRE ,TRYTAKEBIT>>
		<FCLEAR ,SAPPHIRE ,TRYTAKEBIT>
		<PUTP ,SAPPHIRE ,P?ACTION <>>
		<FSET ,SAPPHIRE ,TOUCHBIT>
		<MOVE ,SAPPHIRE ,PROTAGONIST>
		<TELL
"As you pry loose the sapphire, the skeleton's fingers crumble to dust, and
the jewel glows briefly from deep within." CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM NATURAL-ARCH
      (LOC ROOMS)
      (DESC "Natural Arch")
      (REGION "Flathead Mountains")
      (LDESC
"You are on a windswept rock mesa. Paths lead northwest and southwest around
an outcropping. A slender bridge of sandstone arcs gracefully above you.
Beneath the center of the arch, timeworn stairs lead down into a dark cave.")
      (NW TO CRAG)
      (SW TO CRAG)
      (DOWN TO ENCHANTED-CAVE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-6>)
      (ICON NATURAL-ARCH-ICON)>

<OBJECT NATURAL-ARCH-OBJECT
	(LOC NATURAL-ARCH)
	(DESC "sandstone arch")
	(SYNONYM ARCH BRIDGE)
	(ADJECTIVE SANDSTONE NATURAL SLENDER GRACEFUL)
	(FLAGS NDESCBIT)
	(ACTION NATURAL-ARCH-OBJECT-F)>

<ROUTINE NATURAL-ARCH-OBJECT-F ()
	 <COND (<VERB? EXAMINE LOOK-UNDER>
		<TELL "Under the arch, steps lead down into darkness." CR>)>>

<ROOM ENCHANTED-CAVE
      (LOC ROOMS)
      (DESC "Enchanted Cave")
      (REGION "Flathead Mountains")
      (UP TO NATURAL-ARCH)
      (OUT TO NATURAL-ARCH)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (SYNONYM CAVE)
      (ADJECTIVE ENCHANTED)
      (GLOBAL BONES FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-7>)
      (ICON ENCHANTED-CAVE-ICON)
      (ACTION ENCHANTED-CAVE-F)>

<ROUTINE ENCHANTED-CAVE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Your light sparkles off reflective walls, spilling glittering droplets
of illumination across every surface, including the dull gray altar in
the very center of the room. The altar is inscribed with the single
word \"Zilbeetha.\" ">
		<COND (<IN? ,STATUE ,HERE>
		       <TELL ,STATUE-DESC " ">)>
		<TELL
"Strewn about the cave are the bones of many adventurers, amidst dust which
might be that of even older bones. An uneven stair leads up toward light.">)>>

<CONSTANT STATUE-DESC
"Behind the altar is a statue of a young man holding a frail flower. His face
shows heartbreak and despair, with a single tear just beginning to slide down
his cheek.">

<OBJECT STATUE
	(LOC ENCHANTED-CAVE)
	(DESC "statue")
	(SYNONYM STATUE MAN)
	(ADJECTIVE YOUNG)
	(FLAGS NDESCBIT)
	(GENERIC G-DIMWIT-F) ;"because of Dimwit statue"
	(ACTION STATUE-F)>

<ROUTINE STATUE-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSI? ,STATUE>
		     <FSET? ,PRSO ,WEARBIT>>
		<TELL "The statue isn't a department store mannequin!" CR>)
	       (<VERB? EXAMINE>
		<TELL ,STATUE-DESC CR>)
	       (<VERB? ALARM>
		<TELL
"Apparently, you think breaking an enchantment is as easy as breaking an
egg!" CR>)>>

<OBJECT ALTAR
	(LOC ENCHANTED-CAVE)
	(DESC "altar")
	(SYNONYM ALTAR)
	(FLAGS NDESCBIT VOWELBIT SURFACEBIT SEARCHBIT CONTBIT OPENBIT)
	(ACTION ALTAR-F)>

<ROUTINE ALTAR-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSO? ,MILKY-ORB ,SMOKY-ORB ,GLITTERY-ORB ,FIERY-ORB>>
		<COND (<OR <PRSO? ,ENCHANTED-ORB>
			   <AND <EQUAL? ,ORBS-EXAMINED 3>
				<NOT <FSET? ,PRSO ,ORBBIT>>>>
		       <REMOVE ,PRSO>
		       <REMOVE ,STATUE>
		       <MOVE ,FLOWER ,ALTAR>
		       <FCLEAR ,FLOWER ,NDESCBIT>
		       <FCLEAR ,FLOWER ,TRYTAKEBIT>
		       <TELL
"At first, nothing happens. Then the orb glows deep within, and a gentle chorus
of angels begins to swell. As the glow brightens to include the entire cave,
the statue and orb are gone, replaced by a young couple in wedding garb, in
rapturous embrace. As the singing of the angels reaches a crescendo, Zilbeetha
and her lover recede from sight toward planes unknown, leaving a flower of
incomparable fragility and beauty sitting on the altar." CR>
		       <INC-SCORE 25>) 
		      (<IN? ,STATUE ,HERE>
		       <JIGS-UP
"An explosion of vengeful magic leaps from the altar, instantly melting
your flesh away. Your bones clatter amidst the others in the cave.">)>)>>

<BEGIN-SEGMENT 0>

<OBJECT FLOWER
	(LOC ENCHANTED-CAVE)
	(DESC "flower")
	(SYNONYM FLOWER)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT PLANTBIT)
	(ACTION FLOWER-F)>

<ROUTINE FLOWER-F ("OPTIONAL" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<PLANT-STUNNED>)
	       (<AND <VERB? TAKE>
		     <FSET? ,FLOWER ,TRYTAKEBIT>
		     <PRSO? ,FLOWER>>
		<TELL "It's part of a stone statue!" CR>)
	       (<AND <VERB? LISTEN>
		     ,PLANT-TALKER>
		<TELL
"The flower is aware that, having been cut, it will shortly wilt. However, it
has philosophically decided to accept this sad fate without complaint." CR>)
	       (<VERB? EXAMINE>
		<TELL "The flower">
		<COND (<FSET? ,FLOWER ,TRYTAKEBIT>
		       <TELL ", though made of stone,">)>
		<TELL " is a thing of fragile beauty." CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM UPPER-LEDGE
      (LOC ROOMS)
      (DESC "Upper Ledge")
      (REGION "Flathead Mountains")
      (LDESC
"You are on a mountain ledge with a spectacular view of the Flathead Fjord,
which separates the Flathead Mountains (which you are at the northern tip of)
from the Gray Mountains, across the fjord to the north. The ocean, to the west,
is lost amidst the dense fog which rolls up the fjord. A rocky spire stands
like a finger at the very edge of the ledge. A steep path climbs farther up
the mountain. A short distance below is another, smaller ledge.")
      (UP TO CRAG)
      (DOWN TO LOWER-LEDGE IF ROPE-PLACED ELSE
	    "There are no handholds to climb down.")
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (SYNONYM LEDGE)
      (ADJECTIVE UPPER)
      (GLOBAL FJORD LOWER-LEDGE FLATHEAD-MOUNTAINS GRAY-MOUNTAINS)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-4>)
      (ICON UPPER-LEDGE-ICON)>

<GLOBAL ROPE-PLACED <>>

<OBJECT SPIRE
	(LOC UPPER-LEDGE)
	(DESC "rocky spire")
	(SYNONYM SPIRE ROCK)
	(ADJECTIVE ROCKY)
	(FLAGS NDESCBIT)>

<ROOM LOWER-LEDGE
      (LOC ROOMS)
      (DESC "Lower Ledge")
      (REGION "Flathead Mountains")
      (LDESC
"The view of the fjord isn't as good, as you are surrounded on three sides by
nearly vertical cliffs. There don't seem to be any exits.")
      (UP SORRY "You can't even see the rope anymore, let alone reach it.")
      (DOWN SORRY "It's still a good five hundred foot drop to the fjord!")
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (SYNONYM LEDGE)
      (ADJECTIVE LOWER)
      (GLOBAL FJORD UPPER-LEDGE FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FJORD-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-4>)
      (ICON LOWER-LEDGE-ICON)
      (ACTION LOWER-LEDGE-F)
      (THINGS NARROW CRACK NARROW-CRACK-PS)>

<ROUTINE LOWER-LEDGE-F ("OPTIONAL" (RARG <>))
	 <COND (.RARG
		<RFALSE>)
	       (<AND <VERB? THROW PUT-ON>
		     <PRSI? ,LOWER-LEDGE>>
		<REMOVE ,PRSO>
		<COND (<OR <PRSO? ,PERCH>
			   <ULTIMATELY-IN? ,PERCH ,PRSO>>
		       <SETG REMOVED-PERCH-LOC ,WATER>)>
		<TELL
"You toss" T ,PRSO " carefully, but it skitters across the lower ledge and
falls into the fjord." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,UPPER-LEDGE>
		     <NOT <FSET? ,LOWER-LEDGE ,TOUCHBIT>>>
		<TELL
"By leaning far out, you can just make out the edge of something on the ledge
below. Most of it is hidden by protrusions in the cliff wall, though, so you
can't make out what it is." CR>)
	       (<VERB? ENTER CLIMB-ON>
		<COND (<EQUAL? ,HERE ,LOWER-LEDGE>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<VERB? LEAP>
		<SETG PRSO <>> ;"JIGS-UP in V-LEAP"
		<RFALSE>)>>

<ROUTINE NARROW-CRACK-PS ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)
	       (<VERB? REACH-IN>
		<COND (<NOT ,ROPE-PLACED>
		       <JIGS-UP "Yeow! Fangs sink into your hand.">)
		      (T
		       <TELL ,NOTHING-IN-REACH>)>)>>

<OBJECT EASLE
	(LOC LOWER-LEDGE)
	(DESC "easel")
	(FDESC
"Despite the inferior view, someone has been painting here. An easel
is set up on the ledge.")
	(SYNONYM EASLE EASEL)
	(FLAGS TAKEBIT MAGICBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT VOWELBIT)
	(SIZE 10)
	(VALUE 12)>

<BEGIN-SEGMENT 0>

<OBJECT LANDSCAPE
	(LOC EASLE)
	(DESC "landscape")
	(SYNONYM LANDSCAPE PAINTING)
	(FLAGS TAKEBIT MAGICBIT)
	(VALUE 12)
	(GENERIC G-PAINTING-F)
	(ACTION LANDSCAPE-F)>

<ROUTINE LANDSCAPE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"You're not a student of art, but it sure looks like this landscape was done
more with a catapult than a brush. ">
		<COND (<EQUAL? ,HERE ,LOWER-LEDGE>
		       <TELL
"In fact, the artist seems to have gotten more paint on the cliff and ledge
than on the canvas. ">)>
		<TELL
"Despite its flaws, the landscape is obviously of the Flathead Fjord." CR>)>>

<ROUTINE G-PAINTING-F (SRES F)
	 ,LANDSCAPE>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<OBJECT FJORD
	(LOC LOCAL-GLOBALS)
	(DESC "the Flathead Fjord")
	(SYNONYM FJORD)
	(ADJECTIVE FLATHEAD)
	(FLAGS NARTICLEBIT WATERBIT)
	(RESEARCH
"\"The beautiful Flathead Fjord is an ocean inlet which divides the great
mountains of the eastlands into two ranges: the Gray Mountains, on the north
side of the fjord, and the Flathead Mountains, south of the fjord.\"")
	(ACTION FJORD-F)>

<ROUTINE FJORD-F ()
	 <COND (<TOUCHING? ,FJORD>
		<CANT-REACH ,FJORD>)>>
\
<OBJECT GRAY-MOUNTAINS
	(LOC LOCAL-GLOBALS)
	(DESC "Gray Mountains")
	(SYNONYM MOUNTAINS)
	(ADJECTIVE GRAY GREY)
	(RESEARCH
"\"The Gray Mountains refer to both a mountain range and a province. Lying
in the far northern part of the eastlands, the Gray Mountains are a harsh
environment, but a mecca for winter sport enthusiasts.\"")
	(ACTION FLATHEAD-MOUNTAINS-F)>

<ROOM GLACIER
      (LOC ROOMS)
      (DESC "Glacier")
      (REGION "Gray Mountains")
      (LDESC
"You are on a glacier high atop the Gray Mountains. Far below is a frozen
lake, brilliantly reflective in the midday sunshine. The climb down looks
extremely hazardous.")
      (DOWN PER GLACIER-DEATH)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (SYNONYM GLACIER)
      (GLOBAL GRAY-MOUNTAINS)
      (VALUE 10)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-1 MAP-GEN-X-10>)>

<ROUTINE GLACIER-DEATH ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RFALSE>)>
	 <JIGS-UP
"You knock loose a tiny pebble of ice, which starts some other pebbles going,
and pretty soon there's this whole huge incredible avalanche of dirt and snow
and ice and by the way, you're at the bottom of it.">>

<ROOM MIRROR-LAKE
      (LOC ROOMS)
      (DESC "Mirror Lake")
      (REGION "Gray Mountains")
      (LDESC
"You are in the center of a lake whose frozen surface is more reflective than
the finest mirror. It's almost impossible to tell where the sky ends and the
ice begins. Worse, the surface is so smooth it's impossible to move!|
   Looking into the mirror, everything seems somehow... different.")
      (NORTH SORRY "Slip. Slide. No Progress.")
      (NE SORRY "Slip. Slide. No Progress.")
      (EAST SORRY "Slip. Slide. No Progress.")
      (SE SORRY "Slip. Slide. No Progress.")
      (SOUTH SORRY "Slip. Slide. No Progress.")
      (SW SORRY "Slip. Slide. No Progress.")
      (WEST SORRY "Slip. Slide. No Progress.")
      (NW SORRY "Slip. Slide. No Progress.")
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL GRAY-MOUNTAINS)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-8>)
      (ICON MIRROR-LAKE-ICON)
      (ACTION MIRROR-LAKE-F)>

<ROUTINE MIRROR-LAKE-F ("OPT" (RARG <>) "AUX" TMP DIR)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <EQUAL? ,PRSO ,REFLECTION>
		     <EQUAL? <GET-OWNER ,PRSO> ,MIRROR ,REFLECTION>>
		<TELL ,HUH>) ;"for example LOOK AT REFLECTION OF MIRROR"
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? EXAMINE> ;"LOOK AT REFLECTION OF (foo)"
		     <EQUAL? ,PRSO ,REFLECTION>
		     <SET TMP <GET-OWNER ,PRSO>>>
		<PERFORM ,V?MIRROR-LOOK .TMP ,MIRROR>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <OR <VERB? THROW>
			 <AND <VERB? STHROW>
			      <PRSI? ,INTDIR>>>>
		<COND (<IDROP>
		       <RTRUE>)
		      (<VERB? THROW>
		       <COND (<PROB 25> <SET DIR ,P?EAST>)
			     (<PROB 33> <SET DIR ,P?WEST>)
			     (<PROB 50> <SET DIR ,P?NORTH>)
			     (T <SET DIR ,P?SOUTH>)>)
		      (<NOUN-USED? ,INTDIR ,W?NORTH ,W?NE ,W?NW>
		       <SET DIR ,P?NORTH>)
		      (<NOUN-USED? ,INTDIR ,W?SOUTH ,W?SE ,W?SW>
		       <SET DIR ,P?SOUTH>)
		      (<NOUN-USED? ,INTDIR ,W?EAST>
		       <SET DIR ,P?EAST>)
		      (T
		       <SET DIR ,P?WEST>)>
		<LEAVE-MIRROR "throw" .DIR>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? PUSH>
		     <OR <FSET? ,PRSO ,WHITEBIT>
			 <FSET? ,PRSO ,BLACKBIT>>>
		<COND (<PROB 25> <SET DIR ,P?EAST>)
		      (<PROB 33> <SET DIR ,P?WEST>)
		      (<PROB 50> <SET DIR ,P?NORTH>)
		      (T <SET DIR ,P?SOUTH>)>
		<LEAVE-MIRROR "push" .DIR>)>>

<ROUTINE LEAVE-MIRROR (STRING DIR "AUX" AV DESTINATION)
	 <TELL
"As you throw" T ,PRSO ", you slide across the ice in the opposite direction,
and plow into a powdery snow bank" ,ELLIPSIS>
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<EQUAL? .DIR ,P?NORTH>
		<MOVE ,PRSO ,NORTH-OF-MIRROR>
		<SET DESTINATION ,SOUTH-OF-MIRROR>)
	       (<EQUAL? .DIR ,P?SOUTH>
		<MOVE ,PRSO ,SOUTH-OF-MIRROR>
		<SET DESTINATION ,NORTH-OF-MIRROR>)
	       (<EQUAL? .DIR ,P?EAST>
		<MOVE ,PRSO ,EAST-OF-MIRROR>
		<SET DESTINATION ,WEST-OF-MIRROR>)
	       (T
		<MOVE ,PRSO ,WEST-OF-MIRROR>
		<SET DESTINATION ,EAST-OF-MIRROR>)>
	 <COND (<FSET? .AV ,VEHBIT>
		<MOVE .AV .DESTINATION>
		<GOTO .AV>)
	       (T
		<GOTO .DESTINATION>)>
	 <COND (<PRSO? ,PIT-BOMB>
		<REMOVE ,PIT-BOMB>
		<TELL
"   Some pit-filling agents drift by in a useless cloud, dispersing." CR>)>
	 <INC-SCORE ,MIRROR-SCORE>
	 <SETG MIRROR-SCORE 0>
	 <RTRUE>>

<GLOBAL MIRROR-SCORE 14>

<OBJECT MIRROR
	(LOC MIRROR-LAKE)
	(DESC "mirror")
	(SYNONYM MIRROR LAKE SURFACE ICE)
	(ADJECTIVE MIRROR FROZEN SMOOTH REFLECTIVE)
	(FLAGS NDESCBIT)
	(RESEARCH
"\"Mirror Lake, in the Gray Mountains, is believed to possess certain magical
powers. Frank Lloyd Flathead's ski chalet was located nearby.\"")
	(ACTION MIRROR-F)>

<ROUTINE MIRROR-F ("AUX" TMP)
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"As you stare at your reflection in the mirrored surface, you look as you
always have; and yet, you see things you've never seen before: youthful
exuberance and courage, yet tempered by the wisdom and experience of untold
generations of forebears, whose spirits seem to hover over you protectively.|
   Who knows what secrets might be revealed by looking at the reflection
of other things in this magical mirror!?!" CR>)
	       (<AND <VERB? MIRROR-LOOK>
		     <PRSI? ,MIRROR>>
		<COND (<PRSO? ,ME ,PROTAGONIST> ;"latter due to L AT MY REFL."
		       <PERFORM ,V?EXAMINE ,MIRROR>
		       <RTRUE>)
		      (<PRSO? ,ENCHANTED-ORB>
		       <SETG ORB-FOUND T>
		       <TELL
"As you gaze at the reflection of" T ,PRSO ", a different vision takes shape:
a beautiful young maiden, in peaceful sleep. Then, the vision fades." CR>)
		      (<PRSO? ,WAND>
		       <TELL
"The reflection of the wand is unnaturally still; more frozen than even
the arctic landscape that surrounds you." CR>)
		      (<PRSO? ,FLASK>
		       <TELL
"You see the shadow of death hanging over the flask." CR>)
		      (<PRSO? ,CLOAK>
		       <TELL
"The reflection reveals a checkered pattern in the cloth, not visible when
you look at the garment itself." CR>)
		      (<PRSO? ,GLOVE>
		       <TELL
"The glove's reflection conveys a feeling of fingers more sensitive
and dexterous than the world's greatest surgeon." CR>)
		      (<PRSO? ,GOGGLES>
		       <TELL
"The image of the goggles appears surrounded by a brick wall which slowly
transforms to glass!" CR>)
		      (<PRSO? ,RING>
		       <TELL
"Odd. Although the ring has no face of any kind, as you gaze at its reflection
you get the distinct impression that the ring is laughing at you!" CR>
		       <COND (<ULTIMATELY-IN? ,RING>
			      <MOVE ,RING ,HERE>
			      <TELL
"   Perhaps in reaction to this impression, it seems that you
have dropped the ring." CR>)>
		       <RTRUE>)
		      (<PRSO? ,N-S-PASSAGE ,NW-SE-PASSAGE>
		       <TELL
"The reflection of the passage reveals a feature which is invisible when
you look at the passage itself: the edges dripping with unset glue." CR>)
		      (<PRSO? ,PARCHMENT>
		       <TELL
"The paper of the parchment, as seen in the mirror, is suffused with
an other-wordly glow." CR>)
		      (<PRSO? ,PIGEON>
		       <TELL
"The reflection of the inert pigeon is most startling: it appears
soaring majestically through space on widespread wings, bearing a
rider regally upon its back!" CR>)
		      (<PRSO? ,PERCH>
		       <TELL
"You see not an image of a ceramic perch, but of a proud mountain aerie! A
powerful bird is flying toward the nest from a great distance." CR>)
		      (<PRSO? ,AMULET>
		       <TELL
"The reflection of the amulet is suffused in a glow of amazing energies! A
vague ghost of a serpent's head floats over it. A hand reaches to touch the
amulet -- and the mirror goes blank!" CR>)
		      (<PRSO? ,CANDLE>
		       <TELL
"A flurry of images surrounds the candle's reflection: an aged wizard weaving
spells above a vat of bubbling tallow; the same mage handing a taper to a
royal handmaiden; a chambermaid lighting the candle for a young prince; the
same candle, never growing shorter, casting shadows on the faces of a
succession of kings. The last image is of a servant placing the candle in a
dark passageway and closing a concealed doorway behind him." CR>)
		      (<PRSO? ,JESTER>
		       <REMOVE-J>
		       <TELL
"The jester's reflection is that of a much older man! And there's
something else...but the jester notices you studying his reflection,
and vanishes hastily!" CR>) 
		      (<PRSO? ,POTION>
		       <TELL
"The image shows a flowering plant growing from the potion. It seems
to be calling to you." CR>)
		      (<PRSO? ,SAPPHIRE>
		       <TELL
"As you look at the jewel's reflection, the skeleton's bony hand still seems
clamped around it. Then the reflection enlarges, and a chill spreads from your
heart as you see that the hand belongs to Death himself! He silently laughs at
you from within his dark cowl before vanishing!" CR>) 
		      (<OR <FSET? ,PRSO ,WHITEBIT>
			   <FSET? ,PRSO ,BLACKBIT>>
		       <TELL
"Behind the image of" T ,PRSO " you see endless generations of masters,
hunched over a small checkered board." CR>)
		      (<AND <GETP ,PRSO ,P?INANIMATE-DESC>
			    <NOT <FSET? ,PRSO ,ANIMATEDBIT>>>
		       <TELL "You see the image of a " 'PRSO "!" CR>)
		      (T
		       <COND (<AND <EQUAL? ,PRSO ,REFLECTION>
				   <SET TMP <GET-OWNER ,PRSO>>>
			      <SETG PRSO .TMP>)>
		       <COND (<AND <PRSO? ,MILKY-ORB ,SMOKY-ORB
				          ,GLITTERY-ORB ,FIERY-ORB>
			      	   <NOT <FSET? ,PRSO ,ORBBIT>>>
			      <FSET ,PRSO ,ORBBIT>
			      <SETG ORBS-EXAMINED <+ ,ORBS-EXAMINED 1>>)>
		       <TELL "The reflection of ">
		       <COND (<NOT <FSET? ,PRSO ,NARTICLEBIT>>
			      ;"can't use TPRINT because of GET-OWNER, above"
			      <TELL "the ">)>
		       <TELL D ,PRSO " looks just like ">
		       <COND (<NOT <FSET? ,PRSO ,NARTICLEBIT>>
			      ;"can't use TPRINT because of GET-OWNER, above"
			      <TELL "the ">)>
		       <TELL D ,PRSO " itself." CR>)>)
	       (<VERB? MUNG>
		<JIGS-UP
"Lines radiate outward to the edge of the lake. The ice under you opens,
spilling you into frigid water. Instantly, the surfaces refreezes, trapping
you below.">)>>

<OBJECT REFLECTION
	(LOC MIRROR-LAKE)
	(OWNER ROOMS ;"any")
	(DESC "reflection")
	(SYNONYM REFLECTION)
	(FLAGS NDESCBIT)
	(ACTION REFLECTION-F)>

<ROUTINE REFLECTION-F ()
	 <COND (<VERB? EXAMINE>
		<PERFORM ,V?EXAMINE ,MIRROR>
		<RTRUE>)>>

<GLOBAL ORB-FOUND <>>

<GLOBAL ENCHANTED-ORB <>>

<GLOBAL ORBS-EXAMINED 0>

<ROOM EAST-OF-MIRROR
      (LOC ROOMS)
      (DESC "East of Mirror")
      (REGION "Gray Mountains")
      (WEST SORRY "The surface of the lake is too slippery.")
      (NW TO NORTH-OF-MIRROR)
      (SW TO SOUTH-OF-MIRROR)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT BEYONDBIT)
      (GLOBAL GRAY-MOUNTAINS)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-9>)
      (ACTION EAST-OF-MIRROR-F)>

<ROUTINE EAST-OF-MIRROR-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<MIRRORS-EDGE-DESC "west" "northwest" "southwest">)>>

<ROUTINE MIRRORS-EDGE-DESC (STR1 STR2 STR3)
	 <TELL
"You are in a snow drift. To the " .STR1 " is a lake with a mirrored surface.
You could probably plow around the mirror to the " .STR2 " and " .STR3 ".">>

<ROOM WEST-OF-MIRROR
      (LOC ROOMS)
      (DESC "West of Mirror")
      (REGION "Gray Mountains")
      (EAST SORRY "The surface of the lake is too slippery.")
      (WEST TO CHALET)
      (NE TO NORTH-OF-MIRROR)
      (SE TO SOUTH-OF-MIRROR)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT BEYONDBIT)
      (GLOBAL CHALET GRAY-MOUNTAINS)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-7>)
      (ACTION WEST-OF-MIRROR-F)>

<ROUTINE WEST-OF-MIRROR-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<MIRRORS-EDGE-DESC "east" "northeast" "southeast">
		<TELL
" A ski chalet, half-buried in the snow, lies to the west.">)>>

<ROOM NORTH-OF-MIRROR
      (LOC ROOMS)
      (DESC "North of Mirror")
      (REGION "Gray Mountains")
      (SOUTH SORRY "The surface of the lake is too slippery.")
      (SE TO EAST-OF-MIRROR)
      (SW TO WEST-OF-MIRROR)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT BEYONDBIT)
      (GLOBAL GRAY-MOUNTAINS)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-8>)
      (ACTION NORTH-OF-MIRROR-F)>

<ROUTINE NORTH-OF-MIRROR-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<MIRRORS-EDGE-DESC "south" "southeast" "southwest">)>>

<ROOM SOUTH-OF-MIRROR
      (LOC ROOMS)
      (DESC "South of Mirror")
      (REGION "Gray Mountains")
      (NORTH SORRY "The surface of the lake is too slippery.")
      (NE TO EAST-OF-MIRROR)
      (NW TO WEST-OF-MIRROR)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT BEYONDBIT)
      (GLOBAL GRAY-MOUNTAINS)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-8>)
      (ACTION SOUTH-OF-MIRROR-F)>

<ROUTINE SOUTH-OF-MIRROR-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<MIRRORS-EDGE-DESC "north" "northeast" "northwest">)>>

<ROOM CHALET
      (LOC ROOMS)
      (DESC "Chalet")
      (REGION "Gray Mountains")
      (LDESC
"You are in a handsomely designed vacation chalet, with an exit to the east.")
      (EAST TO WEST-OF-MIRROR)
      (OUT TO WEST-OF-MIRROR)
      (FLAGS RLANDBIT ONBIT BEYONDBIT)
      (GLOBAL GRAY-MOUNTAINS)
      (SYNONYM CHALET)
      (ADJECTIVE SKI)
      (MAP-LOC <PTABLE GRAY-MOUNTAINS-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-6>)
      (ICON CHALET-ICON)>

<OBJECT SCALE-MODEL
	(LOC CHALET)
	(DESC "scale model")
	(FDESC
"Leaning unobtrusively in one corner is a scale model of the FrobozzCo World
Headquarters Building. The scale appears to be around 1:1000.")
	(SYNONYM MODEL)
	(ADJECTIVE SCALE)
	(FLAGS TAKEBIT MAGICBIT)
	(SIZE 20)
	(VALUE 12)>
\
<OBJECT SWAMP
	(LOC LOCAL-GLOBALS)
	(DESC "swamp")
	(SYNONYM SWAMP BAYOU DELTA MARSH MUCK BOG)
	(ADJECTIVE SWAMPY MAZE-LIKE FOGGY MIST-COVERED)
	(FLAGS WATERBIT)>

;<BEGIN-SEGMENT 0>

;<ROUTINE DELTA? (RM)
	 <COND (<EQUAL? .RM ,DELTA-1 ,DELTA-2 ,DELTA-3>
		<RTRUE>)
	       (<EQUAL? .RM ,DELTA-4 ,DELTA-5 ,DELTA-6>
		<RTRUE>)
	       (<EQUAL? .RM ,DELTA-7>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<END-SEGMENT>

;<BEGIN-SEGMENT ORACLE>

<ROOM DELTA-1
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH TO DELTA-3)
      (NE TO DELTA-4)
      (EAST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SE SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SOUTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SW TO DELTA-2)
      (WEST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NW TO DELTA-2)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (VALUE 10)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-10>)
      (ICON DELTA-ICON)>

<ROOM DELTA-2
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NE TO DELTA-1)
      (EAST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SE TO DELTA-1)
      (SOUTH TO DELTA-7)
      (SW TO DELTA-7)
      (WEST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NW TO DELTA-3)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-8>)
      (ICON DELTA-ICON)>

<ROOM DELTA-3
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH TO DELTA-4)
      (NE TO DELTA-4)
      (EAST TO DELTA-1)
      (SE SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SOUTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SW TO DELTA-2)
      (WEST TO DELTA-5)
      (NW TO DELTA-5)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-8>)
      (ICON DELTA-ICON)>

<ROOM DELTA-4
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NE TO RIVERS-END)
      (EAST TO DELTA-1)
      (SE SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SOUTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SW TO DELTA-3)
      (WEST TO DELTA-3)
      (NW TO DELTA-5)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-9>)
      (ICON DELTA-ICON)>

<ROOM DELTA-5
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NE TO DELTA-4)
      (EAST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SE TO DELTA-3)
      (SOUTH TO DELTA-3)
      (SW TO DELTA-6)
      (WEST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NW SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-7>)
      (ICON DELTA-ICON)>

<ROOM DELTA-6
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH TO DELTA-5)
      (NE SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (EAST SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SE TO DELTA-7)
      (SOUTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SW SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (WEST TO DELTA-7)
      (NW SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-6>)
      (ICON DELTA-ICON)>

<OBJECT LARGE-LILY-PAD
	(LOC DELTA-6)
	(DESC "huge lily pad")
	(SYNONYM PAD)
	(ADJECTIVE LARGE LILY)
	(FLAGS PLANTBIT SURFACEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 100)
	(ACTION LILY-PAD-F)>

<ROUTINE LILY-PAD-F ("OPT" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<PLANT-STUNNED>)
	       (.ARG
		<RFALSE>)
	       (<VERB? ENTER CLIMB-ON>
		<COND (<VISIBLE? ,OTTO>
		       <TELL "\"For toads only, buster.\"" CR>)
		      (T
		       <TELL "Only a toad could be comfortable there." CR>)>)
	       (<AND <VERB? LISTEN>
		     ,PLANT-TALKER>
		<TELL "The lily pad is ">
		<COND (<PRSO? ,LARGE-LILY-PAD>
		       <COND (<VISIBLE? ,OTTO>
			      <TELL "moaning about">)
			     (T
			      <TELL "giddy at the absence of">)>
		       <TELL " the weight of the giant toad." CR>)
		      (T
		       <TELL "composing an ode to sunlight." CR>)>)>>

<OBJECT OTTO
	(LOC LARGE-LILY-PAD)
	(DESC "ugly toad")
	(SYNONYM TOAD OTTO)
	(ADJECTIVE UGLY LARGE BLUE GRUMPY)
	(FLAGS ACTORBIT VOWELBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION OTTO-F)>

<ROUTINE OTTO-F ("OPT" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<COND (<OR <AND <VERB? GIVE>
				<PRSO? ,SPYGLASS>
				<PRSI? ,ME>>
			   <AND <VERB? SGIVE>
				<PRSO? ,ME>
				<PRSI? ,SPYGLASS>>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-FOR ,OTTO ,SPYGLASS>
		       <SETG WINNER ,OTTO>
		       <RTRUE>)
		      (<AND <VERB? YES>
			    <EQUAL? ,AWAITING-REPLY 2>>
		       <V-YES>)
		      (<AND <VERB? NO>
			    <EQUAL? ,AWAITING-REPLY 2>>
		       <V-NO>)
		      (T
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL
"\"Quiet. I've got a headache. Do you think you own this swamp?\"" CR>
		       <STOP>)>)
	       (<VERB? EXAMINE>
		<TELL
"The toad is not only ugly, it is bright blue and the size of a small shack.
It also looks pretty grumpy." CR>)
	       (<AND <ADJ-USED? ,OTTO ,W?UGLY>
		     <VISIBLE? ,OTTO>>
		<TELL
"\"Who're you calling ugly?!? You're no prize yourself, you know!\"" CR>
		<STOP>)
	       (<AND <NOUN-USED? ,OTTO ,W?TOAD>
		     <VISIBLE? ,OTTO>>
		<SETG OTTO-NAME-COUNTER <+ ,OTTO-NAME-COUNTER 1>>
		<TELL "\"I have a name, you know">
		<COND (<EQUAL? <MOD ,OTTO-NAME-COUNTER 5> 0>
		       <TELL
", a great name, known throughout many lands. And though I spent many years
at sea, few pirates will know my name">)>
		<TELL ".\"" CR>
		<STOP>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,SPYGLASS>>
		<COND (<EQUAL? ,FLIES-EATEN 4>
		       <MOVE ,SPYGLASS ,SMALL-LILY-PAD>
		       <FCLEAR ,SPYGLASS ,TRYTAKEBIT>
		       <THIS-IS-IT ,SPYGLASS>
		       <TELL
"\"Okay, take the stupid thing, but shut up and let me have some peace
and quiet.\" The toad places the spyglass on the small lily pad." CR>)
		      (T
		       <TELL
"\"If you want this spyglass, you must bring me the ">
		       <COND (<EQUAL? ,FLIES-EATEN 0>
			      <TELL "Four ">)
			     (T
			      <TELL "remaining ">
			      <COND (<EQUAL? ,FLIES-EATEN 1>
				     <TELL "three ">)
				    (<EQUAL? ,FLIES-EATEN 2>
				     <TELL "two ">)>)>
		       <TELL "Fantastic Fl">
		       <COND (<EQUAL? ,FLIES-EATEN 3>
			      <TELL "y">)
			     (T
			      <TELL "ies">)>
		       <TELL " of Famathria.\"" CR>)>)
	       (<AND <VERB? EAT>
		     ,ALLIGATOR>
		<TELL
"Although the toad looks tasty, he's about ten times your size." CR>)>>

<GLOBAL OTTO-NAME-COUNTER 0>

<ROUTINE I-STONE-TO-OTTO ()
	 <MOVE ,OTTO ,LARGE-LILY-PAD>
	 <COND (<EQUAL? ,HERE ,DELTA-6>
		<RETURN-FROM-MAP>
		<TELL
"   Otto emerges from the muck of the swamp, looking quite displeased.
Dripping with mud, he plops down on his favorite lily pad">
		<COND (<VISIBLE? ,WAND>
		       <REMOVE ,WAND>
		       <TELL
". \"Let's just make sure we don't have any repetitions of that, eh?\" He
wraps his tongue around the wand and snaps it into a zillion splinters">)>
		<TELL ,PERIOD-CR>)
	       (T
		<RFALSE>)>>

<OBJECT SMALL-LILY-PAD
	(LOC DELTA-6)
	(DESC "small lily pad")
	(SYNONYM PAD)
	(ADJECTIVE SMALL LILY)
	(FLAGS PLANTBIT SURFACEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 20)
	(ACTION LILY-PAD-F)>

<BEGIN-SEGMENT 0>

<OBJECT SPYGLASS
	(LOC SMALL-LILY-PAD)
	(DESC "spyglass")
	(PLURAL "spyglasses")
	(SYNONYM SPYGLASS TELESCOPE)
	(FLAGS TAKEBIT MAGICBIT TRYTAKEBIT)
	(VALUE 12)
	(ACTION SPYGLASS-F)>

<ROUTINE SPYGLASS-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,SPYGLASS ,TRYTAKEBIT>>
		<COND (<IN? ,SPYGLASS ,SMALL-LILY-PAD>
		       <MOVE ,SPYGLASS ,OTTO>
		       <TELL
"The toad snatches the spyglass with its long tongue. ">)>
		<TELL
"\"If you want it, you'll have to ask me to give it to you.\"" CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "The spyglass magnifies distant objects." CR>)
	       (<AND <VERB? EXAMINE>
		     <PRSI? ,SPYGLASS>>
		<TELL ,YOU-SEE T ,PRSO ", somewhat enlarged." CR>)>>

<OBJECT LARGE-FLY
	(LOC LOCAL-GLOBALS)
	(DESC "large fly")
	(PLURAL "flies")
	(SYNONYM FLY)
	(ADJECTIVE LARGE)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 1)
	(ACTION FLY-F)>

<OBJECT LARGER-FLY
	(LOC LOCAL-GLOBALS)
	(DESC "larger fly")
	(PLURAL "flies")
	(SYNONYM FLY)
	(ADJECTIVE LARGER)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 1)
	(ACTION FLY-F)>

<OBJECT EVEN-LARGER-FLY
	(LOC LOCAL-GLOBALS)
	(DESC "even larger fly")
	(PLURAL "flies")
	(SYNONYM FLY)
	(ADJECTIVE EVEN LARGER)
	(FLAGS VOWELBIT TAKEBIT TRYTAKEBIT)
	(SIZE 1)
	(ACTION FLY-F)>

<OBJECT LARGEST-FLY
	(LOC LOCAL-GLOBALS)
	(DESC "the largest fly")
	(PLURAL "flies")
	(SYNONYM FLY)
	(ADJECTIVE LARGEST)
	(FLAGS NARTICLEBIT TAKEBIT TRYTAKEBIT)
	(SIZE 1)
	(ACTION FLY-F)>

<GLOBAL FLIES-EATEN 0>

<ROUTINE FLY-F ()
	 <COND (<VERB? DROP>
		<ORDER-FLIES ,HERE>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL
"This is one juicy delicious-looking hunk of fly... that is, if you're the
type who goes for insect meat..." CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,OTTO>>
		<REMOVE ,PRSO>
		<SETG FLIES-EATEN <+ ,FLIES-EATEN 1>>
		<TELL
"The toad wraps its long tongue around the fly, snaps it gluttonously
into its mouth, and burps rudely." CR>)
	       (<VERB? CATCH>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<TOUCHING? ,PRSO>
		<COND (<VERB? TAKE>
		       <ORDER-FLIES ,PROTAGONIST>)>
		<COND (<FSET? ,PRSO ,TRYTAKEBIT>
		       <COND (<FSET? ,GLOVE ,WORNBIT>
			      <TELL
"Your gloved hand strikes with amazing speed, but the fly darts out of the
way by a hair's breadth." CR>)
			     (T
			      <TELL "The fly buzzes just out of reach." CR>)>)
		      (T
		       <RFALSE>)>)>>

<END-SEGMENT>
<BEGIN-SEGMENT LAKE>
<BEGIN-SEGMENT SECRET>
<BEGIN-SEGMENT ORACLE>

<ROUTINE FLY-ROOM-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,HERE ,TOUCHBIT>>>
		<COND (<IN? ,LARGE-FLY ,LOCAL-GLOBALS>
		       <MOVE ,LARGE-FLY ,HERE>)
		      (<IN? ,LARGER-FLY ,LOCAL-GLOBALS>
		       <MOVE ,LARGER-FLY ,HERE>)
		      (<IN? ,EVEN-LARGER-FLY ,LOCAL-GLOBALS>
		       <MOVE ,EVEN-LARGER-FLY ,HERE>)
		      (<IN? ,LARGEST-FLY ,LOCAL-GLOBALS>
		       <MOVE ,LARGEST-FLY ,HERE>)>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM DELTA-7
      (LOC ROOMS)
      (DESC "Delta")
      (REGION "Frigid River Valley")
      (LDESC
"You are in the midst of the maze-like, swampy bayou where the Frigid
River dumps its silt before reaching the sea. Twisting paths appear to
lead into the growth in all directions.")
      (NORTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (NE TO DELTA-2)
      (EAST TO DELTA-2)
      (SE SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SOUTH SORRY
       "The path dead ends as the growth closes to an unpassable tangle.")
      (SW TO OCEANS-EDGE)
      (WEST TO DELTA-6)
      (NW TO DELTA-6)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT DELTABIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-7>)
      (ICON DELTA-ICON)>

<ROOM RIVERS-END
      (LOC ROOMS)
      (DESC "River's End")
      (REGION "Frigid River Valley")
      (LDESC
"The Frigid River ends its long journey from Flood Control Dam #3 here,
losing its speed and turning into a delta of meandering channels to the
southwest. To continue northeast up the river, you'd need a boat and a
number of strong oarsmen.")
      (NE SORRY "Where's the boat? Where're the oarsmen?")
      (SW TO DELTA-4)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-1 MAP-GEN-X-10>)
      (ICON RIVERS-END-ICON)
      (ACTION FLY-ROOM-F)>

<OBJECT FRIGID-RIVER
	(LOC RIVERS-END)
	(DESC "the Frigid River")
	(SYNONYM RIVER)
	(ADJECTIVE FRIGID)
	(FLAGS NDESCBIT NARTICLEBIT WATERBIT)
	(RESEARCH
"\"The Frigid River, the mightiest in the Great Underground Empire, forms
at the spilloff of Flood Control Dam #3, pours over Aragain Falls, and finally
empties into the Great Sea at the southern end of the Frigid River Valley. The
total length, from dam to river delta, is over 150 bloits.\"")>

<ROOM OCEANS-EDGE
      (LOC ROOMS)
      (DESC "Ocean's Edge")
      (REGION "Frigid River Valley")
      (LDESC
"The channels of the river trickle into the mighty Flathead Ocean, which
extends west to the horizon. A path leads into the delta to the northeast.")
      (NE TO DELTA-7)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (GLOBAL FLATHEAD-OCEAN)
      (MAP-LOC <PTABLE DELTA-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-6>)
      (ICON OCEANS-EDGE-ICON)>

<OBJECT FLATHEAD-OCEAN
	(LOC LOCAL-GLOBALS)
	(DESC "the Flathead Ocean")
	(SYNONYM OCEAN SEA)
	(ADJECTIVE FLATHEAD MIGHTY GREAT)
	(FLAGS NARTICLEBIT WATERBIT)
	(RESEARCH
"\"The Flathead Ocean divides the world into the eastlands and westlands. It
was called the Great Sea until the time of Dimwit Flathead, and it is still
known by its earlier name in many parts of the kingdom.\"")>
\
<ROOM FOOT-OF-STATUE
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Foot of Statue")
      (SW TO VIEW-OF-STATUE)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (GLOBAL DIMWIT-STATUE)
      (VALUE 10)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-8>)
      (ICON FOOT-OF-STATUE-ICON)
      (ACTION FOOT-OF-STATUE-F)>

<ROUTINE FOOT-OF-STATUE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This once verdant valley is now barren. " ,NEAR-STATUE-DESC
" A trail approaches a hilltop to the southwest.">)>>

<OBJECT DIMWIT-STATUE
	(LOC LOCAL-GLOBALS)
	(OWNER DIMWIT-STATUE)
	(DESC "statue of Dimwit Flathead")
	(SYNONYM STATUE DIMWIT FLATHEAD)
	(ADJECTIVE LORD DIMWIT)
	(GENERIC G-DIMWIT-F)
	(ACTION DIMWIT-STATUE-F)>

<ROUTINE DIMWIT-STATUE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,FOOT-OF-STATUE>
		       <TELL ,NEAR-STATUE-DESC CR>)
		      (T
		       <TELL ,DISTANT-STATUE-DESC CR>)>)>>

<CONSTANT NEAR-STATUE-DESC
"Towering above you is a statue so tall that you can't see much beyond
the knees.">

<CONSTANT DISTANT-STATUE-DESC
"To the northeast, a huge statue of Dimwit Flathead casts a dark shadow across
the land. The statue is beginning to deteriorate; vines cover the lower bloit
or so, and some pterodactyls have begun nesting on the flat top of the statue's
head.">

<ROOM VIEW-OF-STATUE
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "View of Statue")
      (NE TO FOOT-OF-STATUE)
      (WEST TO BASE-OF-MOUNTAINS)
      (SE TO CAIRN)
      (SOUTH TO OUTSIDE-HUT)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (GLOBAL DIMWIT-STATUE)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-7>)
      (THINGS <> SHADOW PHIL-SHADOW-PS
       		 SMALL TREES TREE-PS)
      (ACTION VIEW-OF-STATUE-F)>

<ROUTINE TREE-PS ()
	 <COND (<VERB? CLIMB CLIMB-UP>
		<TELL "There are no trees here suitable for climbing." CR>)>>

<ROUTINE VIEW-OF-STATUE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on a tall hilltop near the center of barren Fublio Valley. A few
small trees are beginning the arduous task of refoliating the valley. "
,DISTANT-STATUE-DESC " Trails lead northeast, southeast, west, and
south.">)>>

<ROOM OUTSIDE-HUT
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Outside Hut")
      (LDESC
"A trail from the north ends here. To the west is a decaying hut.")
      (NORTH TO VIEW-OF-STATUE)
      (WEST TO MEGABOZ-HUT)
      (IN TO MEGABOZ-HUT)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (GLOBAL MEGABOZ-HUT)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-7>)
      (ICON OUTSIDE-HUT-ICON)>

<ROOM MEGABOZ-HUT
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Megaboz's Hut")
      (EAST TO OUTSIDE-HUT)
      (OUT TO OUTSIDE-HUT)
      (UP PER ATTIC-ENTER-F)
      (SYNONYM HUT)
      (OWNER MEGABOZ)
      (GLOBAL MEGABOZ-TRAP-DOOR)
      (FLAGS RLANDBIT BEYONDBIT)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-6>)
      (ACTION MEGABOZ-HUT-F)>

<ROUTINE MEGABOZ-HUT-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the unassuming shack where the legendary magician Megaboz once
lived. Embroidered wall hangings adorn one side of the hut, and a poem has
been scrawled on the opposite wall; oddly, some of the words are missing.
The only exit is east. " ,MEGABOZ-CEILING-DESC>)>>

<ROUTINE ATTIC-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<NOT <FSET? ,MEGABOZ-TRAP-DOOR ,OPENBIT>>
		<COND (<NOT .RARG>
		       <RETURN-FROM-MAP>
		       <DO-FIRST "open the trap door">)>
		<RFALSE>)
	       (<NOT <IN? ,PROTAGONIST ,LADDER>>
		<COND (<NOT .RARG>
		       <RETURN-FROM-MAP>
		       <CANT-REACH ,MEGABOZ-TRAP-DOOR>)>
		<RFALSE>)
	       (T
		,ATTIC)>>

<OBJECT POEM
	(LOC MEGABOZ-HUT)
	(DESC "poem")
	(SYNONYM POEM)
	(FLAGS NDESCBIT READBIT)
	(TEXT ;"tired pine, iron mine, wore, magic store"
"\"She stood in the shade of a _ _ _ _ _   _ _ _ _|
She held the prize of an _ _ _ _   _ _ _ _|
And all beheld that she proudly _ _ _ _|
A relic found in a _ _ _ _ _   _ _ _ _ _\"")>

<OBJECT WALL-HANGINGS
	(LOC MEGABOZ-HUT)
	(DESC "wall hangings")
	(SYNONYM HANGING HANGINGS)
	(ADJECTIVE EMBROIDER WALL)
	(FLAGS NDESCBIT READBIT)
	(TEXT
"One hanging reads \"Hut Sweet Hut\" and the other reads \"Forget the rest;
Megaboz is the best.\"")>

<OBJECT MEGABOZ-TRAP-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "trap door")
	(SYNONYM DOOR)
	(ADJECTIVE TRAP)
	(FLAGS DOORBIT)
	(ACTION MEGABOZ-TRAP-DOOR-F)>

<ROUTINE MEGABOZ-TRAP-DOOR-F ()
	 <COND (<AND <EQUAL? ,HERE ,MEGABOZ-HUT>
		     <TOUCHING? ,MEGABOZ-TRAP-DOOR>
		     <NOT <IN? ,PROTAGONIST ,LADDER>>>
		<CANT-REACH ,MEGABOZ-TRAP-DOOR>)
	       (<AND <VERB? ENTER>
		     <EQUAL? ,HERE ,MEGABOZ-HUT>>
		<DO-WALK ,P?UP>)>>

<ROOM ATTIC
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Attic")
      (LDESC
"This musty little room is barely more than a crawl space beneath the roof of
the hut.")
      (DOWN TO MEGABOZ-HUT IF MEGABOZ-TRAP-DOOR IS OPEN)
      (FLAGS RLANDBIT BEYONDBIT)
      (GLOBAL MEGABOZ-TRAP-DOOR LOCK-OBJECT)
      (VALUE 8)
      (SYNONYM ATTIC)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-5>)
      (ICON ATTIC-ICON)
      (THINGS <> SHADOW PHIL-SHADOW-PS)>

<OBJECT ATTIC-REBUS-BUTTON
	(LOC ATTIC)
	(SDESC "blinking key-shaped button")
	(SYNONYM BUTTON)
	(ADJECTIVE KEY-SHAPED BLINKING)
	(ACTION REBUS-BUTTON-F)>

<OBJECT TRUNK
	(LOC ATTIC)
	(DESC "trunk")
	(LDESC
"In the shadows under the eaves, you spot an ancient trunk, covered with
dust and cobwebs.")
	(SYNONYM TRUNK)
	(ADJECTIVE ANCIENT DUSTY)
	(FLAGS TRYTAKEBIT CONTBIT SEARCHBIT LOCKEDBIT)
	(CAPACITY 75)
	(ACTION TRUNK-F)>

<ROUTINE TRUNK-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,TRUNK ,LOCKEDBIT>>
		     ,FLY-IN-TRUNK>
		<COND (<AND ,PRSI
			    <FSET? ,PRSI ,KEYBIT>>
		       <RFALSE>)>
		<SETG FLY-IN-TRUNK <>>
		<COND (<IN? ,LARGE-FLY ,LOCAL-GLOBALS>
		       <MOVE ,LARGE-FLY ,HERE>)
		      (<IN? ,LARGER-FLY ,LOCAL-GLOBALS>
		       <MOVE ,LARGER-FLY ,HERE>)
		      (<IN? ,EVEN-LARGER-FLY ,LOCAL-GLOBALS>
		       <MOVE ,EVEN-LARGER-FLY ,HERE>)
		      (<IN? ,LARGEST-FLY ,LOCAL-GLOBALS>
		       <MOVE ,LARGEST-FLY ,HERE>)>
		<TELL
"As you raise the lid, a huge fly zooms out and begins
buzzing around the room. ">
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,TRUNK>>
		<TELL
"The trunk turns out to be too large and heavy to move." CR>)
	       (<AND <VERB? UNLOCK>
		     <FSET? ,TRUNK ,LOCKEDBIT>
		     <PRSI? ,RUSTY-KEY>>
		<COND (<EQUAL? ,SACRED-WORD-NUMBER 10>
		       <SETG SACRED-WORD-NUMBER <- <RANDOM 10> 1>>)>
		<FCLEAR ,TRUNK ,LOCKEDBIT>
		<LOCKED-UNLOCKED ,TRUNK T>)
	       (<AND <VERB? LOCK>
		     <NOT <FSET? ,TRUNK ,LOCKEDBIT>>
		     <PRSI? ,RUSTY-KEY>>
		<FSET ,TRUNK ,LOCKEDBIT>
		<LOCKED-UNLOCKED ,TRUNK>)>>

<GLOBAL FLY-IN-TRUNK T>

<OBJECT ROBE
	(LOC MEGABOZ)
	(DESC "wizardly robe")
	(SYNONYM ROBE)
	(ADJECTIVE WIZARDLY)
	(FLAGS WEARBIT)>

<BEGIN-SEGMENT 0>

<OBJECT PAN
	(LOC TRUNK)
	(DESC "saucepan")
	(SYNONYM SAUCEPAN PAN)
	(FLAGS TAKEBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION PAN-F)>

<ROUTINE PAN-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL ,HUH>)>>

<OBJECT NOTEBOOK
	(LOC TRUNK)
	(DESC "notebook")
	(SYNONYM NOTEBOOK)
	(FLAGS TAKEBIT READBIT)
	(ACTION NOTEBOOK-F)>

<ROUTINE NOTEBOOK-F ()
	 <COND (<VERB? READ OPEN EXAMINE>
		<TELL
"The notebook is either gibberish or far in advance of your understanding.
It seems to be filled with all kinds of formulas, spells, and shopping
lists.|
   Near the end, you discover what appears to be a list of things to do:
\"1) Mail OZMOO scrolls to Gurth. 2) Cast Curse on Flatheads. 3) Pick up
milk and bread.\"|
   Below is a sketch of a steaming kettle and a single word, \""
<GET ,SACRED-WORDS ,SACRED-WORD-NUMBER> ".\"" CR>)>>

<GLOBAL SACRED-WORD-NUMBER 10>

<CONSTANT SACRED-WORDS
	<PTABLE "sizul"
	       "fzorty"
	       "xzilch"
	       "fublitskee"
	       "zastic"
	       "aulderfoo"
	       "lizowurt"
	       "eldablitz"
	       "mordex"
	       "hildebud">>

<CONSTANT SACRED-WORD-WORDS-LENGTH 10>

<CONSTANT SACRED-WORD-WORDS
	<PTABLE <VOC "SIZUL" <>>
	        <VOC "FZORTY" <>>
	        <VOC "XZILCH" <>>
	        <VOC "FUBLITSKEE" <>>
	        <VOC "ZASTIC" <>>
	        <VOC "AULDERFOO" <>>
	        <VOC "LIZOWURT" <>>
	        <VOC "ELDABLITZ" <>>
	        <VOC "MORDEX" <>>
	        <VOC "HILDEBUD" <>>>>

<OBJECT SACRED-WORD-OBJ
	(DESC "sacred word")
	(SYNONYM SIZUL FZORTY XZILCH FUBLITSKEE ZASTIC AULDERFOO LIZOWURT
	      	 ELDABLITZ MORDEX HILDEBUD)>

<OBJECT HARMONICA
	(LOC TRUNK)
	(DESC "harmonica")
	(SYNONYM HARMONICA)
	(FLAGS TAKEBIT)
	(SIZE 3)
	(ACTION HARMONICA-F)>

<ROUTINE HARMONICA-F ()
	 <COND (<VERB? PLAY INFLATE>
		<TELL
"The harmonica produces a sound like that of cats being tortured." CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM CAIRN
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Cairn")
      (LDESC
"Paths lead around this haphazard pile of stones to the northwest, east,
and south.")
      (NW TO VIEW-OF-STATUE)
      (EAST TO OUTSIDE-SHACK)
      (SOUTH TO QUARRYS-EDGE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-8>)
      (ICON CAIRN-ICON)>

<OBJECT CAIRN-OBJECT
	(LOC CAIRN)
	(DESC "pile of stones")
	(SYNONYM PILE STONE STONES CAIRN)
	(ADJECTIVE HAPHAZARD)
	(FLAGS NDESCBIT)
	(ACTION CAIRN-OBJECT-F)>

<ROUTINE CAIRN-OBJECT-F ()
	 <COND (<VERB? TAKE>
		<TELL
"The stones, individually, are uninteresting; the entire pile is much
too massive to take." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The cairn probably has a magical or religious significance." CR>)
	       (<AND <VERB? COUNT>
		     <NOUN-USED? ,CAIRN-OBJECT ,W?STONES>>
		<TELL "Thousands." CR>)>>

<ROOM OUTSIDE-SHACK
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Outside Shack")
      (LDESC
"To the northeast is a run-down little shack. A sign is posted by the
entrance, and a path runs off to the west.")
      (WEST TO CAIRN)
      (NE TO GUMBOZ-SHACK)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL GUMBOZ-SHACK SIGN)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-9>)>

<ROOM GUMBOZ-SHACK
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Gumboz's Shack")
      (LDESC
"You are in a small shack, the home of an obscure magician named Gumboz. The
only exit is southwest.")
      (SW PER SHACK-EXIT-F)
      (OUT PER SHACK-EXIT-F)
      (FLAGS RLANDBIT BEYONDBIT)
      (SYNONYM SHACK)
      (ADJECTIVE GUMBOZ\'S)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-10>)
      (ACTION GUMBOZ-SHACK-F)>

<ROUTINE GUMBOZ-SHACK-F ("OPT" (RARG <>) "AUX" (SPILL <>))
	 <COND (<EQUAL? .RARG ,M-END>
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
		<COND (<OR .SPILL
			   <PROB 20>>
		       <RETURN-FROM-MAP>
		       <TELL
"   You trip over something invisible (perhaps some sort of feeble
anti-theft device). Fortunately, you manage to keep your footing.">
		       <COND (.SPILL
			      <TELL
" Unfortunately, you seem to have spilled something.">)>
		       <CRLF>)>)>>

<ROUTINE SHACK-EXIT-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<NOT .RARG>
		<RETURN-FROM-MAP>
		<CAST-HUNGER-SPELL>)>
	 ,OUTSIDE-SHACK>

<GLOBAL HUNGER-SPELL-CAST <>>

<GLOBAL HUNGER-COUNT 0>

<BEGIN-SEGMENT 0>

<ROUTINE CAST-HUNGER-SPELL ()
	 <COND (<AND <EQUAL? ,HERE ,GUMBOZ-SHACK>
		     <ULTIMATELY-IN? ,SMALL-VIAL>
		     <NOT ,HUNGER-SPELL-CAST>>
		<SETG HUNGER-SPELL-CAST T>
		<QUEUE I-HUNGER 36>
		<SETG HUNGER-COUNT 1>
		<FCLEAR ,SMALL-VIAL ,TRYTAKEBIT>
		<TELL
"You hear a cry of \"Stop, thief! My vial!\" and a feeble but very angry
wizard begins to appear. Noting that your departure is imminent, he casts
his quickest spell on you; fortunately, it doesn't sound very powerful.|
   You're suddenly very hungry." CR CR>)>>

<ROUTINE I-HUNGER ()
	 <SETG HUNGER-COUNT <+ ,HUNGER-COUNT 1>>
	 <RETURN-FROM-MAP>
	 <TELL "   ">
	 <COND (<EQUAL? ,HUNGER-COUNT 2>
		<QUEUE I-HUNGER 18>
		<TELL
"You're really famished now. Odd -- you had quite a huge meal last night." CR>)
	       (<EQUAL? ,HUNGER-COUNT 3>
		<QUEUE I-HUNGER 12>
		<TELL "You've never felt this hungry in your life!" CR>)
	       (<EQUAL? ,HUNGER-COUNT 4>
		<QUEUE I-HUNGER 6>
		<TELL
"If your stomach could talk, it would be screaming, \"Get some food down here
right away, jerk!\"" CR>)
	       (T
		<JIGS-UP "You pass out from extreme hunger.">)>>

<OBJECT SMALL-VIAL
	(LOC GUMBOZ-SHACK)
	(DESC "four-gloop vial")
        (SYNONYM VIAL WRITING)
	(ADJECTIVE FOUR-GLOOP 4-GLOOP FOUR GLOOP SMALL INT.NUM)
	(FLAGS TAKEBIT READBIT TRYTAKEBIT)
	(SIZE 3)
	(OWNER SMALL-VIAL) ;"read writing on vial"
	(GENERIC G-VIAL-F)
	(ACTION VIAL-F)>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM QUARRYS-EDGE
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Quarry's Edge")
      (LDESC
"The trail curves north and east around an abandoned quarry.|
   An ancient pine clings to the rim of the quarry. Its needles are brown with
age, and its drooping branches cast a dark shadow across the quarry below.")
      (NORTH TO CAIRN)
      (DOWN TO QUARRY)
      (EAST TO OUTSIDE-HOVEL)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL TIRED-PINE QUARRY)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-8>)
      (ICON QUARRYS-EDGE-ICON)
      (THINGS <> SHADOW QUARRY-SHADOW-PS)>

<OBJECT TIRED-PINE
	(LOC LOCAL-GLOBALS)
	(DESC "ancient pine tree")
	(SYNONYM TREE PINE)
	(ADJECTIVE PINE TIRED ANCIENT OLD LARGE)
	(FLAGS VOWELBIT PLANTBIT)
	(ACTION TIRED-PINE-F)>

<ROUTINE TIRED-PINE-F ("OPTIONAL" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<PLANT-STUNNED>)
	       (<AND <TOUCHING? ,TIRED-PINE>
		     <EQUAL? ,HERE ,QUARRY>>
		<CANT-REACH ,TIRED-PINE>)
	       (<AND <VERB? GET-NEAR> ;"stand under the pine tree"
		     <EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?UNDER>>
		<COND (<EQUAL? ,HERE ,QUARRY>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<VERB? CLIMB CLIMB-UP>
		<TELL ,POORLY-CONFIGURED>)
	       (<VERB? GET-NEAR>
		<PERFORM-PRSA ,SMALL-ELM>)
	       (<AND <VERB? LISTEN>
		     ,PLANT-TALKER>
		<TELL
"The tree relates a life-long fantasy about being transplanted in the fertile
soil of Gurth." CR>)>>

<ROOM QUARRY
      (LOC ROOMS)
      (DESC "Quarry")
      (REGION "Fublio Valley")
      (LDESC
"The branches of a weary old pine cast a dark shadow across the floor
of this old stone quarry.")
      (UP TO QUARRYS-EDGE)
      (OUT TO QUARRYS-EDGE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (SYNONYM QUARRY)
      (ADJECTIVE ABANDONED OLD STONE)
      (GLOBAL TIRED-PINE)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-7>)
      (ICON QUARRY-ICON)
      (THINGS <> SHADOW QUARRY-SHADOW-PS)
      (ACTION QUARRY-F)>

<ROUTINE QUARRY-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,RUSTY-KEY ,LOCAL-GLOBALS>
		     <ULTIMATELY-IN? ,SAPPHIRE>
		     <FSET? ,RING ,WORNBIT>>
		<MOVE ,RUSTY-KEY ,HERE>
		<RETURN-FROM-MAP>
		<TELL
"   A strange drowsiness comes over you, and you fall into a swoon. An
unknown number of minutes later, you are roused by a gentle breeze" ,ELLIPSIS>
		<V-LOOK>
		<INC-SCORE 14>)
	       (.RARG
		<RFALSE>)
	       (<AND <EQUAL? ,HERE ,QUARRYS-EDGE>
		     <VERB? ENTER>
		     <EQUAL? ,P-PRSA-WORD ,W?JUMP>>
		<JUMPLOSS>)>>

<ROUTINE QUARRY-SHADOW-PS ()
	 <COND (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,QUARRY>
		       <TELL
"You are; the tree's shadow covers the entire floor of the quarry." CR>)
		      (T
		       <DO-WALK ,P?DOWN>)>)>>

<BEGIN-SEGMENT 0>

<OBJECT RUSTY-KEY
	(LOC LOCAL-GLOBALS)
	(DESC "rusty key")
	(SYNONYM KEY)
	(ADJECTIVE RUSTY OLD)
	(FLAGS TAKEBIT KEYBIT)
	(SIZE 2)
	(ACTION RUSTY-KEY-F)>

<ROUTINE RUSTY-KEY-F ()
	 <COND (<VERB? CLEAN>
		<FSET ,RUSTY-KEY ,READBIT>
		<TELL
"You clean off some of the rust, revealing words engraved on the key." CR>)
	       (<AND <VERB? READ>
		     <FSET? ,RUSTY-KEY ,READBIT>>
		<TELL "\"Frobozz Magic Trunk Key Company\"" CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM OUTSIDE-HOVEL
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Outside Hovel")
      (LDESC
"A trail from the west ends here at this tiny structure. Next to the
hovel's entrance, to the east, is a faded sign.")
      (WEST TO QUARRYS-EDGE)
      (EAST TO KORBOZ-HOVEL)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL SIGN KORBOZ-HOVEL)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-9>)>

<ROOM KORBOZ-HOVEL
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Korboz's Hovel")
      (LDESC
"This tiny shack looks like the living quarters of a hermit wizard. The
only exit is west.")
      (WEST TO OUTSIDE-HOVEL)
      (OUT TO OUTSIDE-HOVEL)
      (FLAGS RLANDBIT BEYONDBIT)
      (SYNONYM HOVEL)
      (ADJECTIVE KORBOZ\'S)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-10>)>

<ROOM BASE-OF-MOUNTAINS
      (LOC ROOMS)
      (REGION "Fublio Valley")
      (DESC "Base of Mountains")
      (LDESC
"You are near the base of the mighty Flathead Mountains, toward the
southernmost end of the range. The mountains run approximately northeast
to southwest here. The path turns here, heading east into the valley
and north into the foothills.")
      (NORTH TO FOOTHILLS)
      (UP TO FOOTHILLS)
      (EAST TO VIEW-OF-STATUE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-6>)
      (ICON BASE-OF-MTS-ICON)>

<ROOM FOOTHILLS
      (LOC ROOMS)
      (REGION "Flathead Mountains")
      (DESC "Foothills")
      (LDESC
"You are in the foothills of the Flathead Mountains, at the entrance to the
Zorbel Pass. The pass rises to the northwest, and a path leads downward to
the south.")
      (NW TO ZORBEL-PASS)
      (UP TO ZORBEL-PASS)
      (SOUTH TO BASE-OF-MOUNTAINS)
      (DOWN TO BASE-OF-MOUNTAINS)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-6>)>

<ROOM ZORBEL-PASS
      (LOC ROOMS)
      (REGION "Flathead Mountains")
      (DESC "Zorbel Pass")
      (LDESC
"This pass is reputed to be the only crossable point along the entire range.
You are now far above the valley floor, which spreads out below you like a
map, but you have still not reached the highest point of the pass.")
      (DOWN TO FOOTHILLS)
      (SE TO FOOTHILLS)
      (NW TO AVALANCHE)
      (UP TO AVALANCHE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-5>)
      (ICON ZORBEL-PASS-ICON)>

<ROOM AVALANCHE
      (LOC ROOMS)
      (REGION "Flathead Mountains")
      (DESC "Avalanche")
      (LDESC
"As you near the highest point of the pass, you find it blocked by a recent
avalanche. Though you can travel no farther to the northwest, the avalanche
has revealed an ancient ravine leading up the side of the mountain.")
      (DOWN TO ZORBEL-PASS)
      (UP TO TIMBERLINE)
      (NW SORRY "The way is blocked by an avalanche.")
      (SE TO ZORBEL-PASS)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-4>)
      (ICON AVALANCHE-ICON)>

<ROOM TIMBERLINE
      (LOC ROOMS)
      (REGION "Flathead Mountains")
      (DESC "Timberline")
      (LDESC
"You are on the slopes of Mount Foobia, the tallest peak in the Flathead
Mountains. A narrow ravine leads almost straight downward. The vegetation
thins out here, and the air is getting a bit thin as well. Not too far
above you, the slope disappears into the thick clouds which eternally
shroud the apex of Foobia.")
      (UP TO AMONGST-THE-CLOUDS)
      (DOWN TO AVALANCHE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-3>)
      (ICON TIMBERLINE-ICON)>

<ROOM AMONGST-THE-CLOUDS
      (LOC ROOMS)
      (REGION "Flathead Mountains")
      (DESC "Amongst the Clouds")
      (LDESC
"You are surrounded by the thick white clouds which perpetually hide the peak
of Mount Foobia. Visibility is severely limited; you can only assume that the
slope continues to be climbable above you. Breathing here is a chore.")
      (UP TO ON-TOP-OF-THE-WORLD)
      (DOWN TO TIMBERLINE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-2>)
      (ICON AMONGST-CLOUDS-ICON)>

<ROOM ON-TOP-OF-THE-WORLD
      (LOC ROOMS)
      (REGION "Flathead Mountains")
      (DESC "On Top of the World")
      (LDESC
"You have emerged above the cloud layer, at a plateau which forms the apex of
Foobia. There is no sign that anyone has ever been here before. Nearby is a
huge object, which vanishes into the mists above. It's difficult to be certain,
but it looks a bit like a piece of a corner of an edge of a toe of an
enormously tremendous brogmoid. A huge colony of fungus clogs the cracks in
the toe.")
      (DOWN TO AMONGST-THE-CLOUDS)
      (UP SORRY "The brogmoid toe is unclimbable.")
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL BROGMOID FLATHEAD-MOUNTAINS)
      (MAP-LOC <PTABLE FUBLIO-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-1>)
      (ICON ON-TOP-OF-WORLD-ICON)>

<OBJECT TOE-FUNGUS
	(LOC ON-TOP-OF-THE-WORLD)
	(DESC "toe fungus")
	(SYNONYM FUNGUS FUNGI)
	(ADJECTIVE TOE)
	(FLAGS NDESCBIT PLANTBIT)
	(GENERIC G-FUNGUS-F)
	(RESEARCH
"\"A class of saprophytic parasitical plants which lack chlorophyll and are
frequently found in the less hygienic cavities of brogmoids.\"")
	(ACTION TOE-FUNGUS-F)>

<ROUTINE TOE-FUNGUS-F ("OPTIONAL" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<COND (<AND <VERB? FIND GIVE>
			    <PRSO? ,LITTLE-FUNGUS>
			    <IN? ,LITTLE-FUNGUS ,GLOBAL-OBJECTS>
			    <NOT <EQUAL? ,FUNGUS-NUMBER 12>> ;"not chosen yet"
			    <NOUN-USED? ,LITTLE-FUNGUS
				   	<GET ,FUNGUS-WORDS ,FUNGUS-NUMBER>>>
		       <GET-LITTLE-FUNGUS>)
		      (T
		       <PLANT-STUNNED>)>)
	       (<AND <VERB? LISTEN>
		     ,PLANT-TALKER>
		<TELL
"You hear a vast murmur of countless little fungi, all discussing
spore-care techniques." CR>)
	       (<VERB? RESEARCH>
		<PERFORM-PRSA ,EAR-FUNGUS>)
	       (<AND <VERB? ASK-ABOUT>
		     ,PLANT-TALKER
		     <PRSI? ,LITTLE-FUNGUS>
		     <IN? ,LITTLE-FUNGUS ,GLOBAL-OBJECTS>
		     <NOT <EQUAL? ,FUNGUS-NUMBER 12>> ;"not chosen yet"
		     <NOUN-USED? ,LITTLE-FUNGUS
				 <GET ,FUNGUS-WORDS ,FUNGUS-NUMBER>>>
		<GET-LITTLE-FUNGUS>)>>

<ROUTINE GET-LITTLE-FUNGUS ()
	 <FSET ,LITTLE-FUNGUS ,TAKEBIT>
	 <THIS-IS-IT ,LITTLE-FUNGUS>
	 <MOVE ,LITTLE-FUNGUS ,HERE>
	 <TELL "A little fungus trots up and says, \"That's me!\"" CR>>

<BEGIN-SEGMENT 0>

<OBJECT LITTLE-FUNGUS
	(LOC GLOBAL-OBJECTS)
        (DESC "little fungus")
	(SYNONYM SEYMOUR SHERMAN IRVING SAMMY MYRON BORIS MELVIN LESTER
	 	 JULIUS RICARDO OMAR BARNABY FUNGUS COUSIN)
	(ADJECTIVE SMALL)
	(FLAGS PLANTBIT)
	(GENERIC G-FUNGUS-F)
	(RESEARCH
"\"A class of saprophytic parasitical plants which lack chlorophyll and are
frequently found in the less hygienic cavities of brogmoids.\"")
	(ACTION LITTLE-FUNGUS-F)>

<ROUTINE LITTLE-FUNGUS-F ("OPTIONAL" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<PLANT-STUNNED>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<COND (<AND <VERB? CALL YELL SAY FIND>
			    <EQUAL? ,HERE ,ON-TOP-OF-THE-WORLD>
			    ,PLANT-TALKER
			    <NOT <EQUAL? ,FUNGUS-NUMBER 12>> ;"not chosen yet"
			    <NOUN-USED? ,LITTLE-FUNGUS
					<GET ,FUNGUS-WORDS ,FUNGUS-NUMBER>>>
		       <GET-LITTLE-FUNGUS>)
		      (<VERB? CALL YELL SAY>
		       <TELL ,NOTHING-HAPPENS>)
		      (<HANDLE ,LITTLE-FUNGUS>
		       <CANT-SEE ,LITTLE-FUNGUS>)
		      (T
		       <TELL ,BY-THAT-NAME>)>)
	       (<AND <OR <NOUN-USED? ,LITTLE-FUNGUS
				     ,W?SEYMOUR ,W?SHERMAN ,W?IRVING>
			 <NOUN-USED? ,LITTLE-FUNGUS
				     ,W?SAMMY ,W?MYRON ,W?BORIS>
			 <NOUN-USED? ,LITTLE-FUNGUS
				     ,W?MELVIN ,W?LESTER ,W?JULIUS>
			 <NOUN-USED? ,LITTLE-FUNGUS
				     ,W?RICARDO ,W?OMAR ,W?BARNABY>>
		     <NOT <NOUN-USED? ,LITTLE-FUNGUS
				      <GET ,FUNGUS-WORDS ,FUNGUS-NUMBER>>>
		     <OR <HANDLE ,LITTLE-FUNGUS>
			 <VERB? FOLLOW>>>
		<TELL ,BY-THAT-NAME>
		<STOP>)
	       (<OR <AND <VERB? DROP>
			 <EQUAL? ,HERE ,EAR>>
		    <AND <VERB? GIVE SHOW PUT PUT-ON>
			 <PRSI? ,EAR-FUNGUS>>
		    <AND <VERB? PUT PUT-ON>
			 <PRSI? ,BROGMOID>
			 <NOUN-USED? ,BROGMOID ,W?EAR>>>
		<SETG EAR-PASSAGE-OPEN T>
		<REMOVE ,LITTLE-FUNGUS>
		<TELL
"There follows a joyful reunion between the little fungus and his long-lost
cousins. Grateful, the ear fungi part, forming a passageway leading deeper
into the ear." CR>
		<INC-SCORE 18>)>>

<END-SEGMENT>
\
<BEGIN-SEGMENT ORACLE>

<ROOM MINE-ENTRANCE
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Mine Entrance")
      (LDESC
"The Antharian granola mines can be entered to the east, and a major
road leads west. Signs of the granola riots are everywhere. Speaking of
signs, there's one next to the mine entrance.")
      (WEST TO COAST-ROAD)
      (EAST TO RUBBLE-ROOM)
      (IN TO RUBBLE-ROOM)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (GLOBAL SIGN GRANOLA-MINE)
      (VALUE 10)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-8>)
      (ICON MINE-ENTRANCE-ICON)>

<ROOM COAST-ROAD
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Coast Road")
      (LDESC
"This is a bend in a wide dirt road running along the ocean's edge. You can
go east or southwest.")
      (EAST TO MINE-ENTRANCE)
      (SW TO FLATHEAD-STADIUM)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (GLOBAL FLATHEAD-OCEAN)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-7>)
      (ICON COAST-ROAD-ICON)>

<ROOM FLATHEAD-STADIUM
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Flathead Stadium")
      (LDESC
"This was one of Dimwit's most impressive projects: a stadium which would
hold the entire population of the Great Underground Empire. A whole range
of sporting matches were held here, from dragonfights to Double Fanucci
tournaments. Arched exits lead northeast, southeast, and south.")
      (NE TO COAST-ROAD)
      (SE TO EDGE-OF-BOG)
      (SOUTH TO NORTH-OF-ANTHAR)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT BEYONDBIT)
      (SYNONYM STADIUM)
      (ADJECTIVE FLATHEAD LARGE)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-6>)
      (ICON STADIUM-ICON)>

<BEGIN-SEGMENT 0>

<OBJECT BAT
	(LOC FLATHEAD-STADIUM)
	(DESC "wooden club")
	(FDESC
"A long wooden club lies on the turf. There is something engraved on the
club's thick end.")
	(SYNONYM CLUB BAT)
	(ADJECTIVE WOODEN BASEBALL)
	(FLAGS TRYTAKEBIT TAKEBIT BURNBIT READBIT MAGICBIT)
	(SIZE 10)
	(VALUE 12)
	(TEXT
"A symbol which resembles a winged rodent is engraved on the barrel
of the club.")
	(ACTION BAT-F)>

<GLOBAL BAT-SWINGS 0>

<ROUTINE BAT-F ()
	 <COND (<AND <TOUCHING? ,BAT>
		     <FSET? ,BAT ,TRYTAKEBIT>>
		<TELL
"An invisible force prevents you from approaching the wooden club." CR>)
	       (<VERB? SWING>
		<SETG BAT-SWINGS <+ ,BAT-SWINGS 1>>
		<TELL "\"Strike " N ,BAT-SWINGS "!">
		<COND (<EQUAL? ,BAT-SWINGS 3>
		       <JIGS-UP " Yer out!\"">)
		      (T
		       <TELL "\"" CR>)>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM NORTH-OF-ANTHAR
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "North of Anthar")
      (LDESC
"You are on a road at the fringe of Anthar. The road continues north and
south. In the latter direction, a hastily constructed fence of rock and
wire blocks the road. A sign is posted in front of the fence. A smaller
path heads eastward.")
      (SOUTH SORRY "The fence is very tall and covered with sharp nasties.")
      (NORTH TO FLATHEAD-STADIUM)
      (EAST TO EDGE-OF-BOG)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL SIGN)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-6>)
      (THINGS <> FENCE FENCE-PS)>

<ROUTINE FENCE-PS ()
	 <COND (<VERB? CROSS CLIMB CLIMB-UP CLIMB-OVER>
		<DO-WALK ,P?SOUTH>)
	       (<VERB? THROW-OVER>
		<COND (<PRSO? ,PERCH>
		       <SETG REMOVED-PERCH-LOC ,PSEUDO-OBJECT>)>
		<REMOVE ,PRSO>
		<TELL
"A good throw --" T ,PRSO " sails over the fence and disappears
into a tangle of barbed wire beyond." CR>)>>

<ROOM EDGE-OF-BOG
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Edge of Bog")
      (LDESC
"A series of flat stones leads east into a mist-covered marsh. Paths lead
northwest and west.")
      (EAST TO CLIFF-BOTTOM)
      (WEST TO NORTH-OF-ANTHAR)
      (NW TO FLATHEAD-STADIUM)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-7>)>

<ROOM CLIFF-BOTTOM
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Cliff Bottom")
      (LDESC
"You are at the bottom of a sheer granite cliff. A foggy swamp lies to
the west. Rough handholds have been carved into the face of the cliff.")
      (WEST TO EDGE-OF-BOG)
      (UP TO PRECIPICE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL SWAMP)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-8>)
      (ICON CLIFF-BOTTOM-ICON)>

<ROOM PRECIPICE
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Precipice")
      (LDESC
"This is a tiny shelf of granite atop a sheer cliff. Below, you can see a
misty bog and, beyond that, the ocean. Far to the northwest is a large
stadium; to the southwest, a town. A path leads east into a hollow.")
      (DOWN TO CLIFF-BOTTOM)
      (EAST TO AERIE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (GLOBAL SWAMP FLATHEAD-OCEAN FLATHEAD-STADIUM GLOBAL-BLDG)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-8>)
      (ICON PRECIPICE-ICON)>

<ROOM AERIE
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Aerie")
      (LDESC
"You are in a natural bowl-shaped depression, hollowed out by eons of howling
wind. At the bottom is a huge bird nest, built of myriad bits of scavenged
twigs and debris. Beyond the nest, to the southeast, is a dark opening. A
trail leads west.")
      (WEST TO PRECIPICE)
      (SE TO ICKY-CAVE)
      (FLAGS RLANDBIT ONBIT BEYONDBIT OUTSIDEBIT)
      (SYNONYM AERIE)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-5 MAP-GEN-X-9>)
      (ICON AERIE-ICON)
      (ACTION AERIE-F)>

<ROUTINE AERIE-F ("OPT" (RARG <>) "AUX" OBJ OWINNER)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <OR <SET OBJ <FIND-IN ,PROTAGONIST ,ONBIT>>
			 <SET OBJ <FIND-LANTERN>>>>
		<REPEAT () ;"if light source is unseen, get its LOC instead"
			<SET OWINNER ,WINNER>
			<SETG WINNER ,NEST> ;"see SEE-INSIDE?"
			<COND (<VISIBLE? .OBJ>
			       <MOVE .OBJ ,CLIFF-BOTTOM>
			       <RETURN>)>
			<SET OBJ <LOC .OBJ>>
			<SETG WINNER .OWINNER>>
		<RETURN-FROM-MAP>
		<TELL
"   \"Caw! Caw!\" A huge black bird swoops down and snatches your " D .OBJ
" in its mighty talons. It flies westward, drops" T .OBJ " over the precipice,
and flutters into the clouds." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <PROB 40>>
		<TELL
"   A gust of wind sends a whirl of dust dancing in a circle around the
bird's nest." CR>)>>

<ROUTINE FIND-LANTERN ()
	 <COND (<ULTIMATELY-IN? ,LANTERN>
		,LANTERN)
	       (T
		<RFALSE>)>>

<OBJECT NEST
	(LOC AERIE)
	(DESC "nest")
	(SYNONYM NEST)
	(ADJECTIVE LARGE BIRD BIRD\'S)
	(FLAGS NDESCBIT VEHBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION NEST-F)>

<ROUTINE NEST-F ("OPTIONAL" VARG)
	 <COND (.VARG
		<RFALSE>)
	       (<AND <VERB? EXAMINE SEARCH>
		     <IN? ,SILK-TIE ,LOCAL-GLOBALS>>
		<MOVE ,SILK-TIE ,NEST>
		<TELL
"Among the items woven into the nest is a faded silk tie!" CR>)
	       (<VERB? LOOK-INSIDE>
		<COND (<IN? ,SILK-TIE ,LOCAL-GLOBALS>
		       <PERFORM ,V?EXAMINE ,NEST>
		       <RTRUE>)
		      (T
		       <TELL "The nest is, at the moment, birdless." CR>)>)>>

;<BEGIN-SEGMENT 0>

<OBJECT SILK-TIE
	(LOC LOCAL-GLOBALS)
	(DESC "silk tie")
	(SYNONYM TIE)
	(ADJECTIVE FADED GRAY)
	(FLAGS TAKEBIT MAGICBIT WEARBIT READBIT)
	(TEXT
"Although terribly old and faded, you can tell that the tie was once gray with
little green zorkmid symbols all over it.")
	(VALUE 12)
	;(ACTION SILK-TIE-F)>

;<ROUTINE SILK-TIE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Although terribly old and faded, you can tell that the tie was once gray with
little green zorkmid symbols all over it." CR>)>>

;<END-SEGMENT>

;<BEGIN-SEGMENT ORACLE>

<ROOM ICKY-CAVE
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Icky Cave")
      (NW TO AERIE)
      (OUT TO AERIE)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (SYNONYM CAVE CAVERN)
      (ADJECTIVE ICKY SMALL)
      (GLOBAL SLIME)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-6 MAP-GEN-X-10>)
      (ICON ICKY-CAVE-ICON)
      (ACTION ICKY-CAVE-F)>

<ROUTINE ICKY-CAVE-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The walls of this small cavern are covered with thick, black slime. It drips
from the stalactites and puddles up on the floor.">
		<COND (<NOT <IN? ,SICKLY-WITCH ,HERE>>
		       <TELL
" Considering the furnishings and relics, this cave must be the home of
several witches. However, the witches are either out or hiding.">)>
		<TELL " The only exit from this tiny cavern is northwest.">)>>

<OBJECT SICKLY-WITCH
	(DESC "sickly witch")
	(LDESC
"In the dimmest corner of the cave huddle a pair of witches. One looks
healthier but less friendly than the other.")
	(SYNONYM WITCH)
	(ADJECTIVE SICKLY FRIENDLY UNHEALTHY)
	(FLAGS ACTORBIT FEMALEBIT ANIMATEDBIT)
	(ACTION WITCH-F)>

<OBJECT PRICKLY-WITCH
	(DESC "prickly witch")
	(SYNONYM WITCH)
	(ADJECTIVE PRICKLY UNFRIENDLY HEALTHY)
	(FLAGS ACTORBIT FEMALEBIT ANIMATEDBIT NDESCBIT)
	(ACTION WITCH-F)>

<ROUTINE WITCH-F ("OPT" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-WINNER>
		<COND (<FSET? ,BAT ,TRYTAKEBIT>
		       <TELL "\"Bring us ">
		       <COND (,VIAL-GIVEN
			      <TELL "earwax of brogmoid">)
			     (T
			      <TELL
"exactly six gloops of water from the Great Underground Oasis">)>
		       <TELL
", and we shall remove the enchantment on that which you seek.\"">
		       <COND (<IN? ,LARGE-VIAL ,LOCAL-GLOBALS>
			      <MOVE ,LARGE-VIAL ,HERE>
			      <TELL " A vial appears in front of you.">)>
		       <CRLF>)
		      (T
		       <TELL
"\"Stop pestering us, or we'll restore the enchantment... and worse!\"" CR>)>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,PRICKLY-WITCH ,SICKLY-WITCH>
		     <NOT ,LIT>>
		<TELL ,TOO-DARK CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,EARWAX>>
		<REMOVE ,EARWAX>
		<SETG EARWAX-GIVEN T>
		<COND (,VIAL-GIVEN
		       <FCLEAR ,BAT ,TRYTAKEBIT>
		       <TELL
"\"A fine specimen!\" cackles the witch. \"Now, where were we? Ah, yes... "
"Brogmoid earwax!" ,FINISH-ENCHANTMENT>)
		      (T
		       <TELL
"\"Ah, brogmoid ear wax! A goodly portion, too! Always handy to have around.\"
She squirrels it away." CR>)>)>>

<CONSTANT FINISH-ENCHANTMENT
" Camel sweat! Rotgrub heart! The enchantment begone!\" A palpable wave of
magic sweeps over you and out of the cave.|">

<GLOBAL VIAL-GIVEN <>>

<GLOBAL EARWAX-GIVEN <>>

<BEGIN-SEGMENT 0>

<OBJECT LARGE-VIAL
	(LOC LOCAL-GLOBALS)
	(DESC "nine-gloop vial")
        (SYNONYM VIAL WRITING)
	(ADJECTIVE NINE-GLOOP 9-GLOOP NINE GLOOP LARGE INT.NUM)
	(FLAGS TAKEBIT READBIT)
	(GENERIC G-VIAL-F)
	(OWNER LARGE-VIAL) ;"read writing on vial"
	(ACTION VIAL-F)>

<ROUTINE G-VIAL-F (SRES F)
	 <COND (<EQUAL? <GET <REST-TO-SLOT <FIND-ADJS .F> ADJS-COUNT 1> 0>
			,W?INT.NUM>
		<COND (<EQUAL? <FIND-NUM .F> ;,P-NUMBER 4>
		       ,SMALL-VIAL)
		      (<EQUAL? <FIND-NUM .F> ;,P-NUMBER 9>
		       ,LARGE-VIAL)
		      (T
		       ;<TELL
,YOU-CANT-SEE-ANY N <FIND-NUM .F> ;,P-NUMBER "-gloop vial here!]" CR>
		       ,NOT-HERE-OBJECT ;,ROOMS)>)>>

<GLOBAL SMALL-VIAL-GLOOPS 0>

<GLOBAL LARGE-VIAL-GLOOPS 0>

<GLOBAL SMALL-VIAL-TAINTED <>>

<GLOBAL LARGE-VIAL-TAINTED <>>

<GLOBAL SMALL-VIAL-IMPRECISE <>>

<GLOBAL LARGE-VIAL-IMPRECISE <>>

<CONSTANT INTEGERS <PLTABLE
		<VOC "ONE"> <VOC "TWO"> <VOC "THREE">
		<VOC "FOUR"> <VOC "FIVE"> <VOC "SIX">
		<VOC "SEVEN"> <VOC "EIGHT"> <VOC "NINE">>>

<ROUTINE CONVERT-NUMBER (ADJS "AUX" ADJ)
	<SET ADJ <GET <REST-TO-SLOT .ADJS ADJS-COUNT> 1>>
	<COND (<EQUAL? .ADJ ,W?INT.NUM>
	       <RETURN ,P-NUMBER>)
	      (<SET ADJ <INTBL? .ADJ ,INTEGERS <GET ,INTEGERS 0>>>
	       <RETURN </ <- .ADJ ,INTEGERS> 2>>)>>

<ROUTINE VIAL-F ("AUX" NUM PRSO-VIAL-GLOOPS PRSI-VIAL-GLOOPS ADJ)
	 <COND (<PRSO? ,SMALL-VIAL>
		<SET PRSO-VIAL-GLOOPS ,SMALL-VIAL-GLOOPS>)
	       (T
		<SET PRSO-VIAL-GLOOPS ,LARGE-VIAL-GLOOPS>)>
	 <COND (,PRSI
		<COND (<PRSI? ,SMALL-VIAL>
		       <SET PRSI-VIAL-GLOOPS ,SMALL-VIAL-GLOOPS>)
		      (T
		       <SET PRSI-VIAL-GLOOPS ,LARGE-VIAL-GLOOPS>)>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The vial ">
		<COND (<EQUAL? .PRSO-VIAL-GLOOPS 0>
		       <TELL "is empty">)
		      (T
		       <TELL "contains ">
		       <COND (<OR <AND <PRSO? ,LARGE-VIAL>
				       ,LARGE-VIAL-IMPRECISE>
				  <AND <PRSO? ,SMALL-VIAL>
				       ,SMALL-VIAL-IMPRECISE>>
			      <TELL "approximately ">)>
		       <TELL N .PRSO-VIAL-GLOOPS " gloop">
		       <COND (<NOT <EQUAL? .PRSO-VIAL-GLOOPS 1>>
			      <TELL "s">)>
		       <TELL " of water">)>
		<TELL ".">
		<COND (<VERB? EXAMINE>
		       <TELL " There is some writing etched onto it.">)>
		<CRLF>)
	       (<VERB? READ>
		<TELL "\"Frobozz Magic Vial Company. Capacity (to the brim): ">
		<COND (<PRSO? ,LARGE-VIAL>
		       <TELL "9">)
		      (T
		       <TELL "4">)>
		<TELL " gloops.\"" CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,LARGE-VIAL>
		     <PRSI? ,SICKLY-WITCH ,PRICKLY-WITCH>>
		<COND (<EQUAL? ,LARGE-VIAL-GLOOPS 6>
		       <COND (<OR ,LARGE-VIAL-TAINTED
				  ,LARGE-VIAL-IMPRECISE>
			      <TELL
"The witch examines the water, grows angry, and flings it
out of the vial. \"This is not ">
			      <COND (,LARGE-VIAL-TAINTED
				     <TELL "pure Oasis water">)
				    (T
				     <TELL "precisely 6 gloops">)>
			      <SETG LARGE-VIAL-TAINTED <>>
			      <SETG LARGE-VIAL-GLOOPS 0>
			      <REMOVE ,LARGE-VIAL-WATER>
			      <TELL
"! You thought we would not know, fool?\" She throws the vial back at you.
\"Do not return until you have done EXACTLY as we ask.\"" CR>)
			     (T
		       	      <REMOVE ,LARGE-VIAL>
			      <SETG VIAL-GIVEN T>
			      <TELL
"\"You have done well,\" croak the witches. \"We shall do as we promised.\"|
   \"Hair of hellhound!\" calls the sickly witch. The prickly witch rummages
around and hands her a clump of coarse black fur.|
   \"Toenail of tarantula!\" The prickly witch produces half a handful of
clippings.|
   \"Spleen of troll!\" The prickly witch hands over a wrinkled organ, caked
with dried blood.|
   \"Earwax of brogmoid!">
			      <COND (,EARWAX-GIVEN
				     <FCLEAR ,BAT ,TRYTAKEBIT>
				     <TELL ,FINISH-ENCHANTMENT>)
				    (T
				     <TELL
"\" The prickly witch rummages around the cave, mumbling with increasing
irritation. \"Earwax of yipple. Earwax of sea slug. Earwax of adventurer.
Carbuncle of brogmoid. Belly-button lint of brogmoid.\" She shakes her head
sadly. \"No earwax of brogmoid. I think we used it up last month... you
remember... when we conjured up that male stripper...\"|
   The sickly witch turns to you. \"Sorry, we cannot remove the enchantment
until you bring us some brogmoid earwax.\"" CR>)>)>)
		      (T
		       <TELL
"\"We asked you for 6 gloops!\" screams the witch. \"No less, no more! Begone,
and return not until you do what we ask!\" A fiery bolt shoots from the witches
fingers, missing your rump by inches as you scurry from the cave." CR CR>
		       <GOTO ,AERIE>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,SMALL-VIAL ,LARGE-VIAL>>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 2>
			      <TELL "The mouth of the vial is too narrow." CR>)
			     (T
			      <WASTES>)>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,WATER>>
		<PERFORM ,V?FILL ,PRSO ,WATER>
		<RTRUE>)
	       (<VERB? FILL>
		<COND (<PRSI? ,OASIS-OBJECT ,LAKE-FLATHEAD>
		       <SETG PRSI ,WATER>)>
		<COND (<PRSI? ,WATER>
		       <COND (<OR <AND <PRSO? ,SMALL-VIAL>
				       <EQUAL? ,SMALL-VIAL-GLOOPS 4>>
				  <AND <PRSO? ,LARGE-VIAL>
				       <EQUAL? ,LARGE-VIAL-GLOOPS 9>>>
			      <TELL
"The " D ,PRSO " is already filled to the brim!" CR>)
			     (<NOT <IN? ,PROTAGONIST ,HERE>>
			      <CANT-REACH ,WATER>)
			     (<PRSO? ,SMALL-VIAL>
			      <COND (<NOT <EQUAL? ,HERE ,OASIS>>
				     <SETG SMALL-VIAL-TAINTED T>)>
			      <COND (<AND <NOUN-USED? ,WATER
						      ,W?GLOOP ,W?GLOOPS>
					  <NOT <ADJ-USED? ,WATER <>>>
					  <SET ADJ <FIND-ADJS ,FINDER>>
					  <SETG P-NUMBER <CONVERT-NUMBER .ADJ>>
					  <L? ,P-NUMBER 4>
					  <G? ,P-NUMBER 0>>
				     <SETG SMALL-VIAL-GLOOPS ,P-NUMBER>
				     <SETG SMALL-VIAL-IMPRECISE T>
				     <TELL "You fill">
				     <NO-GRADATIONS ,P-NUMBER>)
				    (T
				     <SETG SMALL-VIAL-IMPRECISE <>>
			      	     <SETG SMALL-VIAL-GLOOPS 4>
			      	     <MOVE ,SMALL-VIAL-WATER ,SMALL-VIAL>
				     <TELL
"You fill the vial to the brim." CR>)>)
			     (T ;"PRSO is large vial"
			      <COND (<NOT <EQUAL? ,HERE ,OASIS>>
				     <SETG LARGE-VIAL-TAINTED T>)>
			      <COND (<AND <NOUN-USED? ,WATER
						      ,W?GLOOP ,W?GLOOPS>
					  <NOT <ADJ-USED? ,WATER <>>>
					  <SET ADJ <FIND-ADJS ,FINDER>>
					  <SETG P-NUMBER <CONVERT-NUMBER .ADJ>>
					  <L? ,P-NUMBER 9>
					  <G? ,P-NUMBER 0>>
				     <SETG LARGE-VIAL-GLOOPS ,P-NUMBER>
				     <SETG LARGE-VIAL-IMPRECISE T>
				     <TELL "You fill">
				     <NO-GRADATIONS ,P-NUMBER>)
				    (T
			      	     <SETG LARGE-VIAL-IMPRECISE <>>
			      	     <SETG LARGE-VIAL-GLOOPS 9>
			      	     <MOVE ,LARGE-VIAL-WATER ,LARGE-VIAL>
			      	     <TELL
"You fill the vial to the brim." CR>)>)>)
		      (<AND <PRSO? ,SMALL-VIAL>
			    <PRSI? ,LARGE-VIAL>>
		       <POUR-VIALS ,LARGE-VIAL ,SMALL-VIAL>)
		      (<AND <PRSO? ,LARGE-VIAL>
			    <PRSI? ,SMALL-VIAL>>
		       <POUR-VIALS ,SMALL-VIAL ,LARGE-VIAL>)>)
	       (<AND <VERB? POUR>
		     <PRSO? ,SMALL-VIAL ,LARGE-VIAL>>
		<PERFORM ,V?EMPTY ,PRSO ,PRSI>
		<RTRUE>)
	       (<VERB? EMPTY>
		<COND (<EQUAL? .PRSO-VIAL-GLOOPS 0>
		       <TELL "The vial is already empty!" CR>)
		      (<AND <PRSO? ,SMALL-VIAL>
			    <PRSI? ,LARGE-VIAL>>
		       <POUR-VIALS ,SMALL-VIAL ,LARGE-VIAL>)
		      (<AND <PRSI? ,SMALL-VIAL>
			    <PRSO? ,LARGE-VIAL>>
		       <POUR-VIALS ,LARGE-VIAL ,SMALL-VIAL>)
		      (T
		       <COND (<NOT ,PRSI>
			      <SET-GROUND-DESC>
			      <SETG PRSI ,GROUND>)>
		       <COND (<PRSO? ,SMALL-VIAL>
			      <PRINT-GLOOP ,SMALL-VIAL-GLOOPS>
			      <SETG SMALL-VIAL-TAINTED <>>
			      <SETG SMALL-VIAL-IMPRECISE <>>
			      <SETG SMALL-VIAL-GLOOPS 0>
			      <REMOVE ,SMALL-VIAL-WATER>)
			     (T
			      <PRINT-GLOOP ,LARGE-VIAL-GLOOPS>
			      <SETG LARGE-VIAL-TAINTED <>>
			      <SETG LARGE-VIAL-IMPRECISE <>>
			      <SETG LARGE-VIAL-GLOOPS 0>
			      <REMOVE ,LARGE-VIAL-WATER>)>
		       <COND (<AND <PRSI? ,BOWL ,ELIXIR>
				   <IN? ,ELIXIR ,BOWL>>
			      <REMOVE ,ELIXIR>
			      <TELL
" The water and elixir undergo a reaction, and both
disappear in a cloud of smoke!" CR>)
			     (<PRSI? ,CUP>
			      <PERFORM ,V?FILL ,CUP ,WATER>
			      <RTRUE>)
			     (T
		       	      <TELL
" The water spills all over" T ,PRSI " and then evaporates. The " D ,PRSO
" is now empty." CR>)>)>)
	       (<AND <VERB? EMPTY-FROM TAKE ;"REMOVE">
		     <PRSO? ,WATER>>
		<COND (<SET NUM <GET-NP ,PRSO>>
		       <SET NUM <NUMERIC-ADJ? .NUM>>)>
		<COND (<AND <ZERO? .NUM>
			    <SET NUM <NP-ADJS <GET-NP ,PRSO>>>>
		       <SET NUM <CONVERT-NUMBER .NUM>>)>
		<COND (<NOT .NUM>
		       <SET NUM .PRSI-VIAL-GLOOPS>)>
		<COND (<EQUAL? .PRSI-VIAL-GLOOPS 0>
		       <TELL "The vial is empty!" CR>)
		      (<G? .NUM .PRSI-VIAL-GLOOPS>
		       <TELL "There ">
		       <COND (<NOT <EQUAL? .PRSI-VIAL-GLOOPS 1>>
			      <TELL "are">)
			     (T
			      <TELL "is">)>
		       <TELL " only " N .PRSI-VIAL-GLOOPS " gloop">
		       <COND (<NOT <EQUAL? .PRSI-VIAL-GLOOPS 1>>
			      <TELL "s">)>
		       <TELL " in" TR ,PRSI>)
		      (T
		       <PRINT-GLOOP .NUM>
		       <SET PRSI-VIAL-GLOOPS <- .PRSI-VIAL-GLOOPS .NUM>>
		       <COND (<EQUAL? .PRSI-VIAL-GLOOPS 0>
			      <COND (<PRSI? ,LARGE-VIAL>
				     <SETG LARGE-VIAL-GLOOPS 0>
				     <SETG LARGE-VIAL-IMPRECISE <>>
				     <SETG LARGE-VIAL-TAINTED <>>
				     <REMOVE ,LARGE-VIAL-WATER>)
				    (T
				     <SETG SMALL-VIAL-GLOOPS 0>
				     <REMOVE ,SMALL-VIAL-WATER>
				     <SETG SMALL-VIAL-IMPRECISE <>>
				     <SETG SMALL-VIAL-TAINTED <>>)>
			      <TELL " You completely empty" TR ,PRSI>)
			     (T
			      <COND (<PRSI? ,LARGE-VIAL>
				     <SETG LARGE-VIAL-GLOOPS
					   <- ,LARGE-VIAL-GLOOPS .NUM>>
				     <MOVE ,LARGE-VIAL-WATER ,LARGE-VIAL>
				     <SETG LARGE-VIAL-IMPRECISE T>)
				    (T
				     <SETG SMALL-VIAL-GLOOPS
					   <- ,SMALL-VIAL-GLOOPS .NUM>>
				     <MOVE ,SMALL-VIAL-WATER ,SMALL-VIAL>
				     <SETG SMALL-VIAL-IMPRECISE T>)>
			      <TELL " You pour">
			      <NO-GRADATIONS .PRSI-VIAL-GLOOPS>)>)>)>>

<ROUTINE NO-GRADATIONS (VIAL-GLOOPS)
	 <TELL
" as carefully as you can, and it appears to the naked eye that there ">
	 <COND (<NOT <EQUAL? .VIAL-GLOOPS 1>>
		<TELL "are">)
	       (T
		<TELL "is">)>
	 <TELL " now " N .VIAL-GLOOPS " gloop">
	 <COND (<NOT <EQUAL? .VIAL-GLOOPS 1>>
		<TELL "s">)>
	 <TELL " in the vial. However, since there are no gradations on
the vial, it's impossible to be certain." CR>>

<ROUTINE PRINT-GLOOP (NUM)
	 <TELL "\"">
	 <REPEAT ()
		 <TELL "Gloop!">
		 <SET NUM <- .NUM 1>>
		 <COND (<L? .NUM 1>
			<RETURN>)
		       (T
			<TELL " ">)>>
	 <TELL "\"">>

<ROUTINE POUR-VIALS (FROM-VIAL TO-VIAL "AUX" SPARE-ROOM)
	 <COND (<EQUAL? .TO-VIAL ,LARGE-VIAL>
		<SET SPARE-ROOM <- 9 ,LARGE-VIAL-GLOOPS>>)
	       (T
		<SET SPARE-ROOM <- 4 ,SMALL-VIAL-GLOOPS>>)>
	 <COND (<EQUAL? .SPARE-ROOM 0>
		<TELL "But" T .TO-VIAL " is already filled to the brim!" CR>)
	       (<EQUAL? .FROM-VIAL ,LARGE-VIAL>
		<COND (<G? ,LARGE-VIAL-GLOOPS .SPARE-ROOM>
		       <COND (,LARGE-VIAL-TAINTED
			      <SETG SMALL-VIAL-TAINTED T>)>
		       <PRINT-GLOOP .SPARE-ROOM>
		       <SETG LARGE-VIAL-GLOOPS
			     <- ,LARGE-VIAL-GLOOPS .SPARE-ROOM>>
		       <MOVE ,LARGE-VIAL-WATER ,LARGE-VIAL>
		       <COND (,SMALL-VIAL-IMPRECISE
			      <SETG LARGE-VIAL-IMPRECISE T>)>
		       <SETG SMALL-VIAL-IMPRECISE <>>
		       <SETG SMALL-VIAL-GLOOPS 4>
		       <MOVE ,SMALL-VIAL-WATER ,SMALL-VIAL>
		       <TELL
" The " D .TO-VIAL " is now filled to the brim." CR>)
		      (T
		       <PRINT-GLOOP ,LARGE-VIAL-GLOOPS>
		       <COND (,LARGE-VIAL-TAINTED
			      <SETG SMALL-VIAL-TAINTED T>)>
		       <SETG SMALL-VIAL-GLOOPS
			     <+ ,SMALL-VIAL-GLOOPS ,LARGE-VIAL-GLOOPS>>
		       <MOVE ,SMALL-VIAL-WATER ,SMALL-VIAL>
		       <SETG LARGE-VIAL-GLOOPS 0>
		       <SETG LARGE-VIAL-TAINTED <>>
		       <REMOVE ,LARGE-VIAL-WATER>
		       <COND (,LARGE-VIAL-IMPRECISE
			      <SETG LARGE-VIAL-IMPRECISE <>>
			      <SETG SMALL-VIAL-IMPRECISE T>)>
		       <TELL
" The " D ,LARGE-VIAL " has been completely emptied into" TR ,SMALL-VIAL>)>)
	       (<G? ,SMALL-VIAL-GLOOPS .SPARE-ROOM>
		<COND (,SMALL-VIAL-TAINTED
		       <SETG LARGE-VIAL-TAINTED T>)>
		<PRINT-GLOOP .SPARE-ROOM>
		<SETG SMALL-VIAL-GLOOPS <- ,SMALL-VIAL-GLOOPS .SPARE-ROOM>>
		<MOVE ,SMALL-VIAL-WATER ,SMALL-VIAL>
		<SETG LARGE-VIAL-GLOOPS 9>
		<MOVE ,LARGE-VIAL-WATER ,LARGE-VIAL>
		<COND (,LARGE-VIAL-IMPRECISE
		       <SETG SMALL-VIAL-IMPRECISE T>)>
		<SETG LARGE-VIAL-IMPRECISE <>>
		<TELL " The " D ,LARGE-VIAL " is now filled to the brim." CR>)
	       (T
		<COND (,SMALL-VIAL-TAINTED
		       <SETG LARGE-VIAL-TAINTED T>)>
		<PRINT-GLOOP ,SMALL-VIAL-GLOOPS>
		<SETG LARGE-VIAL-GLOOPS
		      <+ ,LARGE-VIAL-GLOOPS ,SMALL-VIAL-GLOOPS>>
		<MOVE ,LARGE-VIAL-WATER ,LARGE-VIAL>
		<SETG SMALL-VIAL-GLOOPS 0>
		<REMOVE ,SMALL-VIAL-WATER>
		<COND (,SMALL-VIAL-IMPRECISE
		       <SETG LARGE-VIAL-IMPRECISE T>)>
		<SETG SMALL-VIAL-IMPRECISE <>>
		<TELL
" The " D ,SMALL-VIAL " has been completely emptied into" TR ,LARGE-VIAL>)>>

<END-SEGMENT>

<BEGIN-SEGMENT ORACLE>

<ROOM RUBBLE-ROOM
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Rubble Room")
      (LDESC
"You are just within the mouth of a granola mine. Daylight is visible to the
west. Tunnels wind downward to the north, northeast, and east. Chunks of
loose rubble, disturbed by the first visitor since the granola riots, fall
from the roof of the mine.")
      (WEST TO MINE-ENTRANCE)
      (OUT TO MINE-ENTRANCE)
      (EAST TO HEART-OF-MINE)
      (NORTH TO HEART-OF-MINE)
      (NE TO HEART-OF-MINE)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (GLOBAL GRANOLA GRANOLA-MINE)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-9>)
      (ACTION RUBBLE-ROOM-F)>

<GLOBAL RUBBLE-SCORE 9>

<ROUTINE RUBBLE-ROOM-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-END>
		<RETURN-FROM-MAP>
		<TELL "   ">
		<COND (<FSET? ,HARDHAT ,WORNBIT>
		       <TELL
"Clunk! A bit of rubble bounces off your hardhat." CR>
		       <INC-SCORE ,RUBBLE-SCORE>
		       <SETG RUBBLE-SCORE 0>
		       <RTRUE>)
		      (T
		       <JIGS-UP "A piece of rubble lands on your head.">)>)>>

<ROOM HEART-OF-MINE
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Heart of Mine")
      (LDESC
"You are in a major granola mine. Half-mined granola is everywhere. The remains
of a vast transportation system lies in ruins. Tunnels wind south, southwest,
and west, and a tiny half-buried tunnel leads downward to the north.")
      (SOUTH TO RUBBLE-ROOM)
      (SW TO RUBBLE-ROOM)
      (WEST TO RUBBLE-ROOM)
      (NORTH TO CRAWL)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (GLOBAL GRANOLA GRANOLA-MINE)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-10>)>

<ROOM CRAWL
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Crawl")
      (LDESC
"You are in a poorly dug tunnel, not even tall enough to stand up in. The
tunnel curves slightly, running from south to northwest.")
      (SOUTH TO HEART-OF-MINE)
      (NW TO DEAD-END)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (GLOBAL GRANOLA GRANOLA-MINE)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-10>)>

<OBJECT CRAWL-REBUS-BUTTON
	(LOC CRAWL)
	(SDESC "blinking key-shaped button")
	(FDESC
"Imbedded in the rocky wall is a blinking button in the shape of a key.")
	(SYNONYM BUTTON)
	(ADJECTIVE KEY-SHAPED BLINKING)
	(ACTION REBUS-BUTTON-F)>

<ROOM DEAD-END
      (LOC ROOMS)
      (REGION "Antharia")
      (DESC "Dead End")
      (LDESC
"The low tunnel ends here in a small cul-de-sac. The way back is southeast.")
      (SE TO CRAWL)
      (OUT TO CRAWL)
      (FLAGS RLANDBIT BEYONDBIT UNDERGROUNDBIT)
      (GLOBAL GRANOLA GRANOLA-MINE)
      (MAP-LOC <PTABLE ANTHARIA-MAP-NUM MAP-GEN-Y-1 MAP-GEN-X-9>)
      (ICON DEAD-END-ICON)>

<OBJECT QUILL-PEN
	(LOC DEAD-END)
	(DESC "quill pen")
	(SYNONYM PEN QUILL)
	(ADJECTIVE QUILL)
	(VALUE 12)
	(SIZE 3)
	(FLAGS TAKEBIT MAGICBIT)>

<OBJECT GRANOLA-MINE
	(LOC LOCAL-GLOBALS)
	(DESC "granola mine")
	(SYNONYM MINE)
	(ADJECTIVE GRANOLA)
	(RESEARCH
"\"The granola mines in northern Antharia once supplied seemingly limitless
quantities of granola. Since the Granola Riots of 865 GUE, the causes of
which are well known, the output of the mines has fallen sharply.\"")
	(ACTION GRANOLA-MINE-F)>

<ROUTINE GRANOLA-MINE-F ()
	 <COND (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,MINE-ENTRANCE>
		       <DO-WALK ,P?IN>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<NOT <EQUAL? ,HERE ,MINE-ENTRANCE>>
		<PERFORM-PRSA ,GLOBAL-HERE>)>>

<OBJECT GRANOLA
	(LOC LOCAL-GLOBALS)
	(DESC "granola")
	(SYNONYM GRANOLA)
	(FLAGS NARTICLEBIT)
	(RESEARCH
"\"The granola mines in northern Antharia once supplied seemingly limitless
quantities of granola. Since the Granola Riots of 865 GUE, the causes of
which are well known, the output of the mines has fallen sharply.\"")
	(ACTION GRANOLA-F)>

<ROUTINE GRANOLA-F ()
	 <COND (<VERB? EXAMINE>
		<STEP-IN-IT "looks">)
	       (<VERB? EAT TASTE>
		<STEP-IN-IT "tastes">)
	       (<VERB? SMELL>
		<STEP-IN-IT "smells">)
	       (<VERB? STAND-ON ENTER>
		<TELL "Oh, yechh!" CR>)
	       (<TOUCHING? ,GRANOLA>
		<STEP-IN-IT "feels">)>>

<ROUTINE STEP-IN-IT (STRING)
	 <TELL
"It " .STRING " just like granola. Good thing you didn't step in it." CR>>