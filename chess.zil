"CHESS for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT FENSHIRE>

<GLOBAL RANK 2> ;"used for both Plain and Construction"

<GLOBAL FILE 5> ;"used for both Plain and Construction"

<GLOBAL PLAIN-LOC 12>

<ROOM PLAIN
      (LOC ROOMS)
      (REGION "Region:  Unknown")
      (DESC "Plain")
      (NORTH PER PLAIN-MOVEMENT-F)
      (NE PER PLAIN-MOVEMENT-F)
      (EAST PER PLAIN-MOVEMENT-F)
      (SE PER PLAIN-MOVEMENT-F)
      (SOUTH PER PLAIN-MOVEMENT-F)
      (SW PER PLAIN-MOVEMENT-F)
      (WEST PER PLAIN-MOVEMENT-F)
      (NW PER PLAIN-MOVEMENT-F)
      (FLAGS RLANDBIT OUTSIDEBIT ONBIT)
      (VALUE 16)
      (ACTION PLAIN-F)>

;"if the sum of RANK and FILE is even, you're on a white square. If the sum
is odd, you're on a black square."

<ROUTINE PLAIN-F ("OPT" (RARG <>) "AUX" PIECE)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are on an amazingly flat plain of ">
		<COND (<EQUAL? <MOD <+ ,RANK ,FILE> 2> 0>
		       <TELL "sun-bleached sand">)
		      (T
		       <TELL "deep, rich loam">)>
		<TELL
". The plain seems to stretch endlessly in all directions">
		<COND (<OR <EQUAL? ,RANK 1 8>
			   <EQUAL? ,FILE 1 8>>
		       <TELL ", except to the ">
		       <COND (<EQUAL? ,RANK 1>
			      <TELL "north">
			      <COND (<EQUAL? ,FILE 1>
				     <TELL " and west">)
				    (<EQUAL? ,FILE 8>
				     <TELL " and east">)>)
			     (<EQUAL? ,RANK 8>
			      <TELL "south">
			      <COND (<EQUAL? ,FILE 1>
				     <TELL " and west">)
				    (<EQUAL? ,FILE 8>
				     <TELL " and east">)>)
			     (<EQUAL? ,FILE 1>
			      <TELL "west">)
			     (T
			      <TELL "east">)>
		       <TELL ", where the world seems to end in a gray void">)>
		<TELL ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <SET PIECE <OR <FIND-IN ,HERE ,BLACKBIT>
			      	    <FIND-IN ,HERE ,WHITEBIT>>>
		     <NOT <FSET? .PIECE ,TOUCHBIT>>>
		<FSET .PIECE ,TOUCHBIT>
		<COND (<PROB 30>
		       <TELL
"   The " D .PIECE " notices your cloak and bows gracefully. \"Greetings,
Lordship. It's been a long time between moves -- I'll bet you've got a great
one planned!\"" CR>)>)>>

<ROUTINE PLAIN-MOVEMENT-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RFALSE>)
	       (<OR <AND <EQUAL? ,RANK 1>
			 <PRSO? ,P?NORTH ,P?NE ,P?NW>>
		    <AND <EQUAL? ,RANK 8>
			 <PRSO? ,P?SOUTH ,P?SE ,P?SW>>
		    <AND <EQUAL? ,FILE 8>
			 <PRSO? ,P?EAST ,P?NE ,P?SE>>
		    <AND <EQUAL? ,FILE 1>
			 <PRSO? ,P?WEST ,P?NW ,P?SW>>>
		<TELL "The world ends at a gray void in that direction." CR>
		<RFALSE>)>
	 <COND (<PRSO? ,P?NORTH ,P?NE ,P?NW>
		<SETG RANK <- ,RANK 1>>)>
	 <COND (<PRSO? ,P?SOUTH ,P?SE ,P?SW>
		<SETG RANK <+ ,RANK 1>>)>
	 <COND (<PRSO? ,P?EAST ,P?SE ,P?NE>
		<SETG FILE <+ ,FILE 1>>)>
	 <COND (<PRSO? ,P?WEST ,P?SW ,P?NW>
		<SETG FILE <- ,FILE 1>>)>
	 <STORE ,PLAIN-OFFSET ,PLAIN-LOC>
	 <SETG PLAIN-LOC <- <+ <* <- ,RANK 1> 8> ,FILE> 1>>
	 <UNSTORE ,PLAIN-OFFSET ,PLAIN-LOC>
	 ,PLAIN>

<OBJECT BLACK-KNIGHT
	(DESC "mounted soldier")
	(LDESC
"There is a soldier on horseback here. His armor is made of the dullest
metals, and his steed is darker than the night.")
	(SYNONYM SOLDIER KNIGHT HORSE MAN)
	(ADJECTIVE MOUNTED BLACK)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT BLACKBIT)
	(ACTION PIECE-F)>

<OBJECT WHITE-KNIGHT
	(DESC "mounted soldier")
	(LDESC
"There is a soldier on horseback here. His armor is made of the shiniest
metals, and his steed is lighter than drifted snow.")
	(SYNONYM SOLDIER KNIGHT HORSE MAN)
	(ADJECTIVE MOUNTED WHITE)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT WHITEBIT)
	(ACTION PIECE-F)>

<OBJECT BLACK-PAWN
	(DESC "foot soldier")
	(LDESC
"You spot a solitary, bored-looking foot soldier. His face is smudged with
coal dust, his uniform is sewn from deeply dyed wool, and the handle of his
sword is solid obsidian.")
	(SYNONYM SOLDIER PAWN MAN)
	(ADJECTIVE FOOT BLACK)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT BLACKBIT)
	(ACTION PIECE-F)>

