"PRARE file for NEW PARSER
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

<ZZPACKAGE "PARSER">

<RENTRY	PRINT-LEXV
	TELL-CTHE
	TELL-THE>

<INCLUDE "BASEDEFS" "PBITDEFS" "PDEFS">

<USE "PMEM" "PSTACK">

<FILE-FLAGS MDL-ZIL? CLEAN-STACK?>

<BEGIN-SEGMENT 0>

<DEFAULTS-DEFINED
	CANT-FIND-OBJECT
	CANT-USE-MULTIPLE
	DONT-UNDERSTAND
	PARSER-REPORT
	PRINT-INTQUOTE
	PRINT-LEXV
	REFRESH
	;SAMPLE-COMMANDS
	SETUP-ORPHAN
	SETUP-ORPHAN-NP
	TOO-MANY-NOUNS
	WHICH-LIST?
	WHICH-PRINT
	YES?>

<DEFINE TOO-MANY-NEW (WHAT)
	<TELL "[Warning: there are too many new " .WHAT "s.]" CR>>

<DEFINE NAKED-OOPS () <TELL "[Please type a word(s) after OOPS.]" CR>>

<DEFINE CANT-OOPS ()
	<TELL "[There was no word to replace in that sentence.]" CR>>

<DEFINE CANT-AGAIN () <TELL "[What do you want to do again?]" CR>>

<DEFAULT-DEFINITION CANT-USE-MULTIPLE
<DEFINE CANT-USE-MULTIPLE (LOSS WD)
	<SETG CLOCK-WAIT T>
	;<COND (<==? .LOSS 2> <TELL "in">)>
	;<TELL "direct ">
	<TELL "[You can't use more than one object at a time with \"">
	<PRINT-VOCAB-WORD .WD>
	<TELL "\"!]" CR>>>

<DEFINE MAKE-ROOM-FOR-TOKENS (CNT LEXV WHERE "AUX" LEN)
	<SET LEN <* 2 <GETB .LEXV 0>>>
	<COND (<L? .LEN <+ .WHERE <* ,P-LEXELEN .CNT>>>
	       <SET CNT </ <- .LEN .WHERE> ,P-LEXELEN>>
	       <TOO-MANY-NEW "word">)>
	<SET LEN <GETB .LEXV ,P-LEXWORDS>>
	<PUTB .LEXV ,P-LEXWORDS <+ .CNT .LEN>>	;"update count"
	<COND (T ;<OR <CHECK-EXTENDED? XZIP>
		      <CHECK-EXTENDED? YZIP>>		;"make space in dest."
		<COPYT <SET LEXV <ZREST .LEXV <* 2 .WHERE>>>
		       <ZREST .LEXV <* .CNT <* 2 ,P-LEXELEN>>>
		       <* 2 <- <* 2 .LEN> <- .WHERE ,P-LEXSTART>>>>)
	      ;(T
	       <PROG ()
		     <SET CNT <* ,P-LEXELEN .CNT>>
		     <SET LEN <* ,P-LEXELEN .LEN>>
		     <REPEAT ()
			     <ZPUT .LEXV <+ .CNT .LEN> <ZGET .LEXV .LEN>>
			     <COND (<L? <SET LEN <- .LEN 1>> .WHERE>
				    <RETURN>)>>>)>>

<DEFINE REPLACE-ONE-TOKEN (N FROM-LEXV PTR TO-LEXV WHERE "AUX" CNT)
	<SET CNT <- .N 1>>
	<COND (<NOT <0? .CNT>>
	       <MAKE-ROOM-FOR-TOKENS .CNT .TO-LEXV .WHERE>)>
	<SET CNT .N>
	<REPEAT (X)	;"copy tokens"
		<COND (<L? <SET CNT <- .CNT 1>> 0>
		       <RETURN>)>
		<SET PTR <+ .PTR ,P-LEXELEN>>
		<ZPUT .TO-LEXV .WHERE <ZGET .FROM-LEXV .PTR>>
		<SET X <+ <* .PTR ,P-LEXELEN> 2>>
		<COND (<ZERO? <INBUF-ADD <GETB .FROM-LEXV .X>
					 <GETB .FROM-LEXV <+ .X 1>>
					 <+ <* .WHERE ,P-LEXELEN> 3>>>
		       <TOO-MANY-NEW "letter">
		       <RETURN>)>
		<SET WHERE <+ .WHERE ,P-LEXELEN>>>>

<DEFAULT-DEFINITION REFRESH
;<SYNTAX $REFRESH = V-$REFRESH>
<DEFINE V-$REFRESH ()
	 <LOWCORE FLAGS <BAND <LOWCORE FLAGS> <BCOM ,F-REFRESH>>>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <RTRUE>>>

<DEFAULT-DEFINITION PRINT-INTQUOTE
<DEFINE PRINT-INTQUOTE ("AUX" (NP <GET-NP ,INTQUOTE>))
	<PRINT-LEXV -1
		    <ZREST <NP-LEXBEG .NP> ,LEXV-ELEMENT-SIZE-BYTES>
		    <+ -1 </ <- <NP-LEXEND .NP> <NP-LEXBEG .NP>>
			     ,LEXV-ELEMENT-SIZE-BYTES>>>
	;<BUFFER-PRINT <ZREST <NP-LEXBEG .NP> <* 2 ,LEXV-ELEMENT-SIZE-BYTES>>
		      <NP-LEXEND .NP>
		      <>
		      T>>>

<DEFAULT-DEFINITION PRINT-LEXV
<DEFINE PRINT-LEXV ("OPT" (QUIET 0)
			(X <ZREST ,TLEXV <* .QUIET ,LEXV-ELEMENT-SIZE-BYTES>>)
			(LEN <- ,P-LEN .QUIET>))
	<COND (<OR <ZERO? .QUIET> <G? 0 ,P-OFLAG>>
	       <TELL "[In other words:" ;,I-ASSUME>)
	      ;(T
	       <IFFLAG (P-DEBUGGING-PARSER <PRINTI "[Debugging info: ">)
		       (T T)>)>
	;<BUFFER-PRINT .X <+ .X <* ,P-WORDLEN ,P-LEN>>>
	<REPEAT (WD (IN-QUOTE <>)
		 (OWD <COND (<EQUAL? .QUIET -1> ,W?APOSTROPHE) (T 0)>))
		<SET WD <ZGET .X 0>>
		<COND (<EQUAL? .WD
			       ,W?PERIOD ,W?COMMA ,W?APOSTROPHE ,W?NO.WORD>
		       T)
		      (<EQUAL? .OWD ,W?APOSTROPHE>
		       T)
		      (<AND <EQUAL? .OWD ,W?QUOTE>
			    <F? .IN-QUOTE>>
		       <SET IN-QUOTE T>)
		      (<AND <EQUAL? .WD ,W?QUOTE>
			    <T? .IN-QUOTE>>
		       <SET IN-QUOTE <>>)
		      (T
		       <TELL !\ >)>
		<COND (<EQUAL? .WD ,W?NO.WORD>
		       T)
		      (<NOT <EQUAL? .WD 0 ,W?INT.NUM ,W?INT.TIM>>
		       <PRINT-VOCAB-WORD .WD>)
		      (T
		       <BUFFER-PRINT .X <+ .X ,P-WORDLEN> <> T>)>
		<COND (<DLESS? LEN 1>
		       <RETURN>)>
		<COND (<NOT <EQUAL? .WD ,W?NO.WORD>>
		       <SET OWD .WD>)>
		<SET X <ZREST .X ,LEXV-ELEMENT-SIZE-BYTES>>>
	<COND (<OR <ZERO? .QUIET> <G? 0 ,P-OFLAG>>
	       <TELL "]" CR>)
	      ;(T
	       <IFFLAG (P-DEBUGGING-PARSER <TELL "]" CR>)
		       (T T)>)>
	;<SETG P-OFLAG <>>>>

