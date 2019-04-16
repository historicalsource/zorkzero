"INPUT for
				ZORK ZERO
	(c) Copyright 1988 Infocom, Inc. All Rights Reserved."

<BEGIN-SEGMENT 0>

<ROUTINE READ-INPUT ("AUX" TRM TMP N M FDEF DIR)
	 <PUTB ,P-INBUF 1 0>
	 <REPEAT ()
	      <COND (,DEMO-VERSION?
		     <SET TRM <READ-DEMO ,P-INBUF <>>>)
		    (T
		     <SET TRM <READ ,P-INBUF <>>>)>
	      <MOUSE-INPUT?>
	      <COND (<EQUAL? .TRM ,PAD0>
		     <SET TRM ,F10>)
		    (<AND <G=? .TRM ,PAD1>
			  <L=? .TRM ,PAD9>>
		     <SET TRM <+ ,F1 <- .TRM ,PAD1>>>)>
	      <COND (<EQUAL? .TRM ,CLICK1 ,CLICK2>
		     <COND (<SET DIR <COMPASS-CLICK ,COMPASS-PIC-LOC ,N-HL>>
			    ;<SET TMP <COND (<EQUAL? .DIR ,P?NORTH ,P?SOUTH> 5)
					   (<EQUAL? .DIR ,P?WEST ,P?EAST> 4)
					   (T 9)>>
			    <DIROUT ,D-TABLE-ON ,O-INBUF>
			    <TELL <DIR-TO-STRING .DIR>>
			    <DIROUT ,D-TABLE-OFF>
			    <PUTB ,O-INBUF 0 ,INBUF-LENGTH>
			    <ADD-TO-INPUT <REST ,O-INBUF 1> 13 <GETB ,O-INBUF 1>>
			    <RETURN>)>)
		    (<EQUAL? .TRM 13 10>
		     <RETURN>)
		    (<AND <SET TMP
			       <INTBL? .TRM <REST ,FKEYS 2> <GET ,FKEYS 0>>>
			  <SET FDEF <GET .TMP 1>>> ;"key def"
		     <SET TRM <ADD-TO-INPUT <REST .FDEF> .TRM <GETB .FDEF 1>>>
		     <COND (<EQUAL? .TRM 13 10> <RETURN>)>)
		    (T
		     <SOUND ,S-BEEP>)>>
	 <SCRIPT-INBUF>
	 <LEX ,P-INBUF ,P-LEXV>>

<ROUTINE ADD-TO-INPUT (FDEF TRM M "AUX" N TMP)
	 ;<SET M <GETB .FDEF 1>> ;"number chars in def"
	 <SET N <GETB ,P-INBUF 1>> ;"number chars already"
	 ;<SET FDEF <REST .FDEF>>
	 <COND (<EQUAL? <GETB .FDEF .M> 13 10>
		<SET TRM 13> ;"this def is a terminator"
		<SET M <- .M 1>>)>
	 <SET FDEF <REST .FDEF>>
	 <SET TMP <REST ,P-INBUF <+ .N 2>>>
	 <COND (<G=? <+ .M .N> <GETB ,P-INBUF 0>> ;"overflowed input buffer"
		<SOUND 1>
		<SET M <- <GETB ,P-INBUF 0> .N 1>>)>
	 <COPYT .FDEF .TMP .M>
	 <PUTB .TMP .M 0>
	 <WINATTR -3 ,A-SCRIPT ,O-CLEAR>
	 <PRINTT .FDEF .M>
	 <PUTB ,P-INBUF 1 <+ .N .M>>
	 <COND (<EQUAL? .TRM 13 10>
		<CRLF>)>
	 <WINATTR -3 ,A-SCRIPT ,O-SET>
	 .TRM>