<OBJECT BLACK-QUEEN
	(DESC "queen")
	(LDESC
"A regal woman proudly surveys the landscape in all directions. Her skin
is dark; her royal garments even darker.")
	(SYNONYM QUEEN WOMAN)
	(ADJECTIVE REGAL PROUD DARK BLACK)
	(FLAGS ACTORBIT FEMALEBIT CONTBIT OPENBIT SEARCHBIT BLACKBIT)
	(ACTION PIECE-F)>

<OBJECT WHITE-CASTLE
	(DESC "man atop a castle tower")
	(LDESC
"Nearby rises a small tower keep, made of creamy marble. Between the
crenellations of the parapet you spot a man, dressed in an ivory chain
mail and carrying a crossbow made of birch.")
	(SYNONYM MAN TOWER CASTLE ROOK)
	(ADJECTIVE CASTLE WHITE)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT WHITEBIT)
	(ACTION PIECE-F)>

<OBJECT BLACK-BISHOP
	(DESC "high priest")
	(LDESC
"You hear a sing-song prayer chant and turn to see a high priest of some sort.
His tall, ebony headpiece bears a religious cipher, and his vestments seem to
soak up all light.")
	(SYNONYM PRIEST BISHOP MAN)
	(ADJECTIVE HIGH BLACK)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT BLACKBIT)
	(ACTION PIECE-F)>

<OBJECT WHITE-PAWN
	(DESC "foot soldier")
	(LDESC
"You spot a solitary, bored-looking foot soldier. His face is smudged with
flour, his uniform is sewn from pure undyed cotton, and the handle of his
sword is solid quartz.")
	(SYNONYM SOLDIER PAWN MAN)
	(ADJECTIVE WHITE FOOT)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT WHITEBIT)
	(ACTION PIECE-F)>

<OBJECT WHITE-QUEEN
	(DESC "queen")
	(LDESC
"A regal woman proudly surveys the landscape in all directions. Her royal
garments are as white as her pale complexion.")
	(SYNONYM QUEEN WOMAN)
	(ADJECTIVE REGAL PROUD WHITE)
	(FLAGS ACTORBIT FEMALEBIT CONTBIT OPENBIT SEARCHBIT WHITEBIT)
	(ACTION PIECE-F)>

<OBJECT WHITE-KING
	(DESC "royal leader")
	(LDESC
"A tall man wearing princely robes stands nearby. His bearing indicates that
this is a man accustomed to command. His linen robes are trimmed with ermine,
and his crown is studded with diamonds and opals.")
	(SYNONYM LEADER KING MAN)
	(ADJECTIVE ROYAL WHITE TALL)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT WHITEBIT)
	(ACTION PIECE-F)>

<OBJECT WHITE-KING-CROWN
	(LOC WHITE-KING)
	(DESC "crown")
	(SYNONYM CROWN)
	(FLAGS NDESCBIT)>

<OBJECT WHITE-KING-ROBE
	(LOC WHITE-KING)
	(DESC "robe")
	(SYNONYM ROBE)
	(FLAGS NDESCBIT)>

<OBJECT BLACK-KING
	(DESC "royal leader")
	(LDESC
"A tall man wearing princely robes stands nearby. His bearing indicates that
this is a man accustomed to command. His velvet robes are trimmed with mink,
and his crown is studded with polished onyx.")
	(SYNONYM LEADER KING MAN)
	(ADJECTIVE ROYAL BLACK TALL)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT BLACKBIT)
	(ACTION PIECE-F)>

<OBJECT BLACK-KING-ROBE
	(LOC BLACK-KING)
	(DESC "robe")
	(SYNONYM ROBE)
	(FLAGS NDESCBIT)>

<OBJECT BLACK-KING-CROWN
	(LOC BLACK-KING)
	(DESC "crown")
	(SYNONYM CROWN)
	(FLAGS NDESCBIT)>

<BEGIN-SEGMENT 0>
;<BEGIN-SEGMENT VILLAGE>
;<BEGIN-SEGMENT LOWER>

<GLOBAL DIR-CNT 0>

<ROUTINE PIECE-F ("OPT" (ARG <>) "AUX" CNT)
	 <COND (<OR <FSET? ,WINNER ,BLACKBIT>
		    <FSET? ,WINNER ,WHITEBIT>>
		<COND (,TIME-STOPPED
		       <SETG P-CONT -1>
		       <TELL
"Seemingly frozen," T ,WINNER " is unresponsive." CR>)
		      (<AND <VERB? WALK>
			    <PRSO? ,P?IN ,P?OUT ,P?UP ,P?DOWN>>
		       <SETG DIR-CNT 0>
		       <TELL ,CANNOT-TRAVEL>
		       <STOP>)
		      (<AND <NOT <AND <VERB? WALK>
				      <T? ,P-WALK-DIR>>>
			    <NOT <AND <VERB? MOVE>
				      <PRSO? ,INTDIR>>>>
		       <SETG DIR-CNT 0>
		       <COND (<AND <VERB? WALK> ;"as in >ROOK, GO SOUTH ONE"
				   ;<PRSO? ,WALL>
				   <NOUN-USED? ,PRSO ,W?ONE>>
			      <TELL
"[The proper way to ask" T ,WINNER " to move is simply to tell
the direction(s), as in >CHARACTER, NW.NW]" CR>)
			     (T
		       	      <SETG P-CONT -1>
			      <TELL
"\"You can tell me directions. That's it.\"" CR>)>)
		      (<NOT <EQUAL? ,HERE ,PLAIN ,CONSTRUCTION>>
		       <SETG P-CONT -1>
		       <TELL
"\"The terrain is strange and unfamiliar; I am too terrified to move!\"" CR>)
		      (<EQUAL? ,DIR-CNT 7>
		       <SETG DIR-CNT 0>
		       <SETG P-CONT -1>
		       <TELL "\"Too many directions!\"" CR>)
		      (T
		       <COND (<VERB? MOVE>
			      <SETG PRSO <DIRECTION-CONVERSION>>)>
		       <PUT ,PIECE-MOVE-TABLE ,DIR-CNT ,PRSO>
		       <SETG DIR-CNT <+ ,DIR-CNT 1>>
		       <COND (<AND <G? ,DIR-CNT 1>
			       	   <NOT <EQUAL? ,WINNER
						,WHITE-KNIGHT
						,BLACK-KNIGHT>>
				   <NOT <EQUAL? ,PRSO
						<GET ,PIECE-MOVE-TABLE
						     <- ,DIR-CNT 2>>>>>
			      ;"checks to make sure that all directions given
				are the same, except in the case of knights"
			      <SETG DIR-CNT 0>
			      <COPYT ,PIECE-MOVE-TABLE 0 16>
			      <TELL ,CANNOT-TRAVEL>
			      <STOP>)
			     (<OR ,P-CONT ,M-PTR>
			      <SETG CLOCK-WAIT T>)
			     (T
			      <SETG DIR-CNT 0>
			      <MOVE-PIECE>)>)>
		<RTRUE>)
	       (<AND <VERB? ENTER>
		     <PRSO? ,WHITE-CASTLE>
		     <NOT <NOUN-USED? ,WHITE-CASTLE ,W?MAN>>>
		<TELL "Oddly, there doesn't seem to be any entrance." CR>)
	       (<AND <VERB? ENTER>
		     <PRSO? ,WHITE-KNIGHT ,BLACK-KNIGHT>
		     <NOUN-USED? ,PRSO ,W?HORSE>>
		<TELL "The horse isn't large enough for two riders." CR>)
	       (<VERB? MOVE>
		<TELL
"Perhaps you should tell" T ,PRSO " the direction(s)." CR>)
	       (<AND <VERB? GIVE>
		     <NOT <FSET? ,PRSO ,TRYTAKEBIT>>
		     <NOT <FIND-IN ,PRSO ,TRYTAKEBIT>>
		     <OR <FSET? ,PRSI ,WHITEBIT>
			 <FSET? ,PRSI ,BLACKBIT>>>
		<COND (,TIME-STOPPED
		       <PERFORM ,V?TELL ,PRSI>
		       <RTRUE>)>
		<MOVE ,PRSO ,PRSI>
		<TELL "The " D ,PRSI " takes" T ,PRSO ".">
		<COND (<AND <PRSO? ,PIGEON>
			    <NOT <EQUAL? ,HERE <META-LOC ,PERCH>>>
			    <OR <NOT <EQUAL? ,HERE ,OUBLIETTE>>
				<NOT <EQUAL? ,REMOVED-PERCH-LOC ,OUBLIETTE>>>>
		       <PIECE-TAKES-PIGEON ,PRSI>)
		      (T
		       <TELL
" \"Your graciousness is not unappreciated, your Lordship.\"" CR>)>)
	       (<AND <VERB? ASK-FOR>
		     <OR <FSET? <LOC ,PRSI> ,WHITEBIT>
		     	 <FSET? <LOC ,PRSI> ,BLACKBIT>>>
		<PERFORM ,V?TAKE ,PRSI>
		<RTRUE>)>>

<ROUTINE PIECE-TAKES-PIGEON (PIECE "OPTIONAL" (DO-CR T))
	 <MOVE-TO-PERCH .PIECE>
	 <TELL " Instantly,">
	 <COND (<EQUAL? .PIECE ,WHITE-CASTLE>
		<TELL " the tower">)
	       (T
		<TELL T .PIECE>)>
	 <TELL " seems to grow more distant without moving. Within seconds,">
	 <COND (<EQUAL? .PIECE ,WHITE-CASTLE>
		<TELL " the tower">)
	       (T
		<TELL T .PIECE>)>
	 <TELL " is gone.">
	 <COND (.DO-CR
		<CRLF>)>
	 <RTRUE>>

<CONSTANT PIECE-MOVE-TABLE
	<TABLE 0 0 0 0 0 0 0 0>>

<ROUTINE MOVE-PIECE
	 ("AUX" CNT DIR NEW-RANK NEW-FILE NEW-LOC X OFFSET BLOCK)
	 <SET NEW-RANK ,RANK>
	 <SET NEW-FILE ,FILE>
	 <SET NEW-LOC <+ <* <- .NEW-RANK 1> 8> <- .NEW-FILE 1>>>
	 <SET CNT 0>
	 <REPEAT ()
		 <SET DIR <GET ,PIECE-MOVE-TABLE .CNT>>
		 <COND (<EQUAL? .DIR <>>
			<RETURN>)>
		 <COND (<EQUAL? .DIR ,P?NORTH ,P?NE ,P?NW>
			<SET NEW-RANK <- .NEW-RANK 1>>)>
		 <COND (<EQUAL? .DIR ,P?EAST ,P?NE ,P?SE>
			<SET NEW-FILE <+ .NEW-FILE 1>>)>
		 <COND (<EQUAL? .DIR ,P?SOUTH ,P?SE ,P?SW>
			<SET NEW-RANK <+ .NEW-RANK 1>>)>
		 <COND (<EQUAL? .DIR ,P?WEST ,P?SW ,P?NW>
			<SET NEW-FILE <- .NEW-FILE 1>>)>
		 <SET CNT <+ .CNT 1>>
		 <COND (<AND <EQUAL? ,HERE ,CONSTRUCTION>
			     <NOT <EQUAL? ,WINNER ,BLACK-KNIGHT ,WHITE-KNIGHT>>
			     <OBSTRUCTION .NEW-LOC .DIR>>
			<SET BLOCK T>
			<COND (<AND <EQUAL? .DIR ,P?EAST>
				    <EQUAL? .NEW-LOC 47>>
			       <TELL
"\"Appearances deceive you -- such a move would send me
off the edge of the world!\"" CR>)
			      (T
			       <TELL
"\"My word! There appears to be a wall in the way!\"" CR>)>
			<RETURN>)>
 		 <SET NEW-LOC <+ <* <- .NEW-RANK 1> 8> <- .NEW-FILE 1>>>
		 <COND (<AND <GET ,PIECE-MOVE-TABLE .CNT>
			     <NOT <EQUAL? ,WINNER ,BLACK-KNIGHT ,WHITE-KNIGHT>>
			     <PIECE-AT-NEW-LOC? .NEW-LOC>>
			<SET BLOCK T>
			<TELL
"\"Alas, the path between here and there is not unobstructed.\"" CR>
			<RETURN>)>>
	 <SET DIR <DIR-TO-STRING <GET ,PIECE-MOVE-TABLE 0>>>
	 ;"for later use, after chess piece says 'I'm off!'"
	 <COPYT ,PIECE-MOVE-TABLE 0 16>
	 <COND (.BLOCK ;"obstructed path to new square"
		<RTRUE>)>
	 <SET X <ILLEGAL-MOVE? .NEW-LOC .NEW-RANK .NEW-FILE>>
	 <COND (<EQUAL? .X ,M-FATAL> ;"pawn blocked by another piece"
		<TELL "\"That land is occupied!\"" CR>
		<RTRUE>)
	       (.X
		<TELL ,CANNOT-TRAVEL>
		<STOP>)
	       (<OR <G? .NEW-RANK 8>
		    <G? .NEW-FILE 8>
		    <L? .NEW-RANK 1>
		    <L? .NEW-FILE 1>>
		<TELL
"\"You would have me plunge off the end of the world">
		<COND (<EQUAL? ,HERE ,CONSTRUCTION>
		       <TELL
" -- or whatever passes for the end of the world in this forsaken badland">)>
		<TELL "!\"" CR>)
	       (<NOT <TAKE-PIECE? .NEW-LOC>>
		<REMOVE ,WINNER>
		<TELL "\"I'm off!\" The " 'WINNER>
		<COND (<EQUAL? ,WINNER ,WHITE-KNIGHT ,BLACK-KNIGHT>
		       <TELL
" and his steed jump high into the air and vanish! A moment later, you hear
a proud whinny in the distance.">)
		      (T
		       <TELL " moves out of sight to the " .DIR ".">)>
		<CRLF>
		<COND (<AND <EQUAL? ,WINNER ,WHITE-PAWN>
			    <EQUAL? ,HERE ,PLAIN>
			    <L? .NEW-LOC 8>> ;"promote pawn to queen"
		       <ROB ,WHITE-PAWN ,WHITE-QUEEN>
		       <SETG WINNER ,WHITE-QUEEN>)
		      (<AND <EQUAL? ,WINNER ,BLACK-PAWN>
			    <EQUAL? ,HERE ,PLAIN>
			    <G? .NEW-LOC 55>> ;"promote pawn to queen"
		       <ROB ,BLACK-PAWN ,BLACK-QUEEN>
		       <SETG WINNER ,BLACK-QUEEN>)>
		<COND (<EQUAL? ,HERE ,PLAIN>
		       <SET OFFSET ,PLAIN-OFFSET>)
		      (T
		       <SET OFFSET ,CONSTRUCTION-OFFSET>)>
		<PIECE-SNARF <+ .NEW-LOC .OFFSET> ,WINNER>
		<PUT-IN-STORAGE .OFFSET ,WINNER .NEW-LOC>)>>

<ROUTINE DIR-TO-STRING (DIR)
	 <COND (<EQUAL? .DIR ,P?UP>
		<RETURN "up">)
	       (<EQUAL? .DIR ,P?DOWN>
		<RETURN "down">)
	       (<EQUAL? .DIR ,P?NORTH>
		<RETURN "north">)
	       (<EQUAL? .DIR ,P?NE>
		<RETURN "northeast">)
	       (<EQUAL? .DIR ,P?EAST>
		<RETURN "east">)
	       (<EQUAL? .DIR ,P?SE>
		<RETURN "southeast">)
	       (<EQUAL? .DIR ,P?SOUTH>
		<RETURN "south">)
	       (<EQUAL? .DIR ,P?SW>
		<RETURN "southwest">)
	       (<EQUAL? .DIR ,P?WEST>
		<RETURN "west">)
	       (<EQUAL? .DIR ,P?NW>
		<RETURN "northwest">)>>

<ROUTINE PIECE-SNARF (NEW-LOC SNARFER "AUX" OBJ (CNT 0) (TOOK-PIGEON <>))
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,STORAGE-TABLE-LENGTH>>
			<RETURN>)
		       (<EQUAL? <GET ,STORAGE-TABLE .CNT> .NEW-LOC>
			<SET OBJ <GET ,STORAGE-TABLE <+ .CNT 1>>>
			<COND (<AND <FSET? .OBJ ,TAKEBIT>
				    <NOT <FSET? .OBJ ,TRYTAKEBIT>>
				    <NOT <FIND-IN .OBJ ,TRYTAKEBIT>>>
			       <COND (<EQUAL? .OBJ ,PIGEON>
				      <SET TOOK-PIGEON T>)>
			       <MOVE .OBJ .SNARFER>
			       <PUT ,STORAGE-TABLE .CNT 0>
			       <PUT ,STORAGE-TABLE <+ .CNT 1> 0>)>)>
		 <SET CNT <+ .CNT 2>>>
	 <COND (.TOOK-PIGEON
		<MOVE-TO-PERCH .SNARFER>)>>

<ROUTINE TAKE-PIECE? (NEW-LOC "AUX" (TAKEE <>) (VAL <>))
	 <SET TAKEE <PIECE-AT-NEW-LOC? .NEW-LOC>>
	 <COND (<NOT .TAKEE>
		T)
	       (<OR <AND <FSET? .TAKEE ,WHITEBIT>
			 <FSET? ,WINNER ,WHITEBIT>>
		    <AND <FSET? .TAKEE ,BLACKBIT>
			 <FSET? ,WINNER ,BLACKBIT>>>
		<TELL "\"I cannot attack one of my own side!\"" CR>
		<SET VAL T>)
	       (T ;"take the TAKEE"
		<PIECE-AT-NEW-LOC? .NEW-LOC T>)>
	 <RETURN .VAL> ;"this routine is called by a predicate">

<ROUTINE ILLEGAL-MOVE? (NEW-LOC NEW-RANK NEW-FILE "AUX" (TAKEE <>) OLD-LOC)
	 <SET OLD-LOC <COND (<EQUAL? ,HERE ,PLAIN>
			     ,PLAIN-LOC)
			    (T
			     ,CONSTRUCTION-LOC)>>
	 <COND (<EQUAL? ,WINNER ,WHITE-KNIGHT ,BLACK-KNIGHT>
		<COND (<EQUAL? <- .OLD-LOC .NEW-LOC>
			       6 10 15 17 -6 -10 -15 -17>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<EQUAL? ,WINNER ,WHITE-KING ,BLACK-KING>
		<COND (<EQUAL? <- .OLD-LOC .NEW-LOC>
			       1 7 8 9 -1 -7 -8 -9>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<EQUAL? ,WINNER ,BLACK-BISHOP>
		<COND (<G? .OLD-LOC .NEW-LOC>
		       <COND (<EQUAL? <MOD <- .OLD-LOC .NEW-LOC> 7> 0>
			      <RFALSE>)
			     (<EQUAL? <MOD <- .OLD-LOC .NEW-LOC> 9> 0>
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      (T
		       <COND (<EQUAL? <MOD <- .NEW-LOC .OLD-LOC> 7> 0>
			      <RFALSE>)
			     (<EQUAL? <MOD <- .NEW-LOC .OLD-LOC> 9> 0>
			      <RFALSE>)
			     (T
			      <RTRUE>)>)>)
	       (<EQUAL? ,WINNER ,WHITE-CASTLE>
		<COND (<AND <NOT <EQUAL? ,RANK .NEW-RANK>>
		     	    <NOT <EQUAL? ,FILE .NEW-FILE>>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? ,WINNER ,WHITE-QUEEN ,BLACK-QUEEN>
		<COND (<OR <EQUAL? ,RANK .NEW-RANK>
			   <EQUAL? ,FILE .NEW-FILE>>
		       <RFALSE>)
		      (<AND <G? .NEW-LOC .OLD-LOC>
			    <OR <EQUAL? <MOD <- .NEW-LOC .OLD-LOC> 7> 0>
				<EQUAL? <MOD <- .NEW-LOC .OLD-LOC> 9> 0>>>
		       <RFALSE>)
		      (<AND <G? .OLD-LOC .NEW-LOC>
			    <OR <EQUAL? <MOD <- .OLD-LOC .NEW-LOC> 7> 0>
				<EQUAL? <MOD <- .OLD-LOC .NEW-LOC> 9> 0>>>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<EQUAL? ,WINNER ,BLACK-PAWN>
		<SET TAKEE <PIECE-AT-NEW-LOC? .NEW-LOC>>
		<COND (<AND <EQUAL? .OLD-LOC 14>
			    <EQUAL? .NEW-LOC 30>>
		       ;"pawn can move two spaces on first move"
		       <COND (.TAKEE
			      <RFATAL>)
			     (T
			      <RFALSE>)>)
		      (<EQUAL? <- .NEW-LOC .OLD-LOC> 7 9>
		       <COND (<NOT .TAKEE>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<EQUAL? <- .NEW-LOC .OLD-LOC> 8>
		       <COND (.TAKEE
			      <RFATAL>)
			     (T
			      <RFALSE>)>)
		      (T
		       <RTRUE>)>)
	       (<EQUAL? ,WINNER ,WHITE-PAWN>
		<SET TAKEE <PIECE-AT-NEW-LOC? .NEW-LOC>>
		<COND (<AND <EQUAL? .OLD-LOC 49>
			    <EQUAL? .NEW-LOC 33>>
		       ;"pawn can move two spaces on first move"
		       <COND (.TAKEE
			      <RFATAL>)
			     (T
			      <RFALSE>)>)
		      (<EQUAL? <- .OLD-LOC .NEW-LOC> 7 9>
		       <COND (.TAKEE
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      (<EQUAL? <- .OLD-LOC .NEW-LOC> 8>
		       <COND (.TAKEE
			      <RFATAL>)
			     (T
			      <RFALSE>)>)
		      (T
		       <RTRUE>)>)
	       (T
		<TELL "Bug7" CR>)>>

<ROUTINE PIECE-AT-NEW-LOC?
	 (NEW-LOC "OPTIONAL" (TAKE-PIECE <>) "AUX" (CNT 0) (TAKEE <>))
	 <SET NEW-LOC <+ .NEW-LOC <COND (<EQUAL? ,HERE ,CONSTRUCTION>
					 ,CONSTRUCTION-OFFSET)
					(T
					 ,PLAIN-OFFSET)>>>
	 <REPEAT ()
		<COND (<EQUAL? .NEW-LOC <GET ,STORAGE-TABLE .CNT>>
		       <SET TAKEE <GET ,STORAGE-TABLE <+ .CNT 1>>>
		       <COND (<OR <FSET? .TAKEE ,WHITEBIT>
				  <FSET? .TAKEE ,BLACKBIT>>
			      <COND (.TAKE-PIECE
				     <ROB .TAKEE ,WINNER>
				     <PUT ,STORAGE-TABLE .CNT 0>)>
			      <RETURN>)>)>
		 <SET CNT <+ .CNT 2>>
		 <COND (<NOT <L? .CNT ,STORAGE-TABLE-LENGTH>>
			<RETURN>)>>
	 <COND (<NOT .TAKEE>
		<RFALSE>) 
	       (<OR <FSET? .TAKEE ,WHITEBIT>
		    <FSET? .TAKEE ,BLACKBIT>>
		<RETURN .TAKEE>)
	       (T
		<RFALSE>)>>

<ROUTINE OBSTRUCTION (L DIR "OPT" (CALLED-BY-EXIT-F <>) "AUX" (CHANGE 0))
	 <COND (<AND <EQUAL? .DIR ,P?NORTH>
		     <OR <INTBL? .L ,NORTH-EXITS 11>
			 <INTBL? <+ .L 100> ,NORTH-EXITS 11>>>
		<SET CHANGE -8>)
	       (<AND <EQUAL? .DIR ,P?NE>
		     <INTBL? .L ,NE-EXITS 17>>
		<SET CHANGE -7>)
	       (<EQUAL? .DIR ,P?EAST>
		<COND (<AND <EQUAL? .L 47>
			    .CALLED-BY-EXIT-F>
		       <SET CHANGE 100> ;"kludge")
		      (<INTBL? .L ,EAST-EXITS 15>
		       <SET CHANGE 1>)>)
	       (<AND <EQUAL? .DIR ,P?SE>
		     <OR <INTBL? .L ,SE-EXITS 7>
		     	 <INTBL? <+ .L 100> ,SE-EXITS 7>>>
		<SET CHANGE 9>)
	       (<AND <EQUAL? .DIR ,P?SOUTH>
		     <OR <INTBL? <+ .L 8> ,NORTH-EXITS 11>
			 <INTBL? <+ .L 108> ,NORTH-EXITS 11>>>
		<SET CHANGE 8>)
	       (<AND <EQUAL? .DIR ,P?SW>
		     <INTBL? <+ .L 7> ,NE-EXITS 17>>
		<SET CHANGE 7>)
	       (<AND <EQUAL? .DIR ,P?WEST>
		     <INTBL? <- .L 1> ,EAST-EXITS 15>>
		<SET CHANGE -1>)
	       (<AND <EQUAL? .DIR ,P?NW>
		     <OR <INTBL? <- .L 9> ,SE-EXITS 7>
		     	 <INTBL? <+ .L 91> ,SE-EXITS 7>>>
		<SET CHANGE -9>)>
	 <COND (.CALLED-BY-EXIT-F
		<RETURN .CHANGE>)
	       (<EQUAL? .CHANGE 0>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LOWER>

<ROOM FIELD-OFFICE
      (LOC ROOMS)
      (DESC "Field Office")
      (REGION "Flatheadia")
      (LDESC
"This is a temporary headquarters for a construction site to the west.
Another exit leads east.")
      (EAST TO EXIT)
      (WEST PER CONSTRUCTION-ENTER-F)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (MAP-LOC <PTABLE LOWER-LEVEL-MAP-NUM MAP-GEN-Y-7 MAP-GEN-X-4>)>

<ROUTINE CONSTRUCTION-ENTER-F ("OPTIONAL" (RARG <>)) ;"called by NEXT-ROOM?"
	 <COND (.RARG
		<RFALSE>)>
	 <SETG CONSTRUCTION-LOC 47>
	 ,CONSTRUCTION>

<OBJECT BLUEPRINT
	(LOC FIELD-OFFICE)
	(DESC "blueprint")
	(SYNONYM BLUEPRINT)
	(FLAGS TAKEBIT BURNBIT READBIT)
	(SIZE 2)
	(TEXT "[This is the blueprint from your ZORK ZERO package.]")>

<BEGIN-SEGMENT 0>

<OBJECT HAMMER ;"in table, at Construction room #61"
	(DESC "hammer")
	(SYNONYM HAMMER)
	(FLAGS TAKEBIT)
	(SIZE 16)
	(ACTION HAMMER-F)>

<ROUTINE HAMMER-F ()
	 <COND (<AND <VERB? KILL>
		     <PRSI? ,HAMMER>> ;"hit object with hammer"
		<PERFORM ,V?MUNG ,PRSO ,HAMMER>
		<RTRUE>)
	       (<AND <VERB? MUNG>
		     <PRSI? ,HAMMER>
		     <FSET? ,PRSO ,ANIMATEDBIT>>
		<TELL "Fortunately," T ,PRSO " evades your blow." CR>)>>

<END-SEGMENT>

<BEGIN-SEGMENT LOWER>

<ROOM CONSTRUCTION
      (LOC ROOMS)
      (DESC "Construction")
      (REGION "Flatheadia")
      (NORTH PER CONSTRUCTION-MOVEMENT-F)
      (NE PER CONSTRUCTION-MOVEMENT-F)
      (EAST PER CONSTRUCTION-MOVEMENT-F)
      (SE PER CONSTRUCTION-MOVEMENT-F)
      (SOUTH PER CONSTRUCTION-MOVEMENT-F)
      (SW PER CONSTRUCTION-MOVEMENT-F)
      (WEST PER CONSTRUCTION-MOVEMENT-F)
      (NW PER CONSTRUCTION-MOVEMENT-F)
      (FLAGS RLANDBIT UNDERGROUNDBIT)
      (ACTION CONSTRUCTION-F)>

<ROUTINE CONSTRUCTION-F ("OPT" (RARG <>) "AUX" (CNT 0))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<INTBL? ,CONSTRUCTION-LOC ,NORTH-EXITS 11>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? ,CONSTRUCTION-LOC ,NE-EXITS 17>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? ,CONSTRUCTION-LOC ,EAST-EXITS 15>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? ,CONSTRUCTION-LOC ,SE-EXITS 7>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? <+ ,CONSTRUCTION-LOC 8> ,NORTH-EXITS 11>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? <+ ,CONSTRUCTION-LOC 7> ,NE-EXITS 17>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? <- ,CONSTRUCTION-LOC 1> ,EAST-EXITS 15>
		       <SET CNT <+ .CNT 1>>)>
		<COND (<INTBL? <- ,CONSTRUCTION-LOC 9> ,SE-EXITS 7>
		       <SET CNT <+ .CNT 1>>)>
		<TELL
"You are in an abandoned underground construction site, roughly
octagonal in shape. ">
		<COND (<G? .CNT 0>
		       <TELL "There ">
		       <COND (<EQUAL? .CNT 1>
			      <TELL "is an exit">)
			     (T
			      <TELL "are exits">)>
		       <TELL " to the ">
		       <COND (<INTBL? ,CONSTRUCTION-LOC ,NORTH-EXITS 11>
			      <TELL "north">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? ,CONSTRUCTION-LOC ,NE-EXITS 17>
			      <TELL "northeast">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? ,CONSTRUCTION-LOC ,EAST-EXITS 15>
			      <TELL "east">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? ,CONSTRUCTION-LOC ,SE-EXITS 7>
			      <TELL "southeast">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? <+ ,CONSTRUCTION-LOC 8> ,NORTH-EXITS 11>
			      <TELL "south">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? <+ ,CONSTRUCTION-LOC 7> ,NE-EXITS 17>
			      <TELL "southwest">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? <- ,CONSTRUCTION-LOC 1> ,EAST-EXITS 15>
			      <TELL "west">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <COND (<INTBL? <- ,CONSTRUCTION-LOC 9> ,SE-EXITS 7>
			      <TELL "northwest">
			      <SET CNT <- .CNT 1>>
			      <AND-OR-COMMA .CNT>)>
		       <TELL ". ">)>
		<COND (<EQUAL? ,CONSTRUCTION-LOC 47>
		       <TELL "Also, a heavily used passage leads east. ">)>
		<TELL
"Engraved on the wall is the number " N ,CONSTRUCTION-LOC ".">)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG RANK <+ </ ,CONSTRUCTION-LOC 8> 1>>
	 	<SETG FILE <+ <MOD ,CONSTRUCTION-LOC 8> 1>>
		<UNSTORE ,CONSTRUCTION-OFFSET ,CONSTRUCTION-LOC>)>>

<ROUTINE AND-OR-COMMA (CNT)
	 <COND (<EQUAL? .CNT 1>
		<TELL " and ">)
	       (<G? .CNT 1>
		<TELL ", ">)>>

<ROUTINE CONSTRUCTION-MOVEMENT-F ("OPT" (RARG <>) "AUX" (CHANGE 0))
	 <COND (.RARG
		<RFALSE>)>
	 <STORE ,CONSTRUCTION-OFFSET ,CONSTRUCTION-LOC>
	 <SET CHANGE <OBSTRUCTION ,CONSTRUCTION-LOC ,PRSO T>>
	 <COND (<EQUAL? .CHANGE 100>
		<RETURN ,FIELD-OFFICE>)>
	 <SETG RANK <+ </ ,CONSTRUCTION-LOC 8> 1>>
	 <SETG FILE <+ <MOD ,CONSTRUCTION-LOC 8> 1>>
	 <COND (<EQUAL? .CHANGE 0>
		<UNSTORE ,CONSTRUCTION-OFFSET ,CONSTRUCTION-LOC>
		<CANT-GO>
		<RFALSE>)
	       (T
		<SETG CONSTRUCTION-LOC <+ ,CONSTRUCTION-LOC .CHANGE>>
		<UNSTORE ,CONSTRUCTION-OFFSET ,CONSTRUCTION-LOC>
		,CONSTRUCTION)>>

<GLOBAL CONSTRUCTION-LOC 47>

<CONSTANT NORTH-EXITS ;"10 rooms plus placeholder for FM passage = 11 entries"
	<TABLE 99 ;"placeholder" 20 33 37 40 46 48 50 55 59 61>>

<CONSTANT NE-EXITS ;"17 rooms"
	<TABLE 12 13 14 20 22 27 28 29 33 36 41 43 46 49 50 53 54>>

<CONSTANT EAST-EXITS ;"15 rooms"
	<TABLE 5 6 12 22 26 30 34 38 42 44 51 56 57 61 62>>

<CONSTANT SE-EXITS ;"6 rooms plus one placeholder = 7 entries"
	<TABLE 99 ;"placeholder" 17 40 43 48 51 54>>

<OBJECT HARDHAT ;"in table, at Construction room #0"
	(DESC "hardhat")
	(SYNONYM HARDHAT HAT)
	(ADJECTIVE HARD)
	(FLAGS TAKEBIT WEARBIT)
	(GENERIC G-HAT-F)
	(VALUE 25)>

<BEGIN-SEGMENT 0>

<ROUTINE REMOVE-ANY-PIECE (L TAKER "AUX" TAKEE (CNT 0))
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,STORAGE-TABLE-LENGTH>>
			<RETURN>)
		       (<EQUAL? <GET ,STORAGE-TABLE .CNT> .L>
			<SET TAKEE <GET ,STORAGE-TABLE <+ .CNT 1>>>
			<COND (<OR <FSET? .TAKEE ,WHITEBIT>
				   <FSET? .TAKEE ,BLACKBIT>>
			       <ROB .TAKEE .TAKER>
			       <PUT ,STORAGE-TABLE .CNT 0>
			       <PUT ,STORAGE-TABLE <+ .CNT 1> 0>)>)>
		 <SET CNT <+ .CNT 2>>>>

;"codes for putting items in storage in fake rooms, shared by Plain,
Construction, and all five FrobozzCo Building fake rooms"

<CONSTANT STORAGE-TABLE
	  <TABLE 301 BLACK-KNIGHT
	         314 BLACK-PAWN
	         315 WHITE-KNIGHT
	         328 BLACK-BISHOP
	         337 BLACK-KING
	         349 WHITE-PAWN
	         357 WHITE-KING
	         363 WHITE-CASTLE
		 400 HARDHAT
	         461 HAMMER
		1004 MEMO
		3019 T-SQUARE
		4193 INSTRUCTION-BOOKLET
			    0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>

<CONSTANT PLAIN-OFFSET 300>
<CONSTANT CONSTRUCTION-OFFSET 400>
<CONSTANT OFFICES-OFFSET 1000>
<CONSTANT OFFICES-N-OFFSET 2000>
<CONSTANT OFFICES-S-OFFSET 3000>
<CONSTANT OFFICES-E-OFFSET 4000>
<CONSTANT OFFICES-W-OFFSET 5000>

<CONSTANT STORAGE-TABLE-LENGTH 200>

<ROUTINE PUT-IN-STORAGE (OFFSET OBJ L "AUX" (CNT 0))
	 <REPEAT ()
		 <COND (<EQUAL? <GET ,STORAGE-TABLE .CNT> 0>
			<PUT ,STORAGE-TABLE .CNT <+ .L .OFFSET>>
			<PUT ,STORAGE-TABLE <+ .CNT 1> .OBJ>
			<RETURN>)
		       (T
			<SET CNT <+ .CNT 2>>)>>>

<END-SEGMENT>
<BEGIN-SEGMENT LOWER>
<BEGIN-SEGMENT FENSHIRE>
<BEGIN-SEGMENT VILLAGE>

<ROUTINE STORE (OFFSET L "OPT" (RM ,HERE) "AUX" (CNT 0) F N)
	 <SET F <FIRST? .RM>>
	 <REPEAT ()
	       <COND (.F
		      <SET N <NEXT? .F>>)
		     (T
		      <RETURN>)>
	       <COND (<NOT <EQUAL? .F ,PROTAGONIST>>
		      <REPEAT ()
			    <COND (<EQUAL? .F ,JESTER>
			      	   <REMOVE-J>
				   <RETURN>)
				  (<EQUAL? <GET ,STORAGE-TABLE .CNT> 0>
				   <PUT ,STORAGE-TABLE .CNT <+ .L .OFFSET>>
				   <PUT ,STORAGE-TABLE <+ .CNT 1> .F>
				   <SET CNT <+ .CNT 2>>
				   <REMOVE .F>
				   <RETURN>)
				  (T
				   <SET CNT <+ .CNT 2>>)>>)>
	       <SET F .N>>>

<ROUTINE UNSTORE (OFFSET L "OPT" (RM ,HERE) "AUX" (CNT 0))
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,STORAGE-TABLE-LENGTH>>
			<RETURN>)
		       (<EQUAL? <GET ,STORAGE-TABLE .CNT> <+ .L .OFFSET>>
			<MOVE <GET ,STORAGE-TABLE <+ .CNT 1>> .RM>
			<PUT ,STORAGE-TABLE .CNT 0>
			<PUT ,STORAGE-TABLE <+ .CNT 1> 0>)>
		 <SET CNT <+ .CNT 2>>>>

<END-SEGMENT>