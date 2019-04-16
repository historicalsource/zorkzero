"CLUES for LIBRARY
(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

"To install:
Add <XFLOAD <ZILLIB>CLUES> to your GAME.ZIL file.
Modify ROUTINE FINISH in VERBS to include Hint.
Add HINT syntaxes (be careful -- you might already have some variety).
Add verb routines for V-HINT and V-HINTS-OFF.
Add HINT to list of verbs in CLOCKER-VERB (a.k.a. GAME-VERB?).
Make sure flag in V-HINTS-OFF syntax is correct (RLANDBIT, KLUDGEBIT, etc.)."

<FILE-FLAGS CLEAN-STACK? MDL-ZIL? ;ZAP-TO-SOURCE-DIRECTORY?>

<DEFAULTS-DEFINED
	FIRST-HINT-POS
	INIT-HINT-SCREEN>

<BEGIN-SEGMENT HINTS>

<CONSTANT RETURN-SEE-HINT	"Hit Return to see hints.">
<CONSTANT RETURN-SEE-NEW-HINT	"Hit Return to see a hint.">
<CONSTANT INVISICLUES		"InvisiClues (tm)">
<CONSTANT M-MAIN-HINT-MENU	"Hit M to see main menu.">
<CONSTANT M-SEE-HINT-MENU	"Hit M to see hint menu.">
<CONSTANT PREVIOUS-HINT		"Hit P for previous item.">
<CONSTANT NEXT-HINT		"Hit N for next item.">
<CONSTANT Q-RESUME-STORY	"Hit Q to resume story.">
<CONSTANT H-OR-USE-MOUSE	"(Or use your mouse.)">
<CONSTANT NO-MORE-HINTS		"[No more hints.]">

"If the first argument is non-false, build a parallel impure table
   for storing the count of answers already seen; make it a constant
   under the given name."

<DEFINE20 CONSTRUCT-HINTS (COUNT-NAME "TUPLE" STUFF "AUX" (SS <>)
			   (HL (T)) (HLL .HL) V
			   (CL (T)) (CLL .CL)
			   TCL TCLL)
   <REPEAT ((CT 0))
     <COND (<OR <EMPTY? .STUFF>
		<TYPE? <1 .STUFF> STRING>>
	    ;"Chapter break"
	    <COND
	     (<NOT .SS>
	      ;"First one, just do setup"
	      <SET SS .STUFF>
	      <SET TCL (T)>
	      <SET TCLL .TCL>
	      <SET CT 0>)
	     (T
	      <SET V <SUBSTRUC .SS 0 <- <LENGTH .SS> <LENGTH .STUFF>>>>
	      ;"One chapter's worth"
	      <COND (<L? 17 <LENGTH .V>>
		     <WARN!-ZILCH!-PACKAGE!- "Too many answers for: " <1 .V>>)>
	      <SET HLL <REST <PUTREST .HLL (<EVAL <FORM PLTABLE !.V>>)>>>
	      <COND (.COUNT-NAME
		     <SET CLL <REST <PUTREST .CLL
					     (<EVAL <FORM TABLE (BYTE)
							  !<REST .TCL>>>)>>>
		     <SET TCL (T)>
		     <SET TCLL .TCL>
		     <SET CT 0>)>
	      <SET SS .STUFF>)>
	    <COND (<EMPTY? .STUFF> <RETURN>)>
	    <SET STUFF <REST .STUFF>>)
	   (T
	    <COND (.COUNT-NAME
		   <COND (<1? <MOD <SET CT <+ .CT 1>> 2>>
			  <SET TCLL <REST <PUTREST .TCLL
						   (0)>>>)>)>
	    <SET STUFF <REST .STUFF>>)>>
   <COND (.COUNT-NAME
	  <EVAL <FORM CONSTANT .COUNT-NAME
		      <EVAL <FORM PTABLE !<REST .CL>>>>>)>
   <EVAL <FORM PLTABLE !<REST .HL>>>>

"Longest hint topic and longest question can be one line, unless it shares
a line with another such in the other column. Each question can have up to
16 answers but no more."

;<CONSTANT HINTS
  <CONSTRUCT-HINTS HINT-COUNTS ;"Put topics in Quotes - followed by PLTABLEs
				 of Questions and Answers in quotes"
	;"17 character wide"
	;"this set of quotes is 36 chars. wide"
	"Topic/Chapter"
	<PLTABLE "Question"
		 "Hint 1"
		 "Hint 2">>>

<GLOBAL H-QUEST-NUM 1>	"shows in HINTS LTABLE which question it's on"

<GLOBAL H-CHAPT-NUM 1>	"shows in HINTS LTABLE which chapter it's on"

<DEFAULT-DEFINITION FIRST-HINT-POS
<CONSTANT FIRST-HINT-LINE 5>
<CONSTANT FIRST-HINT-COLUMN 4>>

<GLOBAL BOTTOM-HINT-NUM:NUMBER 0>
<GLOBAL TOP-HINT-LINE:NUMBER 0>
<GLOBAL LEFT-HINT-COLUMN:NUMBER 0>

<GLOBAL GET-HINT-ROUTINE 0>	"APPLY this to get pointer to text"

<DEFINE DO-HINTS ("AUX" Q WIN FCLR WCLR)
  <IF-SOUND <SETG SOUND-QUEUED? <>>
	    <KILL-SOUNDS>>
  <HLIGHT ,H-NORMAL>
  <SET WIN <INIT-HINT-SCREEN>>
  ;<WINATTR -3 ,A-SCRIPT ,O-CLEAR>
  <SET Q <SHIFT <WINGET -3 ,WFSIZE> -8>>	;"height"
  <SETG TOP-HINT-LINE		<+ 1 </ <- <WINGET -3 ,WTOP> 1> .Q>>>
  <SETG BOTTOM-HINT-NUM <- </ <WINGET -3 ,WHIGH> .Q> 1>>
  <SET Q <BAND <WINGET -3 ,WFSIZE> *377*>>
  <SETG LEFT-HINT-COLUMN	<+ 2 </ <- <WINGET -3 ,WLEFT> 1> .Q>>>
 <PROG ()
  <CLEAR ,S-TEXT>
  <SCREEN .WIN>
  <SET WCLR <WINGET .WIN ,WCOLOR>>
  <COND (<BAND 1 <LOWCORE ZVERSION>>	;"colors visible?"
	 <CCURSET 2 9>	;<CURSET 1 1>
	 <COLOR 1 -1>)
	(T
	 <COLOR 1 1>)>
  <HINT-TITLE ,INVISICLUES .WIN>
  <SCREEN ,S-FULL>
  <SET FCLR <WINGET ,S-FULL ,WCOLOR>>
  <COLOR <BAND <WINGET ,S-TEXT ,WCOLOR> *377*>;"Match colors with text screen."
	 <SHIFT <WINGET ,S-TEXT ,WCOLOR> -8>>
  <DIROUT ,D-TABLE-ON ,SLINE ;-80>
  <DIROUT ,D-TABLE-OFF>		;"flush TWID"
  <SETG GET-HINT-ROUTINE ,H-CHAPT-NAME>
  <H-PUT-UP-FROBS <GET ,HINTS 0>>
  <H-NEW-CURSOR ,H-CHAPT-NUM>
  <REPEAT (CHR TMP (MAXC <GET ,HINTS 0>))
	  <COND (,DEMO-VERSION?
		 <SET CHR <INPUT-DEMO 1>>)
		(T
		 <SET CHR <INPUT 1>>)>
	  <COND (<EQUAL? .CHR ,CLICK1 ,CLICK2>
		 <SET TMP <SELECT-HINT-BY-MOUSE>>
		 <COND (<L=? .TMP 0>
			<COND (<EQUAL? .TMP -1>
			       <SET CHR !\N>)
			      (<EQUAL? .TMP -2>
			       <SET CHR !\P>)
			      (<EQUAL? .TMP -3>
			       <SET CHR 13>)
			      (<EQUAL? .TMP -4>
			       <SET CHR !\Q>)
			      (T
			       <SOUND ,S-BEEP>
			       <AGAIN>)>)>)
		;(T
		 <CCURSET ,BOTTOM-HINT-NUM 1>
		 <TELL "[CHR=" N .CHR "]">)>
	  <COND (<EQUAL? .CHR !\M !\m !\Q !\q ;,ESCAPE-KEY>
		 <SET Q T>
		 <RETURN>)
		(<EQUAL? .CHR !\N !\n ,DOWN-ARROW>
		 <H-NEW-CURSOR ,H-CHAPT-NUM T>
		 <COND (<EQUAL? ,H-CHAPT-NUM .MAXC>
			<SETG H-CHAPT-NUM 1>)
		       (T
			<SETG H-CHAPT-NUM <+ ,H-CHAPT-NUM 1>>)>
		 <SETG H-QUEST-NUM 1>
		 <H-NEW-CURSOR ,H-CHAPT-NUM>)
		(<EQUAL? .CHR !\P !\p ,UP-ARROW>
		 <H-NEW-CURSOR ,H-CHAPT-NUM T>
		 <COND (<EQUAL? ,H-CHAPT-NUM 1>
			<SETG H-CHAPT-NUM .MAXC>)
		       (T
			<SETG H-CHAPT-NUM <- ,H-CHAPT-NUM 1>>)>
		 <SETG H-QUEST-NUM 1>
		 <H-NEW-CURSOR ,H-CHAPT-NUM>)
		(<EQUAL? .CHR 13 10 32>
		 <SET Q <H-PICK-QUESTION>>
		 <RETURN>)
		(<EQUAL? .CHR ,CLICK1 ,CLICK2>
		 <COND (<G? .TMP .MAXC>
			<SOUND ,S-BEEP>)
		       ;(<EQUAL? ,H-CHAPT-NUM .TMP>
			<SET Q <H-PICK-QUESTION>>
			<RETURN>)	;"not like Mac"
		       (T
			<H-NEW-CURSOR ,H-CHAPT-NUM T>
			<SETG H-CHAPT-NUM .TMP>
			<SETG H-QUEST-NUM 1>
			<H-NEW-CURSOR ,H-CHAPT-NUM>
			<COND (<EQUAL? .CHR ,CLICK2>
			       <SET Q <H-PICK-QUESTION>>
			       <RETURN>)>)>)
		(T
		 <SOUND ,S-BEEP>)>>
  <COND (<NOT .Q>
	 <AGAIN>)>>
  <CLEAR -1>
  <SCREEN .WIN>
  <COLOR <BAND .WCLR 255> <SHIFT .WCLR -8>>
  <SCREEN ,S-FULL>
  <COLOR <BAND .FCLR 255> <SHIFT .FCLR -8>>
  <SCREEN ,S-TEXT>
  <HLIGHT ,H-NORMAL>
  ;<WINATTR -3 ,A-SCRIPT ,O-SET>
  <INIT-STATUS-LINE>
  <TELL "Back to the story..." CR>
  <IF-SOUND <COND (,SOUND-ON?
		   <CHECK-LOOPING>)>>
  <RFATAL>>

<DEFINE H-PICK-QUESTION ("AUX" CHR MAXQ (Q <>) ;WIN WID)
  <SETG PARSE-SENTENCE-ACTIVATION <CATCH>>	;"for Q command"
  <HLIGHT ,H-NORMAL>
  <CLEAR ,S-TEXT>
  ;<SET WIN <INIT-HINT-SCREEN>>
  <HINT-TITLE <GET <GET ,HINTS ,H-CHAPT-NUM> 1> ,S-WINDOW ;.WIN>
  <SET WID <CENTER-LINE ,M-MAIN-HINT-MENU 2 ;,H-INVERSE>>
  <SET MAXQ <- <GET <GET ,HINTS ,H-CHAPT-NUM> 0> 1>>
  <SCREEN ,S-FULL>
  <SETG GET-HINT-ROUTINE ,H-GET-QUEST>
  <H-PUT-UP-FROBS <- <GET <GET ,HINTS ,H-CHAPT-NUM> 0> 1>>
  <H-NEW-CURSOR ,H-QUEST-NUM>
  <REPEAT (TMP)
	  <COND (,DEMO-VERSION?
		 <SET CHR <INPUT-DEMO 1>>)
		(T
		 <SET CHR <INPUT 1>>)>
	  <COND (<EQUAL? .CHR ,CLICK1 ,CLICK2>
		 <SET TMP <SELECT-HINT-BY-MOUSE .WID>>
		 <COND (<L=? .TMP 0>
			<COND (<EQUAL? .TMP -1>
			       <SET CHR !\N>)
			      (<EQUAL? .TMP -2>
			       <SET CHR !\P>)
			      (<EQUAL? .TMP -3>
			       <SET CHR 13>)
			      (<EQUAL? .TMP -4>
			       <SET CHR !\Q>)
			      (<EQUAL? .TMP -5>
			       <SET CHR !\M>)
			      (T
			       <SOUND ,S-BEEP>
			       <AGAIN>)>)>)
		;(T
		 <CCURSET ,BOTTOM-HINT-NUM 1>
		 <TELL "[CHR=" N .CHR "]">)>
	  <COND (<EQUAL? .CHR !\Q !\q ;,ESCAPE-KEY>
		 <RTRUE>)
		(<EQUAL? .CHR !\M !\m>
		 <SET Q T>
		 <RETURN>)
		(<EQUAL? .CHR !\N !\n ,DOWN-ARROW>
		 <H-NEW-CURSOR ,H-QUEST-NUM T>
		 <COND (<EQUAL? ,H-QUEST-NUM .MAXQ>
			<SETG H-QUEST-NUM 1>)
		       (T
			<SETG H-QUEST-NUM <+ ,H-QUEST-NUM 1>>)>
		 <H-NEW-CURSOR ,H-QUEST-NUM>)
		(<EQUAL? .CHR !\P !\p ,UP-ARROW>
		 <H-NEW-CURSOR ,H-QUEST-NUM T>
		 <COND (<EQUAL? ,H-QUEST-NUM 1>
			<SETG H-QUEST-NUM .MAXQ>)
		       (T
			<SETG H-QUEST-NUM <- ,H-QUEST-NUM 1>>)>
		 <H-NEW-CURSOR ,H-QUEST-NUM>)
		(<EQUAL? .CHR ,CLICK1 ,CLICK2>
		 <COND (<G? .TMP .MAXQ>
			<SOUND ,S-BEEP>)
		       ;(<EQUAL? ,H-QUEST-NUM .TMP>
			<DISPLAY-HINT>
			<RETURN>)		;"not like Mac"
		       (T
			<H-NEW-CURSOR ,H-QUEST-NUM T>
			<SETG H-QUEST-NUM .TMP>
			<H-NEW-CURSOR ,H-QUEST-NUM>
			<COND (<EQUAL? .CHR ,CLICK2>
			       <DISPLAY-HINT>
			       <RETURN>)>)>)
		(<EQUAL? .CHR 13 10 32>
		 <DISPLAY-HINT>
		 <RETURN>)
		(T
		 <SOUND ,S-BEEP>)>>
  <COND (<NOT .Q>
	 <AGAIN>)>>

<DEFINE H-NEW-CURSOR (POS "OPT" (OFF? <>) "AUX" Y X)
	<SET Y <+ ,TOP-HINT-LINE .POS>>
	<SET X ,LEFT-HINT-COLUMN>
	<COND (<G? .POS ,BOTTOM-HINT-NUM>
	       <SET Y <- .Y ,BOTTOM-HINT-NUM>>
	       <SET X </ <LOWCORE SCRH> ;<WINGET -3 ,WWIDE> 2>>)>
	<CCURSET .Y .X>
	<COND (<NOT .OFF?>
	       <HLIGHT ,H-INVERSE>)
	      (T
	       <HLIGHT ,H-NORMAL>)>
	<TELL <ZAPPLY ,GET-HINT-ROUTINE .POS> !\ >
	<COND (<NOT .OFF?>
	       <HLIGHT ,H-NORMAL>)>>

<DEFINE SELECT-HINT-BY-MOUSE ("OPT" (WID 0) "AUX" VAL MID X Y)
	<SET VAL <SHIFT <WINGET -3 ,WFSIZE> -8>>
	<SET Y <LOWCORE MSLOCY>>
	<SET X <LOWCORE MSLOCX>>
	;<CCURSET ,BOTTOM-HINT-NUM 1>
	;<TELL "[">
	<SET VAL </ <- .Y 1> .VAL>>
	<SET MID </ <* <LOWCORE SCRH> <BAND <WINGET -3 ,WFSIZE> *377*>>
		    ;<WINGET -3 ,WWIDE>
		    2>>
	;<TELL "LN=" N .VAL " FHL=" N ,TOP-HINT-LINE " X=" N .X " MID=" N .MID " TWID=" N .WID>
	<COND (<L? .VAL <- ,TOP-HINT-LINE 1>>
	       <COND (<EQUAL? .VAL 1>
		      <COND (<AND <SET VAL </ .WID 2>>
				  <G? .X <- .MID .VAL>>
				  <L? .X <+ .MID .VAL>>>
			     ;<TELL " VAL=-5">
			     <RETURN -5>)
			    (<L=? .X .MID>
			     ;<TELL " VAL=-1">
			     <RETURN -1>)
			    (T
			     ;<TELL " VAL=-3">
			     <RETURN -3>)>)
		     (<EQUAL? .VAL 2>
		      <COND (<L=? .X .MID>
			     ;<TELL " VAL=-2">
			     <RETURN -2>)
			    (T
			     ;<TELL " VAL=-4">
			     <RETURN -4>)>)
		     (T
		      <COND (T
			     ;<TELL " VAL=0">
			     <RETURN 0>)>)>)
	      (T
	       <SET VAL <- <+ 1 .VAL> ,TOP-HINT-LINE>>
	       ;<TELL " VAL=" N .VAL>
	       <COND (<G? .X .MID>
		      <SET VAL <+ .VAL ,BOTTOM-HINT-NUM>>
		      ;<TELL " -> " N .VAL>)>
	       ;<TELL "]|">
	       .VAL)>>

<DEFINE INVERSE-LINE ("OPT" (LN 0) (INV ,H-INVERSE))
	<COND (<T? .LN>
	       <CCURSET .LN 1>)>
	<HLIGHT .INV>
	<COND (<EQUAL? .INV ,H-NORMAL>
	       <ERASE 1>)
	      (T
	       <FONT 4>
	       <SET LN <LOWCORE (FWRD 1)>>
	       <PRINT-SPACES </ <+ .LN <WINGET -3 ,WWIDE>> .LN>>
	       <FONT 1>
	       <HLIGHT ,H-NORMAL>)>>

<DEFINE DISPLAY-HINT ("AUX" H MX (CNT 2) CV SHIFT? COUNT-OFFS ;WIN WID)
  <HLIGHT ,H-NORMAL>
  <CLEAR ,S-TEXT>
  ;<SET WIN <INIT-HINT-SCREEN>>
  <SCREEN ,S-WINDOW ;.WIN>
  <INVERSE-LINE 3 ,H-NORMAL>
  <RIGHT-LINE ,Q-RESUME-STORY 3 ;,H-INVERSE>
  <INVERSE-LINE 2 ,H-NORMAL>
  <RIGHT-LINE ,RETURN-SEE-NEW-HINT 2 ;,H-INVERSE>
  <COND (<NOT <EQUAL? <BAND <LOWCORE FLAGS> 32> 0>>
	 <CENTER-LINE ,H-OR-USE-MOUSE 3 ;,H-INVERSE>)>
  <INVERSE-LINE 1 ,H-NORMAL>
  <HLIGHT ,H-BOLD>
  <SET H <GET <GET ,HINTS ,H-CHAPT-NUM> <+ ,H-QUEST-NUM 1>>>
  ;"Byte table to use for showing questions already seen.
    Actually a nibble table.  The high four bits of each byte are for
    H-QUEST-NUM odd; the low four bits are for H-QUEST-NUM even.  See SHIFT?
    and COUNT-OFFS."
  <SET CV <GET ,HINT-COUNTS <- ,H-CHAPT-NUM 1>>>
  <CENTER-LINE <GET .H 1> 1 ,H-INVERSE>
  <HLIGHT ,H-NORMAL>
  <SET WID <CENTER-LINE ,M-SEE-HINT-MENU 2 ;,H-INVERSE>>
  <SET MX <GET .H 0>>
  <SCREEN ,S-TEXT>
  <CURSET 1 1>
  ;<WINATTR -3 ,A-SCRIPT ,O-SET>
  ;<PRINT <GET .H 1>>
  ;<CRLF>
  <SET SHIFT? <MOD ,H-QUEST-NUM 2>>
  <SET COUNT-OFFS </ <- ,H-QUEST-NUM 1> 2>>
  <REPEAT ((CURCX <GETB .CV .COUNT-OFFS>)
	   (CURC <+ 2 <ANDB <COND (.SHIFT? <LSH .CURCX -4>)
				  (T .CURCX)> *17*>>))
    <COND (<==? .CNT .CURC>
	   <RETURN>)
	  (T
	   <TELL C 9 <GET .H .CNT> CR>
	   <SET CNT <+ .CNT 1>>)>>
  <REPEAT (CHR ;N TMP (FLG T))
     <COND (.FLG
	    <SET FLG <>>
	    <COND (<G? .CNT .MX>
		   <PRINT ,NO-MORE-HINTS>
		   <CRLF>
		   <SCREEN ,S-WINDOW ;.WIN>
		   <INVERSE-LINE 2 ,H-NORMAL>
		   <CENTER-LINE ,M-SEE-HINT-MENU 2 ;,H-INVERSE>
		   <SCREEN ,S-TEXT>)
		  (T
		   <TELL ;"[" N <+ <- .MX .CNT> 1> ;" hint">
		   ;<COND (<NOT <EQUAL? .N 1>>
			  <TELL "s">)>
		   <TELL ;" left.] -" "> ">)>)>
     <COND (,DEMO-VERSION?
	    <SET CHR <INPUT-DEMO 1>>)
	   (T
	    <SET CHR <INPUT 1>>)>
     <COND (<EQUAL? .CHR ,CLICK1 ,CLICK2>
		 <SET TMP <SELECT-HINT-BY-MOUSE .WID>>
		 <COND (<L=? .TMP 0>
			<COND (<EQUAL? .TMP -3>
			       <SET CHR 13>)
			      (<EQUAL? .TMP -4>
			       <SET CHR !\Q>)
			      (<EQUAL? .TMP -5>
			       <SET CHR !\M>)
			      (T
			       <SOUND ,S-BEEP>
			       <AGAIN>)>)>)
		;(T
		 <CCURSET ,BOTTOM-HINT-NUM 1>
		 <TELL "[CHR=" N .CHR "]">)>
     <COND (<EQUAL? .CHR !\M !\m !\Q !\q ;,ESCAPE-KEY>
	    <COND (.SHIFT?
		   <PUTB .CV .COUNT-OFFS
			 <ORB <ANDB <GETB .CV .COUNT-OFFS> *17*>
			      <LSH <- .CNT 2> 4>>>)
		  (T
		   <PUTB .CV .COUNT-OFFS
			 <ORB <ANDB <GETB .CV .COUNT-OFFS> *360*>
			      <- .CNT 2>>>)>
	    <COND (<EQUAL? .CHR !\Q !\q ;,ESCAPE-KEY>
		   <THROW T ,PARSE-SENTENCE-ACTIVATION>)
		  (T
		   ;<WINATTR -3 ,A-SCRIPT ,O-CLEAR>
		   <RETURN>)>)
	   (<EQUAL? .CHR 13 10 ;"32 ,CLICK1 ,CLICK2">
	    <COND (<L=? .CNT .MX>
		   <SET FLG T>	;"CNT starts as 2"
		   <TELL <GET .H .CNT> CR>
		   ;"3rd = line 7, 4th = line 9, etc."
		   <COND (<G? <SET CNT <+ .CNT 1>> .MX>
			  <SET FLG <>>
			  <PRINT ,NO-MORE-HINTS>
			  <CRLF>
			  <SCREEN ,S-WINDOW ;.WIN>
			  <INVERSE-LINE 2 ,H-NORMAL>
			  <CENTER-LINE ,M-SEE-HINT-MENU 2 ;,H-INVERSE>
			  <SCREEN ,S-TEXT>)>)
		  (T
		   <SOUND ,S-BEEP>)>)
	   (T
	    <SOUND ,S-BEEP>)>>>

<DEFINE H-CHAPT-NAME (N)
	<GET <GET ,HINTS .N> 1>>

<DEFINE H-GET-QUEST (N)
	<GET <GET <GET ,HINTS ,H-CHAPT-NUM> <+ .N 1>> 1>>

<DEFINE H-PUT-UP-FROBS (MX)
  <HLIGHT ,H-NORMAL>
  <REPEAT ((ST 0) (X ,LEFT-HINT-COLUMN) (Y ,TOP-HINT-LINE))
	<COND (<G? <SET ST <+ .ST 1>> .MX>
	       <RETURN>)>
	<SET Y <+ 1 .Y>>
	<CCURSET .Y .X>
	<TELL <ZAPPLY ,GET-HINT-ROUTINE .ST>>
	<COND (<EQUAL? .ST ,BOTTOM-HINT-NUM>
	       <SET Y ,TOP-HINT-LINE>
	       <SET X </ <LOWCORE SCRH> ;<WINGET -3 ,WWIDE> 2>>)>>>

<DEFAULT-DEFINITION INIT-HINT-SCREEN
<DEFINE INIT-HINT-SCREEN ()
  <CLEAR -1>
  <CSPLIT 4>
  <SCREEN ,S-TEXT>
  ,S-WINDOW>>

<DEFINE HINT-TITLE (TITLE WIN "OPTIONAL" (THIRD T))
  <SCREEN .WIN>
  <INVERSE-LINE 1 ,H-NORMAL>
  <INVERSE-LINE 2 ,H-NORMAL>
  <INVERSE-LINE 3 ,H-NORMAL>
  <HLIGHT ,H-BOLD>
  <CENTER-LINE .TITLE 1 ,H-INVERSE>
  <HLIGHT ,H-NORMAL>
  <LEFT-LINE 2 ,NEXT-HINT ;,H-INVERSE>
  <COND (<NOT <EQUAL? <BAND <LOWCORE FLAGS> 32> 0>>
	 <CENTER-LINE ,H-OR-USE-MOUSE 3 ;,H-INVERSE>)>
  <LEFT-LINE 3 ,PREVIOUS-HINT ;,H-INVERSE>
  <COND (.THIRD
	 <RIGHT-LINE ,RETURN-SEE-HINT 2 ;,H-INVERSE>
	 <RIGHT-LINE ,Q-RESUME-STORY 3 ;,H-INVERSE>)>>

<DEFINE LEFT-LINE (LN STR "OPTIONAL" (INV <>))
	<CCURSET .LN 1>
	<COND (.INV
	       <HLIGHT .INV>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<DEFINE RIGHT-LINE (STR "OPTIONAL" (LN 0) (INV <>) (LEN 0))
	<JUSTIFIED-LINE .STR .LN .INV .LEN 1>>

<DEFINE CENTER-LINE (STR "OPTIONAL" (LN 0) (INV <>) (LEN 0))
	<JUSTIFIED-LINE .STR .LN .INV .LEN 2>>

<DEFINE JUSTIFIED-LINE (STR LN INV LEN CTR)
  <COND (<ZERO? .LN>
	 <CURGET ,SLINE>
	 <SET LN <GET ,SLINE 0>>)
	(T
	 <SET LN <- .LN 1>>
	 <SET LN <+ 1 <* .LN <SHIFT <WINGET -3 ,WFSIZE> -8>>>>)>
  <COND (<ZERO? .LEN>
	 <DIROUT ,D-TABLE-ON ,SLINE ;-80>
	 <TELL .STR !\ >
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <LOWCORE TWID>>)>
  <CURSET .LN </ <- <WINGET -3 ,WWIDE> .LEN> .CTR>>
  <COND (.INV
	 <HLIGHT .INV>)>
  <TELL .STR !\ >
  <COND (.INV
	 <HLIGHT ,H-NORMAL>)>
  .LEN>

<END-SEGMENT>