<ROUTINE SCRIPT-INBUF ("AUX" BUF (CNT 0) (N <GETB ,P-INBUF 1>) CHR)
	 <DIROUT ,D-SCREEN-OFF>
	 <SET BUF <REST ,P-INBUF>>
	 <REPEAT ()
		 <COND (<IGRTR? CNT .N> <RETURN>)
		       (ELSE
			<SET CHR <GETB .BUF .CNT>> 
			<COND (<AND <G=? .CHR !\a>
				    <L=? .CHR !\z>>
			       <PRINTC <- .CHR 32>>)
			      (ELSE <PRINTC .CHR>)>)>>
	 <CRLF>
	 <DIROUT ,D-SCREEN-ON>>

<GLOBAL WIDTH 80>

<CONSTANT TCHARS <TABLE (BYTE) 255 0>>

<END-SEGMENT>

;"function key stuff"

<BEGIN-SEGMENT SOFT>

<CONSTANT DIROUT-TABLE <ITABLE 80 <BYTE 0>>>

<ROUTINE PRINT-CENTER-TABLE ()
	 <DIROUT ,D-TABLE-OFF>
	 <CURSET <WINGET -3 ,WYPOS>
		 <+ </ <- <WINGET -3 ,WWIDE>
			  <LOWCORE TWID>>
		       2>
		    1>>
	 <PRINTT <REST ,DIROUT-TABLE 2> <GET ,DIROUT-TABLE 0>>>

"MDL routine to create a set of soft-key tables and defaults"

<DEFINE SOFT-KEYS ("ARGS" TUP "AUX" (CNT 0) (DL (0)) L)
	<SET L
	<MAPF ,LIST
	      <FUNCTION ("AUX" VAL STR STRL)
		   <COND (<EMPTY? .TUP> <MAPSTOP>)>
		   <SET VAL <NTH .TUP 1>>
		   <SET STR <NTH .TUP 2>>
		   <SET TUP <REST .TUP 2>>
		   <COND (<TYPE? .STR STRING>
			  <SET STRL <LENGTH .STR>>
			  <SET DL (.VAL .STRL .STR !.DL)>
			  <COND (<L? .STRL ,FLEN>
				 <SET STR
				      <STRING .STR
					      <ISTRING <- ,FLEN .STRL>
						       !\ >>>)>
			  <SET CNT <+ .CNT 1>>
			  <MAPRET .VAL <TABLE (STRING) ,FLEN .STRL .STR>>)
			 (ELSE
			  <MAPRET .VAL <EVAL .STR>>)>>>>
	<CONSTANT FKEY-TBL <NTH .L 2>>
	<CONSTANT FKEYS-STRTABLE-LEN <* .CNT <+ ,FLEN 2>>>
	<CONSTANT DEFAULT-FKEYS <TABLE (STRING) !.DL>>
	<CONSTANT FKEYS <LTABLE !.L>>>

<CONSTANT FNAMES
	  <LTABLE ,UP-ARROW " UP"
		  ,DOWN-ARROW " DN"
		  ,LEFT-ARROW " LF"
		  ,RIGHT-ARROW " RT"
		;"vt100 keypad keys"
		  ,F1 " F1" 
		  ,F2 " F2"
		  ,F3 " F3"
		  ,F4 " F4"
		  ,F5 " F5"
		  ,F6 " F6"
		  ,F7 " F7"
		  ,F8 " F8"
		  ,F9 " F9"
		  ,F10 "F10">>

<SYNTAX DEFINE = V-DEFINE>

<GLOBAL DONE-DEFINE? <>>

