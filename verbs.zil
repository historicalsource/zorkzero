"VERBS for

			       ZORK ZERO
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

<BEGIN-SEGMENT 0>

<DEFAULTS-DEFINED INIT-HINT-SCREEN>

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = superbrief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPERBRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "Superbrief descriptions." CR>>

<ROUTINE NOT-IN-DEMO ()
	<TELL
"[Sorry, but that command is not available in this demonstration version.]"CR>>

<ROUTINE V-SAVE ("AUX" X WRD COLOR-SAME)
	 <COND (<SAVE-UNDO-CHECK>
		<RTRUE>)>
	 <COND (,DEMO-VERSION?
		<NOT-IN-DEMO>
		<RFATAL>)>
	 <PUTB ,G-INBUF 2 0>
	 <SETG P-CONT <>> ;"flush anything on input line after SAVE"
	 <SET X <SAVE>>
	 <COND (<ZERO? .X>
		<SETG P-CONT -1>
	        <TELL "SAVE failed!" CR>
		<RFATAL>)
	       (<EQUAL? .X 1>
		<RESTORE-ORPHAN>
		<TELL "SAVE completed." CR>
		<RFATAL>)>
	 <SET WRD <WINGET ,S-TEXT ,WCOLOR>>
	 <COND (<AND <EQUAL? <SHIFT .WRD -8> ,FG-COLOR>
		     <EQUAL? <BAND .WRD 255> ,BG-COLOR>>
		<SET COLOR-SAME T>)
	       (T
		<SET COLOR-SAME <>>)>
	 <COLOR ,FG-COLOR ,BG-COLOR>
	 <SETG OLD-HERE <>>
	 <SETUP-SCREEN>
	 <V-$REFRESH>
	 <RESTORE-ORPHAN>
	 <TELL "Okay, restored." CR CR>
	 <SETG P-CONT -1> ;<RFATAL>
	 <V-LOOK>>

<ROUTINE SAVE-UNDO-CHECK ()
	 <COND (<EQUAL? ,HERE ,ROOM-OF-THREE-DOORS>
		<TELL
"[You can't SAVE or UNDO here. You'll have to solve the puzzle!]" CR>)>>

<ROUTINE RESTORE-ORPHAN ()
	 <COND (<AND <IN? ,JESTER ,HERE>
		     ,LIT
		     <OR <AND <EQUAL? ,HERE ,ENTRANCE-HALL>
			      <NOT <FSET? ,PORTCULLIS ,OPENBIT>>>
			 <AND <EQUAL? ,HERE ,SOLAR>
			      <IN? ,EAST-KEY ,JESTER>>
			 <EQUAL? ,HERE ,OUBLIETTE>
			 <AND <EQUAL? ,HERE ,CAVE-IN>
			      <IN? ,PIT-BOMB ,LOCAL-GLOBALS>>
			 <AND <EQUAL? ,HERE ,TAX-OFFICE>
			      <IN? ,ZORKMID-COIN ,LOCAL-GLOBALS>>
			 <AND <EQUAL? ,HERE ,STREAM>
			      <FSET? ,DIPLOMA ,TRYTAKEBIT>>>>
		<SETUP-ORPHAN "answer">)>>

<ROUTINE V-RESTORE ()
	 <COND (,DEMO-VERSION?
		<NOT-IN-DEMO>
		<RFATAL>)>
	 <COND (<NOT <RESTORE>>
		<TELL ,FAILED>)>>

<ROUTINE V-UNDO ("AUX" X)
	<SETG OLD-HERE <>>
	<SETG OLD-REGION <>>
	<COND (<NOT <SAVE-UNDO-CHECK>>
	       <SET X <IRESTORE>>
	       <COND (<EQUAL? .X -1>
		      <TELL "UNDO is unavailable on your computer system." CR>)
		     (T
		      <TELL ,FAILED>)>)>>

<ROUTINE V-SCRIPT ()
	 <COND (,DEMO-VERSION?
		<NOT-IN-DEMO>
		<RFATAL>)>
	 <TELL "[Transcript on.]" CR>
	 <DIROUT ,D-PRINTER-ON>
	 <CORP-NOTICE "begins">	 
	 <RTRUE>>

<ROUTINE V-UNSCRIPT ()
	 <COND (,DEMO-VERSION?
		<NOT-IN-DEMO>
		<RFATAL>)>
	 <CORP-NOTICE "ends">
	 <DIROUT ,D-PRINTER-OFF>
	 <TELL "[Transcript off.]" CR>
	 <DIROUT ,D-SCREEN-OFF>
	 <CRLF> ;"to transcript only"
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<ROUTINE CORP-NOTICE (STRING)
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL
"Here " .STRING " a transcript of interaction with" ;" ZORK ZERO." CR>
	 <V-VERSION>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<GLOBAL COLOR-NOTE <>>

<GLOBAL FG-COLOR 1>

<GLOBAL BG-COLOR 1>

<ROUTINE V-COLOR ("AUX" (DEFAULT <>))
	 <COND (<NOT ,COLOR-NOTE>
		<SETG COLOR-NOTE T>
		<TELL
"Aesthetically, we recommend not changing the standard setting, which
is black text on a white background. ">
		<COND (<AND <EQUAL? <LOWCORE INTID> ,MACINTOSH>
			    <MAC-II?>>
		       <TELL
"Also, if your Mac II displays only 16 colors, you probably won't get
the color you ask for. ">)>
		<TELL "Do you still want to go ahead?" CR "(Y or N) >">
		<COND (<NOT <Y?>>
		       <RTRUE>)>)>
	 <CRLF>
	 <REPEAT ()
	     <DO-COLOR>
	     <TELL
"You should now get " <GET ,COLOR-TABLE ,FG-COLOR> " text on a "
<GET ,COLOR-TABLE ,BG-COLOR> " background. Is that what you want?|
(Y or N) >">
	     <COND (<Y?>
		    <RETURN>)>
	     <COND (<AND <EQUAL? <LOWCORE INTID> ,MACINTOSH>
			 <NOT <MAC-II?>>>
		    <COND (<EQUAL? ,BG-COLOR 2>
			   <SETG BG-COLOR 9>
			   <SETG FG-COLOR 2>)
			  (T
			   <SETG BG-COLOR 2>
			   <SETG FG-COLOR 9>)>
		    <RETURN>)>
	     <TELL CR
"Do you want to pick again, or would you like to just go back to the
standard colors? (Type Y to pick again) >">
	     <COND (<Y?>
		    <CRLF>)
		   (T
		    <SET DEFAULT T>
		    <RETURN>)>>
	 <COND (.DEFAULT
		<COLOR 1 1>)
	       (T
		<COLOR ,FG-COLOR ,BG-COLOR>)>
	 <V-$REFRESH>>

<ROUTINE DO-COLOR ()
	 <COND (<AND <EQUAL? <LOWCORE INTID> ,MACINTOSH>
		     <NOT <MAC-II?>>> ;"b&w Mac"
		<COND (<EQUAL? ,BG-COLOR 2>
		       <SETG BG-COLOR 9>
		       <SETG FG-COLOR 2>)
		      (T
		       <SETG BG-COLOR 2>
		       <SETG FG-COLOR 9>)>)
	       (T
		<SETG FG-COLOR <PICK-COLOR ,FG-COLOR "text" T>>
		<SETG BG-COLOR <PICK-COLOR ,BG-COLOR "background">>)>>

<ROUTINE PICK-COLOR (WHICH STRING "OPTIONAL" (SETTING-FG <>) "AUX" CHAR)
	 <TELL
"The current " .STRING " color is " <GET ,COLOR-TABLE .WHICH> ,PERIOD-CR>
	 <FONT 4>
	 <TELL
"   1 --> WHITE   4 --> GREEN" CR
"   2 --> BLACK   5 --> YELLOW" CR
"   3 --> RED     6 --> BLUE" CR>
	 <FONT 1>
	 <TELL
"Type a number to select the " .STRING " color you want. >">
	 <REPEAT ()
		 <COND (,DEMO-VERSION?
			<SET CHAR <INPUT-DEMO 1>>)
		       (T
			<SET CHAR <INPUT 1>>)>
		 <SET CHAR <- .CHAR 48>> ;"convert from ASCII"
		 <COND (<EQUAL? .CHAR 1> ;"white is really 9, not 1"
			<SET CHAR 9>)>
		 <COND (<EQUAL? .CHAR 2 3 4 5 6 9>
			<COND (<AND <NOT .SETTING-FG>
				    <EQUAL? .CHAR ,FG-COLOR>>
			       <TELL CR
"You can't make the background the same
color as the text! Pick another color. >">)
			      (T
			       <RETURN>)>)
		       (T
			<TELL CR ,TYPE-A-NUMBER "6. >">)>>
	 <CRLF> <CRLF>
	 <RETURN .CHAR>>

<CONSTANT COLOR-TABLE
	  <TABLE ;0 "no change"
		 ;1 "the default color"
		 ;2 "black"
		 ;3 "red"
		 ;4 "green"
		 ;5 "yellow"
		 ;6 "blue"
		 ;7 "magenta"
		 ;8 "cyan"
		 ;9 "white">>

<END-SEGMENT>
<BEGIN-SEGMENT STARTUP>

<ROUTINE V-CREDITS ()
	 <CENTER-1 "Z O R K   Z E R O" T>
	 <CENTER-1 "The Revenge of Megaboz" T>
	 <CRLF>
	 <CENTER-1 "designed and written by" T>
	 <CENTER-1 "Steve Meretzky">
	 <CRLF>
	 <CENTER-1 "based on a concept by" T>
	 <CENTER-2 "Tim Anderson" "Marc Blank">
	 <CENTER-2 "Dave Lebling" "Steve Meretzky">
	 <CRLF>
	 <CENTER-1 "original graphics designed for the Amiga by" T>
	 <CENTER-1 "James Shook">
	 <CRLF>
	 <CENTER-1 "graphical translations" T>
	 <CENTER-3 "Tanya Allan" "Andy Briggs" "Denise Audette">
	 <CENTER-2 "Joy Pulver" "Charlie Voner">
	 <CRLF>
	 <CENTER-1 "design and implementation of InfoParser Mark Two" T>
	 <CENTER-2 "Tim Anderson" "Stu Galley">
	 <CRLF>
	 <CENTER-1 "design and implementation of XZIP development system" T>
	 <CENTER-2 "Tim Anderson" "Dave Lebling">
	 <CRLF>
	 <CENTER-1 "interpreter implementation" T>
	 <CENTER-1 "Macintosh:  Duncan Blanchard">
	 <CENTER-1 "Apple II:  Jon Arnold">
	 <CENTER-1 "IBM: Scott Fray">
	 <CENTER-1 "Amiga: Clarence Din">
	 <CRLF>
	 <CENTER-1 "testing" T>
	 <CENTER-3 "Kurt Boutin" "Gary Brennan" "Amy Briggs">
	 <CENTER-3 "Liz Cyr-Jones" "Craig Fields" "Jacob Galley">
	 <CENTER-3 "Adam Glass" "Tyler Gore" "Matt Hillman">
	 <CENTER-3 "Shaun Kelly" "Adam Levesque" "Patti Pizer">
	 <CENTER-2 "Joe Prosser" "Steve Watkins">
	 <CRLF>
	 <CENTER-1 "package design" T>
	 <CENTER-2 "Carl Genatassio" "Elizabeth Langosy">
	 <CRLF>
	 <CENTER-1 "calendar design" T>
	 <CENTER-2 "Amy Briggs" "Elizabeth Langosy">
	 <CENTER-1 "Steve Meretzky">
	 <CRLF>
	 <CENTER-1 "calendar art" T>
	 <CENTER-1 "Ed Parker">>

<END-SEGMENT>
<BEGIN-SEGMENT 0>

<ROUTINE V-DIAGNOSE ()
	 <COND (<G? ,DESERT-DEATH 0>
		<TELL "You're ">
		<COND (<G? ,DESERT-DEATH 4>
		       <TELL "about to pass out">)
		      (<G? ,DESERT-DEATH 2>
		       <TELL "dangerously close to passing out">)
		      (T
		       <TELL "feeling a bit faint">)>
		<TELL " from the heat." CR>)
	       (,ALLIGATOR
		<TELL "You're a perfectly healthy alligator." CR>)
	       (,TURNED-INTO
		<COND (<EQUAL? ,TURNED-INTO ,VIOLIN>
		       <TELL
"You're fit as a fiddle. In fact, you ARE a fiddle." CR>)
		      (T
		       <TELL
"You are" A ,TURNED-INTO ". Other details of health pale in comparison." CR>)>)
	       (<FSET? ,CLOWN-NOSE ,WORNBIT>
		<TELL
"You're having a bit of trouble breathing, thanks to the " D ,CLOWN-NOSE
" on your nose." CR>)
	       (<G? ,HUNGER-COUNT 0>
		<TELL "You feel ">
		<COND (<EQUAL? ,HUNGER-COUNT 2>
		       <TELL "very ">)
		      (<EQUAL? ,HUNGER-COUNT 3>
		       <TELL "incredibly ">)>
		<TELL "hungry." CR>)
	       (T
		<TELL "You're as fit as a fiddle." CR>)>>	 

<ROUTINE V-INVENTORY ()
	 <SETG D-BIT <- ,WORNBIT>>
	 <COND (<NOT <D-CONTENTS ,WINNER <> <+ ,D-ALL? ,D-PARA?>>>
		<COND (,TURNED-INTO
		       <TELL "You are carrying nothing.">)
		      (T
		       <TELL "You are empty-">
		       <COND (,ALLIGATOR
			      <TELL "claw">)
			     (T
			      <TELL "hand">)>
		       <TELL "ed.">)>)>
	 <SETG D-BIT ,WORNBIT>
	 <D-CONTENTS ,WINNER <> <+ ,D-ALL? ,D-PARA?>>
	 <SETG D-BIT <>>
	 <COND (<AND <FSET? ,GLOVE ,WORNBIT>
		     <NOT ,GLOVE-COMMENT>>
		<SETG GLOVE-COMMENT T>
		<TELL
" [It's probably none of my business, but when you wear that single glove you
resemble singer Michael Flathead, formerly of the Flathead Five.]">)>
	 <CRLF>>

<GLOBAL GLOVE-COMMENT <>>

<GLOBAL BORDER-ON T>

<ROUTINE V-MODE ()
	 <CLEAR -1>
	 <COND (,BORDER-ON
		<SETG BORDER-ON <>>)
	       (T
		<SETG BORDER-ON T>)>
	 <SPLIT-BY-PICTURE ,CURRENT-SPLIT>
	 <SCREEN ,S-FULL>
	 <INIT-STATUS-LINE T>
	 <SCREEN ,S-TEXT>
	 <TELL "Border o">
	 <COND (,BORDER-ON
		<TELL "n">)
	       (T
		<TELL "ff">)>
	 <TELL " (obviously)." CR>>

<ROUTINE V-QUIT ()
	 ;<PARSER-REPORT>
	 <V-SCORE>
	 <DO-YOU-WISH "leave the game">
	 <COND (<Y?>
		<QUIT>)
	       (T
		<TELL ,OK>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE>
	 <DO-YOU-WISH "restart">
	 <COND (<Y?>
		<TELL "Restarting." CR>
		<COLOR 1 1> ;"return to default colors before screen clears"
		<RESTART>
		<TELL ,FAILED>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL CR "Do you really want to " .STRING " (y or n)? >">>

<ROUTINE FINISH ("AUX" (REPEATING <>) (CNT 0))
	 <PROG ()
	       <CRLF>
	       <COND (<NOT .REPEATING>
		      <SET REPEATING T>
		      <V-SCORE>)>
	       <UPDATE-STATUS-LINE>
	       <TELL
"Would you like to start over, restore a saved position, ">
	       <COND (<NOT <EQUAL? ,HERE ,ROOM-OF-THREE-DOORS>>
		      <TELL "undo your last turn, ">)>
	       <TELL "end this session of the game, or ">
	       <COND (<EQUAL? ,SCORE 1000>
		      <TELL "see the credits?" CR>)
		     (T
		      <TELL "get a hint?" CR>)>
	       <TELL "(Type RESTART, RESTORE, ">
	       <COND (<NOT <EQUAL? ,HERE ,ROOM-OF-THREE-DOORS>>
		      <TELL "UNDO, ">)>
	       <TELL "QUIT, or ">
	       <COND (<EQUAL? ,SCORE 1000>
		      <TELL "CREDITS">)
		     (T
		      <TELL "HINT">)>
	       <TELL "): >">
	       <PUTB ,P-LEXV 0 10>
	       <PUTB ,P-INBUF 1 0>
	       <COND (,DEMO-VERSION?
		      <READ-DEMO ,P-INBUF ,P-LEXV>)
		     (T
		      <READ ,P-INBUF ,P-LEXV>)>
	       <MOUSE-INPUT?>
	       <PUTB ,P-LEXV 0 ,LEXV-LENGTH>
	       <SET CNT <+ .CNT 1>>
	       <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTART>
		      <COLOR 1 1> ;"return to default before screen clears"
	              <RESTART>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?RESTORE>
		      	   <NOT <RESTORE>>>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<OR <EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
			  <G? .CNT 10>>
		      ;<PARSER-REPORT>
		      <QUIT>)
		     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?UNDO>
			   <V-UNDO>>
		      <AGAIN>)
		     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?CREDIT ,W?CREDITS>>
		      <V-CREDITS>
		      <AGAIN>)
		     (<EQUAL? <GET ,P-LEXV 1> ,W?HINTS ,W?HINT ,W?HELP
			      		      ,W?CLUE ,W?CLUES>
		      <V-HINT>
		      <AGAIN>)>
	       <AGAIN>>>

<ROUTINE V-VERSION ()
	 <TELL 
"ZORK ZERO: The Revenge of Megaboz|
Copyright (c) 1988 by Infocom, Inc. All rights reserved.|
ZORK is a registered trademark of Infocom, Inc." CR>
	 <INTERPRETER-ID>
	 <TELL "Release " N <BAND <LOWCORE ZORKID> *3777*> " / Serial number ">
	 <LOWCORE-TABLE SERIAL 6 PRINTC>
	 <CRLF>>

<ROUTINE INTERPRETER-ID ()
	 ;"changed 7/21/88 per mail from TAA"
	 ;"changed again 9/12/88 per mail from Duncan"
	 <TELL
<GET ,MACHINES <LOWCORE INTID>> " Interpreter version "
N <LOWCORE (ZVERSION 0)> "." N <LOWCORE INTVR> CR>>

<CONSTANT MACHINES
	  <LTABLE "Dec-20"
		  "Apple IIe"
		  "Macintosh"
		  "Amiga"
		  "Atari ST"
		  "IBM"
		  "Commodore 128"
		  "Commodore 64"
		  "Apple IIc"
		  "Apple IIgs"
		  ""
		  "">>

<ROUTINE MAC-II? ()
	 <PICINF ,ICON-OFFSET ,PICINF-TBL>
	 <COND (<EQUAL? <GET ,PICINF-TBL 0> 0>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<CONSTANT D-RECORD-ON 4>
;<CONSTANT D-RECORD-OFF -4>

<END-SEGMENT>
<BEGIN-SEGMENT STARTUP>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<TELL "ILLEGAL." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 232>>
		<TELL N ,SERIAL CR>)
	       (T
		<INTERPRETER-ID>
		<TELL "Verifying..." CR>
	 	<COND (<VERIFY>
		       <TELL ,OK>)
	       	      (T
		       <TELL "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

<END-SEGMENT>
<BEGIN-SEGMENT 0>

<REPLACE-DEFINITION REFRESH
<ROUTINE V-$REFRESH ("OPTIONAL" (DONT-CLEAR <>))
	 <COND (<EQUAL? ,P-CAN-UNDO 2> ;"called because of an UNDO"
		<RESTORE-ORPHAN> ;"set up the riddle-answer orphans"
		<SETG DIR-CNT 0> ;"clear the chess-piece-move table")>
	 <COND (<EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>
		<DO-MAP>)
	       (<EQUAL? ,CURRENT-SPLIT ,B-SPLIT>
		<DRAW-TOWER>)
	       (<EQUAL? ,CURRENT-SPLIT ,PBOZ-SPLIT>
		<SETUP-PBOZ>)
	       (<EQUAL? ,CURRENT-SPLIT ,SN-SPLIT>
		<SETUP-SN>)
	       (<EQUAL? ,CURRENT-SPLIT ,F-SPLIT>
		<SETUP-FANUCCI>)
	       (T
		<COND (.DONT-CLEAR
		       <INIT-SL-WITH-SPLIT ,CURRENT-SPLIT T>)
		      (T
		       <INIT-STATUS-LINE>)>
		<UPDATE-STATUS-LINE>
	 	<LOWCORE FLAGS <BAND <LOWCORE FLAGS> -5>>
	 	<COND (<EQUAL? ,P-CAN-UNDO 2>
		       <TELL "[Undone.]" CR>)>)>
	 <RTRUE>>>

<END-SEGMENT>
<BEGIN-SEGMENT STARTUP>

;<GLOBAL DEBUG <>>

;<ROUTINE V-$DEBUG ()
	 <TELL "O">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "ff">)
	       (T
		<SETG DEBUG T>
		<TELL "n">)>
	 <TELL ,PERIOD-CR>>

;<ROUTINE V-$SKIP ()
	 <COND (<NOT ,PRSO>
		<V-VERSION>
		<CRLF>
		<DEQUEUE I-PROLOGUE>
		<DEQUEUE I-GIVE-OBJECT>
		<DEQUEUE I-TAKE-OBJECT>
		<MOVE ,PARCHMENT ,GREAT-HALL>
		<MOVE ,CAULDRON ,BANQUET-HALL>
		<MOVE ,STRAW ,SCULLERY>
		<ROB ,PROTAGONIST>
	 	<REMOVE ,DIMWIT>
	 	<REMOVE ,MEGABOZ>
	 	<MOVE ,UNOPENED-NUT ,ROOT-CELLAR>
	 	<FCLEAR ,BANQUET-HALL ,TOUCHBIT>
	 	<FCLEAR ,SCULLERY ,TOUCHBIT>
	 	<FCLEAR ,KITCHEN ,TOUCHBIT>
	 	<FCLEAR ,ROOT-CELLAR ,ONBIT>
	 	<FCLEAR ,WINE-CELLAR ,ONBIT>
	 	<SETG UNDER-TABLE <>>
	 	<SETG MID-NAME-NUM <- <RANDOM 12> 1>>
		<SETG DIAL-NUMBER <RANDOM 2400>>
	 	<SETG HOLEY-SLAB <GET ,SLAB-TABLE <- <RANDOM 7> 1>>>
	 	<MOVE ,CALENDAR ,GREAT-HALL>
		<MOVE ,PROCLAMATION ,ENTRANCE-HALL>
		<REMOVE ,TABLES>
		<REMOVE ,BANQUET-FOOD>
		<MOVE ,CROWN ,TREASURE-CHEST>
		<FSET ,CROWN ,TAKEBIT>
		<MOVE ,ROBE ,TRUNK>
		<FSET ,ROBE ,TAKEBIT>
	 	<GOTO ,GREAT-HALL>)
	       (T
		<MOVE ,CANDLE ,PROTAGONIST>
		<FSET ,PORTCULLIS ,OPENBIT>
		<FSET ,EAST-DOOR ,OPENBIT>
		<FSET ,WEST-DOOR ,OPENBIT>
		<SETG NUT-EATEN T>
		<SETG SECRET-PASSAGE-OPEN T>
		<FSET ,DRAWBRIDGE ,OPENBIT>
		<COND (<PRSO? ,CAULDRON>
		       <GOTO ,BANQUET-HALL>
		       <MOVE ,NOTEBOOK ,HERE>
		       <COND (<EQUAL? ,SACRED-WORD-NUMBER 10>
			      <SETG SACRED-WORD-NUMBER <- <RANDOM 10> 1>>)>
		       <MOVE ,CROWN ,HERE>
		       <MOVE ,SCEPTRE ,HERE>
		       <MOVE ,ZORKMID-BILL ,HERE>
		       <MOVE ,DIPLOMA ,HERE>
		       <FCLEAR ,DIPLOMA ,TRYTAKEBIT>
		       <FCLEAR ,DIPLOMA ,NDESCBIT>
		       <MOVE ,SILK-TIE ,HERE>
		       <MOVE ,STOCK-CERTIFICATE ,HERE>
		       <MOVE ,QUILL-PEN ,HERE>
		       <MOVE ,MANUSCRIPT ,HERE>
		       <MOVE ,VIOLIN ,HERE>
		       <MOVE ,METRONOME ,HERE>
		       <MOVE ,FAN ,HERE>
		       <MOVE ,FLASK ,HERE>
		       <MOVE ,SCREWDRIVER ,HERE>
		       <MOVE ,LANTERN ,HERE>
		       <FCLEAR ,LANTERN ,TRYTAKEBIT>
		       <MOVE ,SCALE-MODEL ,HERE>
		       <MOVE ,T-SQUARE ,HERE>
		       <MOVE ,BAT ,HERE>
		       <FCLEAR ,BAT ,TRYTAKEBIT>
		       <MOVE ,DUMBBELL ,HERE>
		       <MOVE ,LANCE ,HERE>
		       <MOVE ,SADDLE ,HERE>
		       <MOVE ,SPYGLASS ,HERE>
		       <FCLEAR ,SPYGLASS ,TRYTAKEBIT>
		       <MOVE ,SEAMANS-CAP ,HERE>
		       <MOVE ,EASLE ,HERE>
		       <MOVE ,LANDSCAPE ,HERE>)
		      (<PRSO? ,T-OF-B>
		       <GOTO ,JESTERS-QUARTERS>)
		      (<PRSO? ,PBOZ-OBJECT>
		       <GOTO ,PEG-ROOM>)
		      (<PRSO? ,DOUBLE-FANUCCI>
		       <GOTO ,CASINO>)
		      (<PRSO? ,HOTHOUSE>
		       <MOVE ,DIRIGIBLE ,SMALLER-HANGAR>
		       <GOTO ,HOTHOUSE>)
		      (<PRSO? ,REBUS>
		       <REMOVE ,REBUS-MOUSE>
		       <REMOVE ,REBUS-GOOSE>
		       <REMOVE ,REBUS-SLIME-MONSTER>
		       <REMOVE ,REBUS-CAMEL>
		       <REMOVE ,REBUS-SNAKE>
		       <REMOVE ,REBUS-FISH>
		       <FSET ,BASEMENT-REBUS-BUTTON ,TOUCHBIT>
		       <FSET ,CLOSET-REBUS-BUTTON ,TOUCHBIT>
		       <FSET ,CRAG-REBUS-BUTTON ,TOUCHBIT>
		       <FSET ,CRAWL-REBUS-BUTTON ,TOUCHBIT>
		       <FSET ,GROTTO-REBUS-BUTTON ,TOUCHBIT>
		       <FSET ,ATTIC-REBUS-BUTTON ,TOUCHBIT>
		       <GOTO ,GALLERY>)
		      (<PRSO? ,ORACLE-OBJECT>
		       <MOVE ,RUBY ,DEPRESSION>
		       <FSET ,RUBY ,NDESCBIT>
		       <FSET ,RUBY ,NALLBIT>
		       <MOVE ,AMULET ,PROTAGONIST>
		       <GOTO ,ORACLE>)
		      (T
		       <TELL ,HUH>)>)>>

<END-SEGMENT>

;"subtitle real verbs"

<BEGIN-SEGMENT 0>

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS ,ME>
		<PERFORM-PRSA ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ANIMATEDBIT>
		<COND (<FSET? ,PRSO ,FEMALEBIT>
		       <TELL "Sh">)
		      (T
		       <TELL "H">)>
		<TELL "e's wide awake, or haven't you noticed..." CR>)
	       (T
		<TELL "You're nuts." CR>)>>

;<ROUTINE V-ANAGRAM ("AUX" LEN R)
	 <DIROUT ,D-TABLE-ON ,SLINE>
	 <SET LEN <NP-LEXBEG <GET-NP ,PRSO>>>
	 <COND (<EQUAL? ,PRSO ,INTQUOTE>
		<SET LEN <ZREST .LEN <* 2 ,LEXV-ELEMENT-SIZE-BYTES>>>)>
	 <SET R <NP-LEXEND <GET-NP ,PRSO>>>
	 <COND (<EQUAL? ,PRSO ,INTQUOTE>
		<SET R <ZBACK .R ,LEXV-ELEMENT-SIZE-BYTES>>)>
	 <BUFFER-PRINT .LEN .R <> T>
	 <DIROUT ,D-TABLE-OFF>
	 <TELL "How about \"">
	 <SET LEN <GET ,SLINE 0>>
	 <REPEAT ()
		 <COND (<EQUAL? .LEN 0>
			<RETURN>)>
		 <SET R <+ <RANDOM .LEN> 1>>
		 <PRINTC <GETB ,SLINE .R>>
		 <PUTB ,SLINE .R <GETB ,SLINE <+ .LEN 1>>>
		 <SET LEN <- .LEN 1>>>
	 <SETG AWAITING-REPLY 1>
	 <QUEUE I-REPLY 2>
	 <TELL "\"? [It's not a very good anagram routine, is it?]" CR>>

;<ROUTINE V-APPLAUD ()
	 <TELL "\"Clap.\"" CR>>

<ROUTINE V-ASK-ABOUT ("AUX" OWINNER)
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSI>
		<SETG WINNER .OWINNER>
		<THIS-IS-IT ,PRSI>
		<THIS-IS-IT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <COND (<PRSO? ,BROGMOID>
		<TELL ,TALK-TO-BROGMOID>)
	       (T
		<TELL "Unsurprisingly," T ,PRSO " doesn't oblige." CR>)>>

<ROUTINE V-ASK-NO-ONE-FOR ("AUX" ACTOR)
	 <COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT>>
		<PERFORM ,V?ASK-FOR .ACTOR ,PRSO>
		<RTRUE>)
	       (T
		<TELL "There's no one here to ask." CR>)>>

