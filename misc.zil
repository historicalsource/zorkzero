"MISC for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT 0>

<INCLUDE "PDEFS">

;"macros"

<TELL-TOKENS (CRLF CR)   <CRLF>
	     ;[D ,SIDEKICK <DPRINT-SIDEKICK>]
	     D *	 <DPRINT .X>
	     A *	 <APRINT .X>
	     T ,PRSO 	 <TPRINT-PRSO>
	     T ,PRSI	 <TPRINT-PRSI>
	     T *	 <TPRINT .X>
	     AR *	 <ARPRINT .X>
	     TR *	 <TRPRINT .X>
	     N *	 <PRINTN .X>
	     C *         <PRINTC .X>
	     T-IS-ARE *  <IS-ARE-PRINT .X>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1>
					<NTH .O 1>)
				       (<EQUAL? .X FSET?>
					<FORM OR !.O>)
				       (ELSE
					<FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;"PICK-NEXT expects an LTABLE of strings, with an initial element of 2."
;<ROUTINE PICK-NEXT (TBL "AUX" CNT STR)
	 <SET CNT <GET .TBL 1>>
       	 <SET STR <GET .TBL .CNT>>       
	 <INC CNT>
	 <COND (<G? .CNT <GET .TBL 0>>
		<SET CNT 2>)>
	 <PUT .TBL 1 .CNT>
	 <RETURN .STR>>

<ROUTINE PICK-ONE (TBL "AUX" LENGTH CNT RND MSG RFROB)
	 <SET LENGTH <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <SET LENGTH <- .LENGTH 1>>
	 <SET TBL <REST .TBL 2>>
	 <SET RFROB <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .LENGTH .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .LENGTH> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 .MSG>

<ROUTINE DPRINT (OBJ)
	 <COND (<AND <GETP .OBJ ,P?INANIMATE-DESC>
		     <NOT <FSET? .OBJ ,ANIMATEDBIT>>>
		<TELL <GETP .OBJ ,P?INANIMATE-DESC>>)
	       (<GETP .OBJ ,P?SDESC>
	        <TELL <GETP .OBJ ,P?SDESC>>)
	       (T
	        <PRINTD .OBJ>)>>

<ROUTINE APRINT (OBJ "OPT" (NOSP <>) "AUX" LEN)
	 <COND (<NOT .NOSP>
		<TELL !\ >)>
	 <COND (<AND <SET LEN <GET-OWNER .OBJ>>
		     <NOT <EQUAL? .LEN <GETP .OBJ ,P?OWNER>>>>
		<COND (<EQUAL? .LEN ,PROTAGONIST>
		       <TELL "your ">)
		      (<NOT <EQUAL? .LEN .OBJ>>
		       <APRINT .LEN T>
		       <TELL "'s ">)>)
	       (<NOT <FSET? .OBJ ,NARTICLEBIT>>
		<COND (<FSET? .OBJ ,VOWELBIT>
		       <TELL "an ">)
		      (T
		       <TELL "a ">)>)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT (OBJ "OPT" (NOSP <>) "AUX" LEN)
	 <COND (<NOT .NOSP>
		<TELL !\ >)>
	 <COND (<AND <SET LEN <GET-OWNER .OBJ>>
		     <NOT <EQUAL? .LEN <GETP .OBJ ,P?OWNER>>>>
		<COND (<EQUAL? .LEN ,PROTAGONIST>
		       <TELL "your ">)
		      (<NOT <EQUAL? .LEN .OBJ>>
		       <TPRINT .LEN T>
		       <TELL "'s ">)>)
	       (<NOT <FSET? .OBJ ,NARTICLEBIT>>
		<TELL "the ">)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT-PRSO ()
	 <TPRINT ,PRSO>>

<ROUTINE TPRINT-PRSI ()
	 <TPRINT ,PRSI>>

<ROUTINE ARPRINT (OBJ)
	 <APRINT .OBJ>
	 <TELL ,PERIOD-CR>>

<ROUTINE TRPRINT (OBJ)
	 <TPRINT .OBJ>
	 <TELL ,PERIOD-CR>>

<ROUTINE IS-ARE-PRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <DPRINT .OBJ>
	 <COND (<FSET? .OBJ ,PLURALBIT>
		<TELL " are ">)
	       (T
		<TELL " is ">)>>


;<ROUTINE CLEAR-SCREEN ("AUX" (CNT 24))
	 <REPEAT ()
		 <CRLF>
		 <SET CNT <- .CNT 1>>
		 <COND (<0? .CNT>
			<RETURN>)>>>

<REPLACE-DEFINITION VERB-ALL-TEST
<ROUTINE VERB-ALL-TEST (OO II "AUX" (L <LOC .OO>))
	 ;"RTRUE if OO should be included in the ALL, otherwise RFALSE"
	 <COND (<EQUAL? .OO ,ROOMS ;,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RFALSE>)
	       (<AND <VERB? TAKE> ;"TAKE prso FROM prsi and prso isn't in prsi"
		     <T? .II>
		     <NOT <IN? .OO .II>>>
		<RFALSE>)
	       ;(<NOT <ACCESSIBLE? .OO>> ;"can't get at object"
		<RFALSE>)
	       (T ;<EQUAL? ,P-GETFLAGS ,P-ALL> ;"cases for ALL"
		<COND (<AND .II
			    <PRSO? .II>>
		       <RFALSE>)
		      (<VERB? TAKE> 
		       ;"TAKE ALL and object not accessible or takeable"
		       <COND (<AND <NOT <FSET? .OO ,TAKEBIT>>
				   <NOT <FSET? .OO ,TRYTAKEBIT>>>
			      <RFALSE>)
			     (<FSET? .OO ,NALLBIT>
			      <RFALSE>)
			     ;(<AND <NOT <EQUAL? .L ,WINNER ,HERE .II>>
				   <NOT <EQUAL? .L <LOC ,WINNER>>>>
			      <COND (<AND <FSET? .L ,SURFACEBIT>
				     	  <NOT <FSET? .L ,TAKEBIT>>> ;"tray"
				     <RTRUE>)
				    (T
				     <RFALSE>)>)
			     (<AND <NOT .II>
				   <ULTIMATELY-IN? .OO>> ;"already have it"
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    ;"VERB ALL, object not held"
			    <NOT <IN? .OO ,WINNER>>>
		       <RFALSE>)
		      (<AND <VERB? PUT PUT-ON> ;"PUT ALL IN X,obj already in x"
			    <NOT <IN? .OO ,WINNER>>
			    <ULTIMATELY-IN? .OO .II>>
		       <RFALSE>)
		      (<AND <VERB? WEAR>
			    <OR <FSET? .OO ,WORNBIT>
				<NOT <FSET? .OO ,WEARBIT>>>>
		       ;"try to wear only wearable-but-not-yet-worn objects"
		       <RFALSE>)
		      (<EQUAL? .OO .II>
		       ;"i.e. PUT ALL IN BOX shouldn't try to put box in box"
		       <RFALSE>)
		      (T
		       <RTRUE>)>)>>>

;<GLOBAL FIRST-BUFFER <ITABLE BYTE 100>>

;<ROUTINE SAVE-INPUT (TBL "AUX" (OFFS 0) CNT TMP)
	 <SET CNT <+ <GETB ,P-LEXV <SET TMP <* 4 ,P-INPUT-WORDS>>>
		     <GETB ,P-LEXV <+ .TMP 1>>>>
	 <COND (<EQUAL? .CNT 0> ;"failed"
		<RFALSE>)>
	 <SET CNT <- .CNT 1>>
	 <REPEAT ()
		 <COND (<EQUAL? .OFFS .CNT>
			<PUTB .TBL .OFFS 0>
			<RETURN>)
		       (T
			<PUTB .TBL .OFFS <GETB ,P-INBUF <+ .OFFS 1>>>)>
		 <SET OFFS <+ .OFFS 1>>>
	 <RTRUE>>

;<ROUTINE RESTORE-INPUT (TBL "AUX" CHR)
	 <REPEAT ()
		 <COND (<EQUAL? <SET CHR <GETB .TBL 0>> 0>
			<RETURN>)
		       (T
			<PRINTC .CHR>
			<SET TBL <REST .TBL>>)>>>

<REPLACE-DEFINITION GAME-VERB?
<ROUTINE GAME-VERB? () ;"should the verb not run the clock?"
	 <COND (<VERB? $RECORD $UNRECORD $COMMAND $RANDOM $VERIFY $REFRESH
		       SAVE RESTORE RESTART QUIT SCRIPT UNSCRIPT
		       BRIEF SUPERBRIEF VERBOSE VERSION CREDITS
		       NOTIFY HINT COLOR SCORE TIME MAP DEFINE MODE>
		<RTRUE>)>>>

<ROUTINE THIS-IS-IT (OBJ)
	 <COND (<OR <AND <VERB? WALK>
			 <PRSO? .OBJ>> ;"PRSO is a direction"
		    <EQUAL? .OBJ <> ,ROOMS ;,NOT-HERE-OBJECT ,ME ,PROTAGONIST>>
		<RTRUE>)
	       (<DONT-IT .OBJ ,LOBSTER ,W?NUTCRACKER>
		;"or else FIND NUTCRACKER followed by TAKE IT returns
	          [But the lobster isn't here!]"
		<RTRUE>)
	       (<DONT-IT .OBJ ,SNAKE ,W?ROPE>
		<RTRUE>)  
	       (<FSET? .OBJ ,FEMALEBIT>
		<COND (<NOT <EQUAL? ,P-HER-OBJECT .OBJ>>
		       <FCLEAR ,HER ,TOUCHBIT>)>
		<SETG P-HER-OBJECT .OBJ>)
	       (<OR <FSET? .OBJ ,ACTORBIT>
		    <EQUAL? .OBJ ,LITTLE-FUNGUS>>
		<COND (<NOT <EQUAL? ,P-HIM-OBJECT .OBJ>>
		       <FCLEAR ,HIM ,TOUCHBIT>)>
		<SETG P-HIM-OBJECT .OBJ>
		<COND (<NOT <EQUAL? .OBJ ,JESTER ,EXECUTIONER>>
		       ;"basically, animals"
		       <COND (<NOT <EQUAL? ,P-IT-OBJECT .OBJ>>
			      <FCLEAR ,IT ,TOUCHBIT>)>
		       <SETG P-IT-OBJECT .OBJ>)>)
	       (T
		<COND (<NOT <EQUAL? ,P-IT-OBJECT .OBJ>>
		       <FCLEAR ,IT ,TOUCHBIT>)>
		<SETG P-IT-OBJECT .OBJ>)>>

<ROUTINE DONT-IT (OBJ1 OBJ2 WRD)
	 <COND (<AND <EQUAL? .OBJ1 .OBJ2>
		     <NOUN-USED? .OBJ2 .WRD>
		     <FSET? .OBJ2 ,ANIMATEDBIT>
		     <NOT <VISIBLE? .OBJ2>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<REPLACE-DEFINITION NUMBER?
;"from suspect"

<GLOBAL P-EXCHANGE 0>

<ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>) (EXC <>))
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<SET CHR <GETB ,P-INBUF .BPTR>>
			<COND (<==? .CHR 58>
			       <COND (.EXC
				      <RFALSE>)>
			       <SET TIM .SUM>
			       <SET SUM 0>)
			      (<==? .CHR 45 %<ASCII !\/>>
			       <COND (.TIM
				      <RFALSE>)>
			       <SET EXC .SUM>
			       <SET SUM 0>)
			      (<G? .SUM 9999>
			       <RFALSE>)
			      (<AND <L? .CHR 58>
				    <G? .CHR 47>>
			       <SET SUM <+ <* .SUM 10> <- .CHR 48>>>)
			      (T
			       <RFALSE>)>
			<SET BPTR <+ .BPTR 1>>)>>
	 <PUT ,P-LEXV .PTR ,W?NUMBER>
	 <COND (<G? .SUM 9999>
		<RFALSE>)
	       (.EXC
		<SETG P-EXCHANGE .EXC>)
	       (.TIM
		<SETG P-EXCHANGE 0>
		<COND (<G? .TIM 23>
		       <RFALSE>)
		      (<G? .TIM 19>
		       T)
		      (<G? .TIM 12>
		       <RFALSE>)
		      (<G? .TIM  7>
		       T)
		      (T
		       <SET TIM <+ 12 .TIM>>)>
		<SET SUM <+ .SUM <* .TIM 60>>>)
	       (T
		<SETG P-EXCHANGE 0>)>
	 <SETG P-NUMBER .SUM>
	 ,W?NUMBER>>

<GLOBAL P-NUMBER 0>

<ROUTINE PERFORM-PRSA ("OPTIONAL" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>
	 <RTRUE>>

;<ROUTINE CANT-USE (PTR "AUX" BUF)
	<TELL "[You used the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" in a way that I don't understand.]" CR>
	;<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>

<REPLACE-DEFINITION CAPITAL-NOUN?
<ROUTINE CAPITAL-NOUN? (WRD "AUX" TBL)
   <COND (<EQUAL? .WRD ,W?FLATHEAD ,W?DIMWIT ,W?URSULA ,W?MEGABOZ ,W?JOHN 
		       ,W?PIERPONT ,W?STONEWALL ,W?LUCREZIA ,W?SEBASTIAN
		       ,W?DAVISON ,W?THOMAS ,W?ALVA ,W?LEONARDO ,W?JOHANN
		       ,W?RALPH ,W?PAUL ,W?FRANK ,W?LLOYD ,W?BABE ,W?ZILBO
		       ,W?MERETZKY ,W?FOOBUS ,W?BARBAZZO ,W?FERNAP
		       ,W?MUMBERTHRAX ,W?BOZBO ,W?MUMBO ,W?PHLOID ,W?BELWIT>
	  <RTRUE>)
	 (<AND <SET TBL <GETPT ,SAINTS ,P?SYNONYM>>
	       <INTBL? .WRD .TBL </ <PTSIZE .TBL> 2>>>
	  <RTRUE>)
	 (<INTBL? .WRD ,FUNGUS-WORDS 12>
	  <RTRUE>)
	 (<INTBL? .WRD ,MID-NAME-WORDS 12>
	  <RTRUE>)
	 (T
	  <RFALSE>)>>>

<REPLACE-DEFINITION LIT?
<ROUTINE LIT? ("OPT" (RM <>) (RMBIT T) "AUX" OHERE (LIT <>) (RES ,SEARCH-RES))
	<COND (<AND <EQUAL? ,HERE ,UNDERWATER ,LAKE-BOTTOM>
		    <NOT <FSET? ,EXTERIOR-LIGHT ,ONBIT>>>
	       <RFALSE>)>
	<COND (<NOT .RM>
	       <SET RM ,HERE>)>
	<SET OHERE ,HERE>
	<SETG HERE .RM>
	<COND (<AND .RMBIT
		    <FSET? .RM ,ONBIT>>
	       <SET LIT ,HERE>)
	      (<AND <FSET? ,WINNER ,ONBIT>
		    <ULTIMATELY-IN? ,WINNER .RM>>
	       <SET LIT ,WINNER>)
	      (T
	       <MAKE-FIND-RES 'FIND-RES .RES 'FIND-RES-COUNT 0>
	       <MAKE-FINDER 'FINDER ,FINDER 'FIND-APPLIC ,ONBIT
			    'FIND-RES .RES
			    'FIND-FLAGS ,FIND-FLAGS-GWIM>
	       <COND (<EQUAL? .OHERE .RM>
		      <FIND-DESCENDANTS ,WINNER
					%<ORB ,FD-INCLUDE? ,FD-SEARCH?
					      ,FD-NEST? ;,FD-NOTOP?>>
		      <COND (<AND <NOT <EQUAL? ,WINNER ,PROTAGONIST>>
				  <IN? ,PROTAGONIST .RM>>
			     <FIND-DESCENDANTS ,PROTAGONIST
					       %<ORB ,FD-INCLUDE? ,FD-SEARCH?
						     ,FD-NEST? ;,FD-NOTOP?>>)>)>
	       <COND (<0? <FIND-RES-COUNT .RES>:FIX>
		      <COND (<AND <FSET? <LOC ,WINNER> ,VEHBIT>
				  <NOT <FSET? <LOC ,WINNER> ,OPENBIT>>>
			     <FIND-DESCENDANTS <LOC ,WINNER>
					       %<ORB ,FD-INCLUDE? ,FD-SEARCH?
						     ,FD-NEST? ;,FD-NOTOP?>>)>
		      <FIND-DESCENDANTS .RM %<ORB ,FD-INCLUDE? ,FD-SEARCH?
						  ,FD-NEST? ;,FD-NOTOP?>>)>
	       <COND (<G? <FIND-RES-COUNT .RES>:FIX 0>
		      <SET LIT <FIND-RES-OBJ1 .RES>>)>)>
	<SETG HERE .OHERE>
	.LIT>>

;"CLOCKER and related routines"

<CONSTANT C-TABLE %<COND (<GASSIGNED? ZILCH>
			'<ITABLE NONE 30>)
		       (T
			'<ITABLE NONE 60>)>> ;"2x largest num of interrupts"

<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-INTS 60> ;"2x largest number of concurrent of interrupts"

<GLOBAL C-MAXINTS 60> ;"2x largest number of concurrent of interrupts"

<GLOBAL CLOCK-HAND <>>

<CONSTANT C-TABLELEN 60>
<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T
			       <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE RUNNING? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-TICK>>
				   <G? <GET .C ,C-TICK> 1>>
			       <RFALSE>)
			      (T
			       <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>)) ;"automatically enables as well"
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (T
			       <COND (<L? ,C-INTS ,C-INTLEN>
				      <TELL "**Too many ints!**" CR>)>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       <COND (<L? ,C-INTS ,C-MAXINTS>
				      <SETG C-MAXINTS ,C-INTS>)>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (<AND ,CLOCK-HAND
		     %<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (T
			'<L? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)
	       (,TIME-STOPPED
		;"don't run interrupts, but do increment moves"
		<SETG MOVES <+ ,MOVES 1>>
		<RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PROTAGONIST>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG CLOCK-HAND .E>
			<SETG MOVES <+ ,MOVES 1>>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (<APPLY .RTN>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>

"stuff for handling opcodes that want pixels"

<GLOBAL FONT-X 7>
<GLOBAL FONT-Y 10>

<CONSTANT PICINF-TBL
	  <TABLE 0 0>>

<ROUTINE C-PIXELS (X)
	 <+ <* <- .X 1> ,FONT-X> 1>>

<ROUTINE L-PIXELS (Y)
	 <+ <* <- .Y 1> ,FONT-Y> 1>>

;<ROUTINE PIXELS-C (X)
	 <+ </ <- .X 1> ,FONT-X> 1>>

;<ROUTINE PIXELS-L (Y)
	 <+ </ <- .Y 1> ,FONT-Y> 1>>

;<ROUTINE PIXELS-LR (Y)
	 </ <- <+ .Y ,FONT-Y> 1> ,FONT-Y>>

<ROUTINE CCURSET (Y X)
	 <CURSET <L-PIXELS .Y> <C-PIXELS .X>>>

;<ROUTINE CCURGET (TBL)
	 <CURGET .TBL>
	 <PUT .TBL 0 <PIXELS-L <GET .TBL 0>>>
	 <PUT .TBL 1 <PIXELS-C <GET .TBL 1>>>
	 .TBL>

;<ROUTINE CSPLIT (Y)
	 <SPLIT <* .Y ,FONT-Y>>>

;<ROUTINE CWINPOS (W Y X)
	 <WINPOS .W <L-PIXELS .Y> <C-PIXELS .X>>>

;<ROUTINE CWINSIZE (W Y X)
	 <WINSIZE .W <* .Y ,FONT-Y> <* .X ,FONT-X>>>

;<ROUTINE CMARGIN (L R)
	 <MARGIN <* .L ,FONT-X> <* .R ,FONT-X>>>

;<ROUTINE CPICINF (P TBL)
	 <PICINF .P .TBL>
	 <PUT .TBL 0 </ <GET .TBL 0> ,FONT-Y>>
	 <PUT .TBL 1 </ <GET .TBL 1> ,FONT-X>>>

;<ROUTINE CDISPLAY (P Y X)
	 <DISPLAY .P
		  <COND (<ZERO? .Y> 0)
			(ELSE <L-PIXELS .Y>)>
		  <COND (<ZERO? .X> 0)
			(ELSE <C-PIXELS .X>)>>>

;<ROUTINE CDCLEAR (P Y X)
	 <DCLEAR .P
		 <COND (<ZERO? .Y> 0)
		       (ELSE <L-PIXELS .Y>)>
		 <COND (<ZERO? .X> 0)
		       (ELSE <C-PIXELS .X>)>>>

;<ROUTINE CSCROLL (W Y)
	 <SCROLL .W <* .Y ,FONT-Y>>>

<END-SEGMENT>