<ROUTINE V-DEFINE ("AUX" (LINE 0) LINMAX CHR TMP NLINE FKEY FDEF LEFT FY FX)
	 <COND (<NOT ,DONE-DEFINE?>
		<SETG DONE-DEFINE? T>
		<TELL "Software Function Key definition. ">
		<COND (<EQUAL? <LOWCORE INTID> ,MACINTOSH>
		       <TELL
"(NOTE: if your Macintosh has no function keys, use Command-1 thru
Command-0 instead.) ">)>
		<TELL "Use the arrow keys">
		<COND (,ACTIVE-MOUSE
		       <TELL " or the mouse">)>
		<TELL
" to select the key to define or the operation to perform. Hit
the RETURN/ENTER key">
		<COND (,ACTIVE-MOUSE
		       <TELL " or double-click the mouse">)>
		<TELL " to perform operations." CR>
		<HIT-ANY-KEY>)>
	 <CLEAR -1>
	 <SET FKEY <REST ,FKEYS <+ 2 <* 4 .LINE>>>>
	 <SET FDEF <GET .FKEY 1>>
	 <SET LEFT </ <- <LOWCORE SCRH> <GETB .FDEF 0>> 2>>
	 <SET LINMAX </ <GET ,FKEYS 0> 2>>
	 <CLEAR -1>
	 <SCREEN ,SOFT-WINDOW>
	 <FONT 4>
	 <SET TMP <WINGET ,SOFT-WINDOW ,WFSIZE>>
	 <SET FY <SHIFT .TMP -8>>
	 <SET FX <BAND .TMP 255>>
	 <WINPOS ,SOFT-WINDOW
		 <* .FY </ <- <LOWCORE SCRV> .LINMAX> 2>>
		 <* .FX .LEFT>>
	 <WINSIZE ,SOFT-WINDOW
		  <* .FY <+ .LINMAX 1>>
		  <+ 1 <* .FX <+ ,FLEN 4>>>>
	 <DISPLAY-SOFTS .LINE>
	 <DISPLAY-SOFT .FKEY .LINE <>>
	 <REPEAT ()
		 <COND (,DEMO-VERSION?
			<SET CHR <INPUT-DEMO 1>>)
		       (T
			<SET CHR <INPUT 1>>)>
		 <SET NLINE .LINE>
		 <COND (<AND <EQUAL? .CHR ,CLICK1 ,CLICK2>
			     <SET TMP <IN-WINDOW? ,SOFT-WINDOW>>
			     <G? .TMP 1>>
			<SET NLINE <- .TMP 2>>
			<COND (<NOT <EQUAL? .LINE .NLINE>>
			       <DISPLAY-SOFT .FKEY .LINE T>
			       <DISPLAY-SOFT <REST ,FKEYS <+ 2 <* 4 .NLINE>>>
					     .NLINE <>>
			       <SET LINE .NLINE>
			       <SET FKEY <REST ,FKEYS <+ 2 <* 4 .LINE>>>>
			       <SET FDEF <GET .FKEY 1>>)>
			<COND (<AND <EQUAL? .CHR ,CLICK2>
				    <L? <GET .FKEY 0> 0>>
			       <SET CHR 13>)>)>
		 <COND (<EQUAL? .CHR ,CLICK1 ,CLICK2>)
		       (<AND <EQUAL? .CHR 13>
			     <L? <GET .FKEY 0> 0>>
			<SET NLINE 0>
			<COND (<APPLY <GET .FDEF 1>>
			       <SCREEN 0>
			       <CLEAR 0>
			       <V-$REFRESH>
			       <RTRUE>)
			      (ELSE
			       <SET NLINE <- .LINMAX 1>>
			       <DISPLAY-SOFTS .LINE>)>)
		       (<EQUAL? .CHR ,DOWN-ARROW 13>
			<COND (<L? <SET NLINE <+ .NLINE 1>> .LINMAX>)
			      (ELSE <SET NLINE 0>)>)
		       (<EQUAL? .CHR ,UP-ARROW>
			<COND (<G=? <SET NLINE <- .NLINE 1>> 0>)
			      (ELSE
			       <SET NLINE <- .LINMAX 1>>)>)
		       (<SET TMP
			     <INTBL? .CHR <REST ,FKEYS 2> <GET ,FKEYS 0>>>
			<SET NLINE </ <- .TMP ,FKEYS> 4>>)
		       (<EQUAL? .CHR 8 127>
			<SET TMP <GETB .FDEF 1>>
			<COND (<NOT <ZERO? .TMP>>
			       <SET TMP <- .TMP 1>>
			       <PUTB .FDEF 1 .TMP>
			       <PUTB .FDEF <+ .TMP 2> !\ >
			       <CCURSET <+ .LINE 2>
					<+ .TMP 5>>
			       <ERASE 1>)
			      (ELSE <SOUND ,S-BEEP>)>)
		       (<AND <G=? .CHR !\ > <L? .CHR 127>>
			<SET TMP <GETB .FDEF 1>>
			<COND (<EQUAL? .TMP <GETB .FDEF 0>>
			       <SOUND ,S-BEEP>)
			      (<INTBL? 13
				       <REST .FDEF 2>
				       <GETB .FDEF 1>
				       1>
			       <SOUND ,S-BEEP>)
			      (ELSE
			       <COND (<EQUAL? .CHR !\| !\!> <SET CHR 13>)>
			       <PUTB .FDEF 1 <+ .TMP 1>>
			       <COND (<AND <G=? .CHR !\A>
					   <L=? .CHR !\Z>>
				      <SET CHR <+ .CHR 32>>)>
			       <PUTB .FDEF <+ .TMP 2> .CHR>
			       <COND (<EQUAL? .CHR 13>
				      <PRINTC !\|>)
				     (ELSE <PRINTC .CHR>)>)>)
		       (ELSE <SOUND ,S-BEEP>)>
		 <COND (<NOT <EQUAL? .LINE .NLINE>>
			<DISPLAY-SOFT .FKEY .LINE T>
			<DISPLAY-SOFT <REST ,FKEYS <+ 2 <* 4 .NLINE>>>
				      .NLINE <>>
			<SET LINE .NLINE>
			<SET FKEY <REST ,FKEYS <+ 2 <* 4 .LINE>>>>
			<SET FDEF <GET .FKEY 1>>)>>
	 <FONT 1>
	 <SCREEN 0>
	 <V-$REFRESH>>