<ROUTINE V-BEHEAD ("OPTIONAL" (CALLED-BY-V-HANG <>))
	 <TELL "You usually need a ">
	 <COND (.CALLED-BY-V-HANG
		<TELL "noose">)
	       (T
		<TELL "axe">)>
	 <TELL " to do this">
	 <COND (<AND <NOT <FSET? ,PRSO ,ACTORBIT>>
		     <NOT <EQUAL? ,PRSO ,ME>>>
		<TELL
", and besides, it doesn't look like" T ,PRSO " even has a ">
		<COND (.CALLED-BY-V-HANG
		       <TELL "neck">)
		      (T
		       <TELL "head">)>)>
	 <TELL ,PERIOD-CR>>

;<ROUTINE V-BEND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?SPREAD>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <V-ENTER>)
		      (T
		       <HACK-HACK "Spreading">)>)
	       (T
	        <HACK-HACK "Bending">)>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<COND (<SETG PRSI <FIND-IN ,PROTAGONIST ,FLAMEBIT>>
		       <TELL "[with" T ,PRSI "]" CR>
		       <PERFORM ,V?BURN ,PRSO ,PRSI>
		       <RTRUE>)
		      (T
		       <TELL "Your burning gaze is insufficient." CR>
		       <RTRUE>)>)>
	 <COND (<NOT <FSET? ,PRSI ,FLAMEBIT>>
		<TELL "With" A ,PRSI "??!?" CR>)
	       (<FSET? ,PRSO ,BURNBIT>
		<TELL "Instantly," T ,PRSO " catches fire and is consumed.">
		<COND (<ULTIMATELY-IN? ,PRSO>
		       <JIGS-UP
" Unfortunately, you were holding it at the time.">)
		      (T
		       <REMOVE ,PRSO>
		       <CRLF>)>)
	       (<PRSO? ,CANDLE>
		<FSET ,CANDLE ,FLAMEBIT>
		<FSET ,CANDLE ,ONBIT>
		<TELL "You relight the candle." CR>)
	       (T
		<TELL ,YOU-CANT "burn" AR ,PRSO>)>>

<ROUTINE V-BUY ()
	 <TELL "That's not for sale." CR>>

<ROUTINE V-CALL ()
	 <COND (<PRSO? ,INTQUOTE>
		<V-SAY>)
	       (<AND <VISIBLE? ,PRSO>
		     <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>>
	        <PERFORM ,V?TELL ,PRSO>
	        <RTRUE>)
	       (T
		<DO-FIRST "invent the telephone">)>>

<ROUTINE V-CATCH ()
	 <COND (,PRSI
		<TELL
"Sorry," T ,PRSI " isn't much help in catching" TR ,PRSO>)
	       (T
		<TELL "The only thing you're likely to catch is a cold." CR>)>>

<ROUTINE V-CHASTISE ()
	 <COND (<PRSO? ,INTDIR>
		<TELL
,YOULL-HAVE-TO "go in that direction to see what's there." CR>)
	       (T
		<USE-PREPOSITIONS "LOOK " "AT" "INSIDE" "UNDER">)>>

<ROUTINE USE-PREPOSITIONS (VRB PREP1 PREP2 PREP3)
	 <TELL
"[Use prepositions to indicate precisely what you want to do: " .VRB .PREP1
" the object, " .VRB .PREP2 " it, " .VRB .PREP3 " it, etc.]" CR>>

;<ROUTINE V-CHEER ()
	 <COND (<PRSO? ,ROOMS>
		<TELL ,OK>)
	       (T
		<TELL "Probably," T ,PRSO " is as happy as possible." CR>)>>

<ROUTINE V-CLEAN ()
	 <SETG AWAITING-REPLY 1>
	 <QUEUE I-REPLY 2>
	 <TELL "Do you also do windows?" CR>>

<ROUTINE V-CLIMB ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<AND <PRSO? ,CAMEL>
		     <IN? ,PROTAGONIST ,CAMEL>
		     <EQUAL? ,P-PRSA-WORD ,W?RIDE>>
		<TELL
"[You'll have to say which direction you want to ride in.]" CR>)
	       (<AND <PRSO? ,INTDIR>
		     <VISIBLE? ,CAMEL>>
		<COND (<IN? ,PROTAGONIST ,CAMEL>
		       <PERFORM ,V?RIDE-DIR ,CAMEL ,PRSO>
		       <RTRUE>)
		      (T
		       <DO-FIRST "mount" ,CAMEL>)>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<TELL ,HOLDING-IT>)
	       (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?IN>
		<CANT-VERB-A-PRSO "climb into">)
	       (T
		<CANT-VERB-A-PRSO "climb onto">)>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<TELL ,HOLDING-IT>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLOSE ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <AND <FSET? ,PRSO ,VEHBIT>
			 <NOT <PRSO? ,DB ,LADDER
				     ,IRON-MAIDEN ,SNAKE-PIT ,WATER-CHAMBER>>>>
		<YOU-MUST-TELL-ME>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Okay," T ,PRSO " is now closed." CR>
		       <NOW-DARK?>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (T
		<YOU-MUST-TELL-ME>)>>

<ROUTINE V-COUGH ()
	 <COND (<AND <EQUAL? ,HERE ,ICKY-CAVE>
		     <NOT <IN? ,SICKLY-WITCH ,HERE>>>
		<COND (,LIT
		       <MOVE ,SICKLY-WITCH ,HERE>
		       <MOVE ,PRICKLY-WITCH ,HERE>
		       <TELL
"Two witches appear, spraying fumigation spells throughout the cave. One
of the witches, less healthy than the other, frets, \"Oh, dear, I'm not
certain my frail body can stand all these germs!\" The other witch, less
friendly than the first, gives you a blistering glare. \"What manners! I
certainly wouldn't walk into YOUR home and start spewing phlegm around!\"">
		       <COND (<IN? ,JESTER ,HERE>
			      <REMOVE-J>
			      <TELL CR
"   They notice the jester for the first time." ,WITCH-REMOVES-J>)
			     (T
			      <CRLF>)>)
		      (T
		       <TELL
"You hear, briefly, a sound that just might be witches disinfecting
a cave. But, in the dark, who can really tell for sure?" CR>)>)
	       (T
		<TELL
"Hmmm. You seem to be catching a cold. [Can't say I'm surprised,
considering you spent last night sleeping on the cold stone floor
of Flatheadia castle.]" CR>)>>

<ROUTINE PRE-COUNT ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>	;"multiple objects?"
		<TELL "There are " N ,P-MULT ,PERIOD-CR>)>>

<ROUTINE V-COUNT ()
	 <IMPOSSIBLES>>

<ROUTINE V-CRAWL-UNDER ()
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CROSS ()
	 <V-WALK-AROUND>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<IMPOSSIBLES>)
	       (T
		<TELL "Strange concept, cutting" TR ,PRSO>)>>

<ROUTINE V-DATE ()
	 <TELL
"\"It was on a fateful day in the year 883 GUE...\" is how poets of the
future will begin their tales of your quest. Not being a poet of the
future, you think of it as the 14th day of Mumberbur." CR>>

<ROUTINE V-DECODE ()
	 <TELL ,YOULL-HAVE-TO "figure it out yourself." CR>>

;<ROUTINE V-DEFLATE ()
	 <IMPOSSIBLES>>

<ROUTINE V-DIG ()
	 <COND (<PRSI? ,SHOVEL>
		<COND (<NOT <PRSO? ,GROUND>>
		       <IMPOSSIBLES>)
		      (<AND <NOT <FSET? ,HERE ,OUTSIDEBIT>>
			    <NOT <FSET? ,HERE ,DESERTBIT>>>
		       <TELL "The floor is a bit harder than the shovel." CR>)
		      (<AND <EQUAL? ,JUMP-X ,STUMP-X>
			    <EQUAL? ,JUMP-Y ,STUMP-Y>
			    <IN? ,TREASURE-CHEST ,LOCAL-GLOBALS>>
		       <MOVE ,TREASURE-CHEST ,HERE>
		       <TELL
"You dig and dig and dig. And dig. Then, summoning hidden reserves of strength,
you dig some more. Suddenly... \"Clank.\" It's a treasure chest! With a burst
of energy you uncover it and drag it out of the hole. As you do so, the walls
of the hole collapse, filling it in, and you barely make it out alive." CR>)
		      (T
		       <TELL
"You dig a sizable hole but, finding nothing of interest, you fill it in
again out of consideration to future passersby and current gamewriters." CR>)>)
	       (T
		<TELL "Digging with">
		<COND (<ZERO? ,PRSI>
		       <TELL " your hands">)
		      (T
		       <TELL T ,PRSI>)>
		<TELL " is slow and tedious." CR>)>>

<ROUTINE V-DIG-WITH ()
	 <PERFORM ,V?DIG ,GROUND ,PRSO>
	 <RTRUE>>

;<ROUTINE V-DRESS ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<FSET? ,PRSO ,FEMALEBIT>
			      <TELL "Sh">)
			     (T
			      <TELL "H">)>
		       <TELL "e is dressed!" CR>)
		      (T
		       <IMPOSSIBLES>)>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-DRESSED>)>>

<ROUTINE V-DRINK ()
	 <COND (<FSET? ,PRSO ,WATERBIT>
		<PERFORM-PRSA ,WATER>)
	       (T
		<CANT-VERB-A-PRSO "drink">)>>

<ROUTINE V-DRINK-FROM ()
	 <COND (<FSET? ,PRSO ,WATERBIT>
		<PERFORM ,V?DRINK ,WATER>
		<RTRUE>)
	       (T
	        <IMPOSSIBLES>)>>

<ROUTINE V-DRINK-WITH ()
	 <COND (<PRSI? ,STRAW>
		<COND (<PRSO? ,ELIXIR>
		       <JIGS-UP
"After a moment of ecstasy, the elixir fries your brain. Your last sight is
of creatures crawling from unseen crevices, waiting to feast on your corpse.">)
		      (T
		       <PERFORM ,V?DRINK ,PRSO>
		       <RTRUE>)>)
	       (T
		<TELL ,YOU-CANT "drink something with" AR ,PRSI>)>>

<ROUTINE V-DROP ("AUX" CHESSPIECE)
	 <COND (<IN? ,PRSO ,WALDO>
		<COND (<EQUAL? ,HERE ,HOLD>
		       <MOVE ,PRSO ,HOLD>)
		      (T
		       <MOVE ,PRSO ,LAKE-BOTTOM>)>
		<TELL "You release" TR ,PRSO>)
	       (<NOT <SPECIAL-DROP ,PRSO>>
		<COND (<FSET? <LOC ,PROTAGONIST> ,DROPBIT>
		       <MOVE ,PRSO <LOC ,PROTAGONIST>>)
		      (T
		       <MOVE ,PRSO ,HERE>)>
		<COND (<PRSO? ,LARGE-FLY ,LARGER-FLY
			      ,EVEN-LARGER-FLY ,LARGEST-FLY>
		       <TELL "You release" T ,PRSO>)
		      (T
		       <TELL "Dropped">)>
		<COND (<AND <OR <SET CHESSPIECE <FIND-IN ,HERE ,BLACKBIT>>
				<SET CHESSPIECE <FIND-IN ,HERE ,WHITEBIT>>>
			    <NOT <FSET? ,PRSO ,TRYTAKEBIT>>
			    <NOT <FIND-IN ,PRSO ,TRYTAKEBIT>>
			    <NOT ,TIME-STOPPED>>
		       <MOVE ,PRSO .CHESSPIECE>
		       <TELL
". The " D .CHESSPIECE " says, \"Well what do you know? It's been a long time
since I had" A ,PRSO ".\" ">
		       <COND (<FSET? .CHESSPIECE ,FEMALEBIT>
			      <TELL "Sh">)
			     (T
			      <TELL "H">)>
		       <TELL "e picks it up.">
		       <COND (<AND <PRSO? ,PIGEON>
				   <NOT <EQUAL? ,HERE <META-LOC ,PERCH>>>>
			      <PIECE-TAKES-PIGEON .CHESSPIECE>)
			     (T
			      <CRLF>)>)
		      (<AND <PRSO? ,BAR-OF-FOOD>
			    <IN? ,FLAMINGO ,HERE>>
		       <TELL
". The flamingo eyes the food, but appears to be too well-mannered to
eat something that hasn't been offered." CR>)
		      (T
		       <TELL ,PERIOD-CR>)>)>> 

<ROUTINE SPECIAL-DROP (OBJ "OPT" (CALLED-BY-ROB <>)) ;"else drop or throw"
	 <COND (<AND <EQUAL? ,HERE ,OUBLIETTE>
		     <G? <GETP .OBJ ,P?SIZE> 4>>
		<REMOVE .OBJ>
		<COND (<OR <EQUAL? .OBJ ,PERCH>
			   <ULTIMATELY-IN? ,PERCH ,PRSO>>
		       <SETG REMOVED-PERCH-LOC ,OUBLIETTE>)>
		<COND (<NOT .CALLED-BY-ROB>
		       <TELL
"With a gentle slurping noise," T ,PRSO " vanishes slowly into the mud." CR>
		       <NOW-DARK?>)>
		<RTRUE>)
	       (<EQUAL? ,HERE ,UNDER-THE-WORLD ,HANGING-FROM-ROOTS>
		<REMOVE .OBJ>
		<COND (<OR <EQUAL? .OBJ ,PERCH>
			   <ULTIMATELY-IN? ,PERCH ,PRSO>>
		       <SETG REMOVED-PERCH-LOC ,BROGMOID>)>
		<COND (<NOT .CALLED-BY-ROB>
		       <TELL
"As you release" T ,PRSO ", it dwindles into the mist and is gone
from this world forever." CR>)>
		<RTRUE>)
	       (T
	 	<RFALSE>)>>

<ROUTINE PRE-INGEST ()
	 <COND (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>>
		<TELL
"You've turned into" A ,TURNED-INTO ", and as a consequence don't have much
in the way of a mouth." CR>)>>

<ROUTINE V-EAT ()
	 <TELL "It's not likely that" T ,PRSO " would agree with you." CR>>

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,GROUND>)>
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL ,HUH>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "But" T ,PRSO " isn't open." CR>)
	       (<NOT <FIRST? ,PRSO>>
		<TELL "But" T ,PRSO " is already empty!" CR>)
	       (<AND <PRSI? <FIRST? ,PRSO>>
		     <NOT <NEXT? ,PRSI>>>
		<TELL ,THERES-NOTHING "in" T ,PRSO " but" TR ,PRSI>)
	       (T
		<SET OBJ <FIRST? ,PRSO>>
		<REPEAT ()
			<SET NXT <NEXT? .OBJ>>
			<COND (<NOT <EQUAL? .OBJ ,PROTAGONIST>>
			       <TELL D .OBJ ": ">
			       <COND (<FSET? .OBJ ,TAKEBIT>
				      <MOVE .OBJ ,PROTAGONIST>
				      <COND (<PRSI? ,HANDS>
					     <TELL "You take" TR .OBJ>)
					    (<PRSI? ,GROUND>
					     <PERFORM ,V?DROP .OBJ>)
					    (<FSET? ,PRSI ,SURFACEBIT>
					     <PERFORM ,V?PUT-ON .OBJ ,PRSI>)
					    (T
					     <PERFORM ,V?PUT .OBJ ,PRSI>)>)
				     (T
				      <YUKS>)>)>
			<COND (.NXT
			       <SET OBJ .NXT>)
			      (T
			       <RETURN>)>>)>>

<ROUTINE V-EMPTY-FROM ()
	 <COND (<IN? ,PRSO ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T
		       <YUKS>)>)
	       (T
		<NOT-IN>)>>

<ROUTINE PRE-ENTER ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<TELL ,LOOK-AROUND>)	       
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<TELL ,HOLDING-IT>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)
	       (<AND <FSET? ,PRSO ,VEHBIT>
		     <NOT <IN? ,PRSO ,HERE>>>
		<TELL
"You'll have to remove" T ,PRSO " from" T <LOC ,PRSO> " first." CR>)>>

<ROUTINE V-ENTER ("AUX" DIR)
	<COND (<PRSO? ,INTDIR> ;"for example, ENTER EAST"
	       <DO-WALK <DIRECTION-CONVERSION>>)
	      (<FSET? ,PRSO ,WATERBIT>
	       <PERFORM-PRSA ,WATER>)
	      (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <COND (<NOT <EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>>
		      <TELL ,YOU-CANT "board" T ,PRSO " when it's ">
		      <COND (<FSET? <LOC ,PRSO> ,SURFACEBIT>
			     <TELL "on">)
			    (T
			     <TELL "in">)>
		      <TELL TR <LOC ,PRSO>>)
		     (T
		      <MOVE ,PROTAGONIST ,PRSO>
		      <SETG OLD-HERE <>>
		      <TELL "You are now ">
		      <COND (<PRSO? ,CARD-TABLE>
			     <TELL "sitting at">)
			    (<FSET? ,PRSO ,INBIT>
		       	     <TELL "in">)
		      	    (T
		       	     <TELL "on">)>
		      <TELL T ,PRSO ".">
		      <COND (<NOT <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>>
			     <CRLF>)>
		      <FSET ,PRSO ,TOUCHBIT>)>)
	      (<IN? ,PRSO ,ROOMS>
	       <COND (<SET DIR <FIND-NEXT-ROOM>>
		      <DO-WALK .DIR>)
		     (T
		      <V-WALK-AROUND>)>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL-HIT-HEAD>)
	      (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?IN>
	       <CANT-VERB-A-PRSO "get into">)
	      (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?ON>
	       <CANT-VERB-A-PRSO "get onto">)
	      (T
	       <SETG AWAITING-REPLY 1>
	       <QUEUE I-REPLY 2>
	       <TELL
"You have a theory on how to board" A ,PRSO ", perhaps?" CR>)>>

<ROUTINE FIND-NEXT-ROOM ("AUX" PT PTS (DIR 0) ;(CNT 0))
	 <REPEAT ()
		 <SET DIR <NEXTP ,HERE .DIR>>
		 <COND (<OR <ZERO? .DIR>
			    <L? .DIR ,LOW-DIRECTION>>
			;<EQUAL? .CNT 10>
			<RETURN <>>)>
		 ;<SET DIR <GET ,DIRECTION-TABLE .CNT>>
		 <COND (<SET PT <GETPT ,HERE .DIR>>
			<SET PTS <PTSIZE .PT>>
			<COND (<EQUAL? .PTS ,UEXIT ,CEXIT>
			       <COND (<EQUAL? <GETB .PT ,REXIT> ,PRSO>
				      <RETURN .DIR>)>)
			      (<EQUAL? .PTS ,DEXIT>
			       <COND (<EQUAL? <GETB .PT ,DEXITRM> ,PRSO>
				      <RETURN .DIR>)>)>)>
		 ;<SET CNT <+ .CNT 1>>>>

;<CONSTANT DIRECTION-TABLE
	  <TABLE ,P?NORTH
		 ,P?NE
		 ,P?EAST
		 ,P?SE
		 ,P?SOUTH
		 ,P?SW
		 ,P?WEST
		 ,P?NW
		 ,P?UP
		 ,P?DOWN>>

<ROUTINE V-EXAMINE ()
	 <COND (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<COND (<FIRST? ,PRSO>
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <NOTHING-INTERESTING>
		       <TELL "about" TR ,PRSO>)>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL ,IT-SEEMS-THAT T ,PRSO " is ">
		<OPEN-CLOSED ,PRSO>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<OR <FSET? ,PRSO ,OPENBIT>
			   <FSET? ,GOGGLES ,WORNBIT>>			    
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed.">
		       <COND (<AND <FSET? ,PRSO ,TRANSBIT>
				   <FIRST? ,PRSO>>
			      <TELL " ">
			      <V-LOOK-INSIDE>)
			     (T
			      <CRLF>)>)>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<TELL "It's o">
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,READBIT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<IN? ,PRSO ,ROOMS>
		<TELL "You can't see much from here." CR>)
	       (<FSET? ,PRSO ,NARTICLEBIT>
		<SENSE-OBJECT "look">)
	       (<PROB 25>
		<TELL "Totally ordinary looking " D ,PRSO ,PERIOD-CR>)
	       (<OR <PROB 60>
		    <FSET? ,PRSO ,PLURALBIT>
		    <PRSO? ,GROUND>>
		<NOTHING-INTERESTING>
		<TELL "about" TR ,PRSO>)
	       (T
	        <PRONOUN>
		<TELL " look">
		<COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
			    <NOT <PRSO? ,ME>>>
		       <TELL "s">)>
		<TELL " like every other " D ,PRSO " you've ever seen." CR>)>>

<ROUTINE NOTHING-INTERESTING ()
	 <TELL ,THERES-NOTHING>
	 <COND (<PROB 25>
		<TELL "unusual">)
	       (<PROB 33>
		<TELL "noteworthy">)
	       (<PROB 50>
		<TELL "eye-catching">)
	       (T
		<TELL "special">)>
	 <TELL " ">>

<ROUTINE V-EXIT ()
	 <COND (<OR <NOT ,PRSO>
		    <PRSO? ,ROOMS>>
		<COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <PERFORM ,V?EXIT <LOC ,PROTAGONIST>>
		       <RTRUE>)
		      (,UNDER-TABLE
		       <V-STAND>)
		      (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?DOWN>
		       <TELL "You're not on anything." CR>)
		      (T
		       <DO-WALK ,P?OUT>)>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TAKE> ;"since GET OUT is also TAKE OUT"
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND ,UNDER-TABLE
		     <OR <NOT ,PRSO>
			 <PRSO? ,TABLES>>>
		<V-STAND>)
	       (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<SETG P-CONT -1> ;<RFATAL>
		<TELL ,LOOK-AROUND>)
	       (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>
		     <NOT <EQUAL? ,TURNED-INTO ,LITTLE-FUNGUS>>>
		<V-SKIP>)
	       (T
		<MOVE ,PROTAGONIST ,HERE>
		<SETG OLD-HERE <>>
		<TELL "You get ">
		<COND (<PRSO? ,CARD-TABLE>
		       <TELL "up from">)
		      (<FSET? ,PRSO ,INBIT>
		       <TELL "out of">)
		      (T
		       <TELL "off">)>
		<TELL T ,PRSO ".">		
		<CRLF>)>>

<ROUTINE V-FEED ()
         <TELL "You have no food for" TR ,PRSO>>

