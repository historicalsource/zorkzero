"JESTER for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT 0>

<OBJECT JESTER
	(DESC "jester")
	(DESCFCN JESTER-F)
	(SYNONYM JESTER JESTERS JOKER MAN)
	(FLAGS ACTORBIT SEARCHBIT CONTBIT OPENBIT ANIMATEDBIT)
	(ACTION JESTER-F)>

<ROUTINE JESTER-F ("OPT" (ARG <>))
	 <COND (<EQUAL? .ARG ,M-OBJDESC?>
		<RTRUE>)
	       (<EQUAL? .ARG ,M-OBJDESC>
		<TELL "   The jester ">
		<COND (<IN? ,COOKPOT ,HERE>
		       <TELL "is here, " ,COOK-DESC>)
		      (<AND <EQUAL? ,HERE ,TAX-OFFICE>
			    <IN? ,ZORKMID-COIN ,LOCAL-GLOBALS>>
		       <TELL ,BOOKKEEPER-DESC>)
		      (,J-ON-RAFT
		       <TELL
"lies on an inner tube. His eyes twinkle at you behind his sunglasses.">)
		      (T
		       <TELL
"is nearby, watching you with great amusement.">)>)
	       (<EQUAL? .ARG ,M-WINNER>
		<COND (<AND <VERB? SAY>
			    <EQUAL? ,HERE ,ENTRANCE-HALL>
			    <NOT <FSET? ,PORTCULLIS ,OPENBIT>>>
			<RFALSE>)
		       (<AND <VERB? SAY>
			     <IN? ,EAST-KEY ,JESTER>>
			<RFALSE>)
		       (<AND <VERB? SAY>
			     <EQUAL? ,HERE ,OUBLIETTE>>
			<RFALSE>)
		       (T
			<TELL
"\"Don't waste your breath, for I'd go to any length to avoid a
conversation with such depth as yours. Also, silence is the height
of fashion nowadays.\"" CR>
			<STOP>)>)
	       (<VERB? EXAMINE>
		<COND (,J-ON-RAFT
		       <TELL
"The jester is wearing dark glasses and floating around on an inner tube." CR>)
		      (<IN? ,COOKPOT ,HERE>
		       <TELL "The jester is " ,COOK-DESC CR>)
		      (<AND <EQUAL? ,HERE ,TAX-OFFICE>
			    <IN? ,ZORKMID-COIN ,LOCAL-GLOBALS>>
		       <TELL "The jester is " ,BOOKKEEPER-DESC CR>)
		      (<FSET? ,GOGGLES ,WORNBIT>
		       <TELL
,YOU-SEE " right through the jester's clothes as though they were
transparent! Embarassed, you turn away. (But not before noticing that
the jester has pink butterflies stitched onto his underwear.)" CR>)
		      (T
		       <TELL
"The jester is dressed in a green skin-tight suit, and is wearing a hat
with many pointy ends. From each end dangles a gaudy little bell. The
jester's eyes twinkle with mischievous energy." CR>)>)
	       (<AND <VERB? GIVE SHOW>
		     <EQUAL? ,HERE ,MARSH ,NICE-LUNCH-SPOT>
		     <PRSO? ,WORM ,ROOSTER ,FOX>>
		<TELL
"\"Mon Dieu! I must have all zee ingredients together!\"" CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,PIGEON>>
		<COND (<EQUAL? <META-LOC ,PERCH> ,HERE>
		       <TELL
"The jester takes the pigeon, looks it over, shrugs, and hands it back." CR>)
		      (T
		       <TELL
"The jester recedes to a point and vanishes, a look of comical surprise
splattered across his wide face.">
		       <COND (<IN? ,SHELL-TABLE ,HERE>
			      <TELL
" The table and shells disappear as well.">)>
		       <CRLF>
		       <REMOVE-J>
		       <SETG J-DISPOSED ,MOVES>
		       <COND (<LOC ,PERCH>
			      <MOVE ,PIGEON <LOC ,PERCH>>)
			     (T
			      <REMOVE ,PIGEON>)>
		       <RFATAL>)>)
	       (<VERB? SHOW>
		<COND (<PRSO? ,NUT>
		       <COND (,NUT-OPENED
			      <SETG NUT-SHOWN T>
			      <TELL
"\"True, no one has seen this 'ere me -- but thousands
may see it in years to be!\"" CR>)
			     (T
			      <TELL
"\"Uncertain and skeptical I must be; countless people
may have gazed upon this before me.\"" CR>)>)
		      (<PRSO? ,NUT-SHELL ,UNOPENED-NUT>
		       <TELL "The jester cocks one eyebrow">
		       <COND (<EQUAL? ,HERE ,WEST-WING>
			      <TELL
" and a smile dances at the corners of his mouth">)>
		       <TELL ,PERIOD-CR>)>)
	       (<AND <VERB? EAT KILL>
		     ,ALLIGATOR>
		<TELL
"The jester jumps nimbly away from your snapping jaws." CR>)
	       (<VERB? RESEARCH>
		<PICTURED-ENTRY ,J-ILL <>>)>>

<BEGIN-SEGMENT CASTLE>

<ROUTINE J-ENTRY ()
	 <TELL
"\"Jesters employ physical, verbal, and magical trickery for the entertainment
of king and court. The most recent Royal Jester, the favorite of Lord Wurb
Flathead, is named Barbazzo " <GET ,MID-NAMES ,MID-NAME-NUM> " Fernap.\"" CR>>

<GLOBAL MID-NAME-NUM <>>

<CONSTANT MID-NAMES
	<PTABLE "Hideoz"
	       "Bivotar"
	       "Urgwitz"
	       "Foofoonap"
	       "Elderbar"
	       "Goozums"
	       "Syovar"
	       "Buck"
	       "Spike"
	       "Zippy"
	       "Magglebar"
	       "Barfoo">>

<END-SEGMENT>

<BEGIN-SEGMENT 0>

<CONSTANT MID-NAME-WORDS
	<PTABLE <VOC "HIDEOZ" NOUN>
	       <VOC "BIVOTAR" NOUN>
	       <VOC "URGWITZ" NOUN>
	       <VOC "FOOFOONAP" NOUN>
	       <VOC "ELDERBAR" NOUN>
	       <VOC "GOOZUMS" NOUN>
	       <VOC "SYOVAR" NOUN>
	       <VOC "BUCK" NOUN>
	       <VOC "SPIKE" NOUN>
	       <VOC "ZIPPY" NOUN>
	       <VOC "MAGGLEBAR" NOUN>
	       <VOC "BARFOO" NOUN>>>

<OBJECT MID-NAME
	(LOC GLOBAL-OBJECTS)
	(DESC "middle name")
	(SYNONYM HIDEOZ BIVOTAR URGWITZ FOOFOONAP ELDERBAR GOOZUMS
	 	 SYOVAR BUCK SPIKE ZIPPY MAGGLEBAR BARFOO)
	(ACTION MID-NAME-F)>

<ROUTINE MID-NAME-F ()
	<COND (<AND <VISIBLE? ,JESTER>
		    <NOUN-USED? ,MID-NAME <GET ,MID-NAME-WORDS ,MID-NAME-NUM>>>
	       <PERFORM-PRSA ,JESTER>)
	      (<OR <HANDLE ,MID-NAME>
		   <VERB? FOLLOW>>
	       <TELL ,BY-THAT-NAME>
	       <STOP>)>>

<OBJECT OTHER-J-NAMES
	(LOC GLOBAL-OBJECTS)
	(DESC "jester's name")
	(SYNONYM BARBAZZO FERNAP)
	(ACTION OTHER-J-NAMES-F)>

<ROUTINE OTHER-J-NAMES-F ()
	 <COND (<VISIBLE? ,JESTER>
		<PERFORM-PRSA ,JESTER>)
	       (<OR <HANDLE ,OTHER-J-NAMES>
		    <VERB? FOLLOW>>
		<TELL ,BY-THAT-NAME>
		<STOP>)>>

<OBJECT J-POCKET
	(LOC JESTER)
	(DESC "jester's pocket")
	(SYNONYM POCKET)
	(ADJECTIVE HIS JESTER\'S)
	(OWNER JESTER)
	(FLAGS NDESCBIT)
	(ACTION J-GARMENT-F)>

<OBJECT J-HAT
	(LOC JESTER)
	(DESC "jester's hat")
	(SYNONYM HAT BELL BELLS)
	(ADJECTIVE HIS JESTER\'S SMALL GAUDY)
	(OWNER JESTER)
	(FLAGS NDESCBIT)
	(GENERIC G-HAT-F)
	(ACTION J-GARMENT-F)>

<OBJECT J-SHOE
	(LOC JESTER)
	(DESC "jester's shoe")
	(SYNONYM SHOE)
	(ADJECTIVE HIS JESTER\'S)
	(OWNER JESTER)
	(FLAGS NDESCBIT)
	(ACTION J-GARMENT-F)>

<ROUTINE J-GARMENT-F ()
	 <COND (<AND <PRSO? ,J-HAT ,J-SHOE ,J-POCKET>
		     <TOUCHING? ,PRSO>>
		<TELL "The jester dances spryly out of reach." CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE LOOK-UNDER>
		     <IN? ,ZORKMID-BILL ,PRSO>
		     <FSET? ,GOGGLES ,WORNBIT>>
		<TELL
,YOU-SEE " right through" T ,PRSO " as if it were made of glass -- and
sure enough, there's the zorkmid bill!" CR>)
	       (<AND <VERB? EXAMINE>
		     <PRSO? ,J-HAT>>
		<TELL
"It has many floppy tips, with bells dangling from each one." CR>)
	       (<AND <VERB? POINT>
		     <EQUAL? ,HERE ,GAMING-ROOM>
		     <NOT <FSET? ,ZORKMID-BILL ,TOUCHBIT>>>
		<COND (<IN? ,ZORKMID-BILL ,PRSO>
		       <MOVE ,ZORKMID-BILL ,PROTAGONIST>
		       <FSET ,ZORKMID-BILL ,TOUCHBIT>
		       <TELL
"The jester looks sheepish. He removes the bill and hands it to you.
\"You're pretty slick; you've discovered my trick.\"">
		       <J-EXITS>
		       <INC-SCORE 12>
		       <RTRUE>)
		      (T
		       <TELL "The jester howls with glee, and ">
		       <COND (<PRSO? ,J-POCKET>
			      <TELL "turns his pocket inside out">)
			     (<PRSO? ,J-HAT>
			      <TELL "removes his hat">)
			     (T
			      <TELL "removes his shoe">)>
		       <TELL ". Nothing. ">
		       <ANOTHER-SHELL-GAME>)>)>>

<OBJECT J-SUIT
	(LOC JESTER)
	(DESC "jester's suit")
	(SYNONYM SUIT)
	(ADJECTIVE GREEN SKIN-TIGHT)
	(OWNER JESTER)
	(FLAGS NDESCBIT)>

<ROUTINE I-JESTER ("OPTIONAL" (CALLED-BY-DOORBELL <>) "AUX" PLUR APPEAR-PROB)
	 <COND (,TIME-STOPPED
		<DEQUEUE I-JESTER>
		<RFALSE>)>
	 <SET APPEAR-PROB ,J-APPEAR-PROB>
	 <COND (<EQUAL? ,HERE ,FR-OFFICES ,OFFICES-WEST ,OFFICES-EAST
			      ,OFFICES-NORTH ,OFFICES-SOUTH>
		<SET APPEAR-PROB
		     </ .APPEAR-PROB </ <+ ,FLOOR-NUMBER 40> 40>>>)>
	 <QUEUE I-JESTER -1>
	 <COND (<OR <IN? ,PROTAGONIST ,DB>
		    <EQUAL? ,HERE ,INQUISITION ,PLAIN>
		    <AND <EQUAL? ,HERE ,ENTRANCE-HALL>
			 <NOT <FSET? ,PORTCULLIS ,OPENBIT>>
			 <NOT .CALLED-BY-DOORBELL>>>
		<QUEUE I-JESTER <RANDOM 5>>
		<RFALSE>)
	       (<NOT ,LIT>
		<QUEUE I-JESTER <RANDOM 5>>
		<RETURN-FROM-MAP>
		<TELL
"   You hear jingling bells and a familiar laugh in the darkness.">
		<COND (<NOT <FSET? ,SECRET-PASSAGE ,TOUCHBIT>>
		       <TELL
" \"Trouble finding a light? I'm just the man to set you right! Tighten your
belt and pull up your socks and re-read the book from your ZORK ZERO box!
Or,\" the voice asks suspiciously, \"maybe you're one of those software
pirates? In that case, I hope you fall into a bottomless pit.\"">)>
		<TELL CR>
		<RTRUE>)
	       (<OR ,DO-J
		    <PROB .APPEAR-PROB>>
		<SETG DO-J <>>)
	       (T
		<SETG J-APPEAR-PROB <+ ,J-APPEAR-PROB 1>>
		<RFALSE>)> 
	 <DEQUEUE I-JESTER> ;"so he doesn't appear while he's already here"
	 <RETURN-FROM-MAP>
	 <TELL "   ">
	 <COND (<IN? ,JESTER ,HERE> ;"example: going west from West Wing twice"
		T)
	       (,TURNED-INTO
		<REMOVE-J>
		<TELL
"You suddenly notice another " D ,TURNED-INTO ", wearing a jester's costume.
Laughing, it says, \"I'd heard that there was a dauntless adventurer around,
but there's no one here but us ">
		<COND (<SET PLUR <GETP ,TURNED-INTO ,P?PLURAL>>
		       <TELL .PLUR>)
		      (T
		       <TELL D ,TURNED-INTO "s">)>
		<TELL
"!\" Still laughing, the jester/" D ,TURNED-INTO " vanishes." CR>
		<RTRUE>)
	       (<VISIBLE? ,OTTO>
		<TELL
"You spot a fly wearing a tiny floppy green hat with bells at the tips. Otto
spots the fly as well, and begins to salivate. In a high, thin imitation of
the jester's voice, the fly cries \"Help me!\" -- but Otto's tongue moves
before you can, and in a split-second the jester/fly is gonzo.">
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,YACHT>
		<SETG J-ON-RAFT T>
		<TELL
"You notice the jester, floating next to the yacht in an inner tube,
wearing sunglasses and lots of tanning lotion.">)
	       (<FSET? ,JESTER ,TOUCHBIT>
		<TELL "The jester appears.">
		<COND (<AND <EQUAL? ,HERE ,ICKY-CAVE>
			    <IN? ,SICKLY-WITCH ,HERE>>
		       <TELL ,WITCH-REMOVES-J>
		       <RTRUE>)
		      (<FSET? ,HERE ,BEYONDBIT>
		       <TELL " \"Hi! Small world, isn't it!\"">)>)
	       (T
		<FSET ,JESTER ,TOUCHBIT>
		<TELL
"You suddenly notice a wiry fellow with an outrageous costume and a
feral grin. \"I'm the jester of the castle, I may pester, I may hassle;
and I often speak in rhyme, for it helps to pass the time!\"">)>
	 <MOVE ,JESTER ,HERE>
	 <THIS-IS-IT ,JESTER>
	 <COND (<AND <VERB? TAKE>
		     <PRSO? ,EAST-KEY>
		     <FSET? ,EAST-KEY ,TRYTAKEBIT>>
		<MOVE ,EAST-KEY ,JESTER>
		<TELL " He snatches the key before you can take it.">)
	       (<AND <EQUAL? ,HERE ,PITS>
		     <FSET? ,LANTERN ,TRYTAKEBIT>>
		<TELL
" He has an enormous slice of watermelon which he devours with juicy abandon,
rind and all, and then spits out a stream of pits, which land and turn into
even more bottomless pits. \"Don't you hate pits? I know I do!\"" CR>
		<RTRUE>)>
	 <TELL CR "   ">
	 <COND (<EQUAL? ,HERE ,ENTRANCE-HALL>
		<COND (<FSET? ,PORTCULLIS ,OPENBIT>
		       <TELL
"The jester looks at the open portcullis. \"Oh, right! My memory is no
longer so great; I've already opened this gate!\"">
		       <J-EXITS>)
		      (T
		       <SETUP-ORPHAN "answer">
		       <TELL
"\"If you're quick as a fiddle, and answer this riddle, you'll get what
you're hopin' -- the gate will be open!\" The jester clears his throat. \""
<GETP ,HERE ,P?RIDDLE> CR>)>)
	       (<IN? ,EAST-KEY ,JESTER>
		<SETUP-ORPHAN "answer">
		<TELL
"\"Before you get this key, you must answer this riddle for me!\" The jester
poses theatrically. \"" <GETP ,SOLAR ,P?RIDDLE> CR>)
	       (<EQUAL? ,HERE ,OUBLIETTE>
		<COND (<EQUAL? ,OUBLIETTE-SCORE 0>
		       <TELL
"\"Trapped again? Don't frown or fret! I'll help you leave the Oubliette! But
saving you is such a pain; please don't get stuck down here again!\"" CR CR>
		       <GOTO ,DUNGEON>)
		      (T
		       <SETUP-ORPHAN "answer">
		       <TELL
"\"Don't scream or shout, I'll get you out! But first my thirst for a
riddle must be twiddled!\" The jester coughs lightly and begins. \""
<GETP ,HERE ,P?RIDDLE> CR>)>)
	       (<AND <EQUAL? ,HERE ,WEST-WING>
		     <NOT ,NUT-EATEN>>
		<TELL ,ERE-YOU-PASS>)
	       (<AND <EQUAL? ,HERE ,GAMING-ROOM>
		     <NOT <FSET? ,ZORKMID-BILL ,TOUCHBIT>>>
		<MOVE ,SHELL-TABLE ,HERE>
		<TELL
"\"Blackjack... Fanucci... all too tame; let's play the old shell game!\" From
thin air, the jester produces a small table, three shells, and a zorkmid bill
of high denomination. He arranges the shells in a row on the table and places
the bill under the center shell. With hands that move in a dizzying blur, he
shuffles the order of the shells. \"Demonstrate your visual skill -- point to
the location of the zorkmid bill!\" He motions toward the shells, left,
center, and right.">
		<SEE-BILL?>
		<CRLF>)
	       (<EQUAL? ,HERE ,FR-PENTHOUSE>
		<TELL
"\"Your persistence will bring you wide renown; you've reached the four
hundredth floor! The hard part now is getting down -- I suggest that
you simply RESTORE!\"" CR>
		<J-EXITS>)
	       (<AND <PROB ,SLATE-PROB>
		     <IN? ,SLATE ,LOCAL-GLOBALS>>
		<MOVE ,SLATE ,PROTAGONIST>
		<TELL
"\"While cleaning my attic, I found some old haddock, a hammer and nails,
some barrels and pails, an old garden gate, and this silly old slate!\" He
hands you the slate.">
		<J-EXITS T>)
	       (<AND <PROB ,SCROLL-PROB>
		     <IN? ,SCROLL ,LOCAL-GLOBALS>>
		<COND (<FSET? <LOC ,PROTAGONIST> ,DROPBIT>
		       <MOVE ,SCROLL <LOC ,PROTAGONIST>>)
		      (T
		       <MOVE ,SCROLL ,HERE>)>
		<TELL
"\"I thought of no rhyme; my puzzle's on paper this time.\" He drops a
scroll by your feet.">
	        <J-EXITS T>) 
	       (<AND <PROB 25>
		     <NOT <FSET? ,HERE ,BEYONDBIT>>>
		<TELL
"\"I've learned from years of loyalty, spinning rhymes for this noble court,
that with the attention span of royalty, my poems must be short!\"">
		<J-EXITS>)
	       (T
		<TELL "The jester watches you with twinkling eyes." CR>)>
	 <SETG SLATE-PROB <+ ,SLATE-PROB 2>>
	 <SETG SCROLL-PROB <+ ,SCROLL-PROB 2>>>

;"('Appointment in Samaria'

'the lying tribesman and the truth-telling tribesman'

I just made up this puzzle as a variation on one of Lewis Carroll's,
and I want to make sure my own solution is correct and the only one.
Try solving it:
   'I once knew three sisters named Amy, Liz, and Gayle. At one point, the
sum of Amy's age and Liz's age equalled Gayle's age. Several years later,
the sum of Amy's age and Liz's age equalled twice Gayle's age. When Gayle
was 21, how old was Amy?'
   The only solution which satisfies both conditions is if the the three
sisters are triplets: the sums of Liz's and Amy's age would equal Gayle's
age at birth; later the sum of their ages would equal twice Gayle's age.
Therefore, when Gayle is 21, so is Amy.)"

<ROUTINE J-EXITS ("OPT" (JUST-DID-SLATE-OR-SCROLL <>)
		       "AUX" (DO-FUNNY-PAPER <>) (LIT? <>))
	 <REMOVE-J>
	 <COND (<AND <PROB ,FUNNY-PAPER-PROB>
		     <IN? ,FUNNY-PAPER ,LOCAL-GLOBALS>
		     <NOT .JUST-DID-SLATE-OR-SCROLL>>
		<SET DO-FUNNY-PAPER T>)>
	 <COND (<AND <PROB 15>
		     <NOT .DO-FUNNY-PAPER>>
		<TELL
" The jester winces at his rhyming, then shrugs. \"Oh, well, they can't all
be gems.\" In a wink, he is gone." CR>
		<RTRUE>)
	       (<AND <PROB 20>
		     <IN? ,PROTAGONIST ,HERE>
		     <NOT <EQUAL? ,HERE ,TORTURE-CHAMBER>>
		     <NOT .DO-FUNNY-PAPER>>
		<MOVE ,BEDBUG ,HERE>
		<SETG P-CONT -1> ;<RFATAL>
		<TELL
" The jester yawns and says, \"Think I'll catch some winks. Nighty night!
Don't let the bedbugs bite!\" As the jester vanishes, you hear the clicking
of giant mandibles." CR>
		<RTRUE>)>
	 <TELL
" The jester gives a cheerful wave of farewell and vanishes, saying, \"">
	 <COND (.DO-FUNNY-PAPER
		<QUEUE I-FUNNY-PAPER 2>
		<SETG FUNNY-PAPER-PROB 0>
		<TELL
"See you in the funny papers!\" A breeze begins picking up." CR>)
	       (<AND <PROB 20>
		     <NOT <FSET? ,HERE ,DESERTBIT>> ;"screws you"
		     <NOT <EQUAL? ,HERE ,LAKE-FLATHEAD ,UNDERWATER ,LAKE-BOTTOM
				  	,HOLD ,GONDOLA>>
		     <NOT <EQUAL? <GETP ,HERE ,P?REGION> "Fenshire">>>
		<TELL
"See you next week, same bat time, same bat channel!\" A moment later, you
hear a shrieking, \"Fweep! Fweep! Fweep!\" A large deranged bat swoops down,
snatches you up, and deposits you in" ,ELLIPSIS>
		<MOVE ,PROTAGONIST ,HERE> ;"otherwise, bat takes camel too!"
		<COND (<SET LIT? <FIND-IN ,PROTAGONIST ,ONBIT>>
		       T)
		      (<SET LIT? <FIND-IN ,HERE ,ONBIT>>
		       <MOVE .LIT? ,PROTAGONIST>)>
		<GOTO <COND (<OR <BEYOND-LAKE?>
				 <AND .LIT?
				      <PROB 25>>>
			     ,BATS-LAIR)
			    (<AND ,SECRET-PASSAGE-OPEN
				  .LIT?
				  <PROB 40>>
			     ,PARAPET)
			    (<AND <FSET? ,DRAWBRIDGE ,OPENBIT>
			     	  <PROB 50>>
			     ,OUTER-BAILEY)
			    (T
			     ,ROOF)>>)
	       (<AND <PROB 33> ;"don't turn stump-jumping player to alligator"
		     <NOT <EQUAL? ,HERE ,UNDER-THE-WORLD ,HANGING-FROM-ROOTS
				  	,SHOULDER ,EAR ,INNER-EAR>>
		     <EQUAL? ,HUNGER-COUNT 0>
		     <EQUAL? ,JUMP-X 99>
	 	     <EQUAL? ,JUMP-Y 99>>
		<SETG ALLIGATOR T>
		<QUEUE I-UNALLIGATOR 4>
		<TELL "See you later, alligator!\" Your skin feels itchy">
		<COND (<FIRST? ,PROTAGONIST>
		       <TELL " and you've dropped what you were holding">)>
		<TELL ".">
		<ROB ,PROTAGONIST
		     <COND (<FSET? <LOC ,PROTAGONIST> ,DROPBIT>
		       	    <LOC ,PROTAGONIST>)
			   (T
		       	    ,HERE)>>
		<SETG P-CONT -1> ;<RFATAL>
		<CRLF>)
	       (<OR <PROB 50>
		    ,ALLIGATOR
		    <FSET? ,CLOWN-NOSE ,WORNBIT>>
		<TELL
"So long, and thanks for all the fish!\" Odd. You've never given the
jester any fish." CR>)
	       (T
		<MOVE ,CLOWN-NOSE ,PROTAGONIST>
		<FSET ,CLOWN-NOSE ,WORNBIT>
		<QUEUE I-SUFFOCATE -1>
		<SETG P-CONT -1> ;<RFATAL>
		<TELL
"Catch you aroun', clown!\" You suddenly find yourself having a bit of
difficulty breathing." CR>)>
	 <SETG FUNNY-PAPER-PROB <+ ,FUNNY-PAPER-PROB 5>>>

 <ROUTINE BEYOND-LAKE? ()
	 <COND (<FSET? ,HERE ,DESERTBIT>
		<RTRUE>)
	       (<EQUAL? ,HERE ,STABLE ,GROTTO, SHRINE ,G-U-MOUNTAIN ,STREAM
			      ,G-U-WOODS ,G-U-SAVANNAH ,EAST-SHORE ,SOUTH-SHORE
			      ,RING-OF-DUNES ,BASE-OF-MOUNTAIN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL J-APPEAR-PROB 0>

<GLOBAL DO-J <>>

<ROUTINE REMOVE-J ()
	 <QUEUE I-JESTER 12>
	 <SETG J-APPEAR-PROB 0>
	 <SETG GUESSES <>>
	 <SETG J-ON-RAFT <>>
	 <COND (<IN? ,EAST-KEY ,JESTER>
		<MOVE ,EAST-KEY ,SOLAR>)>
	 <COND (<NOT <FSET? ,ZORKMID-BILL ,TOUCHBIT>>
		<MOVE ,ZORKMID-BILL ,LOCAL-GLOBALS>)>
	 <REMOVE ,SHELL-TABLE>
	 <REMOVE ,JESTER>>

<ROUTINE DONT-CRY ()
	 <SETG GUESSES <+ ,GUESSES 1>>
	 <TELL "\"Wrong, but don't ">
	 <COND (<EQUAL? ,GUESSES 3>
		<SETG GUESSES 0>
		<TELL
"get all a-twiddle; I'll repeat the riddle! " <GETP ,HERE ,P?RIDDLE>>)
	       (T
		<TELL "cry -- give it another try.\"">)>
	 <CRLF>>

<GLOBAL J-INQ-SCENE <>>

<GLOBAL J-ON-RAFT <>>

<GLOBAL FUNNY-PAPER-PROB 20>

<GLOBAL SLATE-PROB 33>

<GLOBAL SCROLL-PROB 33>

<GLOBAL GUESSES 0>

<GLOBAL ALLIGATOR <>>

<ROUTINE I-UNALLIGATOR ()
	 <SETG ALLIGATOR <>>
	 <RETURN-FROM-MAP>
	 <TELL
"   With a pop, your tail and snout shorten, and you are no longer a candidate
for being turned into a pair of expensive shoes." CR>>

<GLOBAL SUFFOCATE-COUNTER 0>

<ROUTINE I-SUFFOCATE ()
	 <COND (<NOT <FSET? ,CLOWN-NOSE ,WORNBIT>>
		<SETG SUFFOCATE-COUNTER 0>
		<DEQUEUE I-SUFFOCATE>
		<RFALSE>)>
	 <SETG SUFFOCATE-COUNTER <+ ,SUFFOCATE-COUNTER 1>>
	 <COND (<EQUAL? ,SUFFOCATE-COUNTER 5>
		<RETURN-FROM-MAP>
		<TELL
"   You're still having trouble breathing. It's probably due to the clown nose
that's clamped in the middle of your face." CR>)
	       (<EQUAL? ,SUFFOCATE-COUNTER 8>
		<RETURN-FROM-MAP>
		<TELL
"   It's really getting tough to keep going without fresh air!" CR>)
	       (<EQUAL? ,SUFFOCATE-COUNTER 10>
		<RETURN-FROM-MAP>
		<TELL "   You're getting lightheaded..." CR>)
	       (<EQUAL? ,SUFFOCATE-COUNTER 11>
		<RETURN-FROM-MAP>
		<JIGS-UP "   You pass out from a shortage of air.">)
	       (T
		<RFALSE>)>>

<ROUTINE I-FUNNY-PAPER ()
	 <MOVE ,FUNNY-PAPER <LOC ,PROTAGONIST>>
	 <QUEUE I-REMOVE-FUNNY-PAPER 1>
	 <THIS-IS-IT ,FUNNY-PAPER>
	 <RETURN-FROM-MAP>
	 <TELL
"   The wind blows a colorful piece of newspaper into view. It's a funny
paper!" CR>>

<ROUTINE I-REMOVE-FUNNY-PAPER ("AUX" (TOLD <>))
	 <COND (<NOT <IN? ,FUNNY-PAPER ,PROTAGONIST>>
		<COND (<VISIBLE? ,FUNNY-PAPER>
		       <SET TOLD T>
		       <RETURN-FROM-MAP>
		       <TELL
"   The wind blows the funny paper out of sight." CR>)>
		<MOVE ,FUNNY-PAPER ,LOCAL-GLOBALS>)>
	 <COND (.TOLD
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FUNNY-PAPER
	(LOC LOCAL-GLOBALS)
	(DESC "funny paper")
	(SYNONYM PAPER PIECE NEWSPAPER COMICS)
	(ADJECTIVE COLORFUL FUNNY)
	(FLAGS TAKEBIT BURNBIT READBIT)
	(SIZE 2)
	(ACTION FUNNY-PAPER-F)>

<ROUTINE FUNNY-PAPER-F ()
	 <COND (<VERB? READ>
		<TELL
"It's a comic strip entitled \"Me and the Jester.\" In the strip, a peasant
adventurer is bumbling around a mighty castle, alternately helped and
hindered by a playful jester. In one panel, the Jester suggests that the
adventurer look under the " D ,HOLEY-SLAB " in the Crypt." CR>)
	       (<VERB? FOLLOW>
		<TELL "You've lost track of it." CR>)>>

<OBJECT BEDBUG
	(DESC "giant bedbug")
	(SYNONYM BUG BEDBUG)
	(ADJECTIVE LARGE BED)
	(ACTION BEDBUG-F)>

<ROUTINE BEDBUG-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's quite larger than any bedbug you've ever seen before: about the size
of a small sheep. It looks as if it has just been roused from a deep sleep,
and isn't at all happy about the fact. With a mixture of weariness and anger,
it waves powerful pincers in your direction." CR>)
	       (<VERB? LEAP>
		<IMPOSSIBLES>)
	       (<VERB? KILL BITE KICK>
		<TELL
"This bedbug's chitinous shell is like battle armor." CR>)>>

<OBJECT CLOWN-NOSE
	(DESC "red clown nose")
	(SYNONYM NOSE)
	(ADJECTIVE RED CLOWN)
	(FLAGS WEARBIT TAKEBIT)
	(SIZE 2)
	(ACTION CLOWN-NOSE-F)>

<ROUTINE CLOWN-NOSE-F ()
	 <COND (<AND <VERB? WEAR>
		     <NOT <FSET? ,CLOWN-NOSE ,WORNBIT>>>
		<FSET ,CLOWN-NOSE ,WORNBIT>
		<QUEUE I-SUFFOCATE -1>
		<TELL
"You don the nose, which makes breathing extremely difficult." CR>)>>

<OBJECT SLATE
	(LOC LOCAL-GLOBALS)
	(DESC "dusty slate")
	(SYNONYM SLATE)
	(ADJECTIVE DUSTY SMALL SILLY OLD)
	(FLAGS READBIT TAKEBIT)
	(ACTION SLATE-F)>

<GLOBAL STUMP-X 0>

<GLOBAL STUMP-Y 0>

<ROUTINE SLATE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The small slate is set into a wooden frame. It looks to be at least
fifty if not a hundred years old. A shaky hand has inscribed something
onto the slate." CR>)
	       (<VERB? READ>
		<COND (<EQUAL? ,STUMP-X 0>
		       <SETG STUMP-X <RANDOM 3>>
		       <COND (<PROB 50>
			      <SETG STUMP-X <* ,STUMP-X -1>>)>
		       <SETG STUMP-Y <RANDOM 3>>
		       <COND (<PROB 50>
			      <SETG STUMP-Y <* ,STUMP-Y -1>>)>
		       <TELL
"You shake enough dust off the slate to read it: ">)>
		<TELL
"\"Stand at the oldest and mightiest elm around. Jump ">
		<COND (<G? ,STUMP-Y 0>
		       <TELL "north ">)
		      (T
		       <TELL "south ">)>
		<COND (<EQUAL? ,STUMP-Y 1 -1>
		       <TELL "once">)
		      (<EQUAL? ,STUMP-Y 2 -2>
		       <TELL "twice">)
		      (T
		       <TELL "thrice">)>
		<TELL " then jump ">
		<COND (<G? ,STUMP-X 0>
		       <TELL "east ">)
		      (T
		       <TELL "west ">)>
		<COND (<EQUAL? ,STUMP-X 1 -1>
		       <TELL "once">)
		      (<EQUAL? ,STUMP-X 2 -2>
		       <TELL "twice">)
		      (T
		       <TELL "thrice">)>
		<TELL ".\"" CR>)>>

<OBJECT SCROLL
	(LOC LOCAL-GLOBALS)
	(DESC "scroll")
	(SYNONYM SCROLL PAPER)
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(ACTION SCROLL-F)>

<ROUTINE SCROLL-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL "The paper reads:" CR CR "   ">
		<HLIGHT ,H-ITALIC>
		<TELL "RAM A NAG" CR CR>
		<HLIGHT ,H-NORMAL>
		<TELL "TREEN RIBARLY HENT HOCUT MORRA RICHET" CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT CASTLE>

<OBJECT SHELL-TABLE
	(DESC "small table")
	(SYNONYM TABLE)
	(ADJECTIVE SMALL)
	(FLAGS SURFACEBIT CONTBIT OPENBIT SEARCHBIT)>

<OBJECT LEFT-SHELL
	(LOC SHELL-TABLE)
	(DESC "left shell")
	(SYNONYM SHELL)
	(ADJECTIVE LEFT FIRST)
	(ACTION SHELL-F)>

<OBJECT CENTER-SHELL
	(LOC SHELL-TABLE)
	(DESC "center shell")
	(SYNONYM SHELL)
	(ADJECTIVE CENTER MIDDLE SECOND)
	(ACTION SHELL-F)>

<OBJECT RIGHT-SHELL
	(LOC SHELL-TABLE)
	(DESC "right shell")
	(SYNONYM SHELL)
	(ADJECTIVE RIGHT THIRD)
	(ACTION SHELL-F)>

<ROUTINE SHELL-F ()
	 <COND (<VERB? POINT>
		<TELL
"The jester lifts the shell. Empty. ">
		<ANOTHER-SHELL-GAME>)
	       (<VERB? TOUCH LOOK-UNDER MOVE TAKE>
		<TELL
"The jester stops you, saying, \"You deserve a beating for trying
such cheating!\"" CR>)
	       (<AND <VERB? LOOK-INSIDE EXAMINE>
		     <FSET? ,GOGGLES ,WORNBIT>>
		<TELL
"Thanks to the goggles, you can see right through the shell as though it
were transparent! There's nothing under it." CR>)>>

<ROUTINE ANOTHER-SHELL-GAME ()
	 <TELL
"\"Don't be sore, let's try it once more!\" He reshuffles the shells.">
	 <MOVE ,ZORKMID-BILL ,LOCAL-GLOBALS>
	 <SEE-BILL?>
	 <CRLF>>

<ROUTINE SEE-BILL? ("AUX" BILL-LOC)
	 <COND (<FSET? ,GOGGLES ,WORNBIT>
		<SET BILL-LOC <COND (<PROB 33> ,J-POCKET)
				    (<PROB 50> ,J-SHOE)
				    (T ,J-HAT)>>
		<MOVE ,ZORKMID-BILL .BILL-LOC>
		<TELL
" You find that you can see right through the shells -- and the zorkmid bill
isn't under any of them! Before you can say so, you notice the bill -- ">
		<COND (<EQUAL? .BILL-LOC ,J-HAT>
		       <TELL "under">)
		      (T
		       <TELL "in">)>
		<TELL
T .BILL-LOC "! After a moment, the vision fades, and" T .BILL-LOC " once
again appears opaque.">)>>

<OBJECT ZORKMID-BILL
	(LOC LOCAL-GLOBALS)
	(DESC "zorkmid bill")
	(SYNONYM BILL MONEY)
	(ADJECTIVE ZORKMID)
	(FLAGS TAKEBIT BURNBIT READBIT MAGICBIT)
	(SIZE 1)
	(VALUE 0) ;"12 points given elsewhere"
	(TEXT
"The denomination of the bill is 100,000 zorkmids. Only one such bill
was ever printed, and that was at the personal request of J. Pierpont
Flathead.")>

<ROOM JESTERS-QUARTERS
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Jester's Quarters")
      (DOWN TO SERVANTS-QUARTERS)
      (OUT TO SERVANTS-QUARTERS)
      (NORTH TO WEIRD IF LARGE-DOOR IS OPEN)
      (SOUTH PER SMALL-DOOR-ENTER-F)
      (FLAGS RLANDBIT)
      (SYNONYM QUARTERS)
      (OWNER JESTER)
      (GLOBAL STAIRS LARGE-DOOR SMALL-DOOR)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-4 MAP-GEN-X-10>)
      (ICON J-QUARTER-ICON)
      (ACTION JESTERS-QUARTERS-F)>

<ROUTINE JESTERS-QUARTERS-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a small, spare room. The only features are a small louvered door on
the south wall, a larger arched door on the north wall, and a stair which
spirals downward. ">
		<COND (<FSET? ,LARGE-DOOR ,OPENBIT>
		       <TELL "The large door is open but the small door is">)
		      (T
		       <TELL "Both doors are">)>
		<TELL " closed.">)>>

<ROUTINE SMALL-DOOR-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<NOT .RARG>
		<RETURN-FROM-MAP>
		<DO-FIRST "open" ,SMALL-DOOR>
		<THIS-IS-IT ,SMALL-DOOR>)>
	 <RFALSE>>

<OBJECT LARGE-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "large arched door")
	(SYNONYM DOOR)
	(ADJECTIVE LARGE ARCHED)
	(FLAGS DOORBIT)
	(GENERIC G-J-DOOR-F)
	(ACTION LARGE-DOOR-F)>

<ROUTINE LARGE-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT ,TOWER-BEATEN>>
		<TELL
"Although there's no visible lock, the door refuses to budge." CR>)>>

<ROUTINE G-J-DOOR-F (TBL LEN)
	 <COND (<AND <VERB? OPEN>
		     <FSET? ,LARGE-DOOR ,OPENBIT>>
		,SMALL-DOOR)
	       (<AND <VERB? CLOSE>
		     <FSET? ,LARGE-DOOR ,OPENBIT>>
		,LARGE-DOOR)
	       (T
		<RFALSE>)>>

<OBJECT SMALL-DOOR
	(LOC LOCAL-GLOBALS) ;"so parser will which-print between the two doors"
	(DESC "small louvered door")
	(SYNONYM DOOR)
	(ADJECTIVE SMALL SOUTH LOUVERED)
	(FLAGS NDESCBIT)
	(GENERIC G-J-DOOR-F)
	(ACTION SMALL-DOOR-F)>

<ROUTINE SMALL-DOOR-F ("AUX" WEIGHT-CNT FUDGE)
	 <COND (<VERB? OPEN LOOK-BEHIND>
		<PICINF-PLUS-ONE ,B-1-L-PIC-LOC>
		<PUT ,B-Y-TBL 5 <GET ,PICINF-TBL 0>>
		<PUT ,B-X-TBL 0 <GET ,PICINF-TBL 1>>
		<PICINF-PLUS-ONE ,B-2-C-PIC-LOC>
		<PUT ,B-Y-TBL 4 <GET ,PICINF-TBL 0>>
		<PUT ,B-X-TBL 1 <GET ,PICINF-TBL 1>>
		<PICINF-PLUS-ONE ,B-3-R-PIC-LOC>
		<PUT ,B-Y-TBL 3 <GET ,PICINF-TBL 0>>
		<PUT ,B-X-TBL 2 <GET ,PICINF-TBL 1>>
		<PICINF-PLUS-ONE ,B-4-PIC-LOC>
		<PUT ,B-Y-TBL 2 <GET ,PICINF-TBL 0>>
		<PICINF-PLUS-ONE ,B-5-PIC-LOC>
		<PUT ,B-Y-TBL 1 <GET ,PICINF-TBL 0>>
		<PICINF-PLUS-ONE ,B-6-PIC-LOC>
		<PUT ,B-Y-TBL 0 <GET ,PICINF-TBL 0>>
		<FSET ,SMALL-DOOR ,OPENBIT>
		<SETG TOWER-CHANGED <>>
		<SPLIT-BY-PICTURE ,B-SPLIT T>
		<ADJUST-TEXT-WINDOW ,B-BOTTOM>
		<DRAW-TOWER>
		<TELL
"Opening the door reveals a tiny nook containing a
Tower of Bozbar, consisting of 3 pegs and ">
		<SET WEIGHT-CNT <+ <CCOUNT ,LEFT-PEG>
				   <CCOUNT ,RIGHT-PEG>
				   <CCOUNT ,CENTER-PEG>>>
		<TELL N .WEIGHT-CNT>
		<TELL " cylindrical weight">
		<COND (<NOT <EQUAL? .WEIGHT-CNT 1>>
		       <TELL "s">)>
		<COND (<EQUAL? .WEIGHT-CNT 6>
		       <TELL " ranging from a 1-ugh to a 6-ugh weight">)>
		<TELL ,PERIOD-CR
"   Type the number of the weight you want to move, followed by the peg
you want to move it to: L, C, or R. ">
		<COND (,ACTIVE-MOUSE
		       <TELL
"Or, if you'd rather use your mouse, click on the weight you want to move,
then click on the peg you want to move it to. ">)>
		<TELL "You can Undo your move by typing U">
		<COND (,ACTIVE-MOUSE
		       <TELL " (or clicking on the UNDO spot)">)>
		<COND (<0? <BAND <LOWCORE FLAGS> 8>> ;"system has no UNDO"
		       <TELL
" -- even though Undo doesn't normally work on your system!">)
		      (T
		       <TELL ".">)>
		<TELL " Type X">
		<COND (,ACTIVE-MOUSE
		       <TELL " (or click on the EXIT spot)">)>
		<TELL " to exit.">
		<TOWER-MODE>
		<CRLF> <CRLF>
		<HIT-ANY-KEY>
		<INIT-SL-WITH-SPLIT ,TEXT-WINDOW-PIC-LOC>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The small door is closed." CR>)
	       (<VERB? CLOSE>
		<TELL "It is!" CR>)>>

<OBJECT T-OF-B
	(OWNER T-OF-B)
	(DESC "Tower of Bozbar")
	(SYNONYM TOWER BOZBAR)
	(FLAGS CONTBIT OPENBIT SEARCHBIT)
	(RESEARCH
"The Tower of Bozbar, an ancient game of unknown origin, consists of three pegs
and a pile of weights. The goal is to move the pile from one peg to another,
moving one weight at a time, with the constraint that no weight can ever be
placed atop a smaller weight. Many people say that the Tower of Bozbar is a
superb method of mental relaxation. [Obviously, none of these people have ever
played Zork Zero.]")>

<OBJECT LEFT-PEG
	(LOC T-OF-B)
	(DESC "left peg")
	(SYNONYM PEG POST)
	(ADJECTIVE FIRST LEFT)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)>

<OBJECT CENTER-PEG
	(LOC T-OF-B)
	(DESC "center peg")
	(SYNONYM PEG POST)
	(ADJECTIVE SECOND CENTER MIDDLE)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)>

<OBJECT RIGHT-PEG
	(LOC T-OF-B)
	(DESC "right peg")
	(SYNONYM PEG POST)
	(ADJECTIVE THIRD RIGHT)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)>

<OBJECT 1-WEIGHT
	(LOC CENTER-PEG)
	(DESC "1-ugh weight")
	(SYNONYM WEIGHT)
	(ADJECTIVE 1-UGH)
	(FLAGS NDESCBIT)
	(SIZE 1)
	(ACTION WEIGHT-F)>

<OBJECT 2-WEIGHT
	(LOC CENTER-PEG)
	(DESC "2-ugh weight")
	(SYNONYM WEIGHT)
	(ADJECTIVE 2-UGH)
	(FLAGS NDESCBIT)
	(SIZE 2)
	(ACTION WEIGHT-F)>

<OBJECT 3-WEIGHT
	(LOC CENTER-PEG)
	(DESC "3-ugh weight")
	(SYNONYM WEIGHT)
	(ADJECTIVE 3-UGH)
	(FLAGS NDESCBIT)
	(SIZE 3)
	(ACTION WEIGHT-F)>

<OBJECT 4-WEIGHT
	(LOC CENTER-PEG)
	(DESC "4-ugh weight")
	(SYNONYM WEIGHT)
	(ADJECTIVE 4-UGH)
	(FLAGS NDESCBIT)
	(SIZE 4)
	(ACTION WEIGHT-F)>

<OBJECT 5-WEIGHT
	(LOC CENTER-PEG)
	(DESC "5-ugh weight")
	(SYNONYM WEIGHT)
	(ADJECTIVE 5-UGH)
	(FLAGS NDESCBIT)
	(SIZE 5)
	(ACTION WEIGHT-F)>

<OBJECT 6-WEIGHT
	(LOC CENTER-PEG)
	(DESC "6-ugh weight")
	(SYNONYM WEIGHT)
	(ADJECTIVE 6-UGH)
	(FLAGS NDESCBIT)
	(SIZE 6)
	(ACTION WEIGHT-F)>

<ROUTINE WEIGHT-F ("AUX" CNT (RECURSING <>))
	 <COND (<AND <VERB? MOVE-TO>
		     <PRSI? ,LEFT-PEG ,CENTER-PEG ,RIGHT-PEG>>
		<COND (<IN? ,PRSO ,PRSI>
		       <TELL "It's already on that peg.">)
		      (<NOT-TOP-WEIGHT ,PRSO>
		       <TELL "You can only move the weight that's on top!">)
		      (T
		       <SETG TOWER-CHANGED T>
		       <MOVE-WEIGHT ,PRSO ,PRSI>
		       <MOVE ,PRSO ,PRSI>
		       <TELL "You move" T ,PRSO " to" T ,PRSI>
		       <REPEAT ()
			       <COND (<CRUSH-WEIGHT ,PRSO ,PRSI .RECURSING>
				      <SET RECURSING T>)
				     (T
				      <RETURN>)>>
		       <COND (,TOWER-BEATEN
			      <SETG TOWER-BEATEN <>>
			      <COND (<FSET? ,LARGE-DOOR ,OPENBIT>
				     <FCLEAR ,LARGE-DOOR ,OPENBIT>
				     <TELL
". The large door to the north swings silently shut">)>)>
		       <TELL ".">)>)>>

<GLOBAL TOWER-BEATEN <>> ;"set to PYRAMID in GO"

<GLOBAL TOWER-CHANGED <>> ;"set to <> when you open the door; set to true the
			    first time you move a weight; prevents door from
			    auto-closing before you've made a move"

<ROUTINE-FLAGS CLEAN-STACK?>
<ROUTINE TOWER-MODE ("AUX" CHAR WGT PEG X (JUST-UNDID <>))
	 <REPEAT ()
		 <COND (<AND ,TOWER-CHANGED
			     <NOT .JUST-UNDID>
			     <SETG TOWER-BEATEN <TOWER-WIN-CHECK>>>
			<TELL
"   You hear a \"click\" from the direction of the Tower">
			<COND (<NOT <EQUAL? ,TOWER-BEATEN ,PYRAMID>>
			       <TELL ". It tilts to the ">
			       <COND (<EQUAL? ,TOWER-BEATEN ,PYRAMID-L>
				      <TELL "left">)
				     (T
				      <TELL "right">)>)>
			<FSET ,WEIRD ,REDESCBIT>
			<FCLEAR ,SMALL-DOOR ,OPENBIT>
			<TELL
". The small louvered door swings silently shut.">
			<RETURN>)>
		 <COND (,DEMO-VERSION?
			<SET CHAR <INPUT-DEMO 1>>)
		       (T
			<SET CHAR <INPUT 1>>)>
		 <MOUSE-INPUT?>
		 <COND (<EQUAL? .CHAR ,CLICK1 ,CLICK2>
			<SET CHAR <B-MOUSE-WEIGHT-PICK>>)>
		 <CLEAR ,S-TEXT>
		 <COND (<EQUAL? .CHAR !\X !\x>
			<TELL
"You shut the louvered door, concealing the Tower of Bozbar from view.">
			<RETURN>)
		       (<EQUAL? .CHAR !\U !\u>
			<COND (<NOT ,TOWER-CHANGED>
			       <TELL
"You can't undo until you make a move!">)
			      (.JUST-UNDID
			       <TELL
"You just undid; you can't undo again until you move again!">)
			      (T
			       <SET JUST-UNDID T>
			       <B-RESTORE>
			       <DRAW-TOWER T>
			       <TELL "Undone.">)>)
		       (<OR <EQUAL? .CHAR !\1 !\2 !\3 !\4 !\5 !\6>
			    <EQUAL? .CHAR 146 147 148 149 150 151> ;"keypad">
			<COND (<EQUAL? .CHAR !\1 146>
			       <SET WGT ,1-WEIGHT>)
			      (<EQUAL? .CHAR !\2 147>
			       <SET WGT ,2-WEIGHT>)
			      (<EQUAL? .CHAR !\3 148>
			       <SET WGT ,3-WEIGHT>)
			      (<EQUAL? .CHAR !\4 149>
			       <SET WGT ,4-WEIGHT>)
			      (<EQUAL? .CHAR !\5 150>
			       <SET WGT ,5-WEIGHT>)
			      (T
			       <SET WGT ,6-WEIGHT>)>
			<COND (<NOT <EQUAL? <LOC .WGT>
					    ,LEFT-PEG ,CENTER-PEG ,RIGHT-PEG>>
			       <TELL
"There's no " D .WGT " anymore -- you crushed it.">)
			      (T
			       <COND (,ACTIVE-MOUSE
				      <TELL "Use your mouse or t">)
				     (T
				      <TELL "T">)>
			       <TELL
"ype L (left) or C (center) or R (right) to specify the peg you'd
like to move the " D .WGT " to.">
			       <COND (,DEMO-VERSION?
				      <SET CHAR <INPUT-DEMO 1>>)
				     (T
				      <SET CHAR <INPUT 1>>)>
			       <MOUSE-INPUT?>
			       <COND (<EQUAL? .CHAR ,CLICK1 ,CLICK2>
				      <SET CHAR <B-MOUSE-PEG-PICK>>)>
			       <CLEAR ,S-TEXT>
			       <COND (<NOT <EQUAL? .CHAR
						   !\L !\l !\R !\r !\C !\c>>
				      <TELL "Next time, ">
				      <COND (<EQUAL? .CHAR ,CLICK1>
					     <TELL
"click on the left, center, or right peg!">)
					    (T
					     <TELL
"type R (right), L (left), or C (center) to specify a destination peg!">)>)
				     (T
				      <COND (<EQUAL? .CHAR !\L !\l>
					     <SET PEG ,LEFT-PEG>)
					    (<EQUAL? .CHAR !\R !\r>
					     <SET PEG ,RIGHT-PEG>)
					    (T
					     <SET PEG ,CENTER-PEG>)>
				      <B-SAVE>
				      <COND (<AND <OR <NOT ,TOWER-CHANGED>
						      .JUST-UNDID>
						  ,ACTIVE-MOUSE>
					     <PICINF-PLUS-ONE
					              ,TOWER-UNDO-BOX-LOC>
					     <SCREEN ,S-WINDOW>
					     <DISPLAY ,UNDO-BOX
						      <GET ,PICINF-TBL 0>
						      <GET ,PICINF-TBL 1>>
					     <SCREEN ,S-TEXT>)>
				      <SET JUST-UNDID <>>
				      <SET X
					   <PERFORM ,V?MOVE-TO .WGT .PEG>>)>)>)
		       (<EQUAL? .CHAR !\L !\l !\R !\r !\C !\c>
			<TELL
"You must select a weight before you select a destination!">)
		       (T
			<TELL
,TYPE-A-NUMBER "6, U for Undo, or X to eXit the Tower of Bozbar game.">)>>>

<ROUTINE B-MOUSE-PEG-PICK
	 ("AUX" TL-X TL-Y BR-X BR-Y WEIGHT-WIDTH WEIGHT-HEIGHT)
	 <PICINF ,B-1-WEIGHT ,PICINF-TBL>
	 <SET WEIGHT-WIDTH <GET ,PICINF-TBL 1>>
	 <SET WEIGHT-HEIGHT <GET ,PICINF-TBL 0>>
	 <PICINF-PLUS-ONE ,B-1-L-PIC-LOC>
	 <SET TL-Y <GET ,PICINF-TBL 0>>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET BR-X <+ .WEIGHT-WIDTH .TL-X>>
	 <PICINF-PLUS-ONE ,B-6-PIC-LOC>
	 <SET BR-Y <+ <GET ,PICINF-TBL 0> .TL-Y>>
	 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		<RETURN !\L>)>
	 <PICINF-PLUS-ONE ,B-2-C-PIC-LOC>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET BR-X <+ .WEIGHT-WIDTH .TL-X>>
	 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		<RETURN !\C>)>
	 <PICINF-PLUS-ONE ,B-3-R-PIC-LOC>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET BR-X <+ .WEIGHT-WIDTH .TL-X>>
	 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		<RETURN !\R>)
	       (T
		<SOUND 1>
		<RETURN ,CLICK1>)>>

<ROUTINE B-MOUSE-WEIGHT-PICK ("AUX" TL-X TL-Y BR-X BR-Y (NUM 0) TBL
		     (CNT-X 0) (CNT-Y 0) WEIGHT-WIDTH WEIGHT-HEIGHT)
	 <PICINF-PLUS-ONE ,TOWER-UNDO-BOX-LOC>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET TL-Y <GET ,PICINF-TBL 0>>
	 <PICINF ,UNDO-BOX ,PICINF-TBL>
	 <SET BR-X <+ .TL-X <GET ,PICINF-TBL 1>>>
	 <SET BR-Y <+ .TL-Y <GET ,PICINF-TBL 0>>>
	 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		<RETURN !\U>)>
	 <PICINF-PLUS-ONE ,TOWER-EXIT-BOX-LOC>
	 <SET TL-X <GET ,PICINF-TBL 1>>
	 <SET TL-Y <GET ,PICINF-TBL 0>>
	 <PICINF ,EXIT-BOX ,PICINF-TBL>
	 <SET BR-X <+ .TL-X <GET ,PICINF-TBL 1>>>
	 <SET BR-Y <+ .TL-Y <GET ,PICINF-TBL 0>>>
	 <COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		<RETURN !\X>)>
	 <PICINF ,B-1-WEIGHT ,PICINF-TBL>
	 <SET WEIGHT-WIDTH <GET ,PICINF-TBL 1>>
	 <SET WEIGHT-HEIGHT <GET ,PICINF-TBL 0>>
	 <SET TBL ,LEFT-PEG-TABLE>
	 <REPEAT ()
		 <REPEAT ()
			 <SET TL-X <GET ,B-X-TBL .CNT-X>>
		 	 <SET TL-Y <GET ,B-Y-TBL .CNT-Y>>
		 	 <SET BR-X <+ .TL-X .WEIGHT-WIDTH>>
		 	 <SET BR-Y <+ .TL-Y .WEIGHT-HEIGHT>>
		 	 <COND (<AND <WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
				     <SET NUM <GET .TBL .CNT-Y>>>
				<SET NUM <GETP .NUM ,P?SIZE>>)>
			 <SET CNT-Y <+ .CNT-Y 1>>
			 <COND (.NUM
				<RETURN>)
			       (<EQUAL? .CNT-Y 6>
				<RETURN>)>>
		 <COND (.NUM
			<RETURN>)
		       (<EQUAL? .CNT-X 0>
			<SET CNT-X 1>
			<SET CNT-Y 0>
			<SET TBL ,CENTER-PEG-TABLE>)
		       (<EQUAL? .CNT-X 1>
			<SET CNT-X 2>
			<SET CNT-Y 0>
			<SET TBL ,RIGHT-PEG-TABLE>)
		       (T
			<RETURN>)>>
	 <COND (.NUM
		<RETURN <+ .NUM 48> ;"convert to ASCII">)
               (T
		<SOUND 1>
		<RETURN ,CLICK1>)>>

<ROUTINE TOWER-WIN-CHECK ()
	 <COND (<AND <IN? ,1-WEIGHT ,LEFT-PEG>
		     <IN? ,2-WEIGHT ,LEFT-PEG>
		     <IN? ,3-WEIGHT ,LEFT-PEG>
		     <IN? ,4-WEIGHT ,LEFT-PEG>
		     <IN? ,5-WEIGHT ,LEFT-PEG>
		     <IN? ,6-WEIGHT ,LEFT-PEG>>
		<RETURN ,PYRAMID-L>)
	       (<AND <IN? ,1-WEIGHT ,RIGHT-PEG>
		     <IN? ,2-WEIGHT ,RIGHT-PEG>
		     <IN? ,3-WEIGHT ,RIGHT-PEG>
		     <IN? ,4-WEIGHT ,RIGHT-PEG>
		     <IN? ,5-WEIGHT ,RIGHT-PEG>
		     <IN? ,6-WEIGHT ,RIGHT-PEG>>
		<RETURN ,PYRAMID-R>)
	       (<AND <IN? ,1-WEIGHT ,CENTER-PEG>
		     <IN? ,2-WEIGHT ,CENTER-PEG>
		     <IN? ,3-WEIGHT ,CENTER-PEG>
		     <IN? ,4-WEIGHT ,CENTER-PEG>
		     <IN? ,5-WEIGHT ,CENTER-PEG>
		     <IN? ,6-WEIGHT ,CENTER-PEG>>
		<RETURN ,PYRAMID>)
	       (T
		<RFALSE>)>>

<ROUTINE SET-PEG-TABLE (PEG)
	 <COND (<EQUAL? .PEG ,LEFT-PEG>
		<RETURN ,LEFT-PEG-TABLE>)
	       (<EQUAL? .PEG ,CENTER-PEG>
		<RETURN ,CENTER-PEG-TABLE>)
	       (T
		<RETURN ,RIGHT-PEG-TABLE>)>>

<ROUTINE NOT-TOP-WEIGHT (WGT "AUX" TBL (CNT 0) NOT-TOP)
	 <SET TBL <SET-PEG-TABLE <LOC .WGT>>>
	 <REPEAT ()
		 <COND (<EQUAL? <GET .TBL .CNT> .WGT>
			<COND (<EQUAL? .CNT 5> ;"the peg is full"
			       <SET NOT-TOP <>>)
			      (<EQUAL? <GET .TBL <+ .CNT 1>> 0>
			       <SET NOT-TOP <>>)
			      (T
			       <SET NOT-TOP T>)>
			<RETURN>)>
		 <SET CNT <+ .CNT 1>>>
	 <RETURN .NOT-TOP>>

<ROUTINE MOVE-WEIGHT (WGT PEG "AUX" TBL (CNT 0) X)
	 <SCREEN ,S-WINDOW>
	 <SET X <GET ,B-X-TBL <COND (<EQUAL? <LOC .WGT> ,LEFT-PEG> 0)
					 (<EQUAL? <LOC .WGT> ,CENTER-PEG> 1)
					 (T 2)>>>
	 <SET TBL <SET-PEG-TABLE <LOC .WGT>>>
	 <REPEAT () ;"remove weight from current table"
	     <COND (<EQUAL? <GET .TBL .CNT> .WGT>
		    <DISPLAY ,B-RESTORE-PEG <GET ,B-Y-TBL .CNT> .X>
		    <PUT .TBL .CNT 0>
		    <RETURN>)>
	     <SET CNT <+ .CNT 1>>>
	 <SET CNT 0>
	 <SET X <COND (<EQUAL? .PEG ,LEFT-PEG> 0)
	       	      (<EQUAL? .PEG ,CENTER-PEG> 1)
	       	      (T 2)>>
	 <SET X <ZGET ,B-X-TBL .X>>
	 <SET TBL <SET-PEG-TABLE .PEG>>
	 <REPEAT () ;"put weight in new table"
	     <COND (<EQUAL? <GET .TBL .CNT> 0>
		    <DISPLAY <SET-B-PIC .WGT> <GET ,B-Y-TBL .CNT> .X>
		    <PUT .TBL .CNT .WGT>
		    <RETURN>)>
	     <SET CNT <+ .CNT 1>>>
	 <SCREEN ,S-TEXT>>

<ROUTINE CRUSH-WEIGHT (WGT PEG RECURSING "AUX" TBL (CNT 0) CRUSHED X)
	 <SET TBL <SET-PEG-TABLE .PEG>>
	 <REPEAT ()
	   <COND (<EQUAL? <GET .TBL .CNT> .WGT>
		  <COND (<EQUAL? .CNT 0> ;"it's the only weight on peg"
			 <SET CRUSHED <>>)
			(<AND <SET CRUSHED <GET .TBL <- .CNT 1>>>
			      <L? <GETP .CRUSHED ,P?SIZE>
				  <GETP .WGT ,P?SIZE>>>
			 <SET X <GET ,B-X-TBL
				     <COND (<EQUAL? .PEG ,LEFT-PEG> 0)
					   (<EQUAL? .PEG ,CENTER-PEG> 1)
					   (T 2)>>>
			 <SCREEN ,S-WINDOW>
			 <DISPLAY ,B-RESTORE-PEG
				  <GET ,B-Y-TBL .CNT> .X>
			 <DISPLAY <SET-B-PIC .WGT>
				  <GET ,B-Y-TBL <- .CNT 1>> .X>
			 <SCREEN ,S-TEXT>
			 <REMOVE .CRUSHED>
			 <PUT .TBL .CNT 0>
			 <PUT .TBL <- .CNT 1> .WGT>)
			(T
			 <SET CRUSHED <>>)>
		  <RETURN>)>
	   <SET CNT <+ .CNT 1>>>
	 <COND (<NOT .CRUSHED>
		<RFALSE>)
	       (.RECURSING
		<TELL ". And" T .CRUSHED>)
	       (T
		<TELL ", crushing" T .CRUSHED>)>>

<ROUTINE B-SAVE ("AUX" CNT)
	 <COPYT ,LEFT-PEG-TABLE ,TOWER-UNDO-TABLE 12>
	 <COPYT ,CENTER-PEG-TABLE <REST ,TOWER-UNDO-TABLE 12> 12>
	 <COPYT ,RIGHT-PEG-TABLE <REST ,TOWER-UNDO-TABLE 24> 12>
	 <PUT ,TOWER-UNDO-TABLE 18 <LOC ,1-WEIGHT>>
	 <PUT ,TOWER-UNDO-TABLE 19 <LOC ,2-WEIGHT>>
	 <PUT ,TOWER-UNDO-TABLE 20 <LOC ,3-WEIGHT>>
	 <PUT ,TOWER-UNDO-TABLE 21 <LOC ,4-WEIGHT>>
	 <PUT ,TOWER-UNDO-TABLE 22 <LOC ,5-WEIGHT>>
	 <PUT ,TOWER-UNDO-TABLE 23 <LOC ,6-WEIGHT>>>

<ROUTINE B-RESTORE ("AUX" CNT L)
	 <COPYT ,TOWER-UNDO-TABLE ,LEFT-PEG-TABLE 12>
	 <COPYT <REST ,TOWER-UNDO-TABLE 12> ,CENTER-PEG-TABLE 12>
	 <COPYT <REST ,TOWER-UNDO-TABLE 24> ,RIGHT-PEG-TABLE 12>
	 <COND (<SET L <GET ,TOWER-UNDO-TABLE 18>>
		<MOVE ,1-WEIGHT .L>)>
	 <COND (<SET L <GET ,TOWER-UNDO-TABLE 19>>
		<MOVE ,2-WEIGHT .L>)>
	 <COND (<SET L <GET ,TOWER-UNDO-TABLE 20>>
		<MOVE ,3-WEIGHT .L>)>
	 <COND (<SET L <GET ,TOWER-UNDO-TABLE 21>>
		<MOVE ,4-WEIGHT .L>)>
	 <COND (<SET L <GET ,TOWER-UNDO-TABLE 22>>
		<MOVE ,5-WEIGHT .L>)>
	 <MOVE ,6-WEIGHT <GET ,TOWER-UNDO-TABLE 23>>>

<CONSTANT B-X-TBL ;"x co-ordinates of pegs, left to right"
	  <TABLE <> <> <>>>

<CONSTANT B-Y-TBL ;"y co-ordinates of weights, bottom to top"
	  <TABLE <> <> <> <> <> <>>>

<CONSTANT TOWER-UNDO-TABLE
	<TABLE 0 0 0 0 0 0 ;"store left-peg-table"
	       0 0 0 0 0 0 ;"store center-peg-table"
	       0 0 0 0 0 0 ;"store right-peg-table"
	       0 0 0 0 0 0 ;"store weight locs">>

<CONSTANT LEFT-PEG-TABLE
	<TABLE 0 0 0 0 0 0>>

<CONSTANT CENTER-PEG-TABLE
	<TABLE 6-WEIGHT 5-WEIGHT 4-WEIGHT 3-WEIGHT 2-WEIGHT 1-WEIGHT>>

<CONSTANT RIGHT-PEG-TABLE
	<TABLE 0 0 0 0 0 0>>

<CONSTANT B-PICSET-TBL
	  <TABLE B-RESTORE-PEG
		 1-WEIGHT
		 2-WEIGHT
		 3-WEIGHT
		 4-WEIGHT
		 5-WEIGHT
		 6-WEIGHT
		 0>>

<ROUTINE DRAW-TOWER ("OPTIONAL" (UNDOING <>) "AUX" (CNT 0) WGT PEG-LOC)
	 <CLEAR ,S-FULL>
	 <SCREEN ,S-FULL>
	 <DISPLAY ,B-BORDER 1 1>
	 <PICSET ,B-PICSET-TBL>
	 <SCREEN ,S-WINDOW>
	 <DRAW-PEG ,LEFT-PEG-TABLE 0 ;<GET ,B-X-TBL 0>>
	 <DRAW-PEG ,CENTER-PEG-TABLE 1 ;<GET ,B-X-TBL 1>>
	 <DRAW-PEG ,RIGHT-PEG-TABLE 2 ;<GET ,B-X-TBL 2>>
	 <COND (,ACTIVE-MOUSE
		<PICINF-PLUS-ONE ,TOWER-UNDO-BOX-LOC>
		<DISPLAY <COND (<OR <TOWER-WIN-CHECK>
				    .UNDOING>
				,DIM-UNDO-BOX)
			       (T
				,UNDO-BOX)>
			 <GET ,PICINF-TBL 0> <GET ,PICINF-TBL 1>>
		<PICINF-PLUS-ONE ,TOWER-EXIT-BOX-LOC>
		<DISPLAY ,EXIT-BOX <GET ,PICINF-TBL 0> <GET ,PICINF-TBL 1>>)>
	 <SCREEN ,S-TEXT>>

<ROUTINE DRAW-PEG (TBL X "AUX" WGT (CNT 0))
      <SET X <GET ,B-X-TBL .X>>
      <REPEAT ()
	   <COND (<EQUAL? .CNT 6>
		  <RETURN>)
		 (<EQUAL? <SET WGT <GET .TBL .CNT>> 0>
		  <RETURN>)
		 (T
		  <DISPLAY <SET-B-PIC .WGT> <GET ,B-Y-TBL .CNT> .X>)>
	   <SET CNT <+ .CNT 1>>>>

<ROUTINE SET-B-PIC (WGT)
	 <RETURN <COND (<EQUAL? .WGT ,1-WEIGHT> ,B-1-WEIGHT)
		       (<EQUAL? .WGT ,2-WEIGHT> ,B-2-WEIGHT)
		       (<EQUAL? .WGT ,3-WEIGHT> ,B-3-WEIGHT)
		       (<EQUAL? .WGT ,4-WEIGHT> ,B-4-WEIGHT)
		       (<EQUAL? .WGT ,5-WEIGHT> ,B-5-WEIGHT)
		       (<EQUAL? .WGT ,6-WEIGHT> ,B-6-WEIGHT)>>>

<ROOM WEIRD
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Weird Passageway")
      (SOUTH TO JESTERS-QUARTERS IF LARGE-DOOR IS OPEN)
      (NORTH PER WEIRD-EXIT-F)
      (WEST PER WEIRD-EXIT-F)
      (EAST PER WEIRD-EXIT-F)
      (FLAGS RLANDBIT)
      (GLOBAL LARGE-DOOR)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-10>)
      (ACTION WEIRD-F)>

<ROUTINE WEIRD-EXIT-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<OR <AND <PRSO? ,P?WEST>
			 <EQUAL? ,TOWER-BEATEN ,PYRAMID-L>>
		    <AND <PRSO? ,P?NORTH>
			 <EQUAL? ,TOWER-BEATEN ,PYRAMID>>
		    <AND <PRSO? ,P?EAST>
			 <EQUAL? ,TOWER-BEATEN ,PYRAMID-R>>>
		,TOWER-BEATEN)
	       (T
		<COND (<NOT .RARG>
		       <CANT-GO>)>
		<RFALSE>)>>

<ROUTINE WEIRD-ENTER-F ("OPT" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (<EQUAL? ,HERE ,TOWER-BEATEN>
		,WEIRD)
	       (T
		<COND (<NOT .RARG>
		       <RETURN-FROM-MAP>
		       <TELL
"There DOES seem to be an outline of a entrance in that direction, but
it appears sealed with no way to open it. Too bad." CR>)>
		<RFALSE>)>>

<ROUTINE WEIRD-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a disturbing hallway; the lines of the walls are disorienting in
a strange, non-Euclidean sort of way. The passageway ">
		<COND (<NOT ,TOWER-BEATEN>
		       <TELL "ends abruptly to the north">)
		      (<EQUAL? ,TOWER-BEATEN ,PYRAMID>
		       <TELL "continues straight ahead, to the north">)
		      (T
		       <TELL "curves sharply to the ">
		       <COND (<EQUAL? ,TOWER-BEATEN ,PYRAMID-L>
			      <TELL "left">)
			     (T
			      <TELL "right">)>
		       <TELL " here, ending at an archway to the ">
		       <COND (<EQUAL? ,TOWER-BEATEN ,PYRAMID-L>
			      <TELL "west">)
			     (T
			      <TELL "east">)>)>
		<TELL
". To the south, the passage ends at a large arched door which is ">
		<OPEN-CLOSED ,LARGE-DOOR>
		<TELL ".">)>>

<ROOM PYRAMID
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Pyramid Room")
      (SOUTH PER WEIRD-ENTER-F)
      (OUT PER WEIRD-ENTER-F)
      (FLAGS RLANDBIT)
      (VALUE 7)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-2 MAP-GEN-X-10>)
      (ICON PYRAMID-ICON)
      (ACTION PYRAMID-F)>

<BEGIN-SEGMENT 0>

<OBJECT GOGGLES
	(LOC PYRAMID)
	(OWNER GOGGLES)
	(DESC "pair of goggles")
	(PLURAL "goggles")
	(SYNONYM GOGGLES PAIR ETCHING)
	(FLAGS PLURALBIT TAKEBIT WEARBIT TRANSBIT)
	(ACTION GOGGLES-F)>

<ROUTINE GOGGLES-F ()
	 <COND (<AND <VERB? WEAR>
		     <EQUAL? ,HERE ,GAMING-ROOM>
		     <NOT <FSET? ,ZORKMID-BILL ,TOUCHBIT>>
		     <IN? ,ZORKMID-BILL ,LOCAL-GLOBALS>>
		<MOVE ,ZORKMID-BILL <COND (<PROB 33> ,J-POCKET)
					  (<PROB 50> ,J-SHOE)
					  (T ,J-HAT)>>
		<RFALSE>)
	       (<AND <VERB? EXAMINE>
		     <PRSI? ,GOGGLES>>
		<COND (<NOT <FSET? ,GOGGLES ,WORNBIT>>
		       <PERFORM ,V?LOOK-INSIDE ,GOGGLES>
		       <RTRUE>)
		      (<PRSI? ,WALL>
		       <TELL
"You see the inside of the wall, but apparently it's too thick for the goggles
to see all the way through." CR>)>)
	       (<VERB? EXAMINE>
		<COND (<NOUN-USED? ,GOGGLES ,W?ETCHING>
		       <PERFORM ,V?READ ,GOGGLES>
		       <RTRUE>)
		      (T
		       <TELL
"There is a small etching on one side of the goggles." CR>)>)
	       (<VERB? READ>
		<TELL "\"Frobozz Magic Goggles Company.\"" CR>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,GOGGLES ,WORNBIT>
		       <TELL "You glance about you" ,ELLIPSIS>
		       <V-LOOK>)
		      (T
		       <TELL ,YOULL-HAVE-TO "wear them to do that." CR>)>)>>

<ROUTINE DISCOVER-X-RAY ()
	 <COND (,DONT-KNOW-ABOUT-XRAY
		<SETG DONT-KNOW-ABOUT-XRAY <>>
		<TELL
"This is incredible! You can see right through the outside of the ">
		<COND (<NOT <PRSO? ,UNOPENED-NUT>>
		       <TELL "closed ">)>
		<TELL D ,PRSO " as if it were transparent! ">)>>

<GLOBAL DONT-KNOW-ABOUT-XRAY T>

<OBJECT CRATE
	(LOC PYRAMID)
	(DESC "crate")
	(LDESC
"Sitting in the corner is a wooden shipping crate with some writing
stencilled across the top.")
	(SYNONYM CRATE WRITING)
	(ADJECTIVE WOODEN SHIPPING STENCILLED)
	(FLAGS READBIT BURNBIT CONTBIT SEARCHBIT TAKEBIT)
	(CAPACITY 100)
	(OWNER CRATE) ;"read writing on crate"
	(SIZE 80)
	(TEXT
"\"1000 Clown Noses, Red|
Frobozz Magic Clown Nose Company\"")>

<END-SEGMENT>

<BEGIN-SEGMENT CASTLE>

<ROOM PYRAMID-R
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Pyramid Room")
      (WEST PER WEIRD-ENTER-F)
      (OUT PER WEIRD-ENTER-F)
      (FLAGS RLANDBIT)
      (VALUE 7)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-11>)
      (ICON PYRAMID-ICON)
      (ACTION PYRAMID-F)>

<OBJECT MANUSCRIPT
	(LOC PYRAMID-R)
	(DESC "manuscript")
	(SYNONYM MANUSCRIPT)
	(FLAGS READBIT TAKEBIT BURNBIT MAGICBIT)
	(VALUE 12)
	(TEXT
"The manuscript is entitled \"On the Discoloration of Roadside Slush.\" You
try reading it, but keep dozing off on the third or fourth word.")> 

<ROOM PYRAMID-L
      (LOC ROOMS)
      (REGION "Flatheadia")
      (DESC "Pyramid Room")
      (EAST PER WEIRD-ENTER-F)
      (OUT PER WEIRD-ENTER-F)
      (FLAGS RLANDBIT)
      (VALUE 7)
      (MAP-LOC <PTABLE MAIN-MAP-NUM MAP-GEN-Y-3 MAP-GEN-X-9>)
      (ICON PYRAMID-ICON)
      (ACTION PYRAMID-F)>

<ROUTINE PYRAMID-F ("OPT" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room, though rather wide at floor level, narrows as it rises like
the interior of a pyramid or of an enormous beehive. ">
		<COND (<EQUAL? ,TOWER-BEATEN ,HERE>
		       <TELL "The only exit is ">
		       <COND (<EQUAL? ,HERE ,PYRAMID>
			      <TELL "south">)
			     (<EQUAL? ,HERE ,PYRAMID-L>
			      <TELL "east">)
			     (T
			      <TELL "west">)>
		       <TELL ".">)
		      (T
		       <TELL
"There are no visible exits, although there's a faint
outline of a doorway on the ">
		       <COND (<EQUAL? ,HERE ,PYRAMID>
			      <TELL "south">)
			     (<EQUAL? ,HERE ,PYRAMID-L>
			      <TELL "east">)
			     (T
			      <TELL "west">)>
		       <TELL " wall.">)>)>>

<BEGIN-SEGMENT 0>

<OBJECT CUP
	(LOC PYRAMID-L)
	(DESC "cup")
	(SYNONYM CUP)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT)
	(ACTION CUP-F)>

<ROUTINE CUP-F ()
	 <COND (<VERB? DRINK DRINK-FROM>
		<COND (<IN? ,POTION ,CUP>
		       <PERFORM ,V?DRINK ,POTION>
		       <RTRUE>)
		      (T
		       <TELL "The cup is empty!" CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CUP>
		     <IN? ,POTION ,CUP>>
		<PERFORM ,V?PUT ,PRSO ,POTION>
		<RTRUE>)>>

<END-SEGMENT>
<BEGIN-SEGMENT CASTLE>

<OBJECT POTION
	(LOC CUP)
	(DESC "magic potion")
	(SYNONYM POTION POTIONS LIQUID)
	(ADJECTIVE MAGIC YELLOW-GREEN)
	(FLAGS NARTICLEBIT)
	(RESEARCH
"\"Potions are the most accessible form of magic for the masses, since
they are simply drunk like water. No lessons in complicated spell-casting
are required.\"")
	(ACTION POTION-F)>

<END-SEGMENT>
<BEGIN-SEGMENT 0>

<GLOBAL POTION-GULPS 4>

<GLOBAL PLANT-TALKER <>>

<ROUTINE POTION-F ("AUX" X)
	 <COND (<VERB? TASTE DRINK>
		<COND (<NOT <ULTIMATELY-IN? ,CUP>>
		       <MOVE ,CUP ,PROTAGONIST>
		       <TELL "[taking the cup first]" CR>)>
		<TELL "You take a gulp. The potion is now ">
		<COND (<EQUAL? ,POTION-GULPS 4>
		       <TELL "a quarter">)
		      (<EQUAL? ,POTION-GULPS 3>
		       <TELL "half">)
		      (<EQUAL? ,POTION-GULPS 2>
		       <TELL "three-quarters">)
		      (T
		       <REMOVE ,POTION>
		       <TELL "all">)>
		<TELL " gone.">
		<COND (<NOT ,PLANT-TALKER>
		       <SETG PLANT-TALKER T>
		       <TELL " Your ears seem to tingle for a moment." CR>)>
		<SETG POTION-GULPS <- ,POTION-GULPS 1>>
		<QUEUE I-POTION 15>
		<COND (<AND <SET X <FIND-IN ,HERE ,PLANTBIT>>
			    <NOT ,TIME-STOPPED>>
		       <TELL
"   You notice that" T .X " seems to be murmuring." CR>)>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,POTION>>
		<TELL
"Dipping" T ,PRSO " into the potion seems to have no effect on" TR ,PRSO>)
	       (<AND <VERB? POUR>
		     <PRSO? ,POTION>>
		<REMOVE ,POTION>
		<TELL
"The potion vanishes into a cloud of sweet-smelling fumes which
quickly disperse." CR>)
	       (<VERB? EXAMINE>
		<TELL "The potion is a yellow-green color." CR>)>>

<ROUTINE I-POTION ("AUX" X)
	 <SETG PLANT-TALKER <>>
	 <RETURN-FROM-MAP>
	 <TELL "   Your ears tingle again">
	 <COND (<AND <SET X <FIND-IN ,HERE ,PLANTBIT>>
		     <NOT ,TIME-STOPPED>>
		<TELL ", and" T .X " no longer seems to be murmuring">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE PLANT-STUNNED ()
	 <TELL
"There is no response -- perhaps" T ,WINNER " is simply stunned to hear
a human talking plant-talk." CR>
	 <STOP>>

<END-SEGMENT>

<BEGIN-SEGMENT FENSHIRE>

<OBJECT COOKPOT
	(DESC "cookpot")
	(SYNONYM COOKPOT POT)
	(FLAGS CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 50)
	(ACTION COOKPOT-F)>

<ROUTINE COOKPOT-F ()
	 <COND (<VERB? PUT>
		<TELL
"The jester stops you. \"Non, non! Too many cooks spoil zee broth!\"" CR>)>>

<OBJECT COOKFIRE
	(DESC "cookfire")
	(SYNONYM COOKFIRE FIRE)
	(FLAGS FLAMEBIT)>

<END-SEGMENT>