<DEFINE COPY-INPUT ("OPT" (QUIET 0) "AUX" LEN)
	<COPYT ,G-LEXV ,P-LEXV ,LEXV-LENGTH-BYTES>
	<SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
	<SETG TLEXV <ZGET ,OOPS-TABLE ,O-START ;,O-AGAIN>>
	<COPYT ,G-INBUF ,P-INBUF <+ 1 ,INBUF-LENGTH>>
	<SET LEN <* <* 2 ,P-LEXELEN:FIX>
		    <GETB ,P-LEXV ,P-LEXWORDS>>>
	<ZPUT ,OOPS-TABLE ,O-END
	      <+ <GETB ,TLEXV <SET LEN <- .LEN 1>>>
		 <GETB ,TLEXV <SET LEN <- .LEN 1>>>>>
	<COND (<NOT .QUIET>
	       <PRINT-LEXV .QUIET>)>
	<SETG P-OFLAG <>>>

<COND (<NOT <OR <CHECK-VERSION? XZIP>
		<CHECK-VERSION? YZIP>>>
<DEFINE COPY-INBUF (SRC DEST "AUX" CNT:FIX)
	<SET CNT <- <GETB .SRC 0> 1>>
	<REPEAT ()
		<PUTB .DEST .CNT <GETB .SRC .CNT>>
		<COND (<L? <SET CNT <- .CNT 1>> 0>
		       <RETURN>)>>>

<DEFINE COPY-LEXV (SRC DEST "OPT" (MAX:FIX ,LEXV-LENGTH) "AUX" (CTR:FIX 1))
	<PUTB .DEST 0 <GETB .SRC 0>>
	<PUTB .DEST 1 <GETB .SRC 1>>
	<SET DEST <ZREST .DEST <* ,P-LEXSTART:FIX 2>>>
	<SET SRC <ZREST .SRC <* ,P-LEXSTART:FIX 2>>>
	<REPEAT ()
		<ZPUT .DEST 0 <ZGET .SRC 0>>
		<PUTB .DEST 2 <GETB .SRC 2>>
		<PUTB .DEST 3 <GETB .SRC 3>>
		<COND (<G? <SET CTR <+ .CTR 1>> .MAX>
		       <RETURN>)>
		<SET DEST <ZREST .DEST <* 2 ,P-LEXELEN:FIX>>>
		<SET SRC <ZREST .SRC <* 2 ,P-LEXELEN:FIX>>>>>)>

<END-SEGMENT>

;"<DEFAULT-DEFINITION SAMPLE-COMMANDS"
<IFN-P-BE-VERB

<BEGIN-SEGMENT HINTS>

<SYNTAX $NUDGE = V-$NUDGE>
<SYNTAX $NUDGE OBJECT = V-$NUDGE>

<ROUTINE V-$NUDGE ()
	<SETG CLOCK-WAIT T>
	<LEXV-WORD ,TLEXV ,W?SHOULD>	;"force sample command"
	<TELL "[">
	;<PRINT "Please use commands">
	<TELL-SAMPLE-COMMANDS>
	;<TELL ".]" CR>>

<GLOBAL P-ERRS:NUMBER 0>
;<GLOBAL P-THRESH:NUMBER 10>

<DEFINE COUNT-ERRORS ("OPT" (NUM 1)
		      "AUX" (THRESH <COND (<FSET? ,GREAT-HALL ,TOUCHBIT> 10)
					  (T 2)>))
	<SETG P-ERRS <+ .NUM ,P-ERRS>>
	<COND (<G? ,P-ERRS .THRESH>
	       <SETG P-ERRS 0>
	       <TELL
"[I'm having trouble understanding you. Maybe it's because you're not
used to the rules for commands. ">
	       <COND (<AND <NOT <FSET? ,GREAT-HALL ,TOUCHBIT>>
			   <T? ,PROLOGUE-NOVICE-COUNTER>>
		      <TELL "Here's the command you should type now:|
	"
			    <ZGET ,NOVICE-MOVES ,PROLOGUE-NOVICE-COUNTER>
			    "|
Please try that.]" CR>)
		     (T
		      <TELL-SAMPLE-COMMANDS>)>)>>

<DEFINE FIND-UEXIT-STR ACT ("AUX" (P 0))
 <REPEAT ()
	 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
		<RETURN <> .ACT>)
	       (T
		<COND (<EQUAL? <PTSIZE <GETPT ,HERE .P>> ,UEXIT>
		       <RETURN <DIR-TO-STRING .P> .ACT>)>)>>>

<CONSTANT TELL-SAMPLE-COMMANDS-NUMBER 3>

<DEFINE TELL-SAMPLE-COMMANDS ("AUX" VERB SYN (OBJ <>) (NUM 0))
	<TELL