<ROUTINE PRE-FILL ()
	 <COND (,PRSI
		<RFALSE>)
	       (<FIND-WATER>
		<SETG PRSI ,WATER>
		<RFALSE>)
	       (<AND <VISIBLE? ,LARGE-VIAL-WATER>
		     <VISIBLE? ,SMALL-VIAL-WATER>>
		<COND (<PRSO? ,SMALL-VIAL>
		       <PERFORM ,V?EMPTY ,LARGE-VIAL ,SMALL-VIAL>
		       <RTRUE>)
		      (<PRSO? ,LARGE-VIAL>
		       <PERFORM ,V?EMPTY ,SMALL-VIAL ,LARGE-VIAL>
		       <RTRUE>)
		      (T
		       <TELL
"[You'll have to specify which water you mean, the large vial
or the small vial.]" CR>)>)
	       (<VISIBLE? ,LARGE-VIAL-WATER>
		<PERFORM ,V?EMPTY ,LARGE-VIAL ,PRSO>
		<RTRUE>)
	       (<VISIBLE? ,SMALL-VIAL-WATER>
		<PERFORM ,V?EMPTY ,SMALL-VIAL ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?FILL ,PRSO ,WATER>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<FSET? ,PRSI ,WATERBIT>
		<PERFORM-PRSA ,PRSO ,WATER>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<NOT .L>
		<PRONOUN>
		<TELL " could be anywhere!" CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<IN? ,PRSO ,HERE>
		<TELL "Right in front of you." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<V-DECODE>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "Looks as if" T .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>
		     <NOT <IN? .L ,GLOBAL-OBJECTS>>>
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "O">)
		      (<AND <FSET? .L ,VEHBIT>
			    <NOT <FSET? .L ,INBIT>>>
		       <TELL "O">)
		      (T
		       <TELL "I">)>
		<TELL "n" TR .L>)
	       (T
		<V-DECODE>)>>

<ROUTINE V-FLY ()
	 <COND (<OR <NOT ,PRSO>
		    <PRSO? ,INTDIR>>
		<COND (,TURNED-INTO
		       <COND (<EQUAL? ,TURNED-INTO ,PIGEON
				      ,ROOSTER ,FLAMINGO ,EVEN-LARGER-FLY
				      ,LARGE-FLY ,LARGEST-FLY ,LARGER-FLY>
			      <MOVE ,PROTAGONIST ,HERE>
			      <TELL
"You make a few awkward circuits of the room, bouncing
into several walls. (Ouch.)" CR>)
			     (T
			      <TELL
"Despite what you may have learned in school," A ,TURNED-INTO " is no
more capable of flight than a human." CR>)>)
		      (T
		       <TELL
"Humans are not usually equipped for flying." CR>)>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-FOLLOW ()
	 <COND (<VISIBLE? ,PRSO>
		<TELL "But" T-IS-ARE ,PRSO "right here!" CR>)
	       (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<IMPOSSIBLES>)
	       (T
		<TELL "You have no idea where" T ,PRSO>
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
		<TELL ,PERIOD-CR>)>>

;<GLOBAL FOLLOW-FLAG <>>

;<ROUTINE I-FOLLOW ()
	 <SETG FOLLOW-FLAG <>>
	 <RFALSE>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <VERB? GIVE>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?SHAKE-WITH ,PRSI>
		<RTRUE>)
	       (<PRSO? ,EYES>
		<PRE-SWITCH>
		<PERFORM ,V?EXAMINE ,PRSI ,EYES>
		<RTRUE>)
	       ;(<AND <EQUAL? ,P-PRSA-WORD ,W?FEED>
		     <NOT <FSET? ,PRSO ,FOODBIT>>>
		<TELL "That's not food!" CR>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GET-NEAR ()
	 <WASTES>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "Briskly," T ,PRSI " refuse">
		<COND (<NOT <FSET? ,PRSI ,PLURALBIT>>
		       <TELL "s">)>
		<TELL " your offer." CR>)
	       (T
		<TELL ,YOU-CANT "give" A ,PRSO " to" A ,PRSI "!" CR>)>> 
		 
<ROUTINE V-GIVE-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-QUIT>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-HANG ()
	 <V-BEHEAD T>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <TELL
"[The proper way to talk to characters in the story is PERSON, HELLO.">
	      <COND (<PRSO? ,SAILOR>
		     <TELL " Besides, nothing happens here.">)>
	      <TELL "]" CR>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

<ROUTINE V-HIDE ()
	 <TELL ,YOU-CANT "hide ">
	 <COND (,PRSO
		<TELL "t">)>
	 <TELL "here." CR>>

<END-SEGMENT>
<BEGIN-SEGMENT HINTS>

<GLOBAL HINTS-OFF:NUMBER -1>

<GLOBAL HINT-COUNTER 0>

<ROUTINE V-HINT ()
  <COND (<EQUAL? ,HINTS-OFF -1>
	 <SETG HINTS-OFF 0>
	 <TELL
"Warning: We strongly recommend that you not use hints unless you're definitely
stuck. Peeking at hints prematurely will invariably make you enjoy
the story less. If you want to avoid reading any hints for the rest of this
session, you may at any time during the story type HINTS OFF. Do you still
want a hint? (Y or N) >">
	 <COND (<NOT <Y?>>
		<RFATAL>)>)
	(,HINTS-OFF
	 <PERFORM ,V?HINTS-NO ,ROOMS>
	 <RFATAL>)>
  <SETG HINT-COUNTER <+ ,HINT-COUNTER 1>>
  <COND (<AND <G? ,HINT-COUNTER 0>
	      <EQUAL? <MOD ,HINT-COUNTER 5> 0>>
	 <TELL "You're looking at the hints ">
	 <HLIGHT ,H-BOLD>
	 <TELL "again">
	 <HLIGHT ,H-NORMAL>
	 <TELL
"?!! Even Lord Dimwit Flathead would consider that excessive!
Do you really want to be such a wimp? (Y or N) >">
	 <COND (<NOT <Y?>>
		<RFATAL>)>)>
  <DO-HINTS>>

<REPLACE-DEFINITION INIT-HINT-SCREEN
<ROUTINE INIT-HINT-SCREEN ()
  <CLEAR -1>
  <SCREEN ,S-FULL>
  <COND (,BORDER-ON
	 <DISPLAY ,HINT-BORDER 1 1>)>
  <SPLIT-BY-PICTURE ,TEXT-WINDOW-PIC-LOC>
  <SCREEN ,S-TEXT>
  ,S-WINDOW>>

<END-SEGMENT>
<BEGIN-SEGMENT 0>

<ROUTINE V-HINTS-NO ()
	 <COND (<NOT <PRSO? ,ROOMS>>
		<RECOGNIZE>
		<RTRUE>)
	       (,HINTS-OFF
		<TELL "[You've already deactivated">)
	       (T
		<SETG HINTS-OFF T>
		<TELL "[Okay, you will no longer have access to">)>
	 <TELL " help in this session.]" CR>>

<ROUTINE V-IN ()
	 <DO-WALK ,P?IN>>

<ROUTINE V-INFLATE ()
	 <IMPOSSIBLES>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Trying to kill" A ,PRSO " with">
		<COND (,PRSI
		       <TELL A ,PRSI>)
		      (T
		       <TELL " your bare hands">)>
		<TELL " is suicidal." CR>)
	       (T
		<TELL "How strange, fighting" A ,PRSO "!" CR>)>>

<ROUTINE V-KISS ()
	<TELL "I'd sooner kiss a pig." CR>>

;<ROUTINE V-KNEEL ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?BOW>
		<TELL "You begin to get a sore waist." CR>)
	       (T
	 	<TELL "You begin to get a sore knee." CR>)>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<HACK-HACK "Knocking on">)>>
		
;<ROUTINE V-LAND ()
	 <COND (<AND <NOT ,PRSO>
		     <EQUAL? <LOC ,PROTAGONIST> ,RAFT ,BARGE>>
		<PERFORM-PRSA <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
	 	<TELL ,HUH>)>>