"given a window, returns line hit with mouse click, or false if not in that
window."

<ROUTINE IN-WINDOW? (W "AUX" X Y TOP LEFT)
	 <SET Y <LOWCORE MSLOCY>>
	 <SET X <LOWCORE MSLOCX>>
	 <COND (<OR <L? .Y <SET TOP <WINGET .W ,WTOP>>>
		    <L? .X <SET LEFT <WINGET .W ,WLEFT>>>>
		<RFALSE>)
	       (ELSE
		<SET Y <- .Y .TOP>>
		<SET X <- .X .LEFT>>
		<COND (<OR <G? .Y <WINGET .W ,WHIGH>>
			   <G? .X <WINGET .W ,WWIDE>>>
		       <RFALSE>)>
		<SET Y <+ 1 </ .Y ,FONT-Y>>>
		<RETURN .Y>)>>

<ROUTINE DISPLAY-SOFTS (LINE "AUX" (L <GET ,FKEYS 0>) (F 0) N FKEY (CNT 0))
	 <SET L </ .L 2>>
	 <SCREEN ,SOFT-WINDOW>
	 <CURSET 1 1>
	 <DIROUT ,D-TABLE-ON ,DIROUT-TABLE>
	 <FONT 1>
	 <TELL "Function Keys">
	 <PRINT-CENTER-TABLE>
	 <FONT 4>
	 <SET FKEY <REST ,FKEYS 2>>
	 <REPEAT ()
		 <COND (<L? .CNT .L>
			<DISPLAY-SOFT .FKEY .CNT
				      <COND (<EQUAL? .CNT .LINE> <>)
					    (ELSE T)>>
			<SET FKEY <REST .FKEY 4>>)
		       (ELSE <RETURN>)>
		 <SET CNT <+ .CNT 1>>>>