" Commands tell the computer what you want to do in the story.
Here are some commands that you can type right now, although
they may or may not be useful:|">
	;"0 objects:"
   <REPEAT ((CT <ZGET ,SAMPLE-COMMANDS-TABLE-0 0>)
	    (N <COND (<T? ,PRSO> .CT) (T ,TELL-SAMPLE-COMMANDS-NUMBER)>))
	<SET VERB <ZGET ,SAMPLE-COMMANDS-TABLE-0
			<COND (<T? ,PRSO> .N) (T <RANDOM .CT>)>>>
	<COND (<DLESS? N 0>
	       <RETURN>)
	      (<OR <NOT <EQUAL? .VERB ,W?GO>>
		   <SET OBJ <FIND-UEXIT-STR>>>
	       <INC NUM>
	       <TELL "	">
	       <PRINT-VOCAB-WORD .VERB>
	       <COND (.OBJ
		      <TELL !\  .OBJ>)>
	       <CRLF>
	       <COND (<F? ,PRSO>
		      <RETURN>)>)>>
	;"1 object:"
   <REPEAT ((CT <ZGET ,SAMPLE-COMMANDS-TABLE-1 0>)
	    (N <COND (<T? ,PRSO> .CT) (T ,TELL-SAMPLE-COMMANDS-NUMBER)>))
	<SET VERB <ZGET ,SAMPLE-COMMANDS-TABLE-1
			<COND (<T? ,PRSO> .N) (T <RANDOM .CT>)>>>
	<COND (<DLESS? N 0>
	       <RETURN>)
	      (<AND <SET SYN <VERB-ONE <WORD-VERB-STUFF .VERB>>>
		    <GET-SYNTAX .SYN 1 0 T>
		    <SET OBJ <DETERMINE-OBJ <> 1 T>>
		    <SET OBJ <NOUN-PHRASE-OBJ1 .OBJ>>>
	       <INC NUM>
	       <TELL "	">
	       <PRINT-VOCAB-WORD .VERB>
	       <TELL !\  D .OBJ CR>
	       <COND (<F? ,PRSO>
		      <RETURN>)>)>>
	;"2 objects:"
   <REPEAT ((CT </ <ZGET ,SAMPLE-COMMANDS-TABLE-2 0> 2>)
	    (N <COND (<T? ,PRSO> .CT) (T ,TELL-SAMPLE-COMMANDS-NUMBER)>))
	<COND (<0? .N>
	       <RETURN>)>
	<SET VERB <- <* <COND (<T? ,PRSO> .N) (T <RANDOM .CT>)> 2> 1>>
	<SET SYN <ZGET ,SAMPLE-COMMANDS-TABLE-2 .VERB>>
	<COND (<0? <WORD-CLASSIFICATION-NUMBER .SYN>>	;"a synonym"
	       <SET SYN <WORD-SEMANTIC-STUFF .SYN>>)>
	<COND (<DLESS? N 0>
	       <RETURN>)
	      (<AND <SET SYN <VERB-TWO <WORD-VERB-STUFF .SYN>>>
		    <PARSE-PARTICLE2 ,PARSE-RESULT
				<ZGET ,SAMPLE-COMMANDS-TABLE-2 <+ 1 .VERB>>>
		    <GET-SYNTAX .SYN 2 0 T>
		    <SET OBJ <DETERMINE-OBJ <> 1 T>>
		    <SET OBJ <NOUN-PHRASE-OBJ1 .OBJ>>
		    <SET SYN <DETERMINE-OBJ <> 2 T>>
		    <SET SYN <NOUN-PHRASE-OBJ1 .SYN>>>
	       <INC NUM>
	       <TELL "	">
	       <PRINT-VOCAB-WORD <ZGET ,SAMPLE-COMMANDS-TABLE-2 .VERB>>
	       <TELL !\  D .OBJ !\ >
	       <PRINT-VOCAB-WORD <ZGET ,SAMPLE-COMMANDS-TABLE-2 <+ 1 .VERB>>>
	       <TELL !\  D .SYN CR>
	       <COND (<F? ,PRSO>
		      <RETURN>)>)>>
   <COND (<OR <T? ,P-WON> <1? <RANDOM 2>>> ;<NOT <IGRTR? NUM 3>>
	  <TELL "	say \"">
	  <SET SYN <ZREST ,VOCAB <+ 1 <GETB ,VOCAB 0>>>>
	  <REPEAT (N (M <GETB .SYN 0>))
		<SET N <ZREST .SYN <+ 3 <* .M	;"size of entry"
					   <- <RANDOM <ZGET <ZREST .SYN 1> 0>
					       ;"number of entries">
					      1>>>>>
		<COND (<AND <G=? .N ,W?A>
			    <T? <WORD-CLASSIFICATION-NUMBER .N>>
			    <NOT <EQUAL? .N ,W?END.OF.INPUT ,W?NO.WORD
					    ,W?INT.NUM ,W?INT.TIM>>>
		       <PRINT-VOCAB-WORD .N>
		       <RETURN>)>>
	  <TELL "\"|">)>
   <COND (<IN? ,JESTER ,HERE> ;<NOT <IGRTR? NUM 3>>
	  <TELL "	jester, give me the key|">)>
   <TELL "Now you can try again.]" CR>>

<CONSTANT SAMPLE-COMMANDS-TABLE-0 <PLTABLE
	<VOC "GO">	;"[a direction]"
	<VOC "INVENTORY">
	<VOC "LOOK">
	<VOC "WAIT">>>

<CONSTANT SAMPLE-COMMANDS-TABLE-1 <PLTABLE
	<VOC "TAKE">
	<VOC "DROP">
	<VOC "EXAMINE">	;"[a visible object]"
	<VOC "READ">
	<VOC "OPEN">	;"[a closed container]"
	<VOC "CLOSE">	;"[an open container]"
	<VOC "BOARD">	;"[a vehicle you're not in]"
	<VOC "EXIT">	;"[a vehicle you're in]"
	<VOC "WEAR">
	<VOC "REMOVE">>>

<CONSTANT SAMPLE-COMMANDS-TABLE-2 <PLTABLE
	<VOC "PUT"> <VOC "IN">	;"[a held object] INTO [an open container]"
	<VOC "GIVE"> <VOC "TO">
	<VOC "ASK"> <VOC "ABOUT"> ;"[a character] ABOUT [one of several topics]
	[a character], HELLO
	[a character], GO [a direction]">>

<END-SEGMENT>
>
;">"

<BEGIN-SEGMENT 0>

<ADD-WORD NO.WORD ADJ>

