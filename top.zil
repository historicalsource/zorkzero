"TOP for NEW PARSER
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

<INCLUDE "BASEDEFS" "PBITDEFS" "PDEFS">

<FILE-FLAGS MDL-ZIL?>

<BEGIN-SEGMENT 0>

<DEFAULTS-DEFINED
	ADJ-USED?
	ASKING-VERB-WORD?
	CANT-UNDO
	CAPITAL-NOUN?
	COLLECTIVE-VERB?
	DIR-VERB?
	DIR-VERB-PRSI?
	DIR-VERB-WORD?
	FIND-A-WINNER
	GAME-VERB?
	;I-ASSUME-STRING
	ITAKE-CHECK
	META-LOC
	MORE-SPECIFIC
	NO-M-WINNER-VERB?
	NOT-HERE
	NOT-HERE-VERB?
	NOUN-USED?
	OWNERS
	P-PRONOUNS
	QCONTEXT-CHECK
	SEE-VERB?
	SIBREAKS
	SPEAKING-VERB?
	;TELL-I-ASSUME
	TELL-PRONOUN
	TELL-SAID-TO
	TELL-TOO-DARK
	VERB-ALL-TEST>

<DEFAULT-DEFINITION SIBREAKS
	<SETG20 SIBREAKS ".,\"'!?">>
<DEFAULT-DEFINITION OWNERS
	<CONSTANT OWNERS <TABLE (PURE LENGTH) PLAYER>>>

;<DEFAULT-DEFINITION I-ASSUME-STRING
	<CONSTANT I-ASSUME "[I assume you mean:">>

;<DEFAULT-DEFINITION TELL-I-ASSUME
 <DEFINE TELL-I-ASSUME (OBJ "OPT" PRON)
	<COND (<AND <NOT <FSET? .PRON ,TOUCHBIT>> 
		    <NOT <EQUAL? ,OPRSO .OBJ>>>
	       <FSET .PRON ,TOUCHBIT>
	       <TELL ,I-ASSUME>
	       <TELL !\ >
	       <TELL-THE .OBJ>
	       <TELL ".]" CR>)>>>

<DEFAULT-DEFINITION MORE-SPECIFIC
 <DEFINE MORE-SPECIFIC ()
	<SETG CLOCK-WAIT T>
	<TELL "[Please be more specific.]" CR>>>