<ROUTINE DISPLAY-SOFT (FKEY CNT INV?
		       "AUX" (FDEF <GET .FKEY 1>) S N M TMP
		       (Y <+ .CNT 2>) X)
	 <COND (<L? <GET .FKEY 0> 0> ;"constant string"
		<CCURSET .Y 1>
		<COND (.INV? <HLIGHT ,H-INVERSE>)>
		<FONT 1>
		<DIROUT ,D-TABLE-ON ,DIROUT-TABLE>
		<TELL <GET .FDEF 0>>
		<PRINT-CENTER-TABLE>
		<FONT 4>)
	       (ELSE
		<SET S <GETB .FDEF 0>>
		<SET N <GETB .FDEF 1>>
		<CCURSET .Y 1>
		<COND (<SET TMP
			    <INTBL? <GET .FKEY 0>
				    <REST ,FNAMES 2>
				    <GET ,FNAMES 0>>>
		       <COND (.INV? <HLIGHT ,H-NORMAL>)
			     (ELSE <HLIGHT ,H-INVERSE>)>
		       <TELL <GET .TMP 1>>
		       <HLIGHT ,H-NORMAL>
		       <TELL " ">
		       <COND (.INV? <HLIGHT ,H-INVERSE>)
			     (ELSE <HLIGHT ,H-NORMAL>)>)>
		<SET FDEF <REST .FDEF 2>> ;"get past header bytes"
		<COND (.N ;"any definition?"
		       <SET M <- .N 1>>
		       <COND (<EQUAL? <GETB .FDEF .M> 13> ;"last character CR?"
			      <PRINTT .FDEF .M>
			      <PRINTC !\|>
			      <SET FDEF <REST .FDEF .N>>
			      <SET S <- .S .N>>)>)>
		<PRINTT .FDEF .S>
		<COND (<NOT .INV?>
		       <CCURSET .Y <+ .N 5>>)>)>
	 <HLIGHT ,H-NORMAL>>

<ROUTINE SOFT-RESET-DEFAULTS ("AUX" K L KEYS DEF KL TMP)
	 <SET KL <GET ,FKEYS 0>>
	 <SET DEF ,DEFAULT-FKEYS>
	 <REPEAT ()
		 <SET K <GETB .DEF 0>>
		 <COND (<ZERO? .K> <RETURN>)>
		 <SET DEF <REST .DEF>>
		 <SET L <+ 1 <GETB .DEF 0>>>
		 <COND (<SET KEYS <INTBL? .K <REST ,FKEYS 2> .KL>>
			<SET KEYS <GET .KEYS 1>>
			<SET TMP <REST .KEYS>>
			<PUTB .TMP 0 !\ >
			<COPYT .TMP <REST .TMP> <- <GETB .KEYS 0>>>
			<COPYT .DEF <REST .KEYS> .L>)>
		 <SET DEF <REST .DEF .L>>>
	 <RFALSE>>

<CONSTANT DEFS-NAME <LTABLE (STRING) "DEFS">>

<ROUTINE SOFT-SAVE-DEFS ()
	 <CLEAR 0>
	 <SCREEN 0>
	 <COND (<NOT <SAVE ,FKEY-TBL
			   ,FKEYS-STRTABLE-LEN
			   ,DEFS-NAME>>
	        <TELL "Failed.">)>
	 <CLEAR 0>
	 <SCREEN ,SOFT-WINDOW>
	 <RFALSE>>

<ROUTINE SOFT-RESTORE-DEFS ()
	 <CLEAR 0>
	 <SCREEN 0>
	 <COND (<NOT <RESTORE ,FKEY-TBL ,FKEYS-STRTABLE-LEN ,DEFS-NAME>>
		<TELL "Failed.">)>
	 <CLEAR 0>
	 <SCREEN ,SOFT-WINDOW>
	 <RFALSE>>

<ROUTINE SOFT-EXIT ()
	 <RTRUE>>

<CONSTANT FLEN 30>		;"max length of a key definition"
<CONSTANT SOFT-WINDOW 2>	;"window to use for defining"

"table containing string definitions for each function key.
contiguous so it can be written out or read in."

<SOFT-KEYS ,UP-ARROW "n"
	   ,DOWN-ARROW "s"
	   ,LEFT-ARROW "w"
	   ,RIGHT-ARROW "e"
	   ;"vt100 keypad keys"
	   ,F1 "take " 
	   ,F2 "take all"
	   ,F3 "drop "
	   ,F4 "look around"
	   ,F5 "inventory"
	   ,F6 "unlock door "
	   ,F7 "jester, "
	   ,F8 "give magic locket to moose"
	   ,F9 "read about "
	   ,F10 "examine "
	   -4 <TABLE "Save Defs" SOFT-SAVE-DEFS>
	   -5 <TABLE "Restore Defs" SOFT-RESTORE-DEFS>
	   -6 <TABLE "Reset Defaults" SOFT-RESET-DEFAULTS>
	   -2 <TABLE "Exit" SOFT-EXIT>>