<DEFINE BUFFER-PRINT (BEG END "OPT" (CP <>) (NOSP <>) ;(ALL <>)
		      "AUX" WRD NW (FIRST?? T) (PN <>) TMP)
 <REPEAT ()
	 <COND (<EQUAL? .BEG .END> <RETURN>)>
	 <COND (<OR <T? .NOSP>
		    <EQUAL? .NW ,W?PERIOD ,W?COMMA ,W?APOSTROPHE>>
		<SET NOSP <>>)
	       (T <TELL !\ >)>
	 <SET WRD <ZGET .BEG 0>>
	 <COND (<EQUAL? .END <ZREST .BEG ,P-WORDLEN>>
		<SET NW 0>)
	       (T <SET NW <ZGET .BEG ,P-LEXELEN>>)>
	 <COND (<EQUAL? .WRD ,W?NO.WORD>
		<SET NOSP T>)
	       (<EQUAL? .WRD ,W?MY>
		<PRINTB ,W?YOUR>)
	       (<EQUAL? .WRD ,W?ME>
		<PRINTB ,W?YOU>
		<SET PN T>)
	       (<EQUAL? .WRD ,W?ONE>
		<TELL "object">)
	       (<AND ;<T? .ALL>
		     <IFFLAG (P-APOSTROPHE-BREAKS-WORDS
			<NOT <EQUAL? .WRD <> ,W?ALL ,W?PERIOD ,W?APOSTROPHE>>)
			     (T
			<NOT <EQUAL? .WRD <> ,W?ALL ,W?PERIOD>>)>
		     <OR <AND <0? <SET TMP <WORD-CLASSIFICATION-NUMBER .WRD>>>
			      <F? <WORD-SEMANTIC-STUFF .WRD>>>	;"BUZZ"
			 ;<COMPARE-WORD-TYPES .TMP <GET-CLASSIFICATION PREP>>>
		     <NOT <COMPARE-WORD-TYPES .TMP <GET-CLASSIFICATION ADJ>>>
		     <NOT <COMPARE-WORD-TYPES .TMP <GET-CLASSIFICATION NOUN>>>>
		<SET NOSP T>)
	       (<CAPITAL-NOUN? .WRD>
		<CAPITALIZE .BEG>
		<SET PN T>)
	       (T
		<COND (<AND <T? .FIRST??> <ZERO? .PN> <T? .CP>>
		       <COND (<NOT <EQUAL? .WRD ,W?HER ,W?HIM ,W?YOUR>>
			      <TELL "the ">)>)>
		<COND ;(<AND <T? ,P-OFLAG>
			    <T? .WRD>>
		       <PRINT-VOCAB-WORD .WRD>)
		      (<AND <EQUAL? .WRD ,W?IT>
			    <VISIBLE? ,P-IT-OBJECT>>
		       <TELL D ,P-IT-OBJECT>)
		      (<AND <EQUAL? .WRD ,W?HER>
			    <ZERO? .PN>>
		       <TELL D ,P-HER-OBJECT>)
		      (<AND <EQUAL? .WRD ,W?HIM>
			    <ZERO? .PN>>
		       <TELL D ,P-HIM-OBJECT>)
		      (<EQUAL? .WRD ,W?INT.NUM ,W?INT.TIM>
		       <TELL N <ZGET .BEG 1>>)
		      (T
		       <WORD-PRINT .BEG>)>
		<SET FIRST?? <>>)>
	 <SET BEG <ZREST .BEG ,P-WORDLEN>>>>

<ROUTINE CAPITALIZE (PTR)
	 <COND ;(<T? ,P-OFLAG>
		<PRINT-VOCAB-WORD <LEXV-WORD .PTR>>)
	       (T
		<PRINTC <- <GETB ,P-INBUF <LEXV-WORD-OFFSET .PTR>>
			   <- !\a !\A>>>
		<WORD-PRINT .PTR
			    <- <LEXV-WORD-LENGTH .PTR> 1>
			    <+ <LEXV-WORD-OFFSET .PTR> 1>>)>>

<DEFINE PRINT-PARSER-FAILURE ("AUX"
	(CLASS <ZGET ,ERROR-ARGS 1>) (OTHER <ZGET ,ERROR-ARGS 2>)
	(OTHER2<ZGET ,ERROR-ARGS 3>))
 ;<ZPUT ,ERROR-ARGS 1 0>
 <COND (<==? .CLASS ,PARSER-ERROR-ORPH-S>
	<PROG (TMP PR N)
	      <SETG P-OFLAG </ <- <ZGET ,ORPHAN-S ,O-LEXPTR> ,P-LEXV> 2>>
	      <COPYT ,G-LEXV ,O-LEXV ,LEXV-LENGTH-BYTES>
	      <COPYT ,G-INBUF ,O-INBUF <+ 1 ,INBUF-LENGTH>>
	      <ZPUT ,OOPS-TABLE ,O-AGAIN <ZGET ,OOPS-TABLE ,O-START>>
	      <MAKE-ROOM-FOR-TOKENS 1 ,O-LEXV ,P-OFLAG>
	      <ZPUT ,O-LEXV ,P-OFLAG ,W?NO.WORD ;0>
	      <TELL "[Wh">
	      <COND (<ZAPPLY ,DIR-VERB-WORD? <ZGET ,ORPHAN-S ,O-VERB>>
		     <TELL "ere">)
		    (<==? ,PERSONBIT
			  <COND (<1? <ZGET ,ORPHAN-S ,O-WHICH>>
				 <SYNTAX-FIND ;B4
				      <ZGET ,ORPHAN-S ,O-SYNTAX> 1>)
				(T <SYNTAX-FIND ;B8
				      <ZGET ,ORPHAN-S ,O-SYNTAX> 2>)>>
		     <TELL "om">)
		    (T <TELL "at">)>
	      <TELL !\ >
	      <COND (<AND <SET PR <ZGET ,ORPHAN-S ,O-SUBJECT>>
			  <BAND ,PAST-TENSE
				<WORD-FLAGS<SET TMP<ZGET ,ORPHAN-S ,O-VERB>>>>>
		     <TELL "did ">
		     <TELL-THE .PR>
		     <TELL !\ >)
		    (T
		     <TELL "do you want ">
		     <COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
			    <TELL D ,WINNER " ">)>
		     <TELL "to ">)>
	      <PRINT-VOCAB-WORD <ROOT-VERB <ZGET ,ORPHAN-S ,O-VERB>>>
	      <SET TMP <ZGET ,ORPHAN-S ,O-PART>>
	      <COND (<NOT <EQUAL? .TMP 0 1>>
		     <TELL !\ >
		     <PRINT-VOCAB-WORD .TMP>)>
	      <COND (<SET TMP <ZGET ,ERROR-ARGS 2>>
		     <TELL !\ >
		     <COND (<SET PR <ZGET ,ORPHAN-S ,O-OBJECT>>
			    <TELL-THE .PR>)
			   (T
			    <NP-PRINT .TMP>)>
		     <COND (<SET TMP <ZGET ,ORPHAN-S ,O-SYNTAX>>
			    <SET TMP <COND (<1? <ZGET ,ORPHAN-S ,O-WHICH>>
					    <SYNTAX-PREP .TMP 1>)
					   (T
					    <SYNTAX-PREP .TMP 2>)>>
			    <COND (<T? .TMP>
				   <SET N <GETB ,O-LEXV ,P-LEXWORDS>>
				   <SET PR <ZGET ,O-LEXV
						 <- ,P-OFLAG ,P-LEXELEN>>>
				   <COND (<0? <WORD-CLASSIFICATION-NUMBER .PR>>
					  ;"synonym"
					  <SET PR <WORD-SEMANTIC-STUFF .PR>>)>
				   <COND (<N==? .TMP .PR>
					  <SET N <+ 1 .N>>
					  <PUTB ,O-LEXV ,P-LEXWORDS .N>
					  <ZPUT ,O-LEXV ,P-OFLAG .TMP>
					  <SETG P-OFLAG
						<+ ,P-OFLAG ,P-LEXELEN>>)>
				   <ZPUT ,O-LEXV ,P-OFLAG ,W?NO.WORD ;0>
				   <INBUF-PRINT .TMP ,O-INBUF
						,O-LEXV<+ 1 <* ,P-WORDLEN .N>>>
				   <TELL !\ >
				   <PRINT-VOCAB-WORD .TMP>)>)>)>
	      <TELL "?]" CR>
	      <RTRUE>>)
       (<==? .CLASS ,PARSER-ERROR-ORPH-NP>
	<REPEAT ((NP .OTHER)
		 (PTR <NP-LEXEND .NP>)
		 (NOUN <NP-NAME .NP>))
		<COND (<==? .NOUN <ZGET .PTR 0>>
		       <SETG P-OFLAG </ <- .PTR ,P-LEXV> 2>>
		       <COPYT ,G-LEXV ,O-LEXV ,LEXV-LENGTH-BYTES>
		       <COPYT ,G-INBUF ,O-INBUF <+ 1 ,INBUF-LENGTH>>
		       <ZPUT ,OOPS-TABLE ,O-AGAIN <ZGET ,OOPS-TABLE ,O-START>>
		       <WHICH-PRINT .NP>
		       <RTRUE>)
		      (<G? ,P-LEXV <SET PTR <- .PTR ,LEXV-ELEMENT-SIZE-BYTES>>>
		       <RETURN>)>>)>
 ;<SETG P-OFLAG 0>
 <COND ;(<==? .CLASS ,PARSER-ERROR-QUIET>
	<RTRUE>)
       (<==? .CLASS ,PARSER-ERROR-NOMULT>
	<CANT-USE-MULTIPLE .OTHER .OTHER2>
	<RTRUE>)
       (<EQUAL? .CLASS ,PARSER-ERROR-NOOBJ>
	<CANT-FIND-OBJECT .OTHER .OTHER2>
	<RTRUE>)
       (<EQUAL? .CLASS ,PARSER-ERROR-TMNOUN>
	<TOO-MANY-NOUNS <PARSE-VERB ,PARSE-RESULT>>
	<RTRUE>)
       (T ;<OR <==? .CLASS ,PARSER-ERROR-NOUND>
	    <NOT <L? ,ERROR-PRIORITY 255>>>
	<SET OTHER2 ,OTLEXV>	;"Try to handle PUSH RED --"
	<COND (<OR <AND <ZERO? ,P-LEN>
			<NAKED-ADJECTIVE? <ZGET .OTHER2 0>>>
		   <AND <L? ,P-LEXV
			    <SET OTHER2 <ZBACK ,OTLEXV <* 2 ,P-LEXELEN>>>>
			<L? 0 ,P-LEN>
			<NAKED-ADJECTIVE? <ZGET .OTHER2 0>>
			<WORD-TYPE? <ZGET ,OTLEXV 0>
				    ,P-EOI-CODE ,P-COMMA-CODE>>>
	       <SET CLASS <+ ,P-LEXELEN </ <- .OTHER2 ,P-LEXV> 2>>>
	       <MAKE-ROOM-FOR-TOKENS 1 ,P-LEXV .CLASS>
	       <MAKE-ROOM-FOR-TOKENS 1 ,G-LEXV .CLASS>
	       <CHANGE-LEXV <ZREST .OTHER2 <* 2 ,P-LEXELEN>> ,W?ONE>
	       <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>
			   ;<+ 1 <ZGET ,OOPS-TABLE ,O-LENGTH>>>
	       <SETG TLEXV <ZGET ,OOPS-TABLE ,O-START>>
	       ;<PRINT-LEXV>
	       <RETURN <PARSE-IT <>>>)>
	<COND ;"Try to handle TAKE THIS JOB AND SHOVE IT --"
	      (<AND <G? ,P-LEN 0>
		    <OR <CHANGE-AND-TO-THEN? <SET OTHER2
					      <ZBACK ,OTLEXV<* 2 ,P-LEXELEN>>>>
			<CHANGE-AND-TO-THEN? <SET OTHER2 ,OTLEXV>>>>
	       <CHANGE-LEXV .OTHER2 ,W?THEN>
	       <SETG P-LEN <ZGET ,OOPS-TABLE ,O-LENGTH>>
	       <SETG TLEXV <ZGET ,OOPS-TABLE ,O-START>>
	       <PRINT-LEXV>
	       <RETURN <PARSE-IT <>>>)
	      (T
	       <DONT-UNDERSTAND>
	       ;<RTRUE>)>)>>