<DEFMAC VERB? ("TUPLE" ATMS "AUX" (O ()) (L ())) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				     (ELSE <FORM OR !.O>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<CHTYPE <PARSE <STRING "V?"<SPNAME .ATM>>> GVAL>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O (<FORM EQUAL? ',PRSA !.L> !.O)>
		<SET L ()>>>

<DEFMAC DOBJ? ("TUPLE" ATMS "AUX" (O ()) (L ())) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (ELSE <FORM OR !.O>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L (<COND (<TYPE? .ATM ATOM>
				       <CHTYPE .ATM GVAL>)
				      (T .ATM)>
				!.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O (<FORM EQUAL? ',PRSO !.L> !.O)>
		<SET L ()>>>

<DEFMAC IOBJ? ("TUPLE" ATMS "AUX" (O ()) (L ())) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (ELSE <FORM OR !.O>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L (<COND (<TYPE? .ATM ATOM>
				       <CHTYPE .ATM GVAL>)
				      (T .ATM)>
				!.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O (<FORM EQUAL? ',PRSI !.L> !.O)>
		<SET L ()>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

<DEFMAC T? ('TERM) <FORM NOT <FORM ZERO? .TERM>>>

<IF-P-DEBUGGING-PARSER
<SYNTAX \#DBG = V-PDEBUG>

<GLOBAL P-DBUG:FLAG <>>
<GLOBAL IDEBUG:FLAG <>>

<DEFINE V-PDEBUG ()
 <COND (<T? ,PRSO>
	<SETG IDEBUG <NOT ,IDEBUG>>
	<TELL !\{ N ,IDEBUG "}" CR>)
       (<SETG P-DBUG <NOT ,P-DBUG>>
	<TELL "Find them bugs, boss!" CR>)
       (T <TELL "No bugs left, eh?" CR>)>>>

<SETG P-PRSI <>>
<SETG P-PRSO <>>
<SETG PRSA 0>
<IF-P-BE-VERB
	<GLOBAL PRSQ 0>
	<GLOBAL PRSS:OBJECT 0>>
<GLOBAL PRSI:OBJECT 0>
<GLOBAL PRSO:OBJECT 0>

<GLOBAL P-MULT <>>
<GLOBAL OPRSO <>>
<GLOBAL P-CONT:NUMBER 0>

<CONSTANT P-LEXWORDS 1>	"Byte offset to # of entries in LEXV"
<CONSTANT P-LEXSTART 1>	"Word offset to start of LEXV entries"
<CONSTANT P-LEXELEN 2>	"Number of words per LEXV entry"
<CONSTANT P-WORDLEN 4>

<GLOBAL P-WON <>>

"<CONSTANT M-FATAL 2>"
<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>   

"<CONSTANT M-BEG 1>  
<CONSTANT M-END 6> 
<CONSTANT M-CONT 7> 
<CONSTANT M-WINNER 8>"

<DEFINE MAIN-LOOP ("AUX" X) <REPEAT () <SET X <MAIN-LOOP-1>>>>

<GLOBAL P-PRSA-WORD <>>

<GLOBAL PRSO-NP <>>
<GLOBAL PRSI-NP <>>
<GLOBAL CLOCKER-RUNNING:NUMBER 2>

<DEFAULT-DEFINITION DIR-VERB?
	<DEFMAC DIR-VERB? () '<VERB? WALK>>>

<DEFAULT-DEFINITION DIR-VERB-PRSI?
<DEFINE DIR-VERB-PRSI? (NP)
	<AND <EQUAL? <PARSE-ACTION ,PARSE-RESULT>
		     ,V?MOVE-DIR ,V?RIDE-DIR ,V?ROLL-DIR ,V?SET-DIR>
	     <NOT <EQUAL? <NOUN-PHRASE-OBJ1 .NP> ,INTDIR ,LEFT-RIGHT>>>>>

<DEFAULT-DEFINITION DIR-VERB-WORD?
	<DEFINE DIR-VERB-WORD? (WD) <EQUAL? .WD ,W?WALK ,W?GO ,W?RUN>>>

<DEFAULT-DEFINITION COLLECTIVE-VERB?
	<DEFMAC COLLECTIVE-VERB? () '<VERB? COUNT ;COMPARE>>>

<IF-UNDO <GLOBAL P-CAN-UNDO:NUMBER 0>>

<DEFINE MAIN-LOOP-1 ACT ("AUX" ICNT OCNT NUM (OBJ <>) V OBJ1 (NP <>) NP1)
   <COND (<SETG P-WON <PARSER>>
	  <IFN-P-BE-VERB <COND (<L? <SETG P-ERRS <- ,P-ERRS 1>> 0>
				<SETG P-ERRS 0>)>>
	  <PROG ()
	    <SETG PRSA <PARSE-ACTION ,PARSE-RESULT>>
	    ;<COND (<ZERO? <PARSE-SUBJ ,PARSE-RESULT>>
		   <SETG PRSA <PARSE-ACTION ,PARSE-RESULT>>)
		  (<NOT <EQUAL? <SET V <PARSE-QW ,PARSE-RESULT>> 0 1>>
		   <SETG PRSA <SYNTAX-ID
			    <GET-SYNTAX <VERB-ONE <WORD-VERB-STUFF .V>> 1 1>>>)
		  (T
		   <SETG PRSA <SYNTAX-ID <PARSE-QUERY-SYNTAX ,PARSE-RESULT>>>)>
	    <IF-UNDO
		<COND (<VERB? UNDO>
		       ;<AND <EQUAL? <ZGET ,TLEXV 0> ,W?UNDO>
			    <EQUAL? ,P-LEN 1>
			    <V-UNDO>>
		       <RETURN <PERFORM ,PRSA> .ACT>)
		      (T
		       <SETG P-CAN-UNDO <ISAVE>>
		       <COND (<EQUAL? ,P-CAN-UNDO 2>
			      <COND (<OR ;<T? ,P-CONT> <VERB? SAVE>>
				     <CANT-UNDO>)
				    (T
				     <SETG P-CONT -1>
				     <V-$REFRESH>
				     ;<TELL "[Undone.]|">)>
			      <RETURN <> .ACT>)>)>>
	    <SETG P-PRSO <PARSE-OBJ1 ,PARSE-RESULT>>
	    <SETG P-PRSI <PARSE-OBJ2 ,PARSE-RESULT>>
	    <COND (<AND ,P-PRSO
			<==? ,INTDIR <NOUN-PHRASE-OBJ1 ,P-PRSO>>>
		   <SETG P-DIRECTION
			 <WORD-DIR-ID
			  <NP-NAME <NOUN-PHRASE-NP1 ,P-PRSO>>>>)
		  (<AND ,P-PRSI
			<==? ,INTDIR <NOUN-PHRASE-OBJ1 ,P-PRSI>>>
		   <SETG P-DIRECTION
			 <WORD-DIR-ID
			  <NP-NAME <NOUN-PHRASE-NP1 ,P-PRSI>>>>)>
	    <SETG P-PRSA-WORD <PARSE-VERB ,PARSE-RESULT>>
	    <SETG CLOCK-WAIT <>>
	    <SET ICNT 0>
	    <SET OCNT 0>
	    <COND (,P-PRSI
		   <SET ICNT <NOUN-PHRASE-COUNT ,P-PRSI>>
		   <COND (<NOT <0? .ICNT>> ;<NP-MULTI? ,P-PRSI>
			  <SETG P-MULT .ICNT>)>)>
	    <COND (,P-PRSO
		   <SET OCNT <NOUN-PHRASE-COUNT ,P-PRSO>>
		   <COND (<NOT <0? .OCNT>> ;<NP-MULTI? ,P-PRSO>
			  <SETG P-MULT .OCNT>)>)>
	    <COND (<AND <ZERO? .OCNT> <ZERO? .ICNT>>
		   T)
		  (<AND <NOT <DIR-VERB?>>
			<T? ,P-IT-OBJECT>
			<ACCESSIBLE? ,P-IT-OBJECT>>
		   <COND (<T? .ICNT>
			  <REPEAT ((CNT 0) TOFF)
			   <SET TOFF <+ ,NOUN-PHRASE-HEADER-LEN <* .CNT 2>>>
			   <COND (<==? ,IT <ZGET ,P-PRSI .TOFF>>
				  <ZPUT ,P-PRSI .TOFF ,P-IT-OBJECT>
				  <TELL-PRONOUN ,P-IT-OBJECT ,IT>
				  <RETURN>)
				 (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)>>)>
		   <COND (<T? .OCNT>
			  <REPEAT ((CNT 0) TOFF)
			   <SET TOFF <+ ,NOUN-PHRASE-HEADER-LEN <* .CNT 2>>>
			   <COND (<==? ,IT <ZGET ,P-PRSO .TOFF>>
				  <ZPUT ,P-PRSO .TOFF ,P-IT-OBJECT>
				  <TELL-PRONOUN ,P-IT-OBJECT ,IT>
				  <RETURN>)
				 (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)>>)>)>
	    <SET NUM
		 <COND (<0? .OCNT> .OCNT)
		       (<G? .OCNT 1>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T
			       <SET OBJ <OR <NOUN-PHRASE-OBJ1 ,P-PRSI>
					    ;,NOT-HERE-OBJECT>>
			       <SET NP <NOUN-PHRASE-NP1 ,P-PRSI>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET OBJ <OR <NOUN-PHRASE-OBJ1 ,P-PRSO>
				     ;,NOT-HERE-OBJECT>>
			<SET NP <NOUN-PHRASE-NP1 ,P-PRSI>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <ZERO? .OBJ> <1? .ICNT>>
		   <SET OBJ <OR <NOUN-PHRASE-OBJ1 ,P-PRSI>
				;,NOT-HERE-OBJECT>>
		   <SET NP <NOUN-PHRASE-NP1 ,P-PRSI>>)>
	    <IF-P-BE-VERB
			<COND (<SET V <PARSE-QUERY-SYNTAX ,PARSE-RESULT>>
			       <SETG PRSQ ;V <SYNTAX-ID .V>>)>
			<COND (<SET XX <PARSE-SUBJ ,PARSE-RESULT>>
			       <SETG PRSS ;XX <NOUN-PHRASE-OBJ1 .XX>>)>
			;<SET V <PERFORM ,PRSA ,PRSO ,PRSI ;.PI ;.V ;.XX>>>
	    <COND (<AND <ZERO? ,LIT>
			<SEE-VERB?>>
		   <TELL-TOO-DARK>
		   <SETG P-CONT -1>
		   ;<RTRUE>)
		  (<DIR-VERB?>
		   <SET V <PERFORM ,PRSA <OR ,P-WALK-DIR
					     <NOUN-PHRASE-OBJ1 ,P-PRSO>>>>)
		  (<0? .NUM>
		   <SET V <PERFORM ,PRSA>>
		   <SETG PRSO <>>
		   <SETG PRSO-NP <>>)
		  (<AND ;<EQUAL? .OCNT 1>
			<G? .OCNT ;.ICNT 1> ;<G? .NUM 1>
			<COLLECTIVE-VERB?>>
		   <SET V <PERFORM ,PRSA ,ROOMS>>)
		  (T
		   <REPEAT (XX (CNT -1) ;(X 0) (TMP 0) ;PI)
		    <SET CNT <+ .CNT 1>>
		    <COND (<G=? .CNT .NUM>
			   <COND ;(<G? .X 0>
				  <TELL "The ">
				  <COND (<NOT <EQUAL? .X .NUM>>
					 <TELL "other ">)>
				  <TELL "object">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL !\s>)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "are">)
					(T <TELL "is">)>
				  <TELL "n't here." CR>)
				 (<ZERO? .TMP>
				  <MORE-SPECIFIC>)>
			   <RETURN>)>
		    <COND (<NOT <G? .ICNT 1>>
			   <SET OBJ1
				<OR <ZGET ,P-PRSO
				      <+ <* .CNT 2>
					 ,NOUN-PHRASE-HEADER-LEN>>
				    ;,NOT-HERE-OBJECT>>
			   <SET NP1 <ZGET ,P-PRSO
					  <+ <* .CNT 2>
					     ,NOUN-PHRASE-HEADER-LEN
					     1>>>)
			  (T
			   <SET OBJ1
				<OR <ZGET ,P-PRSI
				      <+ <* .CNT 2>
					 ,NOUN-PHRASE-HEADER-LEN>>
				    ;,NOT-HERE-OBJECT>>
			   <SET NP1 <ZGET ,P-PRSI
					  <+ <* .CNT 2>
					     ,NOUN-PHRASE-HEADER-LEN
					     1>>>)>
		    <COND (<OR <G? .NUM 1>
			       <==? <NP-QUANT .NP1> ,NP-QUANT-ALL>>
			   <COND (<EQUAL? .OBJ1 <> ,NOT-HERE-OBJECT>
				  ;<SET X <+ .X 1>>
				  <NP-PRINT .NP1>
				  <TELL ": ">
				  <NP-CANT-SEE .NP1>
				  <AGAIN>)
				 (<AND <==? <NP-QUANT .NP1> ,NP-QUANT-ALL>
				       <NOT <VERB-ALL-TEST .OBJ1 .OBJ>>>
				  <AGAIN>)
				 (<NOT <ACCESSIBLE? .OBJ1>>
				  <AGAIN>)
				 (<EQUAL? .OBJ1 ,PLAYER>
				  <AGAIN>)
				 (T
				  <COND (<EQUAL? .OBJ1 ,IT>
					 <TELL D ,P-IT-OBJECT>)
					(T <TELL D .OBJ1>)>
				  <TELL ": ">)>)>
		    <SET TMP T>
		    <COND (<NOT <G? .ICNT 1>>
			   <SETG PRSO .OBJ1>
			   <SETG PRSO-NP .NP1>
			   <SETG PRSI ;PI .OBJ>
			   <SETG PRSI-NP .NP>)
			  (T
			   <SETG PRSO .OBJ>
			   <SETG PRSO-NP .NP>
			   <SETG PRSI ;PI .OBJ1>
			   <SETG PRSI-NP .NP1>)>
		    <COND (<AND <EQUAL? ,IT ,PRSI ,PRSO ;,PRSS>
				<NOT <FIX-HIM-HER-IT ,IT ,P-IT-OBJECT>>>
			   <AGAIN> ;<RETURN ,M-FATAL>)>
		    <COND (<AND <EQUAL? ,HER ,PRSI ,PRSO ;,PRSS>
				<NOT <FIX-HIM-HER-IT ,HER ,P-HER-OBJECT>>>
			   <AGAIN> ;<RETURN ,M-FATAL>)>
		    <COND (<AND <EQUAL? ,HIM ,PRSI ,PRSO ;,PRSS>
				<NOT <FIX-HIM-HER-IT ,HIM ,P-HIM-OBJECT>>>
			   <AGAIN> ;<RETURN ,M-FATAL>)>
		    <QCONTEXT-CHECK ,PRSO>
		    <SET XX <SYNTAX-SEARCH <PARSE-SYNTAX ,PARSE-RESULT> 1>>
		    <COND (<AND <T? ,PRSO>	;"Could be ADJACENT room."
				<NOT <BTST .XX ,SEARCH-MOBY>>
				<NOT <BTST .XX
					 <BOR ,SEARCH-MOBY ,SEARCH-MUST-HAVE>>>
				<SET V <META-LOC ,PRSO>>
				<IN? .V ,ROOMS>
				<NOT <GLOBAL-IN? ,PRSO <META-LOC ,WINNER>>>
				<NOT <EQUAL? .V <META-LOC ,WINNER>>>
				;<NOT <EQUAL? <META-LOC ,PRSO>
					     ,HERE ,LOCAL-GLOBALS
					     ,GLOBAL-OBJECTS
					     ,GENERIC-OBJECTS>>>
			   <NOT-HERE ,PRSO>
			   ;<TELL "[">
			   ;<TELL-CTHE ,WINNER>
			   ;<TELL " can't do that from here.]" CR>
			   <AGAIN>)>
		    <COND (<AND <T? ,PRSO>
				<BAND <BOR ,SEARCH-MUST-HAVE ,SEARCH-DO-TAKE>
				      .XX>
				<NOT <BAND ,SEARCH-MOBY .XX>>>
			   <SET V <ITAKE-CHECK ,PRSO .XX>>
			   <COND (<OR <EQUAL? ,M-FATAL .V>
				      ;<EQUAL? ,P-CONT -1>>
				  <RETURN>)
				 (<T? .V>
				  <AGAIN>)>)>
		    <COND (<AND <T? ,PRSI ;.PI>
				<BAND <BOR ,SEARCH-MUST-HAVE ,SEARCH-DO-TAKE>
				      <SET XX <SYNTAX-SEARCH
					       <PARSE-SYNTAX ,PARSE-RESULT>
					       2>>>
				<NOT <BAND ,SEARCH-MOBY .XX>>>
			   <SET V <ITAKE-CHECK ,PRSI ;.PI .XX>>
			   <COND (<OR <EQUAL? ,M-FATAL .V>
				      ;<EQUAL? ,P-CONT -1>>
				  <RETURN>)
				 (<T? .V>
				  <AGAIN>)>)>
		    <SET V <PERFORM ,PRSA ,PRSO ,PRSI ;.PI>>
		    <COND (<OR <EQUAL? ,M-FATAL .V>
			       <EQUAL? ,P-CONT -1>>	;"per SEM 16-Feb-88"
			   <RETURN>)>>)>
	    <SETG OPRSO ,PRSO>
	    <COND (<AND <ZERO? ,CLOCK-WAIT>
			<NOT <GAME-VERB?>>
			;<T? ,P-WON>>
		   <COND (<AND <SET V <LOC ,WINNER>>
			       <NOT <IN? .V ,ROOMS>>
			       ;<FSET? .V ,VEHBIT>>
			  <SET V <D-APPLY "M-END"
					  <GETP .V ,P?ACTION>
					  ,M-END>>)>
		   <SET V <D-APPLY "M-END"
				   <GETP ,HERE ,P?ACTION>
				   ,M-END>>)>
	    <COND (<EQUAL? ,M-FATAL .V>
		   <SETG P-CONT -1>)>
	    <COND (<AND <ZERO? ,CLOCK-WAIT>
			<NOT <GAME-VERB?>>
			;<T? ,P-WON>>
		   <SETG CLOCKER-RUNNING 1>
		   <SET V <CLOCKER>>
		   <SETG CLOCKER-RUNNING 2>
		   <COND (<EQUAL? ,M-FATAL .V>
			  <SETG P-CONT -1>)>)>
	    <COND (<AND <SET V <PARSE-CHOMPER ,PARSE-RESULT>>
			<L? 1 <NOUN-PHRASE-COUNT .V>>
			<NOT <EQUAL? ,P-CONT -1>>>
		   <SET V <HACK-TELL-1 .V>>
		   <COND (<EQUAL? ,M-FATAL .V>
			  <SETG P-CONT -1>)
			 (<T? .V>
			  <AGAIN>)>)>>)
	 (T
	  <SETG CLOCK-WAIT T>
	  <SETG P-CONT <>>)>
   <SETG PRSA <>>
   <SETG PRSO <>>
   <SETG PRSO-NP <>>
   <SETG PRSI ;"PI" <>>>

<DEFAULT-DEFINITION VERB-ALL-TEST
<DEFINE VERB-ALL-TEST (O I "AUX" L)	;"O=PRSO I=PRSI"
 <SET L <LOC .O>>
 <COND (<VERB? DROP GIVE>
	<COND (<EQUAL? .L ,WINNER>
	       <RTRUE>)
	      (T <RFALSE>)>)
       (<VERB? PUT>
	<COND (<EQUAL? .O .I>
	       <RFALSE>)
	      (<NOT <IN? .O .I>>
	       <RTRUE>)
	      (T <RFALSE>)>)
       (<VERB? TAKE>
	<COND (<AND <NOT <FSET? .O ,TAKEBIT>>
		    <NOT <FSET? .O ,TRYTAKEBIT>>>
	       <RFALSE>)>
	<COND (<NOT <ZERO? .I>>
	       <COND (<NOT <EQUAL? .L .I>>
		      <RFALSE>)>)
	      (<EQUAL? .L ;,WINNER ,HERE>
	       <RTRUE>)>
	<COND (<OR <FSET? .L ,PERSONBIT>
		   <FSET? .L ,SURFACEBIT>>
	       <RTRUE>)
	      (<AND <FSET? .L ,CONTBIT>
		    <FSET? .L ,OPENBIT>>
	       <RTRUE>)
	      (T <RFALSE>)>)
       (<NOT <ZERO? .I>>
	<COND (<NOT <EQUAL? .O .I>>
	       <RTRUE>)
	      (T <RFALSE>)>)
       (T <RTRUE>)>>>

<DEFINE FIX-HIM-HER-IT (PRON OBJ)
 <COND (<ZERO? .OBJ>
	<MORE-SPECIFIC>
	<>)
       (<NOT <VISIBLE? .OBJ>>
	<NOT-HERE .OBJ>
	<>)
       (T
	<COND (<EQUAL? ,PRSO .PRON>
	       <SETG PRSO .OBJ>
	       <TELL-PRONOUN .OBJ .PRON>)>
	<COND (<EQUAL? ,PRSI .PRON>
	       <SETG PRSI .OBJ>
	       <TELL-PRONOUN .OBJ .PRON>)>
	<IF-P-BE-VERB
	<COND (<EQUAL? ,PRSS .PRON>
	       <SETG PRSS .OBJ>
	       <TELL-PRONOUN .OBJ .PRON>)>>
	T)>>

<DEFAULT-DEFINITION TELL-PRONOUN
<DEFINE TELL-PRONOUN (OBJ PRON)
 <COND (<AND <NOT <FSET? .PRON ,TOUCHBIT>> 
	     <NOT <EQUAL? ,OPRSO .OBJ>>>
	<TELL "[\"">
	<TELL D ;PRINTB .PRON>
	<TELL "\" meaning ">
	<TELL-THE .OBJ>
	<TELL "]" CR>)>>>

<DEFAULT-DEFINITION GAME-VERB?
<CONSTANT GAME-VERB-TABLE
 <LTABLE V?BRIEF V?QUIT V?RESTART V?RESTORE
	 V?SAVE V?SCORE V?SCRIPT V?SUPER-BRIEF
	 V?TELL V?UNSCRIPT V?VERBOSE V?VERSION V?$VERIFY V?FOOTNOTE>>

<DEFINE GAME-VERB? ()
 <COND (<INTBL? ,PRSA <ZREST ,GAME-VERB-TABLE 2> <ZGET ,GAME-VERB-TABLE 0>>
	<RTRUE>)>
 <COND (<VERB? $RANDOM $COMMAND $RECORD $UNRECORD>
	<RTRUE>)>>>

<DEFAULT-DEFINITION NO-M-WINNER-VERB?
<CONSTANT NO-M-WINNER-VERB-TABLE
 <PLTABLE V?TELL-ABOUT V?SGIVE V?SSHOW V?SRUB V?SPUT-ON>>

<DEFINE NO-M-WINNER-VERB? ()
 <COND (<INTBL? ,PRSA <ZREST ,NO-M-WINNER-VERB-TABLE 2>
		       <ZGET ,NO-M-WINNER-VERB-TABLE 0>>
	<RTRUE>)>>>

<DEFAULT-DEFINITION FIND-A-WINNER
<DEFINE FIND-A-WINNER ACT ("OPT" (RM ,HERE))
 <COND (<AND <T? ,QCONTEXT>
	     <IN? ,QCONTEXT .RM>>
	,QCONTEXT)
       (T
	<REPEAT ((OTHER <FIRST? .RM>) (WHO <>) (N 0))
		<COND (<ZERO? .OTHER>
		       <RETURN .WHO .ACT>)
		      (<AND <FSET? .OTHER ,PERSONBIT>
			    <NOT <FSET? .OTHER ,INVISIBLE>>
			    <NOT <EQUAL? .OTHER ,PLAYER>>>
		       <COND (<G? <SET N <+ 1 .N>> 1>
			      <RETURN <> .ACT>)>
		       <SET WHO .OTHER>)>
		<SET OTHER <NEXT? .OTHER>>>)>>>

<DEFAULT-DEFINITION QCONTEXT-CHECK
<DEFINE QCONTEXT-CHECK (PER "AUX" (WHO <>))
	 <COND (<OR ;<IFFLAG (P-BE-VERB <VERB? BE ;FIND ;HELP>) (T <>)>
		    <AND <VERB? SHOW TELL-ABOUT>
			 <EQUAL? .PER ,PLAYER>>> ;"? more?"
		<COND (<SET WHO <FIND-A-WINNER ,HERE>>
		       <SETG QCONTEXT .WHO>)>
		<COND (<AND <QCONTEXT-GOOD?>
			    <EQUAL? ,WINNER ,PLAYER>> ;"? more?"
		       <SETG WINNER ,QCONTEXT>
		       <TELL-SAID-TO ,QCONTEXT>
		       <RTRUE>)>)>>>

<DEFAULT-DEFINITION TELL-SAID-TO
 <DEFINE TELL-SAID-TO (PER) <TELL "[said to " D .PER "]" CR>>>

<GLOBAL QCONTEXT:OBJECT <>>

<DEFINE QCONTEXT-GOOD? ()
 <COND (<AND <NOT <ZERO? ,QCONTEXT>>
	     <FSET? ,QCONTEXT ,PERSONBIT>
	     ;<NOT <FSET? ,QCONTEXT ,MUNGBIT>>
	     <EQUAL? ,HERE <META-LOC ,QCONTEXT>>>
	<RETURN ,QCONTEXT>)>>

<DEFAULT-DEFINITION META-LOC
<DEFINE META-LOC ML (OBJ "OPTIONAL" (INV <>) "AUX" L)
	<SET L <LOC .OBJ>>
	<REPEAT ()
		<COND (<EQUAL? <> .OBJ .L>
		       <RETURN <> .ML>)
		      (<EQUAL? .L
			       ,LOCAL-GLOBALS ,GLOBAL-OBJECTS ,GENERIC-OBJECTS>
		       <RETURN .L .ML>)
		      (<IN? .OBJ ,ROOMS>
		       <RETURN .OBJ .ML>)
		      (T
		       <COND (<AND .INV <FSET? .OBJ ,INVISIBLE>>
			      <RETURN <> .ML>)>
		       <SET OBJ .L>
		       <SET L <LOC .OBJ>>)>>>>

<DEFAULT-DEFINITION P-PRONOUNS
<GLOBAL P-IT-OBJECT:OBJECT <>>
<GLOBAL P-HER-OBJECT:OBJECT <>>
<GLOBAL P-HIM-OBJECT:OBJECT <>>>

;<DEFINE NOT-IT (WHO)
 <COND (<EQUAL? .WHO ,P-HER-OBJECT>
	<FCLEAR ,HER ,TOUCHBIT>)
       (<EQUAL? .WHO ,P-HIM-OBJECT>
	<FCLEAR ,HIM ,TOUCHBIT>)
       ;(<EQUAL? .WHO ,P-THEM-OBJECT>
	<FCLEAR ,THEM ,TOUCHBIT>)
       (<EQUAL? .WHO ,P-IT-OBJECT>
	<FCLEAR ,IT  ,TOUCHBIT>)>>

<DEFAULT-DEFINITION CANT-UNDO
<IF-UNDO
<DEFINE CANT-UNDO ()
	<TELL "[I can't undo that now.]" CR>>>>

<GLOBAL NOW-PRSI:FLAG <>>

<GLOBAL OBJ-SWAP:FLAG <>>

<DEFAULT-DEFINITION NOT-HERE-VERB?
	<DEFINE NOT-HERE-VERB? (V)
		<EQUAL? .V ,V?WALK-TO>>>

<OBJECT NOT-HERE-OBJECT
	(CONTFCN 0)
	(THINGS 0)>

<DEFAULT-DEFINITION SEE-VERB?
	<DEFINE SEE-VERB? ()
	<VERB? CHASTISE EXAMINE FIND
	       LOOK LOOK-BEHIND LOOK-DOWN LOOK-INSIDE LOOK-UNDER LOOK-UP
	       READ SEARCH>>>

<DEFINE PERFORM (PA "OPT" (PO <>) (PI <>) ;(PQ <>) ;(PS <>)
		    "AUX" V OA OO OI OQ OS X)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <T? .OO> <==? .OO .PI>>
	       <SETG OBJ-SWAP T>)
	      (<AND <T? .OI> <==? .OI .PO>>
	       <SETG OBJ-SWAP T>)
	      (T
	       <SETG OBJ-SWAP <>>)>
	<SETG PRSA .PA>
	<SETG PRSI .PI>
	<SETG PRSO .PO>
	;<IF-P-BE-VERB
	 <SET OS ,PRSS>
	 <SET OQ ,PRSQ>
	 <SETG PRSS .PS>
	 <SETG PRSQ .PQ>>
	<IF-P-DEBUGGING-PARSER
	 <COND (<T? ,P-DBUG>
	       <PRINTI "{Perform: A=">
	       <IFFLAG (IN-ZILCH <PRINTN .PA>)
		       (T <PRINC <NTH ,ACTIONS <+ <* .PA 2> 1>>>)>
	       <COND (<T? .PO>
		      <PRINTI "/O=">
		      <COND (<DIR-VERB?> <PRINTN .PO>)
			    (T <TELL-D-LOC .PO>)>)>
	       <COND (<T? .PI>
		      <PRINTI "/I=">
		      <TELL-D-LOC .PI>)>
	       <IF-P-BE-VERB
	       <COND (<T? ,PRSQ ;.PQ>
		      <PRINTI "/Q=">
		      <IFFLAG (IN-ZILCH <PRINTN ,PRSQ ;.PQ>)
			      (T <PRINC <NTH ,ACTIONS <+ <* ,PRSQ ;.PQ 2> 1>>>)>)>
	       <COND (<T? ,PRSS ;.PS>
		      <PRINTI "/S=">
		      <TELL-D-LOC ,PRSS ;.PS>)>>
	       <PRINTI "}|">)>>
	<SET V <>>
	<IF-P-BE-VERB
	 <COND (<T? ,PRSS>
		<THIS-IS-IT ,PRSS>)>>
	<COND (<T? ,PRSI>
	       <THIS-IS-IT ,PRSI>)>
	<COND (<AND <T? ,PRSO>
		    <NOT <DIR-VERB?>>>
	       <THIS-IS-IT ,PRSO>)>
	<COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
	       <THIS-IS-IT ,WINNER>)>
	<SET PO ,PRSO>
	<SET PI ,PRSI>
	;<IF-P-BE-VERB <SET PS ,PRSS>>
	<COND (<AND ;<ZERO? .V>
		    <NOT <NO-M-WINNER-VERB?>>>
	       <SET V <D-APPLY "Winner" <GETP ,WINNER ,P?ACTION>
			       ,M-WINNER>>)>
	<COND (<AND <ZERO? .V>
		    <NOT <IN? <LOC ,WINNER> ,ROOMS>>
		    ;<FSET? <LOC ,WINNER> ,VEHBIT>>
	       <SET V <D-APPLY "M-BEG"
			       <GETP <LOC ,WINNER> ,P?ACTION>
			       ,M-BEG>>)>
	<COND (<ZERO? .V>
	       <SET V <D-APPLY "M-BEG"
			       <GETP ,HERE ,P?ACTION>
			       ,M-BEG>>)>
	<COND (<ZERO? .V>
	       <COND <IF-P-BE-VERB
		      (<T? ,PRSQ ;.PQ>
		       <COND (<SET X <INTBL? <ZGET ,ACTIONS .PA>
					     <ZREST ,QACTIONS 2>
					     <ZGET ,QACTIONS 0>>>
			      <SET V <D-APPLY "Preaction" <ZGET .X 4>>>)
			     ;(T
			      <SET V <D-APPLY "Preaction"
					      <ZGET ,PREACTIONS .PA>>>)>)>
		     (T
		      <SET V <D-APPLY "Preaction" <ZGET ,PREACTIONS .PA>>>)>)>
	<SETG NOW-PRSI 1>
	<COND (<AND <ZERO? .V>
		    <T? .PI>
		    <NOT <DIR-VERB?>>
		    <LOC .PI>>
	       <COND (<T? <SET V <GETP <LOC .PI> ,P?CONTFCN>>>
		      <SET V <D-APPLY "Container" .V ,M-CONTAINER>>)>)>
	<COND (<AND <ZERO? .V>
		    <T? .PI>>
	       <COND (<EQUAL? .PI ,GLOBAL-HERE>
		      <SET V <D-APPLY "PRSI" <GETP ,HERE ,P?ACTION>>>)>
	       <COND (<ZERO? .V>
		      <SET V <D-APPLY "PRSI" <GETP .PI ,P?ACTION>>>)>)>
	<SETG NOW-PRSI 0>
	<COND (<AND <ZERO? .V>
		    <T? .PO>
		    <NOT <DIR-VERB?>>
		    <LOC .PO>>
	       <SET V <GETP <LOC .PO> ,P?CONTFCN>>
	       <COND (<T? .V>
		      <SET V <D-APPLY "Container" .V ,M-CONTAINER>>)>)>
	<COND (<AND <ZERO? .V>
		    <T? .PO>
		    <NOT <DIR-VERB?>>>
	       <COND (<EQUAL? .PO ,GLOBAL-HERE>
		      <SET V <D-APPLY "PRSO" <GETP ,HERE ,P?ACTION>>>)>
	       <COND (<ZERO? .V>
		      <SET V <D-APPLY "PRSO" <GETP .PO ,P?ACTION>>>)>)>
	<IFFLAG (P-BE-VERB
		 <COND (<ZERO? .V>
			<COND (<T? ,PRSS ;.PS>
			       <SET V <D-APPLY "Subject"
					       <GETP ,PRSS ;.PS ,P?ACTION>
					       ,M-SUBJ>>)>)>)
		;(T
		 "moved down one line")>
	<COND (<ZERO? .V>
	       <COND <IF-P-BE-VERB
		      (<T? ,PRSQ ;.PQ>
		       <COND (<SET X <INTBL? <ZGET ,ACTIONS .PA>
					     <ZREST ,QACTIONS 2>
					     <ZGET ,QACTIONS 0>>>
			      <COND (<SET X <ZGET .X 2>>
				     <SET V <D-APPLY <> .X>>)>)>
		       <COND (<ZERO? .V>
			      <SET V <D-APPLY <> <ZGET ,ACTIONS ,PRSQ>>>)>)>
		     (T
		      <SET V <D-APPLY <> <ZGET ,ACTIONS .PA>>>)>)>
	;<COND (<ZERO? .V>
	       <SET V <D-APPLY <> <ZGET ,ACTIONS .PA>>>)>
	<COND (<EQUAL? ,M-FATAL .V>
	       <SETG P-CONT -1>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	;<IF-P-BE-VERB <SETG PRSS .OS>>
	.V>

<DEFAULT-DEFINITION TELL-TOO-DARK
 <DEFINE TELL-TOO-DARK () <TELL ,TOO-DARK> <RETURN ,M-FATAL>>>

<DEFAULT-DEFINITION ITAKE-CHECK
 <DEFINE ITAKE-CHECK (OBJ BITS "AUX" (TAKEN <>))
	 <COND (<==? .OBJ ,IT>
		<SET OBJ ,P-IT-OBJECT>)>
	 <COND (<AND <NOT <HELD? .OBJ ,WINNER>>
		     <NOT <EQUAL? .OBJ ,HANDS ,ROOMS>>>
		<COND (<FSET? .OBJ ,TRYTAKEBIT>
		       T)
		      (<NOT <==? ,WINNER ,PLAYER>>
		       <SET TAKEN T>)
		      (<AND <BTST .BITS ,SEARCH-DO-TAKE>
			    <==? <ITAKE <> .OBJ> T>>
		       <SET TAKEN T>)>
		<COND (<AND <NOT .TAKEN>
			    <BTST .BITS ,SEARCH-MUST-HAVE>
			    <NOT <BTST .BITS ,SEARCH-MOBY>>>
		       <TELL !\[>
		       <COND (<EQUAL? ,WINNER ,PLAYER>
			      <TELL "You are">)
			     (T
			      <TELL-CTHE ,WINNER>
			      <TELL " is">)>
		       <TELL "n't holding ">
		       <TELL-THE .OBJ>
		       <THIS-IS-IT .OBJ>
		       <TELL "!]" CR>
		       <RTRUE>)
		      ;(<AND .TAKEN <==? ,WINNER ,PLAYER>>
		       <FIRST-YOU "take" .OBJ ,ITAKE-LOC>)>)>>>

<IF-P-DEBUGGING-PARSER
<DEFINE TELL-D-LOC (OBJ)
	<PRINTD .OBJ>
	<COND (<IN? .OBJ ,GLOBAL-OBJECTS>	<PRINTI "(gl)">)
	      (<IN? .OBJ ,LOCAL-GLOBALS>	<PRINTI "(lg)">)
	      (<IN? .OBJ ,ROOMS>		<PRINTI "(rm)">)>
	<COND (<EQUAL? .OBJ ,INTNUM>
	       <PRINTC !\(>
	       <PRINTN ,P-NUMBER>
	       <PRINTC !\)>)>>>

<DEFINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
 <COND (<T? .FCN>
	<IF-P-DEBUGGING-PARSER
	 <COND (<T? ,P-DBUG>
		<COND (<ZERO? .STR>
		       <PRINTI "{Action:}|">)
		      (T
		       <PRINTC !\{>
		       <PRINT .STR>
		       <COND (<=? .STR "Winner">
			      <PRINTC !\=>
			      <TELL D ,WINNER>)>
		       <PRINTI ": ">)>)>>
	<COND (<T? .FOO> <SET RES <ZAPPLY .FCN .FOO>>)
	      (T <SET RES <ZAPPLY .FCN>>)>
	<IF-P-DEBUGGING-PARSER
	 <COND (<AND <T? ,P-DBUG> <T? .STR>>
		<COND (<OR <EQUAL? ,M-FATAL .RES>
			   <EQUAL? ,P-CONT -1>>
		       <PRINTI "Fatal}|">)
		      (<ZERO? .RES>
		       <PRINTI "Not handled}|">)
		      (T <PRINTI "Handled}|">)>)>>
	.RES)>>

<DEFAULT-DEFINITION CAPITAL-NOUN?
	<DEFINE CAPITAL-NOUN? (NAM) <>>>

<DEFAULT-DEFINITION NOT-HERE
<DEFINE NOT-HERE (OBJ "OPT" (CLOCK <>))
	<COND (<ZERO? .CLOCK>
	       <SETG CLOCK-WAIT T>
	       <TELL "[But">)>
	<TELL !\ >
	<TELL-THE .OBJ>
	<TELL " isn't ">
	<COND (<VISIBLE? .OBJ>
	       <TELL "close enough">
	       <COND (<SPEAKING-VERB?> <TELL " to hear you">)>
	       <TELL !\.>)
	      (T <TELL "here!">)>
	 <THIS-IS-IT .OBJ>
	 <COND (<ZERO? .CLOCK>
		<TELL !\]>)>
	 <CRLF>>>

<DEFAULT-DEFINITION ASKING-VERB-WORD?
 <ADD-WORD ASK ASKWORD>
 <ADD-WORD ORDER ASKWORD>
 <ADD-WORD TELL ASKWORD>
 ;<DEFINE ASKING-VERB-WORD? (WD)
 <COND (<EQUAL? .WD ,W?ASK ,W?ORDER ,W?TELL>
	T)>>>

<DEFAULT-DEFINITION SPEAKING-VERB?
 <DEFINE SPEAKING-VERB? ("OPT" (A ,PRSA) ;(PER 0))
 <COND (<EQUAL? .A ,V?ANSWER ,V?ASK-ABOUT ,V?ASK-FOR ,V?HELLO
		   ,V?NO ,V?REPLY ,V?TELL ,V?TELL-ABOUT ,V?YES>
	<COND (T ;<EQUAL? .PER 0 ,PRSO>
	       <RTRUE>)>)>>>

<DEFINE GET-OWNER (OBJ "AUX" TMP NP)
 <COND (<SET NP <GET-NP .OBJ>>
	<COND (<OR <SET TMP <NP-OF .NP>>
		   <AND <SET TMP <NP-ADJS .NP>>
			<SET TMP <ADJS-POSS .TMP>>>>
	       <COND (<OBJECT? .TMP>
		      .TMP)
		     ;(T
		      <NOUN-PHRASE-OBJ1 .TMP>)>)
	      (<AND <SET TMP <GETP .OBJ ,P?OWNER>>
		    <NOT <OBJECT? .TMP>>>	;"body part"
	       ,PLAYER)>)>>

<DEFINE GET-NP ("OPT" (OBJ <>) "AUX" (PRSI? ,NOW-PRSI))
  <COND (<NOT <EQUAL? .OBJ ,PRSO ,PRSI>>
	 <RETURN <>>)
	(.OBJ
	 <COND (<==? .OBJ ,PRSO> <SET PRSI? <>>)
	       (T <SET PRSI? T>)>)>
  <COND (,OBJ-SWAP
	 <COND (<T? .PRSI?> ,PRSO-NP)
	       (T ,PRSI-NP)>)
	(<T? .PRSI?>
	 ,PRSI-NP)
	(T ,PRSO-NP)>>

<DEFAULT-DEFINITION NOUN-USED?
<DEFINE NOUN-USED? (OBJ WD1 "OPT" (WD2 <>) (WD3 <>) "AUX" X)
	<AND <SET X <GET-NP .OBJ>>
	     <SET X <NP-NAME .X>>
	     <EQUAL? .X .WD1 .WD2 .WD3>>>>

<DEFAULT-DEFINITION ADJ-USED?
<DEFINE ADJ-USED? (OBJ WD1 "OPT" (WD2 <>) (WD3 <>) "AUX" NP CT)
 <COND (<AND <SET NP <GET-NP .OBJ>>
	     <SET NP <NP-ADJS .NP>>>
	<COND (<AND <EQUAL? ,PLAYER <ADJS-POSS .NP>>
		    <EQUAL? ,W?MY .WD1 .WD2 .WD3>>
	       ,W?MY)
	      (<G? <SET CT <ADJS-COUNT .NP>> 0>
	       <SET NP <REST-TO-SLOT .NP ADJS-COUNT 1>>
	       <COND (<ZMEMQ .WD1 .NP .CT>
		      .WD1)
		     (.WD2
		      <COND (<ZMEMQ .WD2 .NP .CT>
			     .WD2)
			    (.WD3
			     <COND (<ZMEMQ .WD3 .NP .CT>
				    .WD3)>)>)>)>)>>>

<END-SEGMENT>