<ROUTINE V-LEAD-TO ()
	 <COND (<AND <PRSO? ,CAMEL>
		     <PRSI? ,WATER>
		     <FSET? ,CAMEL ,ANIMATEDBIT>>
		<COND (<NOT ,CAMEL-THIRSTY>
		       <PERFORM ,V?EXAMINE ,CAMEL>
		       <RTRUE>)
		      (T ;<EQUAL? ,HERE ,SOUTH-SHORE>
		       <TELL
"The camel takes the tiniest sip of lake water, snorts with disgust, and
spits it right out." CR>)>)
	       (T
	 	<TELL
"It doesn't look like you'll be leading" T ,PRSO " anywhere, let alone
to" TR ,PRSI>)>>

<ROUTINE V-LEAP ()
	 <COND (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>
		     <NOT <EQUAL? ,TURNED-INTO ,LITTLE-FUNGUS>>>
		<V-SKIP>)
	       (<OR <PRSO? ,ROOMS>
		    <NOT ,PRSO>>
		<COND (<AND <EQUAL? ,HERE ,GONDOLA>
			    <G? ,DIRIGIBLE-COUNTER 0>>
		       <DO-WALK ,P?OUT>)
		      (<EQUAL? ,HERE ,HANGING-FROM-ROOTS
			       	     ,UNDER-THE-WORLD ,SHOULDER>
		       <JIGS-UP
"You sail down through the mist for a seemingly endless time, passing giant
brogmoid shoulders, hips, and knees. Eventually, the mist begins to thin, and
you see a strange land below: Purple forests surround lakes of molten rock.
Volcanoes belch green-blue smoke into the sky. Enormous slug-shaped creatures,
a bloit long, engage in fierce combat. Suddenly, the feeling of floating
endlessly changes to a feeling of falling very quickly, and this strange new
world rushes up and smashes you to pulp.">)
		      (<JUMPLOSS>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,MEGABOZ-HUT>
		       <COND (<IN? ,PROTAGONIST ,LADDER>
			      <TELL
"You don't need to. Thanks to the ladder, you can easily make it
through the trap door." CR>)
			     (T
			      <TELL
"Your best jump leaves you far short of the trap door." CR>)>)
		      (T
		       <V-SKIP>)>)
	       (<PRSO? ,INTDIR>
		<COND (<AND <EQUAL? ,HERE ,OUTER-BAILEY>
			    <NOT <EQUAL? ,JUMP-X 99>>
			    <OR <NOUN-USED? ,INTDIR ,W?SOUTH ,W?NORTH>
				<NOUN-USED? ,INTDIR ,W?EAST ,W?WEST>>>
		       <COND (<NOUN-USED? ,INTDIR ,W?NORTH>
			      <SETG JUMP-Y <+ ,JUMP-Y 1>>)
			     (<NOUN-USED? ,INTDIR ,W?SOUTH>
			      <SETG JUMP-Y <- ,JUMP-Y 1>>)
			     (<NOUN-USED? ,INTDIR ,W?EAST>
			      <SETG JUMP-X <+ ,JUMP-X 1>>)
			     (T
			      <SETG JUMP-X <- ,JUMP-X 1>>)>)
		      (T
		       <SETG JUMP-X 99>
	 	       <SETG JUMP-Y 99>)>
		<COND (<IN? ,PROTAGONIST ,TREE-STUMP>
		       <SETG OLD-HERE <>>
		       <MOVE ,PROTAGONIST ,HERE>)>
		<TELL "You jump once in that direction." CR>)
	       (<NOT <IN? ,PRSO ,HERE>>
		<IMPOSSIBLES>)
	       (<JUMPLOSS>
		<RTRUE>)
	       (T
		<V-SKIP>)>>

<ROUTINE JUMPLOSS ()
	 <COND (<EQUAL? ,HERE ,PARAPET ,UPPER-LEDGE ,LOWER-LEDGE
			      ,G-U-MOUNTAIN ,BALCONY ,ROOF ,QUARRYS-EDGE>
		<COND (<PROB 33>
		       <TELL "Geronimo">)
		      (<PROB 50>
		       <TELL "You should have looked before you leapt">)
		      (T
		       <TELL "This was not a very good place to try jumping">)>
		<JIGS-UP "!">)
	       (T
		<RFALSE>)>>

<ROUTINE V-LEAP-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?EXIT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?LEAP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAVE ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<PERFORM ,V?EXIT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LET-OUT ()
	 <TELL "But" T ,PRSO " isn't all that confined." CR>>

;<ROUTINE V-LICK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TASTE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LIE-DOWN ()
	 <COND (<IN? ,BEDBUG ,HERE>
		<TELL "You curl up for a moment. ">
		<REMOVE-BEDBUG "see">)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,ROOMS>
		     <EQUAL? ,HERE ,DIMWITS-ROOM>>
		<PERFORM ,V?ENTER ,DIMWITS-BED>
		<RTRUE>)
	       (T
		<WASTES>)>>

<ROUTINE PRE-LISTEN ()
	 <COND (,TIME-STOPPED
		<TELL "Unremitting silence." CR>)
	       (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>>
		<SETG P-CONT -1>
		<TO-SPEAK-OF "ears">)>>

<ROUTINE V-LISTEN ("AUX" PLANT)
	 <COND (,PRSO
	 	<SENSE-OBJECT "sound">)
	       (<AND <EQUAL? ,HERE ,TORTURE-CHAMBER>
		     <FSET? ,METRONOME ,TRYTAKEBIT>
		     <G? ,METRONOME-COUNTER 0>>
		<METRONOME-TORTURE>)
	       (<AND <VISIBLE? ,METRONOME>
		     ,METRONOME-ON>
		<QUEUE I-METRONOME 2>
		<I-METRONOME T>)
	       (<AND <SET PLANT <FIND-IN ,HERE ,PLANTBIT>>
		     ,PLANT-TALKER>
		<TELL "[to" T .PLANT "]" CR>
		<PERFORM-PRSA .PLANT>)
	       (T
		<TELL "You hear nothing of interest." CR>)>>

<ROUTINE PRE-LOCK ("AUX" KEY)
	 <COND (<NOT ,PRSI>
		<COND (<SET KEY <FIND-IN ,PROTAGONIST ,KEYBIT>>
		       <SETG PRSI .KEY>
		       <TELL "[with" T .KEY "]" CR>
		       <RFALSE>)
		      (T
		       <SETG AWAITING-REPLY 1>
		       <QUEUE I-REPLY 2>
		       <TELL "What? With your nose?" CR>)>)>>

<ROUTINE V-LOCK ("AUX" KEY)
	 <COND (<FSET? ,PRSO ,LOCKEDBIT>
		<TELL ,ALREADY-IS>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <PRSO? ,TRUNK>>
		<TELL "Unfortunately," T ,PRSI " doesn't lock" TR ,PRSO>)
	       (T
		<TELL ,YOU-CANT "lock" AR ,PRSO>)>>

<ROUTINE PRE-LOOK ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (<AND <VERB? READ>
		     ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>>
		<SETG P-CONT -1>
		<TO-SPEAK-OF "eyes">)
	       (<AND <VERB? READ>
		     <UNTOUCHABLE? ,PRSO>
		     <FSET? ,PRSO ,TAKEBIT>>
		<TELL ,YNH TR ,PRSO>)>>

<ROUTINE V-LOOK ()
	 <COND (<D-ROOM T>
		<D-OBJECTS>)>
	 <RTRUE>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>
	 <TELL "There is nothing behind" TR ,PRSO>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<EQUAL? ,HERE ,HANGING-FROM-ROOTS ,UNDER-THE-WORLD>
		       <V-LOOK>)
		      (T
		       <PERFORM ,V?EXAMINE ,GROUND>
		       <RTRUE>)>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ("AUX" (X-RAYED <>))
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,IT-SEEMS-THAT T ,PRSO " has">
		<COND (<NOT <D-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<D-VEHICLE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that" T ,PRSO " is ">
		<OPEN-CLOSED ,PRSO>
		<TELL ,PERIOD-CR>)
	       ;(<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?OUT ,W?OUTSIDE>
		<TELL "You see nothing special." CR>)
	       (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?OUT>
		<TELL "You see nothing special." CR>)
	       (<FSET? ,PRSO ,SURFACEBIT>		
		<TELL "On the surface of" T ,PRSO " you see">
		<COND (<NOT <D-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,VEHBIT>
		     <NOT <FIRST? ,PRSO>>>
		;"if you're in it, it's handled above"
		<COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <DO-FIRST "open" ,PRSO>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <NOT <FSET? ,PRSO ,TRANSBIT>>
			    <FSET? ,GOGGLES ,WORNBIT>>
		       <SET X-RAYED T>
		       <DISCOVER-X-RAY>)>
		<TELL "There is no one ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" TR ,PRSO>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <NOT <FSET? ,PRSO ,TRANSBIT>>
			    <FSET? ,GOGGLES ,WORNBIT>>
		       <SET X-RAYED T>
		       <DISCOVER-X-RAY>)>
		<COND (<SEE-INSIDE? ,PRSO>
		       <TELL "Within" T ,PRSO " you see">
		       <COND (<NOT <D-NOTHING>>
		              <TELL ,PERIOD-CR>)>
		       <COND (.X-RAYED
			      <TELL
"   After a moment, the power of the goggles wanes, and" T ,PRSO " no
longer seems transparent." CR>)>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>
			    <EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?IN>
			   ;<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>>
		       <COND (<UNTOUCHABLE? ,PRSO>
			      <CANT-REACH ,PRSO>
			      <RTRUE>)>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <DO-FIRST "open" ,PRSO>)>)
	       ;(<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "look inside">)
	       (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?IN>
		<CANT-VERB-A-PRSO "look inside">)
	       (T
		<CANT-VERB-A-PRSO "look through">)>>

<ROUTINE V-LOOK-OVER ()
	 <V-EXAMINE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,WALDO>>
		     <NOT <IN? ,PRSO ,WALDO>>>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL ,WEARING-IT>)
		      (T
		       <TELL ,HOLDING-IT>)>)
	       (<FSET? ,PRSO ,WATERBIT>
		<PERFORM-PRSA ,WATER>)
	       (T
		<TELL "There is nothing but ">
		<COND (<IN? ,PRSO ,MIRROR-LAKE>
		       <TELL "ice">)
		      (<FSET? <LOC ,PRSO> ,DELTABIT>
		       <TELL "swamp">)
		      (<OR <PRSO? ,NORTH-DOCK ,SOUTH-DOCK ,EAST-DOCK ,WEST-DOCK
				  ,YACHT ,WHARF ,BRIDGE>
			   <AND <OR <PRSO? ,DRAWBRIDGE>
				    <AND <PRSO? ,GLOBAL-HERE>
					 <EQUAL? ,HERE ,DRAWBRIDGE>>>
				<FSET? ,DRAWBRIDGE ,OPENBIT>>
			   <AND <EQUAL? ,HERE ,LAKE-BOTTOM>
				<IN? ,PRSO ,HERE>>
			   <AND <PRSO? ,WALDO ,DB>
			   	<NOT <EQUAL? ,HERE ,HOLD>>>
			   <AND <IN? ,PRSO ,WALDO>
				<NOT <EQUAL? ,HERE ,HOLD>>>
			   <IN? ,PRSO ,FISH-TANK>>
		       <TELL "water">)
		      (T
		       <TELL "dust">)>
		<TELL " there." CR>)>>

;<ROUTINE V-LOVE ()
	 <TELL "Not difficult, considering how lovable" T ,PRSO " ">
	 <COND (<FSET? ,PRSO ,PLURALBIT>
		<TELL "are">)
	       (T
		<TELL "is">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

;<ROUTINE V-MAKE ()
	 <TELL ,YOU-CANT "just make" A ,PRSO " out of thin air." CR>>

;<ROUTINE V-MAKE-WITH ()
	 <PERFORM ,V?SET ,PRSI ,PRSO>
	 <RTRUE>>

<GLOBAL MAP-NOTE <>>

<GLOBAL CHANGED-MAP-WARNING <>>

<CONSTANT MAIN-MAP-NUM 1>
<CONSTANT SECRET-WING-MAP-NUM 2>
<CONSTANT VILLAGE-MAP-NUM 3>
<CONSTANT LOWER-LEVEL-MAP-NUM 4>
<CONSTANT LAKE-MAP-NUM 5>
<CONSTANT DESERT-MAP-NUM 6>
<CONSTANT FOOZLE-MAP-NUM 7>
<CONSTANT FENSHIRE-MAP-NUM 8>
<CONSTANT FJORD-MAP-NUM 9>
<CONSTANT GRAY-MOUNTAINS-MAP-NUM 10>
<CONSTANT DELTA-MAP-NUM 11>
<CONSTANT FUBLIO-MAP-NUM 12>
<CONSTANT ANTHARIA-MAP-NUM 13>

<GLOBAL MAP-TOP-LEFT-X 0>
<GLOBAL MAP-TOP-LEFT-Y 0>
<GLOBAL MAP-ELEMENT-WIDTH 0>
<GLOBAL MAP-ELEMENT-HEIGHT 0>
<GLOBAL MAP-BOX-WIDTH 0>
<GLOBAL MAP-BOX-HEIGHT 0>
<GLOBAL MAP-SPACE-WIDTH 0>
<GLOBAL MAP-SPACE-HEIGHT 0>

<CONSTANT MAP-GEN-X-1 0>
<CONSTANT MAP-GEN-X-2 -1>
<CONSTANT MAP-GEN-X-3 -2>
<CONSTANT MAP-GEN-X-4 -3>
<CONSTANT MAP-GEN-X-5 -4>
<CONSTANT MAP-GEN-X-6 -5>
<CONSTANT MAP-GEN-X-7 -6>
<CONSTANT MAP-GEN-X-8 -7>
<CONSTANT MAP-GEN-X-9 -8>
<CONSTANT MAP-GEN-X-10 -9>
<CONSTANT MAP-GEN-X-11 -10>
<CONSTANT MAP-GEN-Y-1 0>
<CONSTANT MAP-GEN-Y-2 -1>
<CONSTANT MAP-GEN-Y-3 -2>
<CONSTANT MAP-GEN-Y-4 -3>
<CONSTANT MAP-GEN-Y-5 -4>
<CONSTANT MAP-GEN-Y-6 -5>
<CONSTANT MAP-GEN-Y-7 -6>

<CONSTANT MAP-PICSET-TBL
	  <TABLE ICONLESS-ROOM-BOX
		 YOU-ARE-HERE-SYMBOL
		 N-S-CON
		 E-W-CON
		 NE-SW-CON
		 NW-SE-CON
		 MAP-N-HL
		 MAP-NE-HL
		 MAP-E-HL
		 MAP-SE-HL
		 MAP-S-HL
		 MAP-SW-HL
		 MAP-W-HL
		 MAP-NW-HL
		 MAP-N-UNHL
		 MAP-NE-UNHL
		 MAP-E-UNHL
		 MAP-SE-UNHL
		 MAP-S-UNHL
		 MAP-SW-UNHL
		 MAP-W-UNHL
		 MAP-NW-UNHL
		 ;"stuff room icons in these 20 slots, ending with a zero"
		 <> <> <> <> <>
		 <> <> <> <> <>
		 <> <> <> <> <>
		 <> <> <> <> <> >>

<CONSTANT MAIN-ICON-TBL
	<LTABLE GONDOLA-ICON
		PEG-ROOM-ICON
		WEST-WING-ICON
		GYM-ICON
		TORCH-ROOM-ICON
		ROOF-ICON
		PARLOR-ICON
		FORMAL-GARDEN-ICON
		BALCONY-ICON
		GALLERY-ICON
		THRONE-ROOM-ICON
		BANQUET-HALL-ICON
		KITCHEN-ICON
		WINE-CELLAR-ICON
		LIBRARY-ICON
		EAST-WING-ICON
		CHAPEL-ICON
		J-QUARTER-ICON
		PYRAMID-ICON
		0>>

<CONSTANT SECRET-WING-ICON-TBL
	 <LTABLE DIMWITS-ROOM-ICON
		 MAGIC-CLOSET-ICON
		 PARAPET-ICON
		 BASTION-ICON
		 SECRET-PASSAGE-ICON
		 TEE-ICON
		 TOP-OF-STAIR-ICON
		 BOTTOM-OF-STAIR-ICON
		 ORACLE-ICON
		 DUNGEON-ICON
		 CELL-ICON
		 0>>

<CONSTANT VILLAGE-ICON-TBL
	 <LTABLE PERIMETER-WALL-ICON
		 GARRISON-ICON
		 OUTER-BAILEY-ICON
		 DRAWBRIDGE-ICON
		 BARBICAN-ICON
		 UPPER-BARBICAN-ICON
		 CAUSEWAY-ICON
		 INNER-BAILEY-ICON
		 URS-OFFICE-ICON
		 SHADY-PARK-ICON
		 CHURCH-ICON
		 COURTROOM-ICON
		 POST-OFFICE-ICON
		 FR-HQ-ICON
		 MAGIC-SHOP-ICON
		 BACK-ALLEY-ICON
		 OFFICES-ICON
		 PENTHOUSE-ICON
		 0>>

<CONSTANT LOWER-LEVEL-ICON-TBL
	 <LTABLE ROOTS-ICON
		 EAR-ICON
		 MOUTH-OF-CAVE-ICON
		 LEDGE-IN-PIT-ICON
		 PASSAGE-STORAGE-ICON
		 VAULT-ICON
		 G-U-HIGHWAY-ICON
		 EXIT-ICON
		 KENNELS-ICON
		 ROYAL-ZOO-ICON
		 LABORATORY-ICON
		 0>>

<CONSTANT LAKE-ICON-TBL
	 <LTABLE HOLD-ICON
		 UNDERWATER-ICON
		 LAKE-BOTTOM-ICON
		 EAST-SHORE-ICON
		 WEST-SHORE-ICON
		 NORTH-SHORE-ICON
		 SOUTH-SHORE-ICON
		 LAKE-FLATHEAD-ICON
		 RING-OF-DUNES-ICON
		 G-U-SAVANNAH-ICON
		 BATS-LAIR-ICON
		 BASE-OF-MT-ICON
		 G-U-MOUNTAIN-ICON
		 STABLE-ICON
		 SHRINE-ICON
		 0>>

<CONSTANT DESERT-ICON-TBL
	 <LTABLE CACTUS-PATCH-ICON
		 TALL-DUNES-ICON
		 G-U-OASIS-ICON
		 0>>

<CONSTANT FOOZLE-ICON-TBL
	 <LTABLE WHARF-ICON
		 FISHING-VILLAGE-ICON
		 QUILBOZZA-BEACH-ICON
		 WARNING-ROOM-ICON
		 FISHY-ODOR-ICON
		 ROOM-OF-3-DOORS-ICON
		 FORK-ICON
		 WISHYFOO-ICON
		 REST-STOP-ICON
		 CROSSROADS-ICON
		 TOLL-PLAZA-ICON
		 FISSURES-EDGE-ICON
		 ORB-ROOM-ICON
		 0>>

<CONSTANT FENSHIRE-ICON-TBL
	 <LTABLE GONDOLA-ICON
		 RUINED-HALL-ICON
		 SECRET-ROOM-ICON
		 HOTHOUSE-ICON
		 MARSH-ICON
		 0>>

<CONSTANT CRAG-ICON-TBL
	 <LTABLE CRAG-ICON
		 UPPER-LEDGE-ICON
		 LOWER-LEDGE-ICON
		 IRON-MINE-ICON
		 NATURAL-ARCH-ICON
		 ENCHANTED-CAVE-ICON
		 0>>

<CONSTANT GLACIER-ICON-TBL
	 <LTABLE MIRROR-LAKE-ICON
		 CHALET-ICON
		 0>>

<CONSTANT DELTA-ICON-TBL
	 <LTABLE RIVERS-END-ICON
		 OCEANS-EDGE-ICON
		 DELTA-ICON
		 0>>

<CONSTANT FUBLIO-ICON-TBL
	 <LTABLE ON-TOP-OF-WORLD-ICON
		 AMONGST-CLOUDS-ICON
		 TIMBERLINE-ICON
		 AVALANCHE-ICON
		 ZORBEL-PASS-ICON
		 BASE-OF-MTS-ICON
		 FOOT-OF-STATUE-ICON
		 OUTSIDE-HUT-ICON
		 ATTIC-ICON
		 CAIRN-ICON
		 QUARRYS-EDGE-ICON
		 QUARRY-ICON
		 0>>

<CONSTANT ANTHARIA-ICON-TBL
	 <LTABLE STADIUM-ICON
		 COAST-ROAD-ICON
		 MINE-ENTRANCE-ICON
		 STADIUM-ICON
		 COAST-ROAD-ICON
		 MINE-ENTRANCE-ICON
		 DEAD-END-ICON
		 CLIFF-BOTTOM-ICON
		 PRECIPICE-ICON
		 AERIE-ICON
		 ICKY-CAVE-ICON
		 0>>

<ROUTINE V-MAP ("AUX" TBL RM RM-ICON CX CY CHAR)
	 ;<COND (,DEBUG
		<SET RM <FIRST? ,ROOMS>>
		<REPEAT ()
			<COND (<NOT .RM>
			       <RETURN>)>
			<FSET .RM ,TOUCHBIT>
			<SET RM <NEXT? .RM>>>
		<SETG BEEN-IN-FR-UPPER-FLOORS T>)>
	 <COND (,DEMO-VERSION?
		<NOT-IN-DEMO>
		<RFATAL>)
	       (<EQUAL? <DO-MAP> ,M-FATAL> ;"no map available, for example"
		<RFATAL>)>
	 <SET TBL <GETP ,HERE ,P?MAP-LOC>>
	 <SET CY <MAP-Y <ZGET .TBL 1>>>
	 <SET CX <MAP-X <ZGET .TBL 2>>>
	 <REPEAT ()
		 <COND (<EQUAL? 2 <ISAVE>>
			<V-$REFRESH>)>
		 <SET CHAR <BLINK <COND (<SET RM-ICON <GETP ,HERE ,P?ICON>>
					 .RM-ICON)
					(T
					 ,ICONLESS-ROOM-BOX)>
		            	  ,YOU-ARE-HERE-SYMBOL .CY .CX ,S-FULL>>
		 <COND (<EQUAL? .CHAR ,CLICK1 ,CLICK2>
			<COND (<MAP-CLICK> ;"rtrue if moved"
			       <SETG ROSE-NEEDS-UPDATING T>
			       <COND (<NOT <EQUAL? ,CURRENT-SPLIT
						   ,MAP-TOP-LEFT-LOC>>
				      ;"exit function caused you to leave map"
				      <RETURN>)
				     (<FSET? ,HERE ,DELTABIT>
				      ;"else defeats maze -- rooms stay on map"
				      <RETURN-FROM-MAP>
				      <RETURN>)
				     (,CHANGE-MAP
				      <DO-MAP>)>
			       ;"update map"
			       <SET TBL <GETP ,HERE ,P?MAP-LOC>>
			       <SET CY <MAP-Y <ZGET .TBL 1>>>
			       <SET CX <MAP-X <ZGET .TBL 2>>>)>
			<COND (<NOT <EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>>
			       <RETURN>)>)
		       (T
			<RETURN>)>>
	 <RETURN-FROM-MAP>>

<GLOBAL ROSE-NEEDS-UPDATING <>>

<GLOBAL CHANGE-MAP <>>

<ROUTINE DO-MAP ("AUX" TBL MAP-NUM RM RM-ICON)
	 <SETG CHANGE-MAP <>>
	 <COND (<AND <EQUAL? ,HERE ,GONDOLA>
		     <EQUAL? <GET <GETP ,HERE ,P?MAP-LOC> 0> <>>>
		<TELL "[Mapping is temporarily unavailable.]" CR>
		<RFATAL>)
	       (<NOT <GETP ,HERE ,P?MAP-LOC>>
		<TELL "[No on-screen map is available for this location.">
		<COND (<EQUAL? ,HERE ,CONSTRUCTION>
		       <TELL " Use the blueprint from your package.">)>
		<TELL "]" CR>
		<RFATAL>)
	       (<AND <OR <FSET? ,HERE ,DELTABIT>
			 <EQUAL? ,HERE ,RIVERS-END ,OCEANS-EDGE>>
		     <NOT ,CHANGED-MAP-WARNING>>
		<SETG CHANGED-MAP-WARNING T>
		<TELL "The jester ">
		<COND (<NOT <IN? ,JESTER ,HERE>>
		       <TELL "appears for a moment and ">)>
		<TELL
"says, \"It may seem odd and it may seem queer, but on-screen mapping
works differently here.\"" CR CR>
		<HIT-ANY-KEY>)
	       (<NOT ,MAP-NOTE>
		<SETG MAP-NOTE T>
		<TELL
"Please read the section in the manual on on-screen mapping, if you have not
already done so. Are you ready to see the map (y or n)? >">
		<COND (<NOT <Y?>>
		       <RFATAL>)>)>
	 <IF-SOUND <SETG SOUND-QUEUED? <>>
		   <KILL-SOUNDS>>
	 <PICINF ,MAP-BOX-SIZE ,PICINF-TBL>
	 <SETG MAP-BOX-WIDTH <ZGET ,PICINF-TBL 1>>
	 <SETG MAP-BOX-HEIGHT <ZGET ,PICINF-TBL 0>>
	 <PICINF ,MAP-SPACE-SIZE ,PICINF-TBL>
	 <SETG MAP-SPACE-WIDTH <ZGET ,PICINF-TBL 1>>
	 <SETG MAP-SPACE-HEIGHT <ZGET ,PICINF-TBL 0>>
	 <PICINF-PLUS-ONE ,MAP-TOP-LEFT-LOC>
	 <SETG MAP-TOP-LEFT-X <ZGET ,PICINF-TBL 1>>
	 <SETG MAP-TOP-LEFT-Y <ZGET ,PICINF-TBL 0>>
	 <PICINF ,MAP-BASIC-ELT-SIZE ,PICINF-TBL>
	 <SETG MAP-ELEMENT-WIDTH <ZGET ,PICINF-TBL 1>>
	 <SETG MAP-ELEMENT-HEIGHT <ZGET ,PICINF-TBL 0>>
	 <CLEAR -1>
	 <SCREEN ,S-FULL>
	 <SETG CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>
	 <DISPLAY ,MAP-BORDER 1 1>
	 <SET TBL <GETP ,HERE ,P?MAP-LOC>>
	 <SET MAP-NUM <GET .TBL 0>>
	 <SET RM <FIRST? ,ROOMS>>
	 <MODIFY-PICSET-TBL .MAP-NUM>
	 <PICSET ,MAP-PICSET-TBL>
	 <DRAW-TITLES .MAP-NUM>
	 <REPEAT ()
	    <COND (<NOT .RM>
		   <RETURN>)>
	    <COND (<SET TBL <GETP .RM ,P?MAP-LOC>> ;"not all rooms go on a map"
		   <COND (<AND <EQUAL? <GET .TBL 0> .MAP-NUM>
			       <OR <FSET? .RM ,TOUCHBIT>
				   <EQUAL? ,HERE .RM> ;"if you're in dark room"
				   <AND <EQUAL? .RM ,FR-OFFICES
						,OFFICES-NORTH ,OFFICES-SOUTH
						,OFFICES-EAST ,OFFICES-WEST>
					,BEEN-IN-FR-UPPER-FLOORS>>>
			  <COND (<AND <FSET? .RM ,DELTABIT>
				      <NOT <FIRST? .RM>>>
				 T)
				(<SET RM-ICON <GETP .RM ,P?ICON>>
				 <DISPLAY-ROOM .RM-ICON
					       <GET .TBL 1> <GET .TBL 2>>
				 <DRAW-CONS .RM .TBL>)
				(T
				 <DISPLAY-ROOM ,ICONLESS-ROOM-BOX
					       <GET .TBL 1> <GET .TBL 2>>
				 <DRAW-CONS .RM .TBL>)>)>)>
	    <SET RM <NEXT? .RM>>>
	 <PICINF-PLUS-ONE ,MAP-ROSE-LOC>
	 <DISPLAY ,MAP-ROSE-BG <GET ,PICINF-TBL 0> <GET ,PICINF-TBL 1>>
	 <UPDATE-MAP-ROSE>>

<ROUTINE UPDATE-MAP-ROSE ()
	 <SETG ROSE-NEEDS-UPDATING <>>
	 <PICINF-PLUS-ONE ,MAP-COMPASS-PIC-LOC>
	 <DRAW-COMPASS-ROSE ,P?NORTH ,MAP-N-HL ,MAP-N-UNHL>
	 <DRAW-COMPASS-ROSE ,P?NE ,MAP-NE-HL ,MAP-NE-UNHL>
	 <DRAW-COMPASS-ROSE ,P?EAST ,MAP-E-HL ,MAP-E-UNHL>
	 <DRAW-COMPASS-ROSE ,P?SE ,MAP-SE-HL ,MAP-SE-UNHL>
	 <DRAW-COMPASS-ROSE ,P?SOUTH ,MAP-S-HL ,MAP-S-UNHL>
	 <DRAW-COMPASS-ROSE ,P?SW ,MAP-SW-HL ,MAP-SW-UNHL>
	 <DRAW-COMPASS-ROSE ,P?WEST ,MAP-W-HL ,MAP-W-UNHL>
	 <DRAW-COMPASS-ROSE ,P?NW ,MAP-NW-HL ,MAP-NW-UNHL>>

<ROUTINE MODIFY-PICSET-TBL (MAP-NUM "AUX" TBL)
	 <SET TBL <COND (<EQUAL? .MAP-NUM ,MAIN-MAP-NUM>
			 ,MAIN-ICON-TBL)
			(<EQUAL? .MAP-NUM ,SECRET-WING-MAP-NUM>
			 ,SECRET-WING-ICON-TBL)
			(<EQUAL? .MAP-NUM ,VILLAGE-MAP-NUM>
			 ,VILLAGE-ICON-TBL)
			(<EQUAL? .MAP-NUM ,LOWER-LEVEL-MAP-NUM>
			 ,LOWER-LEVEL-ICON-TBL)
			(<EQUAL? .MAP-NUM ,LAKE-MAP-NUM>
			 ,LAKE-ICON-TBL)
			(<EQUAL? .MAP-NUM ,DESERT-MAP-NUM>
			 ,DESERT-ICON-TBL)
			(<EQUAL? .MAP-NUM ,FOOZLE-MAP-NUM>
			 ,FOOZLE-ICON-TBL)
			(<EQUAL? .MAP-NUM ,FENSHIRE-MAP-NUM>
			 ,FENSHIRE-ICON-TBL)
			(<EQUAL? .MAP-NUM ,FJORD-MAP-NUM>
			 ,CRAG-ICON-TBL)
			(<EQUAL? .MAP-NUM ,GRAY-MOUNTAINS-MAP-NUM>
			 ,GLACIER-ICON-TBL)
			(<EQUAL? .MAP-NUM ,DELTA-MAP-NUM>
			 ,DELTA-ICON-TBL)
			(<EQUAL? .MAP-NUM ,FUBLIO-MAP-NUM>
			 ,FUBLIO-ICON-TBL)
			(T
			 ,ANTHARIA-ICON-TBL)>>
	 <COPYT <REST .TBL 2> <REST ,MAP-PICSET-TBL 42> <* 2 <GET .TBL 0>>>>

<ROUTINE MAP-CLICK ("AUX" TL-X TL-Y BR-X BR-Y TOP (CNT-X 1) (CNT-Y 1)
			        (DONE <>) DIR OHERE TBL MAP-NUM)
	 <COND (<SET DIR <MAP-NEIGHBORS>>
		<DO-WALK .DIR>
		<D-APPLY "map" <GETP ,HERE ,P?ACTION> ,M-END>
		<CLOCKER>
		<RTRUE>)
	       (<SET DIR <COMPASS-CLICK ,MAP-COMPASS-PIC-LOC ,MAP-N-HL>>
		<SET OHERE ,HERE>
		<SET TBL <GETP ,HERE ,P?MAP-LOC>>
		<SET MAP-NUM <GET .TBL 0>>
		<DO-WALK .DIR>
		<COND (<EQUAL? ,HERE .OHERE>
		       <SOUND 1>
		       <RFALSE>)
		      (<SET TBL <GETP ,HERE ,P?MAP-LOC>>
		       <COND (<NOT <EQUAL? .MAP-NUM <GET .TBL 0>>>
			      <SETG CHANGE-MAP T>)>)
		      (T ;"you've entered a room that's not on the map"
		       <RETURN-FROM-MAP>)> 
		<D-APPLY "map" <GETP ,HERE ,P?ACTION> ,M-END>
		<CLOCKER>
		<RTRUE>)
	       (T
		<SOUND 1>
		<RFALSE>)>>

;"call me with a ROOM and a FUNCTION to test/act on; if this function returns
non-false, MAP-NEIGHBORS returns the direction to the neighboring room"

<ROUTINE MAP-NEIGHBORS ("AUX" DIR PT PTS TMP)
	 <MAP-DIRECTIONS (DIR PT ,HERE)
		<SET PTS <PTSIZE .PT>>
		<COND (<EQUAL? .PTS ,NEXIT>)
		      (<EQUAL? .PTS ,UEXIT ,CEXIT>
		       <SET TMP <GETB .PT ,REXIT>>
		       <COND (<CLICKED-ON-NEIGHBOR .TMP>
			      <RETURN .DIR>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <SET TMP <GETB .PT ,DEXITRM>>
		       <COND (<CLICKED-ON-NEIGHBOR .TMP>
			      <RETURN .DIR>)>)
		      (<EQUAL? .PTS ,FEXIT>
		       <SETG PRSO .DIR> ;"so exit routines return correct info"
		       <COND (<SET TMP <APPLY <GET .PT ,FEXITFCN> ,M-ENTER>>
			      <COND (<CLICKED-ON-NEIGHBOR .TMP>
				     <RETURN .DIR>)>)>)>>
	 <RFALSE>>

<ROUTINE CLICKED-ON-NEIGHBOR (RM "AUX" TL-X TL-Y BR-X BR-Y TBL MAP-NUM)
	 <SET TBL <GETP ,HERE ,P?MAP-LOC>>
	 <SET MAP-NUM <GET .TBL 0>>
	 <COND (<SET TBL <GETP .RM ,P?MAP-LOC>>
		<COND (<NOT <EQUAL? <GET .TBL 0> .MAP-NUM>>
		       <RFALSE>)>
		<SET TL-Y <MAP-Y <GET .TBL 1>>>
		<SET TL-X <MAP-X <GET .TBL 2>>>
		<PICINF ,MAP-BOX-SIZE ,PICINF-TBL>
		<SET BR-Y <+ .TL-Y <GET ,PICINF-TBL 0>>>
		<SET BR-X <+ .TL-X <GET ,PICINF-TBL 1>>>
		<COND (<WITHIN? .TL-X .TL-Y .BR-X .BR-Y>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE RETURN-FROM-MAP ()
	 <COND (<EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>
		<SETG CHANGE-MAP <>>
		<SETG CURRENT-SPLIT ,TEXT-WINDOW-PIC-LOC>
	 	<V-$REFRESH>
		<COND (<EQUAL? ,VERBOSITY 2>
		       <V-LOOK>)>
	 	<IF-SOUND <COND (,SOUND-ON?
				 <CHECK-LOOPING>)>>
		<RFATAL>)>>

;"if either POS positive, it's the top-left x or y + pos*element-width/height.
  if negative, it's the ID of a picture that gives the appropriate coordinate."

<ROUTINE MAP-X (X-POS)
	 <COND (<G? .X-POS 0>
		<PICINF-PLUS-ONE .X-POS>
		<ZGET ,PICINF-TBL 1>)
	       (T
		<+ ,MAP-TOP-LEFT-X <* <- .X-POS> ,MAP-ELEMENT-WIDTH>>)>>

<ROUTINE MAP-Y (Y-POS)
	 <COND (<G? .Y-POS 0>
		<PICINF-PLUS-ONE .Y-POS>
		<ZGET ,PICINF-TBL 0>)
	       (T
		<+ ,MAP-TOP-LEFT-Y <* <- .Y-POS> ,MAP-ELEMENT-HEIGHT>>)>>

<ROUTINE DISPLAY-ROOM (PICTURE-ID Y-POS X-POS "OPT" (Y-FUDGE 0) (X-FUDGE 0))
  <DISPLAY .PICTURE-ID
	   <+ .Y-FUDGE <MAP-Y .Y-POS>> <+ .X-FUDGE <MAP-X .X-POS>>>>

<ROUTINE DRAW-TITLES (MAP-NUM "AUX" TMP TMP1)
	 <COND (<EQUAL? .MAP-NUM ,MAIN-MAP-NUM>
		<DISPLAY-ROOM ,MAIN-TITLE ,MAIN-TITLE-LOC ,MAIN-TITLE-LOC>
		<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-1 ,MAP-GEN-X-1>
		<COND (<FSET? ,CHAPEL ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-EAST-SYMBOL ,MAP-GEN-Y-6
				     ,MAP-GEN-X-8 0 ,MAP-BOX-WIDTH>)>
		<COND (<FSET? ,GREAT-HALL ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-NE-SYMBOL ,MAP-GEN-Y-4 ,MAP-GEN-X-5
				     <- ,MAP-BOX-HEIGHT 2>
				     <- <+ ,MAP-SPACE-WIDTH 2>>>
		       <DISPLAY-ROOM ,DOWN-SE-SYMBOL ,MAP-GEN-Y-4 ,MAP-GEN-X-5
				     <- ,MAP-BOX-HEIGHT 2>
				     <- ,MAP-BOX-WIDTH 2>>)>)
	       (<EQUAL? .MAP-NUM ,SECRET-WING-MAP-NUM>
		<DISPLAY-ROOM ,SECRET-WING-TITLE
			      ,SECRET-WING-TITLE-LOC ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-1 ,MAP-GEN-X-8>
		<COND (<FSET? ,CRYPT ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-EAST-SYMBOL ,MAP-GEN-Y-3
				     ,MAP-GEN-X-8 0 ,MAP-BOX-WIDTH>)>)
	       (<EQUAL? .MAP-NUM ,VILLAGE-MAP-NUM>
	 	<DISPLAY-ROOM ,VILLAGE-TITLE ,MAP-GEN-Y-5 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,VERTICAL-LEGEND ,MAP-GEN-Y-1 ,MAP-GEN-X-10>
		<COND (<AND <FSET? ,SHADY-PARK ,TOUCHBIT>
			    <FSET? ,VILLAGE-CENTER ,TOUCHBIT>>
		       <DISPLAY-ROOM ,E-W-CON ,MAP-GEN-Y-3 ,MAP-GEN-X-6>
		       <SET TMP <MAP-X ,5-FUDGE>>
		       <DISPLAY-ROOM ,E-W-CON
				     ,MAP-GEN-Y-3 ,MAP-GEN-X-6 0 .TMP>
		       <DISPLAY-ROOM ,E-W-CON
				     ,MAP-GEN-Y-3 ,MAP-GEN-X-6 0 <* .TMP 2>>
		       <DISPLAY-ROOM ,E-W-CON
				     ,MAP-GEN-Y-3 ,MAP-GEN-X-6 0 <* .TMP 3>>)>
		<COND (<FSET? ,FR-HQ ,TOUCHBIT>
		       <DISPLAY-ROOM ,LOBBY-OFFICE-CON
				     ,MAP-GEN-Y-3 ,MAP-GEN-X-8
				     <- ,MAP-BOX-HEIGHT 2>
				     <- ,MAP-BOX-WIDTH 2>>)>
		<COND (,BEEN-IN-FR-UPPER-FLOORS
		       <DISPLAY-ROOM ,OFFICE-PENTHOUSE-CON
				     ,MAP-GEN-Y-5 ,MAP-GEN-X-8
				     <- ,MAP-BOX-HEIGHT 2>
				     <- ,MAP-BOX-WIDTH 2>>)>)
	       (<EQUAL? .MAP-NUM ,LOWER-LEVEL-MAP-NUM>
	 	<DISPLAY-ROOM ,LOWER-LEVEL-TITLE ,MAP-GEN-Y-5 ,MAP-GEN-X-9>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-2 ,MAP-GEN-X-8>
		<COND (<FSET? ,LOWEST-HALL ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-SW-SYMBOL ,MAP-GEN-Y-4 ,MAP-GEN-X-4
				     <- ,MAP-BOX-HEIGHT 2>
				     <- ,MAP-BOX-WIDTH 2>>
		       <DISPLAY-ROOM ,LOW-HALL-CON ,MAP-GEN-Y-5
				     ,MAP-GEN-X-4 0 ,MAP-BOX-WIDTH>)>
		<COND (<FSET? ,LOWER-HALL ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-WEST-SYMBOL ,MAP-GEN-Y-5
				     ,MAP-GEN-X-6 0 ,MAP-BOX-WIDTH>)>)
	       (<EQUAL? .MAP-NUM ,LAKE-MAP-NUM>
	 	<DISPLAY-ROOM ,LAKE-TITLE
			      ,LAKE-TITLE-LOC ,LAKE-TITLE-LOC>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-6 ,MAP-GEN-X-8>
	 	<COND (<FSET? ,HOLD ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-SOUTH-SYMBOL ,MAP-GEN-Y-4
				     ,MAP-GEN-X-1 ,MAP-BOX-HEIGHT>
		       <DISPLAY-ROOM ,DOWN-SOUTH-SYMBOL ,MAP-GEN-Y-5
				     ,MAP-GEN-X-1 ,MAP-BOX-HEIGHT>)>
	 	<COND (<FSET? ,UNDERWATER ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-SOUTH-SYMBOL ,MAP-GEN-Y-6
				     ,MAP-GEN-X-1 ,MAP-BOX-HEIGHT>)>
	        <COND (<FSET? ,GROTTO ,TOUCHBIT>
		       <DISPLAY-ROOM ,N-S-CON ,MAP-GEN-Y-4 ,MAP-GEN-X-7>
		       <SET TMP <MAP-Y ,5-FUDGE>>
		       <DISPLAY-ROOM ,N-S-CON
				     ,MAP-GEN-Y-4 ,MAP-GEN-X-7 .TMP>
		       <DISPLAY-ROOM ,N-S-CON
				     ,MAP-GEN-Y-4 ,MAP-GEN-X-7 <* .TMP 2>>
		       <DISPLAY-ROOM ,N-S-CON
				     ,MAP-GEN-Y-4 ,MAP-GEN-X-7 <* .TMP 3>>)>
	 	<COND (<FSET? ,CONDUCTOR-PIT ,TOUCHBIT>
		       <DISPLAY-ROOM ,DOWN-WEST-SYMBOL ,MAP-GEN-Y-3
				     ,MAP-GEN-X-3 0 ,MAP-BOX-WIDTH>)>)
	       (<EQUAL? .MAP-NUM ,DESERT-MAP-NUM>
		<DISPLAY-ROOM ,DESERT-TITLE ,MAP-GEN-Y-2 ,MAP-GEN-X-2>
		<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-3 ,MAP-GEN-X-8>)
	       (<EQUAL? .MAP-NUM ,FOOZLE-MAP-NUM>
	 	<DISPLAY-ROOM ,FOOZLE-TITLE ,MAP-GEN-Y-1 ,MAP-GEN-X-2>
	 	<DISPLAY-ROOM ,VERTICAL-LEGEND ,MAP-GEN-Y-1 ,MAP-GEN-X-10>
	 	<DISPLAY-ROOM ,FOOZLE-MAP-ILL ,MAP-GEN-Y-6 ,MAP-GEN-X-8>
		<COND (<FSET? ,WISHYFOO-TERRITORY ,TOUCHBIT>
		       <DISPLAY-ROOM ,WISHYFOO-FORK-CON ,MAP-GEN-Y-4
				     ,MAP-GEN-X-4 ,MAP-BOX-HEIGHT>)>
		<COND (<FSET? ,CAVE-IN ,TOUCHBIT>
		       <DISPLAY-ROOM ,E-W-CON ,MAP-GEN-Y-3
				     ,MAP-GEN-X-8 0 ,MAP-BOX-WIDTH>)>
	 	<COND (<FSET? ,FISSURE-EDGE ,TOUCHBIT>
		       <DISPLAY-ROOM ,N-S-CON ,MAP-GEN-Y-4
				     ,MAP-GEN-X-7 ,MAP-BOX-HEIGHT>)>)
	       (<EQUAL? .MAP-NUM ,FENSHIRE-MAP-NUM>
	 	<DISPLAY-ROOM ,FENSHIRE-TITLE ,MAP-GEN-Y-3 ,MAP-GEN-X-5>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-6 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,FENSHIRE-MAP-ILL ,MAP-GEN-Y-5 ,MAP-GEN-X-6>)
	       (<EQUAL? .MAP-NUM ,FJORD-MAP-NUM>
	 	<DISPLAY-ROOM ,FJORD-TITLE ,MAP-GEN-Y-2 ,MAP-GEN-X-8>
		<DISPLAY-ROOM ,VERTICAL-LEGEND ,MAP-GEN-Y-1 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,FJORD-MAP-ILL ,MAP-GEN-Y-6 ,MAP-GEN-X-5>
		<DISPLAY-ROOM ,RV-TELEPORT-ARROW
			      ,MAP-GEN-Y-4 ,MAP-GEN-X-4 ,MAP-BOX-HEIGHT>
		<COND (<AND <FSET? ,CRAG ,TOUCHBIT>
			    <FSET? ,NATURAL-ARCH ,TOUCHBIT>>
		       <DISPLAY-ROOM ,ARCH-N-CON
				     ,MAP-GEN-Y-4 ,MAP-GEN-X-4
				     <+ <- <MAP-Y ,ARCH-N-CON-SIZE>> 1>
				     ,MAP-BOX-WIDTH>
		       <DISPLAY-ROOM ,ARCH-S-CON
				     ,MAP-GEN-Y-4 ,MAP-GEN-X-4
				     ,MAP-BOX-HEIGHT
				     ,MAP-BOX-WIDTH>)>)
	       (<EQUAL? .MAP-NUM ,GRAY-MOUNTAINS-MAP-NUM>
		<DISPLAY-ROOM ,GRAY-MTS-TITLE ,MAP-GEN-Y-5 ,MAP-GEN-X-7>
		<DISPLAY-ROOM ,VERTICAL-LEGEND ,MAP-GEN-Y-1 ,MAP-GEN-X-2>
	 	<DISPLAY-ROOM ,GRAY-MTS-MAP-ILL ,MAP-GEN-Y-5 ,MAP-GEN-X-1>
		<DISPLAY-ROOM ,RV-TELEPORT-ARROW
			      ,MAP-GEN-Y-1 ,MAP-GEN-X-10 ,MAP-BOX-HEIGHT>
		<COND (<FSET? ,GLACIER ,TOUCHBIT>
		       <DISPLAY-ROOM ,GLACIER-MIRROR-CON
				     ,MAP-GEN-Y-1 ,MAP-GEN-X-8
				     <- ,MAP-BOX-HEIGHT 2>
				     <- ,MAP-BOX-WIDTH 2>>)>)
	       (<EQUAL? .MAP-NUM ,DELTA-MAP-NUM>
	 	<DISPLAY-ROOM ,DELTA-TITLE ,MAP-GEN-Y-6 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-3 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,DELTA-MAP-ILL ,MAP-GEN-Y-1 ,MAP-GEN-X-1>
		<DISPLAY-ROOM ,RV-TELEPORT-ARROW
			      ,MAP-GEN-Y-5 ,MAP-GEN-X-10 ,MAP-BOX-HEIGHT>
		<COND (<AND <FIRST? ,DELTA-1>
			    <FIRST? ,DELTA-2>>
		       <DISPLAY-ROOM ,ARCH-S-CON
				     ,MAP-GEN-Y-5 ,MAP-GEN-X-8
				     ,MAP-BOX-HEIGHT ,MAP-BOX-WIDTH>
		       <DISPLAY-ROOM ,ARCH-N-CON
				     ,MAP-GEN-Y-5 ,MAP-GEN-X-8
				     <+ <- <MAP-Y ,ARCH-N-CON-SIZE>> 1>
				     ,MAP-BOX-WIDTH>)>
		<COND (<AND <FIRST? ,DELTA-1>
			    <FIRST? ,DELTA-3>>
		       <DISPLAY-ROOM ,DELTA-1-3-CON ,MAP-GEN-Y-3 ,MAP-GEN-X-8
				  <- </ ,MAP-BOX-HEIGHT 2> 1> ,MAP-BOX-WIDTH>)>
		<COND (<AND <FIRST? ,DELTA-1>
			    <FIRST? ,DELTA-4>>
		       <DISPLAY-ROOM ,DELTA-1-4-CON ,MAP-GEN-Y-2 ,MAP-GEN-X-9
				     0 ,MAP-BOX-WIDTH>)>
		<COND (<AND <FIRST? ,DELTA-2>
			    <FIRST? ,DELTA-7>>
		       <DISPLAY-ROOM ,RUBBLE-SE-CON
				     ,MAP-GEN-Y-5 ,MAP-GEN-X-7
				     ,MAP-BOX-HEIGHT ,MAP-BOX-WIDTH>)>
		<COND (<AND <FIRST? ,DELTA-2>
			    <FIRST? ,DELTA-3>>
		       <DISPLAY-ROOM ,DELTA-2-3-CON
				     ,MAP-GEN-Y-3 ,MAP-GEN-X-8 ,MAP-BOX-HEIGHT
				     <+ <- <MAP-X ,2-3-CON-SIZE>> 1>>)>
		<COND (<AND <FIRST? ,DELTA-3>
			    <FIRST? ,DELTA-4>>
		       <DISPLAY-ROOM ,RUBBLE-NW-CON
				    ,MAP-GEN-Y-3 ,MAP-GEN-X-9
				    <- <- <MAP-Y ,RUBBLE-CON-SIZE>> 1>
				    <- <- <MAP-X ,RUBBLE-CON-SIZE>> 1>>)>
		<COND (<AND <FIRST? ,DELTA-3>
			    <FIRST? ,DELTA-5>>
		       <DISPLAY-ROOM ,DELTA-3-5-CON
				     ,MAP-GEN-Y-2 ,MAP-GEN-X-8
				     ,MAP-BOX-HEIGHT
				     <+ <- <MAP-X ,3-5-CON-SIZE>> 1>>)>
		<COND (<AND <FIRST? ,DELTA-4>
			    <FIRST? ,DELTA-5>>
		       <DISPLAY-ROOM ,ARCH-N-CON
				     ,MAP-GEN-Y-2 ,MAP-GEN-X-7
				     <+ <- <MAP-Y ,ARCH-N-CON-SIZE>> 1>
				     ,MAP-BOX-WIDTH>)>
		<COND (<AND <FIRST? ,DELTA-5>
			    <FIRST? ,DELTA-6>
			    <FSET? ,DELTA-6 ,TOUCHBIT>>
		       <DISPLAY-ROOM ,DELTA-5-6-CON
				     ,MAP-GEN-Y-2 ,MAP-GEN-X-7
				     ,MAP-BOX-HEIGHT
				     <+ <- <MAP-X ,5-6-CON-SIZE>> 1>>)>
		<COND (<AND <FIRST? ,DELTA-6>
			    <FSET? ,DELTA-6 ,TOUCHBIT>
			    <FIRST? ,DELTA-7>>
		       <DISPLAY-ROOM ,DELTA-6-7-CON
				     ,MAP-GEN-Y-5 ,MAP-GEN-X-7
				     0 <- <MAP-X ,6-7-CON-SIZE>>>)>)
	       (<EQUAL? .MAP-NUM ,FUBLIO-MAP-NUM>
	 	<DISPLAY-ROOM ,FUBLIO-TITLE ,MAP-GEN-Y-2 ,MAP-GEN-X-9>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-4 ,MAP-GEN-X-1>
		<DISPLAY-ROOM ,TELEPORT-ARROW ,MAP-GEN-Y-4 ,MAP-GEN-X-8
			      <- <MAP-Y ,TELEPORT-ARROW-SIZE>>>)
	       (<EQUAL? .MAP-NUM ,ANTHARIA-MAP-NUM>
	 	<DISPLAY-ROOM ,ANTHARIA-TITLE ,MAP-GEN-Y-5 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,HORIZONTAL-LEGEND ,MAP-GEN-Y-6 ,MAP-GEN-X-1>
	 	<DISPLAY-ROOM ,ANTHARIA-MAP-ILL ,MAP-GEN-Y-1 ,MAP-GEN-X-1>
		<DISPLAY-ROOM ,TELEPORT-ARROW ,MAP-GEN-Y-4 ,MAP-GEN-X-8
			      <- <MAP-Y ,TELEPORT-ARROW-SIZE>>>
		<COND (<AND <FSET? ,RUBBLE-ROOM ,TOUCHBIT>
			    <FSET? ,HEART-OF-MINE ,TOUCHBIT>>
		       <DISPLAY-ROOM ,RUBBLE-SE-CON
				     ,MAP-GEN-Y-3 ,MAP-GEN-X-9
				     ,MAP-BOX-HEIGHT ,MAP-BOX-WIDTH>
		       <DISPLAY-ROOM ,RUBBLE-NW-CON
				    ,MAP-GEN-Y-4 ,MAP-GEN-X-10
				    <- <- <MAP-Y ,RUBBLE-CON-SIZE>> 1>
				    <- <- <MAP-X ,RUBBLE-CON-SIZE>> 1>>)>
		<COND (<FSET? ,NORTH-OF-ANTHAR ,TOUCHBIT>
		       <DISPLAY-ROOM ,N-S-CON ,MAP-GEN-Y-6 ,MAP-GEN-X-6
				     ,MAP-BOX-HEIGHT>)>)>>

<ROUTINE DRAW-CONS (RM TBL "AUX" Y X PTS NEXT-RM NEXT-TBL NEXT-Y NEXT-X)
 <SET Y <MAP-Y <GET .TBL 1>>>
 <SET X <MAP-X <GET .TBL 2>>>
 <COND (<SHOW-DIRECTION? .RM ,P?NORTH>
	<DISPLAY ,N-S-CON <- .Y ,MAP-SPACE-HEIGHT> .X>)>
 <COND (<SHOW-DIRECTION? .RM ,P?NE>
	<DISPLAY ,NE-SW-CON
		 <- .Y ,MAP-SPACE-HEIGHT> <+ .X ,MAP-BOX-WIDTH>>)>
 <COND (<SHOW-DIRECTION? .RM ,P?EAST>
	<DISPLAY ,E-W-CON .Y <+ .X ,MAP-BOX-WIDTH>>)>
 <COND (<SHOW-DIRECTION? .RM ,P?SE>
	<DISPLAY ,NW-SE-CON
		 <+ .Y ,MAP-BOX-HEIGHT> <+ .X ,MAP-BOX-WIDTH>>)>
 <COND (<SHOW-DIRECTION? .RM ,P?SOUTH>
	<DISPLAY ,N-S-CON <+ .Y ,MAP-BOX-HEIGHT> .X>)>
 <COND (<SHOW-DIRECTION? .RM ,P?SW>
	<DISPLAY ,NE-SW-CON
		 <+ .Y ,MAP-BOX-HEIGHT> <- .X ,MAP-SPACE-WIDTH>>)>
 <COND (<SHOW-DIRECTION? .RM ,P?WEST>
	<DISPLAY ,E-W-CON .Y <- .X ,MAP-SPACE-WIDTH>>)>
 <COND (<SHOW-DIRECTION? .RM ,P?NW>
	<DISPLAY ,NW-SE-CON
		 <- .Y ,MAP-SPACE-HEIGHT> <- .X ,MAP-SPACE-WIDTH>>)>
 <COND (<SET PTS <GETPT .RM ,P?DOWN>>
	<COND (<EQUAL? <PTSIZE .PTS> ,UEXIT ,CEXIT>
	       <SET NEXT-RM <GETB .PTS ,REXIT>>)
	      (<EQUAL? <PTSIZE .PTS> ,DEXIT>
	       <SET NEXT-RM <GETB .PTS ,DEXITRM>>)>
	<COND (<AND <EQUAL? .RM ,LOWER-HALL>
		    <FSET? ,LOWEST-HALL ,TOUCHBIT>>
	       T)
	      (<EQUAL? .RM ,WISHYFOO-TERRITORY>
	       T)
	      (<AND .NEXT-RM
		    <SET NEXT-TBL <GETP .NEXT-RM ,P?MAP-LOC>>
		    <EQUAL? <GET .NEXT-TBL 0> <GET .TBL 0>>>
	       <SET NEXT-Y <MAP-Y <GET .NEXT-TBL 1>>>
	       <SET NEXT-X <MAP-X <GET .NEXT-TBL 2>>>
	       <COND (<EQUAL? .X .NEXT-X>
		      <COND (<G? .Y .NEXT-Y>
			     <DISPLAY ,DOWN-NORTH-SYMBOL
				      <- .Y ,MAP-SPACE-HEIGHT> .X>)
			    (T
			     <DISPLAY ,DOWN-SOUTH-SYMBOL
				      <+ .Y ,MAP-BOX-HEIGHT> .X>)>)
		     (<EQUAL? .Y .NEXT-Y>
		      <COND (<G? .X .NEXT-X>
			     <DISPLAY ,DOWN-WEST-SYMBOL
				      .Y <- .X ,MAP-SPACE-WIDTH>>)
			    (T
			     <DISPLAY ,DOWN-EAST-SYMBOL
				      .Y <+ .X ,MAP-BOX-WIDTH>>)>)>)>)>
 <SET NEXT-RM <>> ;"it might not be, if it got set by the DOWN clause"
 <COND (<SET PTS <GETPT .RM ,P?UP>>
	<COND (<EQUAL? <PTSIZE .PTS> ,UEXIT ,CEXIT>
	       <SET NEXT-RM <GETB .PTS ,REXIT>>)
	      (<EQUAL? <PTSIZE .PTS> ,DEXIT>
	       <SET NEXT-RM <GETB .PTS ,DEXITRM>>)>
	<COND (<AND .NEXT-RM
		    <SET NEXT-TBL <GETP .NEXT-RM ,P?MAP-LOC>>
		    <EQUAL? <GET .NEXT-TBL 0> <GET .TBL 0>>>
	       <SET NEXT-Y <MAP-Y <GET .NEXT-TBL 1>>>
	       <SET NEXT-X <MAP-X <GET .NEXT-TBL 2>>>
	       <COND (<EQUAL? .X .NEXT-X>
		      <COND (<G? .Y .NEXT-Y>
			     <DISPLAY ,DOWN-SOUTH-SYMBOL
				      <- .Y ,MAP-SPACE-HEIGHT> .X>)
			    (T
			     <DISPLAY ,DOWN-NORTH-SYMBOL
				      <+ .Y ,MAP-BOX-HEIGHT> .X>)>)
		     (<EQUAL? .Y .NEXT-Y>
		      <COND (<G? .X .NEXT-X>
			     <DISPLAY ,DOWN-EAST-SYMBOL
				      .Y <- .X ,MAP-SPACE-WIDTH>>)
			    (T
			     <DISPLAY ,DOWN-WEST-SYMBOL
				      .Y <+ .X ,MAP-BOX-WIDTH>>)>)>)>)>>

<ROUTINE V-MAYBE ()
	 <YOU-SOUND "indecis">>

<ROUTINE V-MEET ()
	 <PERFORM ,V?TELL ,PRSO>
	 <RTRUE>>

<ROUTINE V-MEASURE ()
	 <COND (<OR <FSET? ,PRSO ,PARTBIT>
		    <PRSO? ,ME>>
		<TELL "Usual size." CR>)
	       (T
	 	<TELL "The same size as any other " D ,PRSO ,PERIOD-CR>)>>

<ROUTINE V-MIRROR-LOOK ()
	 <COND (<IN? ,PRSO ,PRSI>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "But" T ,PRSO " isn't in" TR ,PRSI>)>>

<ROUTINE V-MOVE ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<WASTES>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		<PART-OF>)
	       (<LOC-CLOSED ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving" T ,PRSO " reveals nothing." CR>)
	       (<EQUAL? ,P-PRSA-WORD ,W?PULL>
		<HACK-HACK "Pulling">)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?MOVE>
		     <PRSO? ,INTDIR>>
		<DO-WALK <DIRECTION-CONVERSION>>)
	       (T
		<CANT-VERB-A-PRSO "move">)>>

<ROUTINE V-MOVE-DIR ()
	 <TELL "Pick up" T ,PRSO " and go that way!" CR>>

<ROUTINE V-MOVE-TO ()
	 <COND (<NOT <ULTIMATELY-IN? ,PRSO>>
		<TELL ,YNH TR ,PRSO>)
	       (T
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-MUNG ()
         <HACK-HACK "Trying to destroy">>

<ROUTINE V-NO ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<V-YES>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<TELL "\"You're right, you don't. I do.\"" CR>)
	       (T
		<YOU-SOUND "negat">)>>

;<ROUTINE V-NO-VERB ()
	 <COND (<NOUN-USED? ,ME ,W?I>
		<V-INVENTORY>)
	       (,ORPHAN-FLAG
		<WASTES>)
	       (<NOT <VISIBLE? ,PRSO>>
		<CANT-SEE ,PRSO>)
	       ;(<FSET? ,PRSO ,ACTORBIT> 
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)
	       (,P-CONT
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)
	       (T
		;<TELL "[Examine" T ,PRSO "]" CR CR>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)>>

;<GLOBAL ORPHAN-FLAG <>>

;<ROUTINE I-ORPHAN ()
	 <SETG ORPHAN-FLAG <>>
	 <RFALSE>>

<ROUTINE NO-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?NO ,W?NOPE>
		    <EQUAL? .WRD ,W?NAH ,W?UH-UH>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <FCLEAR ,PRSO ,ONBIT>
		       <FCLEAR ,PRSO ,FLAMEBIT>
		       <TELL "Okay," T ,PRSO " is now o">
		       <COND (<PRSO? ,CANDLE>
			      <TELL "ut">)
			     (T
			      <TELL "ff">)>
		       <TELL ,PERIOD-CR>
		       <NOW-DARK?>)
		      (T
		       <TELL "It isn't on!" CR>)>)
	       (T
		<CANT-TURN "ff">)>>

<ROUTINE V-ON ()
	 <COND ;(<FSET? ,PRSO ,ACTORBIT>
		<TELL "Hopefully, your sexy body will do the trick." CR>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now on." CR>
		       <NOW-LIT?>)>)
	       (T
		<CANT-TURN "n">)>>

<ROUTINE V-OPEN ()
	 <COND (<AND ,PRSI
		     <FSET? ,PRSI ,KEYBIT>>
		<PERFORM ,V?UNLOCK ,PRSO ,PRSI>
		<RTRUE>)
	       (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <AND <FSET? ,PRSO ,VEHBIT>
			 <NOT <PRSO? ,DB ,LADDER
				     ,IRON-MAIDEN ,SNAKE-PIT ,WATER-CHAMBER>>>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,OPENBIT>
		<TELL ,ALREADY-IS>)
	       (<FSET? ,PRSO ,LOCKEDBIT>
		<TELL "The " D ,PRSO " is locked." CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<FSET ,PRSO ,OPENBIT>
		<TELL "The " D ,PRSO " swings open." CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<FSET ,PRSO ,OPENBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<OR <NOT <FIRST? ,PRSO>>
			   <FSET? ,PRSO ,TRANSBIT>
			   <PRSO? ,DB>>
		       <TELL "Opened." CR>)
		      (T
		       <TELL "Opening" T ,PRSO " reveals">
		       <COND (<NOT <D-NOTHING>>
			      <TELL ,PERIOD-CR>)>
		       <NOW-LIT?>)>
		<RTRUE>)
	       (T
		<YOU-MUST-TELL-ME>)>>