<DEFINE NAKED-ADJECTIVE? (WD)
   <AND <WORD-TYPE? .WD ,P-ADJ-CODE>
	<NOT <WORD-TYPE? .WD ,P-DIR-CODE>>
	;<NOT <EQUAL? .WD ,W?S>>	;"possessive"
	<NOT <EQUAL? .WD ,W?ONE>>>>

<DEFINE CHANGE-AND-TO-THEN? (PTR)
   <AND <EQUAL? <ZGET .PTR 0> ,W?AND ,W?COMMA>
	<OR <WORD-TYPE? <ZGET <SET PTR <ZREST .PTR <* 2 ,P-LEXELEN>>> 0>
			,P-VERB-CODE ,P-DIR-CODE>
	    <WORD-TYPE? <ZGET .PTR 0> ,P-EOI-CODE>>>>

<DEFAULT-DEFINITION DONT-UNDERSTAND
<DEFINE DONT-UNDERSTAND ()
 <SETG CLOCK-WAIT T>
 <COND (<AND <EQUAL? 1 <GETB ,P-LEXV ,P-LEXWORDS>>
	     <WORD-TYPE? <ZGET ,P-LEXV ,P-LEXSTART> ,P-NOUN-CODE ,P-ADJ-CODE>>
	<MISSING "verb">
	<RETURN T>)>
 <IFN-P-BE-VERB
	<COND (<COUNT-ERRORS 1>
	       <RETURN T>)>>
 <TELL
"[Sorry, but I don't understand. Please say that another way, or try
something else.]" CR>>>>

<DEFINE MISSING (NV)
	<TELL "[I think there's a " .NV " missing in that sentence!]" CR>>

<DEFAULT-DEFINITION CANT-FIND-OBJECT
<DEFINE CANT-FIND-OBJECT (NP PART ;SEARCH "AUX" TMP)
 <COND (<ZERO? <NP-QUANT .NP>>	;<EQUAL? .NP ,ORPHAN-NP>
	<NP-CANT-SEE .NP>)
       (T
	<TELL "[There isn't anything to ">
	<COND (<SET TMP <PARSE-VERB ,PARSE-RESULT>>
	       <PRINT-VOCAB-WORD .TMP>
	       ;<SET TMP <PARSE-PARTICLE1 ,PARSE-RESULT>>
	       <COND (<NOT <EQUAL? .PART ;.TMP 0 1>>
		      <TELL C !\ >
		      <PRINT-VOCAB-WORD .TMP>)>)
	      (T <TELL "do that to">)>
	<TELL "!]" CR>)>>