;<CONSTANT FKEYS-STRTABLE-LEN <* 14 <+ ,FLEN 2>>>

;<CONSTANT MTBL <ITABLE 4 0>>

;<CONSTANT SOFT-TOP 3>

<END-SEGMENT>

<BEGIN-SEGMENT 0>

<ROUTINE Y? ("AUX" X)
	 <REPEAT ()
	     <COND (,DEMO-VERSION?
		    <SET X <INPUT-DEMO 1>>)
		   (T
		    <SET X <INPUT 1>>)>
	     ;<MOUSE-INPUT?>
	     <COND (<EQUAL? .X !\Y !\y ,CLICK1 ,CLICK2>
		    <SET X T>
		    <RETURN>)
		   (<EQUAL? .X !\N !\n>
		    <SET X <>>
		    <RETURN>)
		   (T
		    <TELL CR "[Please type Y or N] >">)>>
	 <CRLF>
	 <RETURN .X>>

<ROUTINE BLINK (PIC1 PIC2 Y X SCR "AUX" CHAR LAST (CNT 0))
	 <SCREEN .SCR>
	 <DISPLAY .PIC2 .Y .X>
	 <SCREEN ,S-TEXT>
	 <SET LAST .PIC2>
	 <REPEAT ()
		 <SETG TYPED-TIMED-OUT <>>
		 <SET CHAR <INPUT 1 3 ;"three-tenths of a second" ,TYPED?>>
		 <MOUSE-INPUT?>
		 <COND (,TYPED-TIMED-OUT
			<SCREEN .SCR>
			<DISPLAY <COND (<EQUAL? .LAST .PIC1>
					<SET LAST .PIC2>
					.PIC2)
				       (T
					<SET LAST .PIC1>
					.PIC1)> .Y .X>
			<SET CNT <+ .CNT 1>>
			<COND (<AND <EQUAL? .CNT 4>
				    ,ROSE-NEEDS-UPDATING
				    <EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>>
			       <UPDATE-MAP-ROSE>)>
			<SCREEN ,S-TEXT>)
		       (T
			<COND (<EQUAL? .LAST .PIC2> ;"leave unhighlited pic up"
			       <SCREEN .SCR>
			       <DISPLAY .PIC1 .Y .X>
			       <SCREEN ,S-TEXT>)>
			<RETURN .CHAR>)>>>

<GLOBAL TYPED-TIMED-OUT <>>

<ROUTINE TYPED? ()
	 <SETG TYPED-TIMED-OUT T>
	 <RTRUE>>

<ROUTINE PICINF-PLUS-ONE (PIC)
	 <PICINF .PIC ,PICINF-TBL>
	 <PUT ,PICINF-TBL 0 <+ <GET ,PICINF-TBL 0> 1>>
	 <PUT ,PICINF-TBL 1 <+ <GET ,PICINF-TBL 1> 1>>>

<GLOBAL MOUSE-LOC-X <>> ;"X-coordinate of most recent mouse click"

<GLOBAL MOUSE-LOC-Y <>> ;"Y-coordinate of most recent mouse click"

<ROUTINE MOUSE-INPUT? ()
	 <SETG MOUSE-LOC-X <LOWCORE MSLOCX>>
	 <SETG MOUSE-LOC-Y <LOWCORE MSLOCY>>>

;<CONSTANT CENTER-TABLE <ITABLE 80 <BYTE 0>>>

;<ROUTINE PRINT-CENTER-TABLE ()
	 <DIROUT ,D-TABLE-OFF>
	 <CURSET <WINGET -3 ,WYPOS>
		 <+ </ <- <WINGET -3 ,WWIDE>
			  <LOWCORE TWID>>
		       2>
		    1>>
	 <PRINTT <REST ,CENTER-TABLE 2> <GET ,CENTER-TABLE 0>>>

<END-SEGMENT>