<ROUTINE V-PAY ("AUX" (MONEY <>))
	 <COND (<ULTIMATELY-IN? ,ZORKMID-BILL>
		<SET MONEY ,ZORKMID-BILL>)
	       (<ULTIMATELY-IN? ,ZORKMID-COIN>
		<SET MONEY ,ZORKMID-COIN>)>
	 <COND (.MONEY
		<PERFORM ,V?GIVE .MONEY ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have no money!" CR>)>>

<ROUTINE V-PICK ()
	 <CANT-VERB-A-PRSO "pick">>

<ROUTINE V-PLAY ()
	 <CANT-VERB-A-PRSO "play">>

<ROUTINE V-POINT ()
	 <TELL "That would be pointless." CR>>

<ROUTINE V-POUR ()
	 <IMPOSSIBLES>>

<ROUTINE V-PRAY ()
	 <COND (<AND <NOT ,PRSO>
		     <EQUAL? ,HERE ,ORACLE>>
		<PERFORM ,V?PRAY ,ORACLE-OBJECT>
		<RTRUE>)
	       (T
		<TELL
"If you pray long enough, your prayers may be answered." CR>)>>

;<ROUTINE V-PULL-OVER ()
	 <HACK-HACK "Pulling">>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-DIR ()
	 <V-PUSH>>

;<ROUTINE V-PUSH-OFF ()
	 <COND (<AND <PRSO? ,ROOMS ,DOCK-OBJECT ,RAFT ,BARGE>
		     <NOT <IN? ,PROTAGONIST ,HERE>>>
		<PERFORM ,V?LAUNCH <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<TELL ,HUH>)>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSI? ,GROUND ,CEILING>
		<COND (<AND <PRSO? ,N-S-PASSAGE ,NW-SE-PASSAGE>
		            <VERB? PUT>>
		       <TELL "You can only install the passage in a wall!" CR>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)
	       (<PRSO? ,HANDS>
		<COND (<AND <VERB? PUT-ON PUT>
			    <FSET? ,PRSI ,PARTBIT>>
		       <RFALSE>)
		      (<VERB? PUT>
		       <PERFORM ,V?REACH-IN ,PRSI>
		       <RTRUE>)
		      (<AND <VERB? PUT-ON>
			    <PRSI? ,STRAW>>
		       <SETG FINGER-ON-STRAW T>
		       <COND (<IN? ,STRAW ,BOWL>
			      <SETG ELIXIR-TRAPPED T>)>
		       <QUEUE I-FINGER-OFF-STRAW 2>
		       <TELL
"You put your finger over the end of the straw." CR>)
		      (T
		       <IMPOSSIBLES>)>)
	       (<AND <PRSO? ,GLOVE>
		     <PRSI? ,HANDS>>
		<PERFORM ,V?WEAR ,GLOVE>
		<RTRUE>)
	       (<IN? ,PRSO ,WALDO>
		<TELL
"The waldo seems incapable of more than just picking something up
and dropping it." CR>)
	       (<AND <NOT <FSET? ,PRSI ,PARTBIT>>
		     <PRE-LOOK>>		     
		<RTRUE>)
	       (<ULTIMATELY-IN? ,PRSI ,PRSO>		      
		<TELL ,YOU-CANT "put" T ,PRSO>
		<COND (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?ON>
		       ;<FSET? ,PRSO ,SURFACEBIT>
		       ;<EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?ON>
		       <TELL " on">)
		      (T
		       <TELL " in">)>
		<TELL T ,PRSI " when" T ,PRSI " is already ">
		<COND (<FSET? ,PRSO ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSO "!" CR>)
	       (<UNTOUCHABLE? ,PRSI>
		<CANT-REACH ,PRSI>)
	       ;(,IN-FRONT-FLAG  ;"you dont have to have it"
		<PERFORM ,V?PUT-IN-FRONT ,PRSO ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-PUT ()
	 <COND (<FSET? ,PRSI ,WATERBIT>
		<COND (<PRSO? ,SMALL-VIAL ,LARGE-VIAL>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSO ,WATER>)>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<TELL "How can you do that?" CR>)
	       (<FSET? ,PRSI ,DOORBIT>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<DO-FIRST "open" ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<TELL ,HUH>)
	       (<AND <G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
			    <GETP ,PRSI ,P?SIZE>>
		    	 <GETP ,PRSI ,P?CAPACITY>>
		     <NOT <ULTIMATELY-IN? ,PRSO ,PRSI>>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (<AND <PRSO? ,FOX ,ROOSTER ,WORM>
		     <FSET? ,PRSO ,ANIMATEDBIT>>
		<TELL "You try, but" T ,PRSO " seems agitated and ">
		<COND (<PRSO? ,FOX>
		       <TELL "slyly jumps">)
		      (<PRSO? ,ROOSTER>
		       <TELL "hops">)
		      (T
		       <TELL "wriggles">)>
		<TELL " out." CR>) 
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>
		<SCORE-OBJ ,PRSO>)>>

<ROUTINE V-PUT-BEHIND ()
	 <WASTES>>

;<ROUTINE V-PUT-NEAR ()
	 <WASTES>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (<AND <FSET? ,PRSI ,ACTORBIT>
		     <FSET? ,PRSO ,WEARBIT>>
		<TELL "But it's not" T ,PRSI"'s size." CR>)
	       (T
		<TELL "There's no good surface on" TR ,PRSI>)>>

<ROUTINE V-PUT-THROUGH ()
	 <COND (<FSET? ,PRSI ,DOORBIT>
		<COND (<FSET? ,PRSI ,OPENBIT>
		       <V-THROW>)
		      (T
		       <DO-FIRST "open" ,PRSI>)>)
	       (<AND <PRSI? <LOC ,PROTAGONIST>>
		     <EQUAL? ,P-PRSA-WORD ,W?THROW ,W?TOSS ,W?HURL>>
		<SETG PRSI <>>
		<V-THROW>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-PUT-TO ()
	 <WASTES>>

<ROUTINE V-PUT-UNDER ()
         <WASTES>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

<ROUTINE PRE-RESEARCH ()
	 <COND (<AND <NOT ,PRSI>
		     <EQUAL? ,HERE ,LIBRARY>>
		<SETG PRSI ,ENCYCLOPEDIA>)>
	 <COND (<PRSO? ,ROOMS> ;"input was LOOK UP"
		<COND (<NOT ,LIT>
		       <TELL ,TOO-DARK CR>)
		      (<EQUAL? ,HERE ,ON-TOP-OF-THE-WORLD>
		       <PERFORM ,V?EXAMINE ,BROGMOID>
		       <RTRUE>)
		      (<FSET? ,HERE ,OUTSIDEBIT>
		       <TELL "Sunlight filters through heavy cloud cover." CR>)
		      (<EQUAL? ,HERE ,ON-TOP-OF-THE-WORLD>
		       <TELL
"You see a gray misty void, stretching upward as far as you can see." CR>)
		      (T
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)>)
	       (<NOT ,LIT>
		<PERFORM ,V?READ ,ENCYCLOPEDIA>
		<RTRUE>)
	       (<NOT ,PRSI>
		<TELL "There's no encyclopedia here to look it up in." CR>)
	       (<NOT <EQUAL? ,PRSI ,ENCYCLOPEDIA>>
		<TELL ,YOU-CANT "read about things in" AR ,PRSI>)
	       (T
		<SETG VOLUME-USED T>
		<RFALSE>)>>

<ROUTINE V-RESEARCH ("AUX" ENTRY PIC-NUM)
	 <COND (<SET ENTRY <GETP ,PRSO ,P?RESEARCH>>
		<TELL .ENTRY CR>)
	       (<EQUAL? ,PRSO ,INTQUOTE>
		<COND (<EQUAL? <GET <NP-LEXBEG <SET ENTRY <GET-NP ,PRSO>>> 0>
			       ,W?QUOTE>
		       <CHANGE-LEXV <NP-LEXBEG .ENTRY> ,W?NO.WORD>)>
		<COND (<EQUAL? <GET <NP-LEXEND .ENTRY> 0>
			       ,W?QUOTE>
		       <CHANGE-LEXV <NP-LEXEND .ENTRY> ,W?NO.WORD>)>
		;<DO-IT-AGAIN>
		<SETG P-CONT <GET ,OOPS-TABLE ,O-START>>
		<SETG P-LEN ,P-WORDS-AGAIN>
		<TELL "[Uh, the quotation marks confused me...]" CR>)
	       (T
		<TELL "You look up \"">
		<NP-PRINT <GET-NP ,PRSO>>
		<TELL "\" in the encyclopedia, but find no entry." CR>)>>

<ROUTINE V-SRESEARCH ()
	 <PERFORM ,V?RESEARCH ,PRSI ,PRSO>
	 <RTRUE>>

;<ROUTINE V-RAPE ()
	 <TELL "Unacceptably ungallant behavior." CR>>

<ROUTINE V-SRIDE-DIR ()
	 <PERFORM ,V?RIDE-DIR ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-RIDE-DIR ()
	 <COND (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<TELL "But you're not even ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" TR ,PRSO>)
	       (<PRSI? ,INTDIR>
		<DO-WALK <WORD-DIR-ID <NP-NAME <GET-NP ,PRSI>>>>)
	       (<PRSO? ,CAMEL>
		<TELL "Please use directions, as in RIDE CAMEL WEST." CR>)
	       (T
		<TELL "How can you do that?" CR>)>>

;<ROUTINE V-RIDE-TO ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?ENTER .V>
		<RTRUE>)
	       (T
		<TELL ,THERES-NOTHING "to ride." CR>)>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<FSET? ,PRSO ,WATERBIT>
		<PERFORM-PRSA ,WATER>)
	       (<OR <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>
		    <NOT <FSET? ,PRSO ,CONTBIT>>>
		<YUKS>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TRYTAKEBIT>>>
		<TELL ,THERES-NOTHING "in" TR ,PRSO>)
	       (T
		<TELL "You feel something inside" TR ,PRSO>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <CANT-VERB-A-PRSO "read">)>>

;<ROUTINE V-RELIEVE ()
	 <TELL ,HUH>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ROLL ()
	 <TELL "A rolling " D ,PRSO " gathers no moss." CR>>

<ROUTINE V-ROLL-DIR ("AUX" OHERE)
	 <COND ;(<NOT <PRSI? ,INTDIR>>
		<RECOGNIZE>)
	       (<PRSO? ,DUMBBELL ,CANNONBALL>
		<COND (<AND <ULTIMATELY-IN? ,PRSO>
			    <NOT <IN? ,PRSO ,WALDO>>>
		       <TELL ,HOLDING-IT>
		       <RTRUE>)>
		<SET OHERE ,HERE>
		<DO-WALK <DIRECTION-CONVERSION>>
		<COND (<EQUAL? ,HERE ,UNDER-THE-WORLD ,HANGING-FROM-ROOTS>
		       <REMOVE ,PRSO>
		       <TELL
"   The " D ,PRSO " disappointingly fails to roll along the ground ABOVE
you, and plunges into the void." CR>)
		      (<NOT <EQUAL? ,HERE .OHERE>>
		       <MOVE ,PRSO ,HERE>
		       <TELL "   The " D ,PRSO " rolls to a stop." CR>)>
		<RTRUE>)
	       (T
		<V-ROLL>)>>

<ROUTINE V-ROLL-DOWN ("AUX" OHERE)
	 <COND (<PRSO? ,DUMBBELL ,CANNONBALL>
		<COND (<AND <ULTIMATELY-IN? ,PRSO>
			    <NOT <IN? ,PRSO ,WALDO>>>
		       <TELL ,HOLDING-IT>
		       <RTRUE>)>
		<SET OHERE ,HERE>
		<DO-WALK ,P?DOWN>
		<COND (<NOT <EQUAL? ,HERE .OHERE>>
		       <TELL "   The " D ,PRSO>
		       <COND (<EQUAL? ,HERE ,OUBLIETTE>
			      <REMOVE ,PRSO>
			      <TELL " sinks into the mud">)
			     (T
			      <MOVE ,PRSO ,HERE>
			      <TELL " rolls to a stop">)>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (T
		<V-ROLL>)>>

<ROUTINE V-ROLL-UP ("AUX" OHERE)
	 <COND (<PRSO? ,DUMBBELL ,CANNONBALL>
		<COND (<AND <ULTIMATELY-IN? ,PRSO>
			    <NOT <IN? ,PRSO ,WALDO>>>
		       <TELL ,HOLDING-IT>
		       <RTRUE>)>
		<SET OHERE ,HERE>
		<DO-WALK ,P?UP>
		<COND (<NOT <EQUAL? ,HERE .OHERE>>
		       <MOVE ,PRSO ,HERE>
		       <TELL "   The " D ,PRSO " rolls to a stop." CR>)>
		<RTRUE>)
	       (T
		<V-ROLL>)>>

<ROUTINE V-SACRED-WORD ()
	 <COND (<AND <NOT <EQUAL? ,SACRED-WORD-NUMBER 10>> ;"haven't seen word"
		     <EQUAL? ,P-PRSA-WORD
			     <GET ,SACRED-WORD-WORDS ,SACRED-WORD-NUMBER>>
		     ,TIME-STOPPED>
		<SETG TIME-STOPPED <>>
		<FSET ,OUTER-GATE ,OPENBIT>
		<FSET ,PERIMETER-WALL ,REDESCBIT>
		<QUEUE I-END-GAME -1>
		<TELL
"As you utter the sacred word, time resumes its normal motion! ">
		<COND (<EQUAL? ,HERE ,PERIMETER-WALL>
		       <TELL "The huge outer gates burst open, and t">)
		      (T
		       <TELL
"You hear a distant grinding sound like the opening of a huge door. T">)>
		<TELL
"he entire structure around you begins to shake and tremble; the last moments
of the castle are at hand!" CR>)
	       (T
	 	<TELL
"As you utter it, the power of the sacred word sends you staggering." CR>)>>

<ROUTINE V-NOT-SO-SACRED-WORD ()
	 <TELL
"The word hangs in the air like a damp fog before dissipating." CR>>

<ROUTINE V-SADDLE ()
	 <COND (<NOT ,PRSI>
		<COND (<ULTIMATELY-IN? ,SADDLE>
		       <PERFORM ,V?PUT-ON ,SADDLE ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "You don't have a saddle!" CR>)>)
	       (<PRSI? ,SADDLE>
		<PERFORM ,V?PUT-ON ,SADDLE ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"You can only saddle something with a saddle! In fact, that's probably
where the word comes from!" CR>)>>

<ROUTINE V-SAVE-SOMETHING ()
	 <COND (<PRSO? ,ME>
		<V-HINT>)
	       (T
		<TELL "Sorry, but" T ,PRSO " is beyond help." CR>)>>

"<ADD-WORD 'TIME'	MISCWORD>
<ADD-WORD 'TRIPLET'	MISCWORD>
<ADD-WORD 'TRIPLETS'	MISCWORD>
<ADD-WORD 'QUADRUPLET'	MISCWORD>
<ADD-WORD 'QUINTUPLET'	MISCWORD>
<ADD-WORD 'LETTER'	MISCWORD>
<ADD-WORD 'A'		MISCWORD>
<ADD-WORD 'THE'		MISCWORD>
<ADD-WORD 'Y'		MISCWORD>
<ADD-WORD 'MUSIC'	MISCWORD>
<ADD-WORD 'MUSICAL'	MISCWORD>
<ADD-WORD 'INSTRUMENTS'	MISCWORD>
<ADD-WORD 'BOOKKEEPER'  MISCWORD>
<ADD-WORD 'BOOKKEEPING'  MISCWORD>"

<ROUTINE V-SAY ("AUX" V V2 TMP)
	 <SET TMP <NP-LEXBEG <GET-NP>>>
	 <COND (<EQUAL? ,PRSO ,INTQUOTE>
		<SET TMP <ZREST .TMP <* 2 ;3 ,LEXV-ELEMENT-SIZE-BYTES>>>)>
	 <SET V <GET .TMP 0>>
	 <SET V2 <GET .TMP ,P-LEXELEN>>
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD .V>>
		<V-YES>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD .V>>
		<V-NO>)
	       (<INTBL? .V ,SACRED-WORD-WORDS ,SACRED-WORD-WORDS-LENGTH>
		<SETG P-PRSA-WORD .V>
		<V-SACRED-WORD>)
	       (<AND ,PRSO
		     <PRSO? ,SACRED-WORD-OBJ>>
		<SETG P-PRSA-WORD <NP-NAME <GET-NP ,PRSO>>>
	        <V-SACRED-WORD>)
	       (<EQUAL? .V ,W?FLODOOR ,W?ZIPSO ,W?FURGALNETI>
		<V-NOT-SO-SACRED-WORD>)
	       (<AND <EQUAL? ,HERE ,ENTRANCE-HALL>
		     <IN? ,JESTER ,HERE>
		     <NOT <FSET? ,PORTCULLIS ,OPENBIT>>>
		<COND (<OR <PRSO? ,TIME-OBJECT>
			   <EQUAL? .V ,W?TIME>>
		       <FSET ,PORTCULLIS ,OPENBIT>
		       <TELL
"The portcullis creaks open. \"Friend or foe, you're free to go!\"">
		       <J-EXITS>
		       <INC-SCORE 20>)
		      (T
		       <DONT-CRY>)>)
	       (<AND <EQUAL? ,HERE ,OUBLIETTE>
		     <IN? ,JESTER ,HERE>>
		<COND (<OR <PRSO? ,TRIPLET>
			   <EQUAL? .V ,W?TRIPLET ,W?TRIPLETS
				      ,W?QUADRUPLET ,W?QUINTUPLET>
			   <EQUAL? .V2 ,W?TRIPLET ,W?TRIPLETS
			       	       ,W?QUADRUPLET ,W?QUINTUPLET>>
		       <TELL
"The jester solemnly shakes your hand, and you feel yourself rising
out of the oubliette." CR CR>
		       <GOTO ,DUNGEON>
		       <INC-SCORE ,OUBLIETTE-SCORE>
		       <SETG OUBLIETTE-SCORE 0>
		       <RTRUE>)
		      (T
		       <DONT-CRY>)>)
	       (<AND <IN? ,EAST-KEY ,JESTER>
		     <IN? ,JESTER ,HERE>>
		<COND (<OR <PRSO? ,LETTER-Y>
			   <EQUAL? .V ,W?Y>
			   <AND <EQUAL? .V ,W?A ,W?LETTER>
				<EQUAL? .V ,W?Y>>
			   <AND <EQUAL? .V ,W?A ,W?THE>
				<EQUAL? .V2 ,W?LETTER>
				<EQUAL? <GET .TMP <* 2 ,P-LEXELEN>> ,W?Y>>>
		       <MOVE ,EAST-KEY ,PROTAGONIST>
		       <FSET ,EAST-KEY ,TOUCHBIT>
		       <FCLEAR ,EAST-KEY ,TRYTAKEBIT>
		       <TELL
"The jester grins and tosses you the key. \"Way to be -- Here's the key!\"">
		       <J-EXITS>
		       <INC-SCORE 20>)
		      (T
		       <DONT-CRY>)>)
	       (<AND <IN? ,DIPLOMA ,JESTER>
		     <IN? ,JESTER ,HERE>>
		<COND (<OR <PRSO? ,MUSIC>
			   <EQUAL? .V ,W?MUSIC>
			   <AND <EQUAL? .V ,W?MUSICAL>
				<EQUAL? .V2 ,W?INSTRUMENTS>>>
		       <MOVE ,DIPLOMA ,PROTAGONIST>
		       <FCLEAR ,DIPLOMA ,TRYTAKEBIT>
		       <FCLEAR ,DIPLOMA ,NDESCBIT>
		       <FSET ,DIPLOMA ,TOUCHBIT>
		       <SETG COMPASS-CHANGED T>
		       <TELL
"\"Go to the head of the class!\" The jester hands you the framed
document. \"With flying colors, you pass!\"">
		       <J-EXITS>
		       <INC-SCORE 12>)
		      (T
		       <DONT-CRY>)>)
	       (<AND <EQUAL? ,HERE ,TAX-OFFICE>
		     <IN? ,ZORKMID-COIN ,LOCAL-GLOBALS>
		     <IN? ,JESTER ,HERE>>
		<COND (<OR <PRSO? ,BOOKKEEPER>
			   <EQUAL? .V ,W?BOOKKEEPER ,W?BOOKKEEPING>>
		       <MOVE ,ZORKMID-COIN ,HERE>
		       <TELL
"You hear a \"clink\" by your feet. \"You're fast as a bunny
and right on the money!\"">
		       <J-EXITS>
		       <INC-SCORE 6>)
		      (T
		       <DONT-CRY>)>)
	       (<AND <EQUAL? ,HERE ,CAVE-IN>
		     <IN? ,PIT-BOMB ,LOCAL-GLOBALS>
		     <IN? ,JESTER ,HERE>>
		<COND (<OR <AND <PRSO? ,MID-NAME>
				<NOUN-USED? ,MID-NAME
				  	  <GET ,MID-NAME-WORDS ,MID-NAME-NUM>>>
			    <EQUAL? .V <GET ,MID-NAME-WORDS ,MID-NAME-NUM>>>
		       <MOVE ,PIT-BOMB ,HERE>
		       <TELL
"\"That's my proper appellation; the finest in the nation!\"">
		       <J-EXITS>
		       <INC-SCORE 6>
		       <CRLF>
		       <COND (<EQUAL? ,HERE ,CAVE-IN>
			      <V-LOOK>)>
		       <RTRUE>)
		      (<OR <PRSO? ,OTHER-J-NAMES>
			   <EQUAL? .V ,W?BARBAZZO ,W?FERNAP>>
		       <TELL
"\"That's my name, but not my middle; try again to win this riddle!\"" CR>)
		      (T
		       <TELL
"\"That's not my middle moniker; and I should know! I just looked it up
this morning! Try again.\"" CR>)>)
	       (<AND <EQUAL? ,HERE ,ON-TOP-OF-THE-WORLD>
		     <IN? ,LITTLE-FUNGUS ,GLOBAL-OBJECTS>
		     ,PLANT-TALKER
		     <NOT <EQUAL? ,FUNGUS-NUMBER 12>> ;"not chosen yet"
		     <EQUAL? .V <GET ,FUNGUS-WORDS ,FUNGUS-NUMBER>>>
		<GET-LITTLE-FUNGUS>)
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<SETG CLOCK-WAIT T>
		<TELL
"[If you want" T .V " to do something, the proper way is|
   >" D .V ", do something]" CR>) 
	       (T
		<TELL "You say that out loud, but with no effect." CR>)>
	 <STOP>>

;<ROUTINE V-ANSWER-KLUDGE ()
	 <COND (<NOUN-USED? ,W?I ,ME>
		<V-INVENTORY>)
	       (T
	 	<SETG P-WON <>>
		<TELL ,NO-VERB>
		<STOP>)>>

<ROUTINE V-SCORE ()
	 <TELL "You have scored " N ,SCORE " point">
	 <COND (<NOT <EQUAL? ,SCORE 1>>
		<TELL "s">)>
	 <TELL " (out of 1000) in " N ,MOVES " turn">
	 <COND (<NOT <EQUAL? ,MOVES 1>>
		<TELL "s">)>
	 <TELL ". This gives you the rank of ">
	 <COND (<EQUAL? ,SCORE 1000>
		<TELL "Dungeon Master">)
	       (<G? ,SCORE 875>
		<TELL "Cursebuster">)
	       (<G? ,SCORE 750>
		<TELL "Master Explorer">)
	       (<G? ,SCORE 625>
		<TELL "Expert Adventurer">)
	       (<G? ,SCORE 500>
		<TELL "Respected Adventurer">)
	       (<G? ,SCORE 375>
		<TELL "Nobleman">)
	       (<G? ,SCORE 250>
		<TELL "Knight">)
	       (<G? ,SCORE 125>
		<TELL "Tradesman">)
	       (T
		<COND (<L? ,SCORE 0>
		       <TELL "Incompetent ">)>
		<TELL "Peasant">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE SCORE-OBJ (OBJ "AUX" VAL)
	 <SET VAL <GETP .OBJ ,P?VALUE>>
	 <COND (.VAL
		<INC-SCORE .VAL>
		<PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE V-NOTIFY ()
	 <TELL "Okay, you will no">
	 <COND (,NOTIFICATION-ON
		<SETG NOTIFICATION-ON <>>
		<TELL " longer">)
	       (T
		<SETG NOTIFICATION-ON T>
		<TELL "w">)>
	 <TELL " be notified when your score changes." CR>>

<GLOBAL NOTIFICATION-ON T>

<GLOBAL NOTIFICATION-WARNING <>>

<ROUTINE INC-SCORE (PTS)
	 <COND (<NOT <EQUAL? .PTS 0>>
		<COND (,NOTIFICATION-ON
		       <SOUND 1>
		       <HLIGHT ,H-BOLD>
		       <TELL "   [Your score has just gone ">
		       <COND (<G? .PTS 0>
			      <TELL "up">)
			     (T
			      <TELL "down">)>
		       <TELL " by ">
		       <COND (<G? .PTS 0>
			      <PRINTN .PTS>)
			     (T
			      <PRINTN <* .PTS -1>>)>
		       <TELL ".">
		       <COND (<NOT ,NOTIFICATION-WARNING>
			      <SETG NOTIFICATION-WARNING T>
			      <TELL
" Note: you can turn this feature on and off using the NOTIFY command.">)>
		       <TELL "]" CR>
		       <HLIGHT ,H-NORMAL>)>
		<SETG SCORE <+ ,SCORE .PTS>>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<V-SHAKE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<D-VEHICLE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<FSET? ,PRSO ,CONTBIT>
		<TELL "You find">
		<COND (<NOT <D-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (T
		<CANT-VERB-A-PRSO "search">)>>

<ROUTINE V-SSEARCH-OBJECT-FOR ()
	 <PERFORM ,V?SEARCH-OBJECT-FOR ,PRSI, PRSO>
	 <RTRUE>>

<ROUTINE V-SEARCH-OBJECT-FOR ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?SEARCH ,PRSO>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <IN? ,PRSI ,PRSO>
		    <IN? ,PRSI ,HERE>>
		<TELL "Very observant. There "
		      <COND (<FSET? ,PRSI ,FEMALEBIT>
			     "she")
			    (<FSET? ,PRSI ,ACTORBIT>
			     "he")
			    (T
			     "it")>
		      " is." CR>)
	       (T 
		<TELL "You don't find" T ,PRSI " there." CR>)>>

<ROUTINE V-SEND ()
	 <TELL
"You haven't any stamps, and there isn't a mailbox in sight!" CR>>

<ROUTINE V-SET ()
	 <COND (<NOT ,PRSI>
		<COND (<PRSO? ,ROOMS> ;"input was TURN AROUND"
		       <TELL
"You do a 360 degree spin, but no agents appear to sign you
up for the Borphee Metropolitan Ballet Company." CR>)
		      (<OR <FSET? ,PRSO ,TAKEBIT>
			   <FSET? ,PRSO ,INTEGRALBIT>>
		       <HACK-HACK "Turning">)
		      (T
		       <TELL ,YNH TR ,PRSO>)>) 
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-SET-DIR ()
	 <IMPOSSIBLES>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" PERSON)
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "That wouldn't be polite." CR>)
	       ;(<EQUAL? ,PRSO ,HANDS> ;"in hands-f"
		<COND (<SET PERSON <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?SHAKE-WITH ,PRSO .PERSON>
		       <RTRUE>)>)
	       (T
		<HACK-HACK "Shaking">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT ,PRSI>
		<PERFORM ,V?SHAKE-WITH ,HANDS ,PRSO>
		<RTRUE>)
	       (<NOT <PRSO? ,HANDS>>
		<RECOGNIZE>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "I don't think" T ,PRSI " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>

<ROUTINE V-SHOW ("AUX" ACTOR)
	 <COND (<AND <NOT ,PRSI>
		     <SET ACTOR <FIND-IN ,HERE ,ACTORBIT>>>
		<PERFORM ,V?SHOW ,PRSO .ACTOR>
		<RTRUE>)
	       (<NOT ,PRSI>
		<TELL "There's no one here to show it to." CR>)
	       (T
		<TELL 
"It doesn't look like" T-IS-ARE ,PRSI "interested." CR>)>>

<ROUTINE V-SHUT-UP ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "[I hope you're not addressing me...]" CR>)
	       (T
		<PERFORM ,V?CLOSE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SING ()
	 <TELL ,HUH>>

<ROUTINE V-SING-TO ()
	 <COND (<PRSO? ,BEDBUG>
		<PERFORM ,V?PUT-TO ,BEDBUG ,GLOBAL-SLEEP>
		<RTRUE>)
	       (T
	 	<WASTES>)>>

<ROUTINE V-SINK ()
	 <IMPOSSIBLES>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<AND ,PRSO
		     <NOT <PRSO? ,ROOMS>>>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,HERE>>
		<TELL ,LOOK-AROUND>)
	       (<EQUAL? ,HERE ,CASINO>
		<TELL "[at the card table]" CR>
		<PERFORM ,V?ENTER ,CARD-TABLE>
		<RTRUE>)
	       (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT "on">>
		<PERFORM ,V?ENTER .VEHICLE>
		<RTRUE>)
               (T
		<WASTES>)>>

<ROUTINE V-SKIP ()
	 <COND (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>
		     <NOT <EQUAL? ,TURNED-INTO ,LITTLE-FUNGUS>>>
		<SETG P-CONT -1> ;<RFATAL>
		<TELL "Ahem..." A ,TURNED-INTO>
		<COND (<FSET? ,TURNED-INTO ,PLURALBIT>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
		<TELL" usually incapable of locomotion." CR>)
	       (T
		<TELL "Wasn't that fun?" CR>)>>

<ROUTINE V-SLEEP ()
	 <TELL "You're not tired">
	 <COND (<IN? ,BEDBUG ,HERE>
		<TELL ", but you curl up for a moment and fake sleep. ">
		<REMOVE-BEDBUG "see">)
	       (T
		<TELL ,PERIOD-CR>)>>

<ROUTINE PRE-SMELL ()
	 <COND (<FSET? ,CLOWN-NOSE ,WORNBIT>
		<TELL ,YOU-CANT "smell a thing with this clown nose on!" CR>)>>

<ROUTINE V-SMELL ()
	 <COND (<NOT ,PRSO>
		<COND (<EQUAL? ,HERE ,WEST-WING>
		       <TELL ,FUDGE CR>)
		      (<EQUAL? ,HERE ,FISHY-ODOR>
		       <TELL "Phew! Rotten fish!" CR>)
		      (T
		       <TELL "You smell nothing unusual at the moment." CR>)>)
	       (T
		<SENSE-OBJECT "smell">)>>

<ROUTINE SENSE-OBJECT (STRING)
	 <PRONOUN>
	 <TELL " " .STRING>
	 <COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
		     <NOT <PRSO? ,ME>>>
		<TELL "s">)>
	 <TELL " just like" AR ,PRSO>>

<ROUTINE V-SNAP ()
	 <TELL "Perhaps it's your mind that has snapped." CR>>

<ROUTINE V-SPUT-ON ()
         <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HOLD> ;"for HOLD UP OBJECT"
		<WASTES>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>
		     <EQUAL? ,P-PRSA-WORD ,W?STAND> ;"for STAND UP OBJECT">
		<WASTES>)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?GET> ;"for GET UP ON OBJECT"
		     ,PRSO
		     <NOT <PRSO? ,ROOMS>>> ;"not GET UP"
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,HERE>>
		<PERFORM ,V?EXIT <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (<AND <NOT <PRSO? ,ROOMS <>>>
		     <NOT <EQUAL? ,P-PRSA-WORD ,W?STAND>>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (,UNDER-TABLE
		<SETG UNDER-TABLE <>>
		<SETG OLD-HERE <>>
		<TELL "You get out from under the table." CR>)
	       (T
		<TELL "You're already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <COND (<PRSO? ,EAST-DOCK ,WEST-DOCK ,NORTH-DOCK ,SOUTH-DOCK
		       ,TREE-STUMP ,YACHT ,TOBOGGAN ,CONDUCTOR-STAND>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (T
	 	<WASTES>)>>

<ROUTINE V-STELL ()
	 <PERFORM ,V?TELL ,PRSI>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <COND (<PRSI? ,INTDIR>
		<PERFORM ,V?THROW ,PRSO ,PRSI>)
	       (T
	 	<PERFORM ,V?THROW-TO ,PRSI ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-SUCK-ON ()
	 <PERFORM ,V?TASTE ,PRSO>
	 <RTRUE>>

<ROUTINE V-SUCK-WITH ()
	 <PERFORM ,V?DRINK ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-SWAT ()
	 <COND (,PRSI
		<TELL "Sorry, but" A ,PRSI " makes a poor ">)
	       (T
		<TELL "You don't have a ">)>
	 <COND (<PRSO? ,LARGE-FLY ,LARGER-FLY ,EVEN-LARGER-FLY ,LARGEST-FLY>
		<TELL "fly">)
	       (T
		<TELL D ,PRSO>)>
	 <TELL "swatter." CR>>

<ROUTINE V-SWIM ("AUX" X)
	 <COND (,PRSO
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<SET X <FIND-WATER>>
		<PERFORM ,V?ENTER .X>
		<RTRUE>)
	       (T
		<TELL "Your head must be swimming." CR>)>>

<ROUTINE V-SWING ()
	 ;<COND (,PRSI
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)>
	 <TELL "\"Whoosh.\"" CR>>

;"called from syntaxes that switch the prso and prsi"
<ROUTINE PRE-SWITCH ()
	 <SETG OBJ-SWAP T>
	 <RFALSE>>

;<ROUTINE PRE-SWITCH ("AUX" I O IA OA)
	 <SET O <NP-NAME <GET-NP ,PRSO>>>
	 <SET I <NP-NAME <GET-NP ,PRSI>>>
	 <SET OA <GET <NP-ADJS <GET-NP ,PRSO>> 1>>
	 <SET IA <GET <NP-ADJS <GET-NP ,PRSI>> 1>>
	 <NP-NAME <GET-NP ,PRSO> .I>
	 <NP-NAME <GET-NP ,PRSI> .O>
	 <PUT <NP-ADJS <GET-NP ,PRSO>> 1 .IA>
	 <PUT <NP-ADJS <GET-NP ,PRSO>> 1 .OA> 
	 <RFALSE>>		

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?WRAP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-TAKE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,PARTBIT>>
		     <PRE-LOOK>>
		<RTRUE>)
	       (<AND <PRSO? ,HANDS>
		     ,PRSI
		     <OR <AND <PRSI? ,HAND-HOLE ,WALDO>
		     	      ,HAND-IN-WALDO>
			 <AND <PRSI? ,STRAW>
			      ,FINGER-ON-STRAW>>>
		<PERFORM ,V?REMOVE ,HANDS>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>		     
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n it!" CR>)
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     ,PRSI
		     <IN? ,PRSI ,ROOMS>> ;"such as TAKE PLATTER IN SCULLERY"
		<V-WALK-AROUND>)
	       (<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>
			 <NOT <PRSO? ,WALDO ,SMALL-VIAL-WATER
				     ,LARGE-VIAL-WATER>>>>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <COND (<PRSO? ,CLOWN-NOSE>
			      <PERFORM ,V?TAKE-OFF ,CLOWN-NOSE>
			      <RTRUE>)>
		       <TELL "You're already wearing">)
		      (T
		       <TELL "You already have">)>
		<TELL T ,PRSO ,PERIOD-CR>)
	       (<UNTOUCHABLE? ,PRSO>
		<COND (,HAND-IN-WALDO
		       <WALDO-TAKE>
		       <RTRUE>)
		      (T
		       <CANT-REACH ,PRSO>)>)
	       (<NOT ,PRSI>
		<RFALSE>)
	       (<PRSI? ,ME>
		<PERFORM ,V?DROP ,PRSI>
		<RTRUE>)
	       (<AND <PRSO? ,WATER>
		     <EQUAL? ,P-PRSA-WORD ,W?REMOVE>
		     <OR <AND <PRSI? ,LARGE-VIAL>
			      <G? ,LARGE-VIAL-WATER 0>>
			 <AND <PRSI? ,SMALL-VIAL>
			      <G? ,SMALL-VIAL-WATER 0>>>>
		<PERFORM ,V?EMPTY-FROM ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <NOT <IN? ,PRSO ,PRSI>>
		     <NOT <EQUAL? ,PRSI <GETP ,PRSO ,P?OWNER>>>>
		<NOT-IN>)
	       (,PRSI
		<SETG PRSI <>>
		<RFALSE>)>>

<ROUTINE V-TAKE ("AUX" (L <LOC ,PRSO>))
	 <COND (<NOT <EQUAL? <ITAKE T> ,M-FATAL>>
		<COND (<OR <EQUAL? .L ,HERE>
			   <EQUAL? .L <LOC ,PROTAGONIST>>>
		       <TELL "You pick up" TR ,PRSO>)
		      (T
		       <TELL "You take" T ,PRSO " from" TR .L>)>
		<SCORE-OBJ ,PRSO>)>>

<ROUTINE V-TAKE-OFF ("AUX" (VEHICLE <LOC ,PROTAGONIST>))
	 <COND (<PRSO? ,ROOMS>
		<COND (<FSET? .VEHICLE ,VEHBIT>
		       <PERFORM ,V?EXIT .VEHICLE>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,GONDOLA>
		       <DO-WALK ,P?OUT>)
		      (T
		       <TELL "You're not ">
		       <COND (<EQUAL? <PARSE-PARTICLE1 ,PARSE-RESULT> ,W?OUT>
			      <TELL "i">)
			     (T ;"get off"
			      <TELL "o">)>
		       <TELL "n anything." CR>)>)
	       (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<THIS-IS-IT ,PRSO>
		<TELL "You remove" TR ,PRSO>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?EXIT ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You aren't wearing" TR ,PRSO>)>>

<ROUTINE V-TAKE-WITH ()
	 <COND (<NOT <ULTIMATELY-IN? ,PRSI>>
		<TELL ,YNH TR ,PRSI>)
	       (T
		<TELL "Sorry," T-IS-ARE ,PRSI "no help in getting" TR ,PRSO>)>>

<ROUTINE V-TASTE ()
	 <SENSE-OBJECT "taste">>

<ROUTINE PRE-TELL ()
	 <COND (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>>
		<SETG P-CONT -1>
		<TO-SPEAK-OF "mouth">)
	       (<OR <VERB? SING SING-TO SAY>
		    <NOT ,PRSO>> ;"for example, V-YELL"
		<RFALSE>)
	       (<AND <FSET? ,PRSO ,PLANTBIT>
		     ,PLANT-TALKER>
		<RFALSE>)
	       (<AND <OR <PRSO? ,OTHER-J-NAMES>
			 <AND <PRSO? ,MID-NAME>
			      <NOUN-USED? ,MID-NAME
					 <GET ,MID-NAME-WORDS ,MID-NAME-NUM>>>>
		     <VISIBLE? ,JESTER>>
		<PERFORM-PRSA ,JESTER>
		<RTRUE>)
	       (<PRSO? ,OTHER-J-NAMES ,MID-NAME>
		<TELL ,BY-THAT-NAME>
		<STOP>)
	       (<AND <PRSO? ,LITTLE-FUNGUS>
		     <IN? ,LITTLE-FUNGUS ,GLOBAL-OBJECTS>>
		<COND (<EQUAL? ,HERE ,ON-TOP-OF-THE-WORLD>
		       <PERFORM ,V?CALL ,PRSO>)
		      (T
		       <TELL ,BY-THAT-NAME>)>
		<STOP>)
	       (<AND <NOT <FSET? ,PRSO ,ACTORBIT>>
	             <NOT <PRSO? ,ME ,ORACLE-OBJECT ,SAILOR ,INTQUOTE>>>
		<V-TELL>
		<STOP>)>>

<ROUTINE V-TELL ()
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <PRSO? ,SAILOR>
		    <AND <FSET? ,PRSO ,PLANTBIT>
			 ,PLANT-TALKER>>
		<COND (<OR ,P-CONT
			   <PRSO? ,SAILOR>>
		       <SETG WINNER ,PRSO>
		       <SETG CLOCK-WAIT T>
		       <RTRUE>)
		      (T
		       <TELL
"Hmmm..." T ,PRSO " looks at you expectantly,
as if you seemed to be about to talk." CR>)>)
	       (<PRSO? ,BROGMOID>
		<TELL ,TALK-TO-BROGMOID>)
	       (T
		<TELL
"It's a well-known fact that only schizophrenics talk to" AR ,PRSO>
	        <STOP>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<TELL
"[Maybe you could find an encyclopedia to look that up in.]" CR>)
	       (T
		<PERFORM ,V?SHOW ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-THANK ()
	 <COND (<NOT ,PRSO>
		<TELL "[Just doing my job.]" CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "It seems" T ,PRSO " is unmoved by your politeness." CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-THROW ()
	 <COND (<NOT <SPECIAL-DROP ,PRSO>>
	 	<COND (<EQUAL? <LOC ,PROTAGONIST> ,YACHT ,DB>
		       <MOVE ,PRSO <LOC ,PROTAGONIST>>)
		      (T
		       <MOVE ,PRSO ,HERE>)>
		<COND (<AND ,PRSI
			    <NOT <PRSI? ,GROUND ,INTDIR>>>
		       <TELL "You missed." CR>)
		      (T
		       <THIS-IS-IT ,PRSO>
		       <TELL "Thrown." CR>)>)>>

<ROUTINE V-THROW-OVER ()
	 <WASTES>>

<ROUTINE V-THROW-FROM ()
	 <IMPOSSIBLES>>

<ROUTINE V-THROW-OVERBOARD ()
	 <COND (<IN? ,PROTAGONIST ,YACHT>
		<PERFORM ,V?PUT ,PRSO ,WATER>
		<RTRUE>)
	       (<EQUAL? ,HERE ,HOLD>
		<TELL ,YOULL-HAVE-TO "go up on deck to do that." CR>)
	       (T
		<TELL "You generally have to be on a boat to do that." CR>)>>

<ROUTINE V-THROW-TO ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?THROW ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-TIE ()
	 <TELL ,YOU-CANT "tie" TR ,PRSO>>

<ROUTINE V-TIME ()
	 <TELL "It is daytime. You have taken " N ,MOVES " turn">
	 <COND (<NOT <EQUAL? ,MOVES 1>>
		<TELL "s">)>
	 <COND (<G? ,MOVES 1000>
		<TELL
". (The day really seems to be dragging, doesn't it?)" CR>)
	       (T
		<TELL ,PERIOD-CR>)>>

<ROUTINE V-TIP ()
	 <TELL
"You tell" T ,PRSO " about Lucky Brogmoid in the seventh race
at Bozbar Downs, but ">
	 <COND (<FSET? ,PRSO ,PLURALBIT>
		<TELL "they don't">)
	       (T
		<COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		       <TELL "it">)
		      (<FSET? ,PRSO ,FEMALEBIT>
		       <TELL "she">)
		      (T
		       <TELL "he">)>
		<TELL " doesn't">)>
	 <TELL " seem too interested." CR>>

<ROUTINE V-TIP-OVER ()
	 <WASTES>>

<ROUTINE PRE-TOUCH ()
	 <COND (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>
		<RTRUE>)
	       (,TURNED-INTO
		<COND (<AND <VERB? OFF>
			    <EQUAL? ,P-PRSA-WORD ,W?BLOW>>
		       <COND (<FSET? ,TURNED-INTO ,ANIMATEDBIT>
			      <RFALSE>)
			     (T
			      <PRE-TELL>)>)
		      (T
		       <SETG P-CONT -1>
		       <TO-SPEAK-OF "hands">)>)>>

<ROUTINE V-STOUCH ()
	 <PERFORM ,V?TOUCH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-TOUCH ()
	 <COND (<LOC-CLOSED ,PRSO>
		<RTRUE>)
	       (T
		<HACK-HACK "Fiddling with">)>>

<ROUTINE V-UNLOCK ()
	 <COND (<FSET? ,PRSO ,LOCKEDBIT>
		<TELL "Unfortunately," T ,PRSI " do">
		<COND (<NOT <FSET? ,PRSI ,PLURALBIT>>
		       <TELL "es">)>
		<TELL "n't unlock" TR ,PRSO>)
	       (T
		<TELL "But" T ,PRSO " isn't locked." CR>)>>

<ROUTINE V-UNTIE ()
	 <IMPOSSIBLES>>

<ROUTINE V-USE ()
	 <TELL
,YOULL-HAVE-TO "be more specific about how you want to use" TR ,PRSO>>

;<ROUTINE V-USE-QUOTES ()
	 <COND ;(<IN? ,HAREM-GUARD ,HERE>
		<PICK-WIFE ,PRSO>)
	       (T
	        <TELL
"[You need quotes to say something \"out loud.\" See the instruction manual
section entitled \"Communicating With Infocom's Interactive Fiction.\"]" CR>)>>

<ROUTINE V-WALK ("AUX" (AV <LOC ,PROTAGONIST>) VEHICLE PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<USE-PREPOSITIONS "WALK " "TO" "THROUGH" "AROUND">)
	       (<AND <EQUAL? ,HERE ,BANQUET-HALL>
		     <RUNNING? ,I-PROLOGUE>
		     <G? ,PROLOGUE-COUNTER 2>>
		<SETG P-CONT -1> ;<RFATAL>
		<RETURN-FROM-MAP>
		<TELL "Thick black smoke blocks every exit." CR>)
	       (<AND ,TURNED-INTO
		     <NOT <FSET? ,TURNED-INTO ,ANIMATEDBIT>>
		     <NOT <EQUAL? ,TURNED-INTO ,LITTLE-FUNGUS>>>
		<RETURN-FROM-MAP>
		<V-SKIP>)
	       (<AND <PRSO? ,P?OUT>
		     <FSET? .AV ,DROPBIT>>
		<RETURN-FROM-MAP>
		<PERFORM ,V?EXIT .AV>
		<RTRUE>)	        
	       (<AND <PRSO? ,P?IN>
		     <NOT <GETPT ,HERE ,P?IN>>
		     <SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		     <NOT <ULTIMATELY-IN? .VEHICLE>>>
		<RETURN-FROM-MAP>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?ENTER>
		       <TELL "[">
		       <COND (<NOT <FSET? .VEHICLE ,NARTICLEBIT>>
			      <TELL "the ">)>
		       <TELL D .VEHICLE "]" CR>)>
		<PERFORM ,V?ENTER .VEHICLE>
		<RTRUE>)
	       (<AND <IN? ,BEDBUG ,HERE>
		     <NOT ,TIME-STOPPED>>
		<SETG P-CONT -1> ;<RFATAL>
		<RETURN-FROM-MAP>
		<TELL
"With a flurry of its powerful, hairy legs, the bedbug scuttles over
to block your way." CR>)
	       (<AND <PRSO? ,P?DOWN>
		     <IN? ,PROTAGONIST ,YACHT>>
		<GOTO ,HOLD>)
	       (,UNDER-TABLE
		<RETURN-FROM-MAP>
		<DO-FIRST "get out from under the table">)
	       (<AND <FSET? .AV ,VEHBIT>
		     <NOT <AND <EQUAL? .AV ,LADDER>
			       <PRSO? ,P?UP>>>
		     <NOT <AND <EQUAL? .AV ,CAMEL>
			       <FSET? ,CAMEL ,ANIMATEDBIT>>>>
		<COND (<AND <EQUAL? .AV ,DB>
			    <PRSO? ,P?UP>
			    <NOT <EQUAL? ,HERE ,HOLD>>>
		       <PERFORM ,V?RAISE ,LEVER>
		       <RTRUE>)
		      (<AND <EQUAL? .AV ,DB>
			    <PRSO? ,P?DOWN>
			    <NOT <EQUAL? ,HERE ,LAKE-BOTTOM>>>
		       <PERFORM ,V?LOWER ,LEVER>
		       <RTRUE>)>
		<RETURN-FROM-MAP>
		<TELL "You're not going anywhere until you get ">
		<COND (<EQUAL? .AV ,CARD-TABLE>
		       <TELL "up from">)
		      (<FSET? .AV ,INBIT>
		       <TELL "out of">)
		      (T
		       <TELL "off">)>
		<SETG P-CONT -1> ;<RFATAL>
		<TELL TR .AV>)
	       (<AND <FSET? ,RING ,WORNBIT>
		     <OR <PROB 40>
			 <EQUAL? ,HERE ,UNDER-THE-WORLD ,HANGING-FROM-ROOTS
				 ,LEDGE-IN-PIT ,MOUTH-OF-CAVE>>>
		<RETURN-FROM-MAP>
		<TELL "Oops! You awkwardly ">
		<COND (<EQUAL? ,HERE ,UNDER-THE-WORLD ,HANGING-FROM-ROOTS
			       ,LEDGE-IN-PIT ,MOUTH-OF-CAVE>
		       <TELL "lost your grip! ">
		       <PERFORM ,V?LEAP ,ROOMS>
		       <RTRUE>)
		      (T
		       <TELL
"tripped over your own feet and fell down trying to walk. Fortunately,
you're not seriously hurt." CR>)>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <RETURN-FROM-MAP>
		       <SETG P-CONT -1> ;<RFATAL>
		       <TELL <GET .PT ,NEXITSTR> CR>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <SETG P-CONT -1> ;<RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <SETG P-CONT -1> ;<RFATAL>
			      <RETURN-FROM-MAP>
			      <TELL .STR CR>)
			     (T
			      <SETG P-CONT -1> ;<RFATAL>
			      <CANT-GO>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GET .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,DEXITRM>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <RETURN-FROM-MAP>
			      <THIS-IS-IT .OBJ>
			      <SETG P-CONT -1> ;<RFATAL>
			      <TELL .STR CR>)
			     (T
			      <RETURN-FROM-MAP>
			      <THIS-IS-IT .OBJ>
			      <SETG P-CONT -1> ;<RFATAL>
			      <DO-FIRST "open" .OBJ>)>)>)
	       (T
		<COND (<PRSO? ,P?OUT ,P?IN>
		       <V-WALK-AROUND>)
		      (T
		       <CANT-GO>)>
		<SETG P-CONT -1> ;<RFATAL>)>>

<ROUTINE CANT-GO ()
	 <COND (<AND <NOT ,LIT>
		     <NOT <EQUAL? <LOC ,PROTAGONIST> ,DB ,HOLD>>
		     <NOT <EQUAL? ,HERE ,PIT-BOMB-LOC>>
		     <NOT ,TIME-STOPPED>
		     <PROB 75>>
		<RETURN-FROM-MAP>
		<DARK-DEATH>)
	       (<OR <AND <IN? ,N-S-PASSAGE ,HERE>
			 <EQUAL? ,PRSO ,N-S-PASSAGE-DIR>>
		    <AND <IN? ,NW-SE-PASSAGE ,HERE>
			 <EQUAL? ,PRSO ,NW-SE-PASSAGE-DIR>>>
		<COND (<AND <EQUAL? ,HERE ,CONSTRUCTION>
			    <NOT <EQUAL? ,CONSTRUCTION-LOC ,N-S-PASSAGE-LOC>>
			    <PRSO? ,N-S-PASSAGE-DIR>>
		       <BEEP-OR-CANT-GO>)
		      (<AND <EQUAL? ,HERE ,CONSTRUCTION>
			    <NOT <EQUAL? ,CONSTRUCTION-LOC ,NW-SE-PASSAGE-LOC>>
			    <PRSO? ,NW-SE-PASSAGE-DIR>>
		       <BEEP-OR-CANT-GO>)
		      (T
		       <RETURN-FROM-MAP>
		       <TELL
"You walk down the Frobozz Magic Passage Company passage, but it ends in a
dead end and you are forced to return to" TR ,HERE>)>)
	       (T
		<BEEP-OR-CANT-GO>)>>

<ROUTINE BEEP-OR-CANT-GO ()
	 <COND (<EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>
		<SOUND 1>)
	       (T
		<TELL "You can't go that way." CR>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Please use compass directions to move around." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<PRSO? ,SICKLY-WITCH ,PRICKLY-WITCH>
			      <TELL "She's">)
			     (T
		       	      <TELL "He's">)>)
		      (<FSET? ,PRSO ,PLURALBIT>
		       <TELL "They're">)
		      (T
		       <TELL "It's">)>
		<TELL " here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time ">
	 <COND (,TIME-STOPPED
		<TELL "doesn't pass">)
	       (T
		<TELL "passes">)>
	 <TELL "..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <COND (<AND <SET NUM <LOC ,WINNER>>
		     <NOT <IN? .NUM ,ROOMS>>
		     ;<FSET? .NUM ,VEHBIT>>
		<SET NUM <D-APPLY "M-END" <GETP .NUM ,P?ACTION> ,M-END>>)>
	 <SET NUM <D-APPLY "M-END" <GETP ,HERE ,P?ACTION> ,M-END>>
	 <COND (<EQUAL? ,M-FATAL .NUM>
		<SETG P-CONT -1>)>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<VISIBLE? ,PRSO>
		<V-FOLLOW>)
	       (T
	 	<TELL "You may be waiting quite a while." CR>)>>

;<ROUTINE V-WAVE ()
	 <COND (<AND ,PRSI
		     <NOT ,IN-FRONT-FLAG>>
		<RECOGNIZE>)
	       (<ULTIMATELY-IN? ,PRSO>
		<WASTES>)	       	       
	       (T
		<TELL ,YNH TR ,PRSO>)>>

<ROUTINE V-WEAR ()
         <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<CANT-VERB-A-PRSO "wear">)
	       (<IN? ,PRSO ,WALDO>
		<TELL ,YNH TR ,PRSO>)
	       (T
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "already">)
		      (T
		       <MOVE ,PRSO ,PROTAGONIST>
		       <FSET ,PRSO ,WORNBIT>
		       <TELL "now">)>
		<TELL " wearing" TR ,PRSO>)>>

<ROUTINE V-WRAP ()
	 <WASTES>>

<ROUTINE V-YAWN ()
	 <COND (<IN? ,BEDBUG ,HERE>
		<REMOVE-BEDBUG "see">)
	       (T
		<SETG AWAITING-REPLY 1>
		<QUEUE I-REPLY 2>
		<TELL "[Is the game boring you?]" CR>)>>

<ROUTINE REMOVE-BEDBUG (STRING)
	 <REMOVE ,BEDBUG>
	 <TELL
"That was all the bedbug needed to " .STRING ". It curls up into a well-armed
piece of sleeping bedbug armor. You hear a chuckle from an invisible source,
and the sleeping bedbug disappears!" CR>>

<ROUTINE V-YELL ()
	 <COND (<PRSO? ,INTQUOTE>
		<V-SAY>)
	       (T
	 	<TELL "Aaaarrrggghhhh!" CR>
	 	<STOP>)>>

<ROUTINE I-REPLY ()
	 <SETG AWAITING-REPLY <>>
	 <RFALSE>>

<GLOBAL AWAITING-REPLY <>>

<ROUTINE V-YES ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1> 
	        <TELL "That was just a rhetorical question." CR>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<TELL
"\"Well, you don't. This swamp is owned by a cartel of lily pad farmers in
Borphee, who are indebted up to their ears to a conglomerate of Gurthian
banks, of which I am the primary stockholder. Ergo, you could safely say
that I own this swamp.\"" CR>) 
	       (T
	 	<YOU-SOUND "posit">)>>

<ROUTINE YOU-SOUND (STRING)
	 <TELL "You sound rather " .STRING "ive." CR>>

<ROUTINE YES-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?YES ,W?Y ,W?YUP>
		    <EQUAL? .WRD ,W?OK ,W?OKAY ,W?SURE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-ZAP ()
	 <COND (,PRSI
		<PERFORM ,V?POINT ,PRSI ,PRSO>
		<RTRUE>)
	       (<PRSO? ,WAND>
		<TELL "Try waving the wand at something in particular." CR>)
	       (<AND <ULTIMATELY-IN? ,WAND>
		     <VISIBLE? ,WAND>>
		<PERFORM ,V?POINT ,WAND ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have neither a magical wand nor a ray gun." CR>)>>

;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) (OBJ 0))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <COND (<FSET? .OBJ ,INTEGRALBIT>
		<COND (.VB
		       <PART-OF>)>
		<RFATAL>)
	       (<NOT <FSET? .OBJ ,TAKEBIT>>
		<COND (.VB
		       <YUKS>)>
		<RFATAL>)
	       (,ALLIGATOR
		<SETG P-CONT -1>
		<COND (.VB
		       <TELL
,YOU-CANT "pick anything up right now. The logic goes something like this:|
   1. You need hands to pick something up.|
   2. You've been turned into an alligator.|
   3. Alligators don't have hands." CR>)>
		<RFATAL>)
	       (,TURNED-INTO
		<COND (.VB
		       <TELL
"Surely you realize that" A ,TURNED-INTO " is hardly equipped to
carry items around!" CR>)>
		<RFATAL>)
	       (<LOC-CLOSED .OBJ .VB>
		<RFATAL>)
	       (<UNTOUCHABLE? .OBJ>
		<COND (.VB
		       <CANT-REACH .OBJ>)>
		<RFATAL>)
	       (<AND <FSET? ,RING ,WORNBIT>
		     <G? <CCOUNT ,PROTAGONIST> 4>>
		<COND (.VB
		       <TELL
"Oops! While trying to pick up" T .OBJ ", you accidentally dropped
everything you were holding! How clumsy!">
		       <ROB ,PROTAGONIST
			    <COND (<FSET? <LOC ,PROTAGONIST> ,DROPBIT>
		       	      	   <LOC ,PROTAGONIST>)
				  (T
				   ,HERE)>
			    T>
		       <CRLF>)>
		<RFATAL>)
	       (<G? <CCOUNT ,PROTAGONIST> 10>
		<COND (.VB
		       <TELL
"You're already juggling as many items as you could possibly carry." CR>)>
		<RFATAL>)
	       (<AND <NOT <ULTIMATELY-IN? .OBJ>>
		     <G? <+ <WEIGHT .OBJ> <WEIGHT ,PROTAGONIST>> 100>>
		<COND (.VB
		       <COND (<FSET? .OBJ ,PLURALBIT>
			      <TELL "They're">)
			     (T
			      <TELL "It's">)>
		       <TELL " too heavy">
		       <COND (<FIRST? ,PROTAGONIST>
			      <TELL ", considering your current load">)>
		       <TELL ,PERIOD-CR>)>
		<RFATAL>)>
	 <FSET .OBJ ,TOUCHBIT>
	 <FCLEAR .OBJ ,NDESCBIT>
	 <COND (<IN? ,PROTAGONIST .OBJ>
		<RFALSE> ;"Hope this is right -- pdl 4/22/86")>
	 <COND (<NOT .VB> ;"called by PARSER for implicit take"
		<TELL "[taking" T .OBJ " first]" CR>
		<SCORE-OBJ .OBJ>)>
	 <MOVE .OBJ ,PROTAGONIST>>

;"IDROP is called by PRE-GIVE and PRE-PUT.
  IDROP acts directly as PRE-DROP, PRE-THROW and PRE-PUT-THROUGH."
<ROUTINE IDROP ()
	 <COND (<AND <EQUAL? ,HERE ,HANGING-FROM-ROOTS>
		     <PRSO? ,ROOMS ,ROOTS>> ;"LET GO or LET GO OF ROOTS"
		<PERFORM ,V?LEAP>
		<RTRUE>)
	       (<PRSO? ,ROOMS> ;"input was LET GO"
		<TELL "You're not hanging onto anything." CR>)
	       (<PRSO? ,HANDS>
		<COND (<VERB? DROP THROW GIVE>
		       <IMPOSSIBLES>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? THROW>
		     <PRSO? ,EYES>>
		<COND (<NOT ,PRSI>
		       <V-LOOK>
		       <RTRUE>)>
		<PRE-SWITCH>
		<PERFORM ,V?EXAMINE ,PRSI ,EYES>
		<RTRUE>)
	       (<AND <PRSO? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?ENTER ,PRSI>
		<RTRUE>)
	       (<AND <PRSI? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)
	       (<AND <VERB? DROP>
		     <IN? ,PRSO ,WALDO>>
		<RFALSE>)
	       (<NOT <ULTIMATELY-IN? ,PRSO>>
		<COND (<OR <PRSO? ,ME>
			   <FSET? ,PRSO ,PARTBIT>>
		       <IMPOSSIBLES>)
		      (T
		       <TELL
"That's easy for you to say since you don't even have" TR ,PRSO>)>
		<RFATAL>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		<PART-OF>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<DO-FIRST "open" <LOC ,PRSO>>)
	       (<FSET? ,PRSO ,WORNBIT>
		<DO-FIRST "remove" ,PRSO>)
	       (T
		<RFALSE>)>>

<ROUTINE CCOUNT	(OBJ "OPTIONAL" (DESCRIBED-ITEMS-ONLY <>) "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND .DESCRIBED-ITEMS-ONLY
				    <FSET? .X ,NDESCBIT>>
			       T)
			      (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .CONT ,WORNBIT>>
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>>
			       <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

;"subtitle describers"

<ROUTINE D-ROOM ("OPTIONAL" (VERB-IS-LOOK <>) "AUX" (FIRST-VISIT <>) PIC)
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>
		<GRUE-PIT-WARNING>
		<RFALSE>)
	       (<OR <NOT <FSET? ,HERE ,TOUCHBIT>>
		    <FSET? ,HERE ,REDESCBIT>>
		<SET FIRST-VISIT T>)>
	 <HLIGHT ,H-BOLD>
	 <SAY-HERE>
	 <HLIGHT ,H-NORMAL>
	 <CRLF>
	 <COND (<OR .VERB-IS-LOOK
		    <EQUAL? ,VERBOSITY 2>
		    <AND .FIRST-VISIT
			 <EQUAL? ,VERBOSITY 1>>>
		<COND (<SET PIC <GETP ,HERE ,P?ICON>>
		       <MARGINAL-PIC .PIC>)
		      (T
		       <TELL "   ">)>
		<COND (<NOT <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <TELL <GETP ,HERE ,P?LDESC>>)>
		<CRLF>)>
	 <FCLEAR ,HERE ,REDESCBIT>
	 <FSET ,HERE ,TOUCHBIT>
	 <COND (<EQUAL? ,HERE ,CONSTRUCTION ,PLAIN ,FR-OFFICES ,OFFICES-NORTH
			      ,OFFICES-SOUTH ,OFFICES-EAST ,OFFICES-WEST>
		<FSET ,HERE ,REDESCBIT>)>
	 <RTRUE>>

;"Print FDESCs, then DESCFCNs and LDESCs, then everything else. DESCFCNs
must handle M-OBJDESC? by RTRUEing (but not printing) if the DESCFCN would
like to handle printing the object's description. RFALSE otherwise. DESCFCNs
are responsible for doing the beginning-of-paragraph indentation."

<ROUTINE D-OBJECTS ("AUX" O STR (1ST? T) (AV <LOC ,PROTAGONIST>))
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O>
		<RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O>
			<RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<TELL "   " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <D-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <SET 1ST? T>
	 <REPEAT () ;"DESCFCNS"
		 <COND (<NOT .O>
			<RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET STR <APPLY .STR ,M-OBJDESC>>>
			;" *** make sure descfcns rtrue, after printing!"
			<COND (<AND <FSET? .O ,CONTBIT>
				    <N==? .STR ,M-FATAL>>
			       <D-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)
		       (<SET STR <GETP .O ,P?LDESC>>
			<TELL "   " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <D-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <D-CONTENTS ,HERE <> 0>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<D-CONTENTS .AV <> ,D-ALL? ;"was 0">)>>

<CONSTANT D-ALL? 1> ;"print everything?"
<CONSTANT D-PARA? 2> ;"started paragraph?"

"<D-CONTENTS ,OBJECT-WHOSE-CONTENTS-YOU-WANT-DESCRIBED
		    level: -1 means only top level
			    0 means top-level (include crlf)
			    1 for all other levels
			    or string to print
		    all?: t if not being called from room-desc >"

<ROUTINE ORDER-GRAVEL (OBJ)
	 <COND (<IN? ,EVEN-MORE-GRAVEL .OBJ>
		<MOVE ,EVEN-MORE-GRAVEL .OBJ>)>
	 <COND (<IN? ,MORE-GRAVEL .OBJ>
		<MOVE ,MORE-GRAVEL .OBJ>)>
	 <COND (<IN? ,GRAVEL .OBJ>
		<MOVE ,GRAVEL .OBJ>)>>

<ROUTINE ORDER-FLIES (OBJ)
	 <COND (<IN? ,LARGEST-FLY .OBJ>
		<MOVE ,LARGEST-FLY .OBJ>)>
	 <COND (<IN? ,EVEN-LARGER-FLY .OBJ>
		<MOVE ,EVEN-LARGER-FLY .OBJ>)>
	 <COND (<IN? ,LARGER-FLY .OBJ>
		<MOVE ,LARGER-FLY .OBJ>)>
	 <COND (<IN? ,LARGE-FLY .OBJ>
		<MOVE ,LARGE-FLY .OBJ>)>>

<ROUTINE D-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
  "AUX" (F <>) N (1ST? T) (IT? <>) DB (START? <>) (TWO? <>) (PARA? <>))
  <ORDER-FLIES .OBJ>
  <ORDER-GRAVEL .OBJ>
  <COND (<EQUAL? .LEVEL 2>
	 <SET LEVEL T>
	 <SET PARA? T>
	 <SET START? T>)
	(<BTST .ALL? ,D-PARA?>
	 <SET PARA? T>)>
  <SET N <FIRST? .OBJ>>
  <COND (<OR .START?
	     <IN? .OBJ ,ROOMS>
	     <FSET? .OBJ ,ACTORBIT>
	     <EQUAL? .OBJ ,PROTAGONIST>
	     <AND <FSET? .OBJ ,CONTBIT>
		  <OR <FSET? .OBJ ,OPENBIT>
		      <FSET? .OBJ ,TRANSBIT>>
		  <FSET? .OBJ ,SEARCHBIT>
		  .N>>
	 <REPEAT ()
	  <COND (<OR <NOT .N>
		     <AND <DESCRIBABLE? .N>
			  <OR <BTST .ALL? ,D-ALL?>
			      <SIMPLE-DESC? .N>>>>
		 <COND
		  (.F
		   <COND
		    (.1ST?
		     <SET 1ST? <>>
		     <COND (<EQUAL? .LEVEL <> T>
			    <COND (<NOT .START?>
				   <COND (<NOT .PARA?>
					  <COND (<NOT <EQUAL? .OBJ
							      ,PROTAGONIST>>
						 <TELL "   ">)>
					  <SET PARA? T>)
					 (<EQUAL? .LEVEL T>
					  <TELL " ">)>
				   <COND (<EQUAL? .OBJ ,HERE>
					  <TELL ,YOU-SEE>)
					 (<EQUAL? .OBJ ,PROTAGONIST>
					  <COND (<EQUAL? ,D-BIT ,WORNBIT>
						 <TELL " You are wearing">)
						(T
						 <TELL "You are carrying">)>)
					 (<EQUAL? .OBJ ,YACHT>
					  <TELL
"Sitting on the deck of the royal yacht">
					  <COND (<AND
						  <EQUAL? <CCOUNT .OBJ T> 1>
						  <NOT <FSET? <FIRST? .OBJ>
							      ,PLURALBIT>>>
						 <TELL " is">)
					        (T
						 <TELL " are">)>)
					 (<FSET? .OBJ ,SURFACEBIT>
					  <TELL "Sitting on" T .OBJ>
					  <COND (<AND
						  <EQUAL? <CCOUNT .OBJ T> 1>
						  <NOT <FSET? <FIRST? .OBJ>
							      ,PLURALBIT>>>
						 <TELL " is">)
					        (T
						 <TELL " are">)>)
					 (T
					  <TELL ,IT-SEEMS-THAT T .OBJ>
					  <COND (<FSET? .OBJ ,ACTORBIT>
						 <TELL " has">)
						(T
						 <TELL " contains">)>)>)>)
			   (<NOT <EQUAL? .LEVEL -1>>
			    <TELL .LEVEL>)>)
		    (.N
		     <TELL ",">)
		    (T
		     <TELL " and">)>
		   <TELL A .F>
		   <COND (<FSET? .F ,ONBIT>
			  <TELL " (providing light)">)
			 (<AND <EQUAL? .F ,LARGE-VIAL>
			       <G? ,LARGE-VIAL-GLOOPS 0>>
			  <HOLDING-GLOOPS ,LARGE-VIAL-GLOOPS
					  ,LARGE-VIAL-IMPRECISE>)
			 (<AND <EQUAL? .F ,SMALL-VIAL>
			       <G? ,SMALL-VIAL-GLOOPS 0>>
			  <HOLDING-GLOOPS ,SMALL-VIAL-GLOOPS
					  ,SMALL-VIAL-IMPRECISE>)>
		   <COND (<AND <NOT .IT?> <NOT .TWO?>>
			  <SET IT? .F>)
			 (T
			  <SET TWO? T>
			  <SET IT? <>>)>)>
		 <SET F .N>)>
	  <COND (.N
		 <SET N <NEXT? .N>>)>
	  <COND (<AND <NOT .F>
		      <NOT .N>>
		 <COND (<AND .IT?
			     <NOT .TWO?>>
			<THIS-IS-IT .IT?>)>
		 <COND (<AND .1ST? .START?>
			;<SET 1ST? <>>
			<TELL " nothing">
			<RFALSE>)>
		 <COND (<AND <NOT .1ST?>
			     <EQUAL? .LEVEL <> T>>
			<COND (<EQUAL? .OBJ ,HERE>
			       <TELL " here">)>
			<TELL ".">)>
		 <RETURN>)>>
	 <COND (<EQUAL? .LEVEL <> T>
		<SET F <FIRST? .OBJ>>
		<REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       
		       (<AND <FSET? .F ,CONTBIT>
			     <DESCRIBABLE? .F T>
			     <OR <BTST .ALL? ,D-ALL?>
				 <SIMPLE-DESC? .F>>>
			<SET DB ,D-BIT>
			<SETG D-BIT <>>
			<COND (<D-CONTENTS .F T
						  <COND (.PARA?
							 <+ ,D-ALL? ,D-PARA?>)
							(T
							 ,D-ALL?)>>
			       <SET 1ST? <>>
			       <SET PARA? T>)>
			<SETG D-BIT .DB>)>
		 <SET F <NEXT? .F>>>)>
	 <COND (<AND <NOT .1ST?>
		     <EQUAL? .LEVEL <> T>
		     <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		<CRLF>)>
	 <NOT .1ST?>)>>

<GLOBAL D-BIT <>> ;"bit to screen objects"

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,WINNER>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?>
		     <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)
	       (,D-BIT
		<COND (<G? ,D-BIT 0>
		       <COND (<FSET? .OBJ ,D-BIT>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<NOT <FSET? .OBJ <- ,D-BIT>>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (T
		<RTRUE>)>>

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-OBJDESC?>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE D-VEHICLE () ;"for LOOK AT/IN vehicle when you're in it"
	 <TELL "Other than yourself, you can see"> 
	 <COND (<NOT <D-NOTHING>>
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL " in">)
		      (T
		       <TELL " on">)>
		<TELL TR ,PRSO>)>
	 <RTRUE>>

<ROUTINE D-NOTHING ()
	 <COND (<D-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,PROTAGONIST ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

<ROUTINE HOLDING-GLOOPS (NUM IMPRECISE)
	 <TELL " (holding ">
	 <COND (.IMPRECISE
		<TELL "around ">)>
	 <TELL N .NUM " gloop">
	 <COND (<NOT <EQUAL? .NUM 1>>
		<TELL "s">)>
	 <TELL " of water)">>

;"subtitle movement and death"

;"<CONSTANT REXIT 0>
<CONSTANT UEXIT 1 ;2>
<CONSTANT NEXIT 2 ;3>
<CONSTANT FEXIT 3 ;4>
<CONSTANT CEXIT 4 ;5>
<CONSTANT DEXIT 5 ;6>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1 ;4>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 0 ;1>
<CONSTANT DEXITSTR 1 ;2>
<CONSTANT DEXITRM 5>"

<GLOBAL CURRENT-BORDER <>> ;"set to CASTLE-BORDER in GO"

<ROUTINE GOTO (NEW-LOC "AUX" OHERE OLIT BORDER X)
	 <SETG JUMP-X 99>
	 <SETG JUMP-Y 99>
	 <SETG FINGER-ON-STRAW <>>
	 <SETG ELIXIR-TRAPPED <>>
	 <COND (<IN? ,JESTER ,HERE>
		<REMOVE-J>)>
	 <SET OLIT <LIT? ,HERE>>
	 <SET OHERE ,HERE>
	 <COND (<AND <IN? ,PROTAGONIST ,CAMEL>
		     <FSET? ,CAMEL ,ANIMATEDBIT>>
		<FCLEAR ,CAMEL ,TOUCHBIT>
		<MOVE ,CAMEL .NEW-LOC>)
	       (T
	 	<MOVE ,PROTAGONIST .NEW-LOC>)>
	 <COND (<IN? .NEW-LOC ,ROOMS>
		<SETG HERE .NEW-LOC>)
	       (T
		<SETG HERE <LOC .NEW-LOC>>)>
	 <SETG COMPASS-CHANGED T>
	 <SETG LIT <LIT? ,HERE>>
	 <SET BORDER <SET-BORDER>>
	 <COND (<NOT <EQUAL? .BORDER ,CURRENT-BORDER>>
		<SETG CURRENT-BORDER .BORDER>
		<COND (<AND ,BORDER-ON
			    <NOT <EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>>>
		       <CLEAR-BORDER>
		       <INIT-SL-WITH-SPLIT ,TEXT-WINDOW-PIC-LOC T>)>)>
	 <COND (<NOT ,LIT>
		<RETURN-FROM-MAP>
		<COND (.OLIT
		       <TELL "You have moved into a dark place.">
		       <GRUE-PIT-WARNING>)
		      (<AND <NOT <EQUAL? <LOC ,PROTAGONIST>
					 ,DB ,HOLD ,PIT-BOMB-LOC>>
			    <NOT ,TIME-STOPPED>
			    <PROB 75>>
		       <DARK-DEATH>)
		      (T
		       <TELL ,TOO-DARK>
		       <GRUE-PIT-WARNING>)>)
	       (T
	 	<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 	<COND (<AND <EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>
			    <NOT <FSET? ,HERE ,TOUCHBIT>>>
		       <RETURN-FROM-MAP>)>
		<COND (<AND <NOT <EQUAL? ,CURRENT-SPLIT ,MAP-TOP-LEFT-LOC>>
			    <D-ROOM>
			    <NOT <EQUAL? ,VERBOSITY 0>>>
		       <D-OBJECTS>)>)>
	 <COND (<AND <GLOBAL-IN? ,WATER ,HERE>
		     <SET X <FIND-WATER>>>
		;"so you can say GET WATER FROM OASIS, or whatever"
		<PUTP ,WATER ,P?OWNER .X>)>
	 <SCORE-OBJ ,HERE>
	 <RTRUE>>

<ROUTINE JIGS-UP (DESC)
	 <TELL .DESC>
	 <TELL CR CR
"      ****  You have died  ****" CR>
	 <FINISH>>

;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" L) ;"revised 2/18/86 by SEM"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE ,PROTAGONIST>
		<RTRUE>)
	       (<AND <OR <FSET? .L ,OPENBIT>
			 <IN? ,PROTAGONIST .L> ;"you can be in closed sphere">
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L) ;"revised 5/2/84 by SEM and SWG"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UNTOUCHABLE? (OBJ)
;"figures out whether, due to vehicle-related locations, object is touchable"
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ ,PARCHMENT>
		     ,UNDER-TABLE>
		<RTRUE>)
	       (<AND <EQUAL? .OBJ ,LANTERN>
		     <FSET? ,LANTERN ,TRYTAKEBIT>>
		<RTRUE>)
	       (<ULTIMATELY-IN? .OBJ ,SNAKE-PIT>
		<RTRUE>)
	       (<AND <ULTIMATELY-IN? .OBJ ,YACHT>
		     <IN? ,PROTAGONIST ,HERE>>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,HERE>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ ,YACHT ,LAKE-FLATHEAD ,WEST-DOCK ,EAST-DOCK
			     	  ,NORTH-DOCK ,SOUTH-DOCK>
		     <EQUAL? <LOC ,PROTAGONIST> ,YACHT ,WEST-DOCK ,EAST-DOCK
			     			,NORTH-DOCK ,SOUTH-DOCK>>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ ,WALDO>
		     ,HAND-IN-WALDO
		     <VERB? OPEN CLOSE>>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ ,MEGABOZ-TRAP-DOOR>
		     <IN? ,PROTAGONIST ,LADDER>>
		<RFALSE>)
	       (<OR <ULTIMATELY-IN? .OBJ <LOC ,PROTAGONIST>>
		    <EQUAL? .OBJ <LOC ,PROTAGONIST>>
		    <IN? .OBJ ,GLOBAL-OBJECTS> ;"me, hands, etc.">
		<RFALSE>)
	       (T
		<RTRUE>)>>

;<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on other side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GET .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE HELD? (X Y) <ULTIMATELY-IN? .X .Y>>

<ROUTINE ULTIMATELY-IN? (OBJ "OPTIONAL" (CONT <>)) ;"formerly HELD?"
	 <COND (<NOT .CONT>
		<SET CONT ,PROTAGONIST>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<AND <VERB? EMPTY>
		     <EQUAL? .OBJ ,WATER>
		     <NOUN-USED? ,WATER ,W?GLOOP ,W?GLOOPS>
		     <OR <AND <ULTIMATELY-IN? ,LARGE-VIAL>
			      <G? ,LARGE-VIAL-GLOOPS 0>>
			 <AND <ULTIMATELY-IN? ,SMALL-VIAL>
			      <G? ,SMALL-VIAL-GLOOPS 0>>>>
		<RTRUE>)
	       (<AND <IN? .OBJ ,WALDO>
		     ,HAND-IN-WALDO
		     <VERB? DROP>>
	        <RTRUE>)
	       (<AND ,HAND-IN-WALDO
		     <EQUAL? .OBJ ,WALDO>
		     <EQUAL? .CONT ,PROTAGONIST>>
		;"so syntaxes with HAVE won't say YOU'RE NOT HOLDING THE WALDO"
		<RTRUE>)
	       (<AND <EQUAL? .OBJ ,WATER>
		     <VERB? POUR>
		     <OR <ULTIMATELY-IN? ,LARGE-VIAL-WATER>
			 <ULTIMATELY-IN? ,SMALL-VIAL-WATER>>>
		<RTRUE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       ;(<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<ULTIMATELY-IN? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <COND (<AND .OBJ
		     <NOT <FSET? .OBJ ,INVISIBLE>>
		     <OR <FSET? .OBJ ,TRANSBIT>
			 <FSET? .OBJ ,OPENBIT>
			 <AND <FSET? ,GOGGLES ,WORNBIT>
			      <EQUAL? ,WINNER ,PROTAGONIST>>>>
		<RTRUE>)>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<INTBL? .OBJ1 .TEE </ <PTSIZE .TEE> 2>>)>>

<ROUTINE FIND-IN (WHERE FLAG-IN-QUESTION
		  "OPTIONAL" (STRING <>) "AUX" OBJ RECURSIVE-OBJ)
	 <SET OBJ <FIRST? .WHERE>>
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .OBJ .FLAG-IN-QUESTION>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (.STRING
			       <TELL "[" .STRING T .OBJ "]" CR>)>
			<RETURN .OBJ>)
		       (<SET RECURSIVE-OBJ
			     <FIND-IN .OBJ .FLAG-IN-QUESTION .STRING>>
			<RETURN .RECURSIVE-OBJ>)
		       (<NOT <SET OBJ <NEXT? .OBJ>>>
			<RETURN <>>)>>>

<ROUTINE WITHIN? (TL-X TL-Y BR-X BR-Y) ;"mouse click in rectangle?"
	 ;<COND (,DEBUG
		<TELL CR
"[Calling WITHIN? with X = " N ,MOUSE-LOC-X ", Y = " N ,MOUSE-LOC-Y
"; top-left is " N .TL-X "," N .TL-Y
" and bottom-right is " N .BR-X "," N .BR-Y ".]" CR>)>
	 <COND (<AND <NOT <L? ,MOUSE-LOC-X .TL-X>>
		     <NOT <G? ,MOUSE-LOC-X .BR-X>>
		     <NOT <L? ,MOUSE-LOC-Y .TL-Y>>
		     <NOT <G? ,MOUSE-LOC-Y .BR-Y>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE DIRECTION? (OBJ)
	 <COND (<OR <EQUAL? .OBJ ,P?NORTH ,P?SOUTH ,P?EAST>
		    <EQUAL? .OBJ ,P?WEST ,P?NE ,P?NW>
		    <EQUAL? .OBJ ,P?SE ,P?SW>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOW-DARK? ()
	 <COND (<AND ,LIT
		     <NOT <LIT? ,HERE>>>
		<SETG LIT <>>
		<SETG COMPASS-CHANGED T>
		<TELL "   It is now too dark to see.">
		<COND (<IN? ,JESTER ,HERE>
		       <REMOVE-J>
		       <TELL
" A sound of jingling bells becomes increasingly
distant before fading entirely.">)>
		<CRLF>)>
	 <RTRUE>>

<ROUTINE NOW-LIT? ()
	 <COND (<AND <NOT ,LIT>
		     <LIT? ,HERE>>
		<SETG LIT T>
		<SETG COMPASS-CHANGED T>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE LOC-CLOSED (OBJ "OPTIONAL" (VB T) "AUX" (L <LOC .OBJ>))
	 <COND (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>
		     <FSET? .OBJ ,TAKEBIT>
		     <NOT <IN? ,PROTAGONIST .L>> ;"bathysphere, for example">
		<COND (.VB
		       <DO-FIRST "open" .L>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>
	 <RTRUE>>

<ROUTINE STOP ()
	 <SETG P-CONT -1>
	 <RFATAL>>

<ROUTINE ROB (WHO "OPT" (WHERE <>) (EXCLUDE-WORN-ITEM <>)
	      	  "AUX" (TAKER <>) (TOOK-PIGEON <>) N X)
      <SET X <FIRST? .WHO>>
      <REPEAT ()
	   <COND (<ZERO? .X>
		  <RETURN>)>
	   <SET N <NEXT? .X>>
	   <COND (<AND .EXCLUDE-WORN-ITEM
		       <FSET? .X ,WORNBIT>>
		  T)
		 (.WHERE
		  <FCLEAR .X ,WORNBIT>
		  <COND (<OR .TAKER
			     <AND <IN? .WHERE ,ROOMS>
				  <OR <SET TAKER <FIND-IN .WHERE ,BLACKBIT>>
				      <SET TAKER <FIND-IN .WHERE ,WHITEBIT>>>>>
			 <COND (<EQUAL? .X ,PIGEON>
				<SET TOOK-PIGEON T>)>
			 <MOVE .X .TAKER>)
			(<NOT <SPECIAL-DROP .X T>>
			 <MOVE .X .WHERE>)>)
		 (T
		  <FCLEAR .X ,WORNBIT>
		  <REMOVE .X>)>
	   <SET X .N>>
      <COND (.TAKER
	     <COND (<VISIBLE? .TAKER>
	     	    <TELL
" The " D .TAKER " is only too happy to pick it all up">
		    <COND (<AND .TOOK-PIGEON
				<NOT <EQUAL? ,HERE <META-LOC ,PERCH>>>>
			   <TELL ", including the pigeon.">
			   <PIECE-TAKES-PIGEON .TAKER <> ;"no CR">)
			  (T
			   <TELL ".">)>)
		   (.TOOK-PIGEON
		    <MOVE-TO-PERCH .TAKER>)>)>
      <RTRUE>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR T ,PRSO>
	 <HO-HUM>>

<ROUTINE HO-HUM ()
	 <TELL <PICK-ONE ,HO-HUM-LIST> CR>>

<CONSTANT HO-HUM-LIST
	<LTABLE
	 0 
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<ROUTINE YUKS ()
	 <TELL <PICK-ONE ,YUK-LIST> CR>>

<CONSTANT YUK-LIST
	<LTABLE
	 0 
	 "What a concept!"
	 "Not bloody likely."
	 "A valiant attempt."
         "Nice try."
	 "You can't be serious.">>

<ROUTINE IMPOSSIBLES ()
	 <TELL <PICK-ONE ,IMPOSSIBLE-LIST> CR>>

<CONSTANT IMPOSSIBLE-LIST
	<LTABLE
	 0
	 "Fat chance."
	 "Dream on."
	 "Impossible!!!"
	 "You've got to be kidding."
	 "Out of the question.">>

<ROUTINE WASTES ()
	 <TELL <PICK-ONE ,WASTE-LIST> CR>>

<CONSTANT WASTE-LIST
	<LTABLE
	 0
	 "That would be a waste of time."
	 "There's no point in doing that."
	 "There's another turn down the drain."
	 "Why bother?">>

<END-SEGMENT>