<DEFINE NP-CANT-SEE ("OPT" (NP <GET-NP>) "AUX" TMP)
	<COND (<SET TMP <NP-NAME .NP>>
	       <TELL "[">
	       <TELL-CTHE ,WINNER>
	       <TELL " can't see ">
	       <COND (<OR <CAPITAL-NOUN? .TMP>
			  <AND <SET TMP <NP-ADJS .NP>>
			       <ADJS-POSS .TMP>>>
		      <NP-PRINT .NP T>)
		     (T
		      <TELL "any ">
		      <NP-PRINT .NP>)>
	       <TELL !\ >
	       <COND (<AND <SET TMP <NP-LOC .NP>>
			   <OR <AND ;<EQUAL? .NP ,ORPHAN-NP>
				    ;"removed for HIT MAN ON HEAD WITH ROCK"
				    <PMEM-TYPE? .TMP NOUN-PHRASE>
				    <TELL "in">>
			       <AND <PMEM-TYPE? .TMP LOCATION>
				    <SET TMP <LOCATION-OBJECT .TMP>>
				    <PRINT-VOCAB-WORD <LOCATION-PREP .TMP>>>>>
		      <TELL " ">
		      <TELL-THE <NOUN-PHRASE-OBJ1 .TMP>>)
		     (T
		      <COND ;(<ZAPPLY ,MOBY-FIND? .SEARCH>
			     <TELL "anyw">)
			    (T <TELL "right ">)>
		      <TELL "here">)>
	       <TELL ".]" CR>)
	      (T <MORE-SPECIFIC>)>>>

<DEFAULT-DEFINITION WHICH-LIST?
<DEFINE WHICH-LIST? (NP SR)
	<COND (<L=? <FIND-RES-COUNT .SR> <FIND-RES-SIZE .SR>>
	       T)>>>

<DEFAULT-DEFINITION WHICH-PRINT
<DEFINE WHICH-PRINT (NP "AUX" (SR ,ORPHAN-SR)
			   (LEN <FIND-RES-COUNT .SR>) (SZ <FIND-RES-SIZE .SR>))
	<COND (<NOT <==? ,WINNER ,PLAYER>>
	       <TELL "\"I don't understand ">
	       <COND (<WHICH-LIST? .NP .SR>
		      <TELL "if">)
		     (T
		      <TELL "which">
		      <COND (<T? .NP>
			     ;<SETG P-ONE-NOUN <NP-NAME .NP>>
			     <TELL !\ >
			     <NP-PRINT .NP>)>)>)
	      (T
	       <TELL "[Which">
	       <COND (<T? .NP>
		      ;<SETG P-ONE-NOUN <NP-NAME .NP>>
		      <TELL !\ >
		      <NP-PRINT .NP>)>
	       <TELL " do">)>
	<TELL " you mean">
	<COND (<WHICH-LIST? .NP .SR>
	       <COND (<==? ,WINNER ,PLAYER>
		      <TELL !\,>)>
	       <REPEAT ((REM .LEN) (VEC <REST-TO-SLOT .SR FIND-RES-OBJ1>))
		<TELL !\ >
		<TELL-THE <ZGET .VEC 0>>
		<COND (<==? .REM 2>
		       <COND (<NOT <==? .LEN 2>>
			      <TELL !\,>)>
		       <TELL " or">)
		      (<G? .REM 2>
		       <TELL !\,>)>
		<COND (<L? <SET REM <- .REM 1>> 1>
		       <RETURN>)
		      (<L? <SET SZ <- .SZ 1>> 1>
		       <COND (T ;<ZERO? <SET SR <FIND-RES-NEXT .SR>>>
			      <RETURN>)>
		       ;<SET SZ ,FIND-RES-MAXOBJ>
		       ;<SET VEC <REST-TO-SLOT .SR OBJLIST-NEXT>>)
		      (T <SET VEC <ZREST .VEC 2>>)>>)>
	<COND (<NOT <==? ,WINNER ,PLAYER>>
	       <TELL ".\"" CR>)
	      (T
	       <TELL "?]" CR>)>>>

<DEFINE NP-PRINT (NP:PMEM "OPT" (DO-QUANT <>) "AUX" LEN)
 <COND (<OBJECT? .NP>
	<TELL-THE .NP>)
       (<PMEM-TYPE? .NP NOUN-PHRASE>
	<COND (<SET LEN <NOUN-PHRASE-COUNT .NP>>
	       <DEC LEN>
	       <REPEAT (OBJ (CT 0))
		<COND (<SET OBJ <ZGET .NP <+ ,NOUN-PHRASE-HEADER-LEN
					     <* .CT 2>>>>
		       <TELL-THE .OBJ>)>
		<COND (<G? <SET CT <+ .CT 1>> .LEN>
		       <RETURN>)
		      (T <TELL ", ">)>>)>)
       (T
	<COND (<AND <T? .DO-QUANT>
		    <SET LEN <NP-QUANT .NP>>>	;"sounds bad after 'any'"
	       <PRINTB <GET-QUANTITY-WORD .LEN>>
	       <COND (<NP-NAME .NP>
		      <TELL !\ >)>)>
	<COND (<SET LEN <NP-ADJS .NP>>
	       <ADJS-PRINT .LEN>)>
	<COND (<AND <SET LEN <NP-LEXEND .NP>>
		    <OR <==? <ZGET .LEN 0> <NP-NAME .NP>>
			<AND <COMPARE-WORD-TYPES
			      <WORD-CLASSIFICATION-NUMBER <ZGET .LEN 0>>
			      <GET-CLASSIFICATION END-OF-INPUT>>
			     <L? ,P-LEXV
			       <SET LEN <ZBACK .LEN ,LEXV-ELEMENT-SIZE-BYTES>>>
			     <==? <ZGET .LEN 0> <NP-NAME .NP>>>>>
	       <BUFFER-PRINT .LEN <ZREST .LEN ,P-WORDLEN> <> T>)
	      (<SET LEN <NP-NAME .NP>>
	       <PRINT-VOCAB-WORD .LEN>)>
	<COND (<AND <SET LEN <NP-OF .NP>>
		    <PMEM? .LEN>
		    <PMEM-TYPE? .LEN NP>>
	       <TELL " of ">
	       <NP-PRINT .LEN>)>
	<COND (<AND <SET LEN <NP-EXCEPT .NP>>
		    <PMEM? .LEN>
		    <PMEM-TYPE? .LEN NP>>
	       <TELL " except ">
	       <NP-PRINT .LEN>)>)>>

<DEFINE ADJS-PRINT (ADJT "AUX" LEN)
 <COND (<SET LEN <ADJS-POSS .ADJT>>
	<COND (<EQUAL? .LEN ,PLAYER ,ME>
	       <TELL "your ">)
	      (T
	       <NP-PRINT ;TELL-THE .LEN>
	       <TELL "'s ">)>)>
 <COND (<SET LEN <ADJS-COUNT .ADJT>>
	<SET ADJT <REST-TO-SLOT .ADJT ADJS-COUNT 1>>
	<COND (<G? .LEN ,ADJS-MAX-COUNT>
	       <SET LEN ,ADJS-MAX-COUNT>)>
	<DEC LEN>
	<SET ADJT <ZREST .ADJT <* 2 .LEN>>>
	<REPEAT (WD (CT 0) TMP)
	 <SET WD <ZGET .ADJT 0>>
	 <COND (<EQUAL? .WD ,W?MY>
		<TELL "your ">)
	       (<EQUAL? .WD ,W?INT.NUM ,W?INT.TIM>
		<TELL N ,P-NUMBER>	;"good enough?"
		<TELL !\ >)
	       (<NOT <EQUAL? .WD ,W?NO.WORD>>
		<COND (<AND <CAPITAL-NOUN? .WD>
			    <SET TMP <GETB ,P-LEXV ,P-LEXWORDS>>
			    <SET TMP <INTBL? .WD
					     <REST-TO-SLOT ,P-LEXV LEXV-START>
					     .TMP *204*>>>
		       <CAPITALIZE .TMP>)
		      (T
		       <PRINT-VOCAB-WORD .WD>)>
		<TELL !\ >)>
	 <COND (<G? <SET CT <+ .CT 1>> .LEN>
		<RETURN>)
	       (T <SET ADJT <ZBACK .ADJT 2>>)>>)>>

<DEFAULT-DEFINITION TOO-MANY-NOUNS
<DEFINE TOO-MANY-NOUNS (WD)
	<TELL "[I can't understand that many nouns with ">
	<COND (<T? .WD>
	       <TELL !\">
	       <PRINT-VOCAB-WORD .WD>
	       <TELL !\">)
	      (T <TELL "that verb">)>
	<TELL ".]" CR>>>

<DEFINE INBUF-ADD (LEN:FIX BEG:FIX SLOT:FIX "AUX" DBEG:FIX TMP)
	 <SET TMP <ZGET ,OOPS-TABLE ,O-END>>
	 <COND (<T? .TMP>
		<SET DBEG .TMP>)
	       (T
		<SET TMP <* ,P-WORDLEN <ZGET ,OOPS-TABLE ,O-LENGTH>>>
		<SET DBEG <+ <GETB ,G-LEXV .TMP>
			     <GETB ,G-LEXV <+ .TMP 1>>>>)>
	 <COND (<L? ,INBUF-LENGTH <+ .DBEG <- .LEN 1>>>
		<RFALSE>)>
	 <ZPUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <COND (T ;<OR <CHECK-EXTENDED? XZIP>
		    <CHECK-EXTENDED? YZIP>>
		<COPYT <ZREST ,P-INBUF .BEG> <ZREST ,G-INBUF .DBEG> .LEN>)
	       ;(T
		<REPEAT ((CTR:FIX 0))
			<PUTB ,G-INBUF <+ .DBEG .CTR>
			      <GETB ,P-INBUF <+ .BEG .CTR>>>
			<SET CTR <+ .CTR 1>>
			<COND (<EQUAL? .CTR .LEN>
			       <RETURN>)>>)>
	 <PUTB ,G-LEXV .SLOT .DBEG>
	 <PUTB ,G-LEXV <- .SLOT 1> .LEN>
	 T>

<DEFINE INBUF-PRINT (WD INBUF LEXV SLOT:FIX
		     "AUX" DBEG:FIX (CTR:FIX 0) TMP (LEN:FIX 11))
	 <SET TMP <ZGET ,OOPS-TABLE ,O-END>>
	 <COND (<T? .TMP>
		<SET DBEG .TMP>)
	       (T
		<SET TMP <* ,P-WORDLEN <ZGET ,OOPS-TABLE ,O-LENGTH>>>
		<SET DBEG <+ <GETB .LEXV .TMP>
			     <GETB .LEXV <+ .TMP 1>>>>)>
	 <COND (<L? <GETB .INBUF 0> <+ .DBEG <- .LEN 1>>>
		<RFALSE>)>
	 <COND ;(<NOT <CHECK-EXTENDED?>> <RFALSE>)
	       (T
		<DIROUT ,D-TABLE-ON <ZREST .INBUF .DBEG>>
		<PRINT-VOCAB-WORD .WD>
		<DIROUT ,D-TABLE-OFF>
		<SET LEN <GETB .INBUF <+ 1 .DBEG>>>)>
	 <SET DBEG <+ 2 .DBEG>>
	 <ZPUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <PUTB .LEXV .SLOT .DBEG>
	 <PUTB .LEXV <- .SLOT 1> .LEN>
	 T>

<DEFAULT-DEFINITION YES?

<CONSTANT YES-INBUF <ITABLE 19 (BYTE LENGTH) 0>>
<CONSTANT YES-LEXV  <ITABLE 3 (LEXV) 0 0>>

<DEFINE YES? ("OPT" (NO-Q <>) "AUX" WORD VAL)
	<COND (<NOT .NO-Q>
	       <TELL !\?>)>
	<REPEAT ()
		<TELL "|>">
		<COND (T ;<OR <CHECK-EXTENDED? XZIP>
			   <CHECK-EXTENDED? YZIP>>
		       <PUTB ,YES-INBUF 1 0>)>
		<ZREAD ,YES-INBUF ,YES-LEXV>
		<COND (<AND <NOT <0? <GETB ,YES-LEXV ,P-LEXWORDS>>>
			    <SET WORD <ZGET ,YES-LEXV ,P-LEXSTART>>>
		       <COND (<COMPARE-WORD-TYPES
			       <WORD-CLASSIFICATION-NUMBER .WORD>
			       <GET-CLASSIFICATION VERB>>
			      <SET VAL <WORD-VERB-STUFF .WORD>>)
			     (T <SET VAL <>>)>
		       <COND (<EQUAL? .VAL ,ACT?YES>
			      <SET VAL T>
			      <RETURN>)
			     (<OR <EQUAL? .VAL ,ACT?NO>
				  <EQUAL? .WORD ,W?N>>
			      <SET VAL <>>
			      <RETURN>)
			     (<EQUAL? .VAL ,ACT?RESTART>
			      <V-RESTART>)
			     (<EQUAL? .VAL ,ACT?RESTORE>
			      <V-RESTORE>)
			     (<EQUAL? .VAL ,ACT?QUIT>
			      <V-QUIT>)>)>
		<TELL "[Please type YES or NO.]">>
	.VAL>>

<DEFAULT-DEFINITION SETUP-ORPHAN
<DEFINE SETUP-ORPHAN (STR "OPT" (A <>) (B <>))
	<DIROUT ,D-TABLE-ON ,O-INBUF>
	<TELL .STR>
	<COND (<T? .A>
	       <COND (<OBJECT? .A>
		      <TELL D .A>)
		     (T <TELL .A>)>
	       <COND (<T? .B>
		      <COND (<OBJECT? .B>
			     <TELL D .B>)
			    (T <TELL .B>)>)>)>
	;<PRINTC 0>	;"Some ZIPs might need this."
	<DIROUT ,D-TABLE-OFF>
	<PUTB ,O-INBUF 0 ,INBUF-LENGTH>
	<LEX ,O-INBUF ,O-LEXV>
	<COND (<ZERO? <SET A <GETB ,O-LEXV ,P-LEXWORDS>>>	;"any words?"
	       <>)
	      (<INTBL? 0 <ZREST ,O-LEXV <* 2 ,P-LEXSTART>> .A *204*>
							;"any unknown words?"
	       <>)
	      (T
	       <SETG P-OFLAG <+ 1 <* ,P-LEXELEN <GETB ,O-LEXV ,P-LEXWORDS>>>>
	       <MAKE-ROOM-FOR-TOKENS 1 ,O-LEXV ,P-OFLAG>
	       <ZPUT ,O-LEXV ,P-OFLAG ,W?NO.WORD ;0>
	       <SETG P-OFLAG <- 0 ,P-OFLAG>>	;"for verbose response"
	       <ZPUT ,OOPS-TABLE ,O-AGAIN ;,O-START
				 <ZREST ,P-LEXV <* 2 ,P-LEXSTART>>>
	       T)>>>

<DEFAULT-DEFINITION SETUP-ORPHAN-NP

;"<SYNTAX SWG = V-SWG>
<DEFINE V-SWG ()
 <COND (<SETUP-ORPHAN-NP 'take frob' ,RED-FROB ,GREEN-FROB>
	<TELL 'Which frob do you want?' CR>)
       (T <TELL 'Nope.' CR>)>>"

<DEFINE SETUP-ORPHAN-NP (STR OBJ1 OBJ2 "OPT" (OBJ3 <>) "AUX" (NUM 2)
			 (VEC <REST-TO-SLOT ,ORPHAN-SR FIND-RES-OBJ1>))
	<DIROUT ,D-TABLE-ON ,O-INBUF>
	<TELL .STR>
	;<PRINTC 0>	;"Some ZIPs might need this."
	<DIROUT ,D-TABLE-OFF>
	<PUTB ,O-INBUF 0 ,INBUF-LENGTH>
	<LEX ,O-INBUF ,O-LEXV>
	<COND (<INTBL? 0 <ZREST ,O-LEXV <* 2 ,P-LEXSTART>>
			 <GETB ,O-LEXV ,P-LEXWORDS>
			 *204*>		;"any unknown words?"
	       <>)
	      (T
	       <SETG P-OFLAG <- 1 <* ,P-LEXELEN <GETB ,O-LEXV ,P-LEXWORDS>>>>
	       <ZPUT ,OOPS-TABLE ,O-START <ZREST ,P-LEXV <* 2 ,P-LEXSTART>>>
	       <ZPUT .VEC 0 .OBJ1>
	       <ZPUT .VEC 1 .OBJ2>
	       <COND (<T? .OBJ3>
		      <INC NUM>
		      <ZPUT .VEC 2 .OBJ3>)>
	       <FIND-RES-COUNT ,ORPHAN-SR .NUM>
	       T)>>>

<DEFINE INSERT-ADJS (E "AUX" CT (PTR <ABS ,P-OFLAG>))
 <COND (<NOT <EQUAL? .E <> T>>
	<COND (<SET CT <ADJS-POSS .E>>
	       <COND (<PMEM? .CT>
		      <SET CT <NP-NAME .CT>>)
		     (T
		      <SET CT <ZGET <GETPT .CT ,P?SYNONYM> 0>>)>
	       <IFFLAG (P-APOSTROPHE-BREAKS-WORDS
			<SET PTR <INSERT-ADJS-WD .PTR .CT>>
			<SET PTR <INSERT-ADJS-WD .PTR ,W?APOSTROPHE>>
			<SET PTR <INSERT-ADJS-WD .PTR ,W?S>>)
		       (T	;"Find next word in vocabulary."
			<SET CT <+ .CT <GETB <ZREST ,VOCAB
						    <+ 1 <GETB ,VOCAB 0>>>
					     0>>>
			<COND (T ;<BAND ,POSSESSIVE <WORD-FLAGS .CT>>
			       <SET PTR <INSERT-ADJS-WD .PTR .CT>>)>)>)>
	<COND (<SET CT <ADJS-COUNT .E>>
	       <SET E <REST-TO-SLOT .E ADJS-COUNT 1>>
	       <REPEAT (WD)
		       <COND (<DLESS? CT 0>
			      <RETURN>)
			     (<EQUAL? <SET WD <ZGET .E .CT>>
				      <ZGET ,ERROR-ARGS 3>>	;"e.g. OPEN"
			      <AGAIN>)>
		       <SET PTR <INSERT-ADJS-WD .PTR .WD>>>)>)>>

<DEFINE INSERT-ADJS-WD (PTR WD)
	<MAKE-ROOM-FOR-TOKENS 1 ,G-LEXV .PTR>
	<ZPUT ,G-LEXV .PTR .WD>
	<SET PTR <+ .PTR ,P-LEXELEN>>
	<INBUF-PRINT .WD ,G-INBUF ,G-LEXV <- <* 2 .PTR> 1>>
	.PTR>

<DEFAULT-DEFINITION PARSER-REPORT
<DEFINE PARSER-REPORT ()
 <PRINTI "[Parser used: ">
 <PRINTN <* 2 <- ,PMEM-STORE-LENGTH ,PMEM-STORE-WARN>>>
 <PARSER-REPORT-STACK ,STATE-STACK>
 <PARSER-REPORT-STACK ,DATA-STACK>
 <PRINTC !\+>
 <REPEAT ((PTR <ZREST ,SPLIT-STACK 2>) (N <- ,MAX-PSTACK-SIZE 1>))
	<COND (<SET PTR <INTBL? 0 .PTR .N>>
	       <COND (<AND <0? <ZGET .PTR 1>>
			   <0? <ZGET .PTR 2>>>
		      <PRINTN <- .PTR <ZREST ,SPLIT-STACK 2>>>
		      <RETURN>)
		     (T
		      <SET PTR <ZREST .PTR 2>>
		      <SET N <+ -1 <- ,MAX-PSTACK-SIZE
				      </ <- .PTR ,SPLIT-STACK> 2>>>>)>)
	      (T
	       <PRINTN <* 2 <- ,MAX-PSTACK-SIZE 1>>>
	       <RETURN>)>>
 <PRINTI " bytes.]">
 <CRLF>>

<DEFINE PARSER-REPORT-STACK (STK "AUX" N)
 <PRINTC !\+>
 <SET N ,MAX-PSTACK-SIZE>
 <REPEAT ()
	<COND (<OR <DLESS? N 1>
		   <0? <ZGET .STK .N>>>
	       <PRINTN <* 2 <- <- ,MAX-PSTACK-SIZE .N> 1>>>
	       <RTRUE>)>>>>

<END-SEGMENT>
<ENDPACKAGE>
