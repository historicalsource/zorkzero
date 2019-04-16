"FIND file for NEW PARSER
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

<ZZSECTION "FIND">

<INCLUDE "BASEDEFS" "PDEFS" "PBITDEFS">

<USE "NEWSTRUC" "PARSER" "PMEM">

<FILE-FLAGS MDL-ZIL? CLEAN-STACK? ;ZAP-TO-SOURCE-DIRECTORY?>

<BEGIN-SEGMENT 0>

<PUT-DECL BOOLEAN '<OR ATOM FALSE>>

<DEFMAC FD-FLAG (WHICH 'VAL "OPT" 'NEW)
  <COND (<ASSIGNED? NEW>
	 <COND (<OR <TYPE? .NEW ATOM FALSE>
		    <AND <TYPE? .NEW FORM>
			 <EMPTY? .NEW>>>
		<COND (<TYPE? .NEW ATOM>
		       ;"Just turning flag on"
		       <FORM ORB ,.WHICH .VAL>)
		      (T
		       <FORM ANDB .VAL <XORB ,.WHICH -1>>)>)
	       (<TYPE? .VAL FIX LVAL GVAL>
		<FORM COND
		      (.NEW
		       <FORM ORB .VAL ,.WHICH>)
		      (T
		       <FORM ANDB .VAL <XORB ,.WHICH -1>>)>)
	       (T
		<FORM BIND ((FLAG .VAL))
		  <FORM COND
			(.NEW
			 <FORM ORB ,.WHICH '.FLAG>)
			(T
			 <FORM ANDB '.FLAG <XORB ,.WHICH -1>>)>>)>)
	(T
	 <FORM NOT <FORM 0? <FORM ANDB .VAL ,.WHICH>>>)>>

<MSETG FIND-FLAGS-GWIM 1>
<DEFMAC FIND-GWIM? ('F)
  <FORM NOT <FORM 0? <FORM ANDB <FORM FIND-FLAGS .F> ,FIND-FLAGS-GWIM>>>>

<CONSTANT FINDER <MAKE-FINDER>>
<GLOBAL P-NOT-HERE:NUMBER ;BYTE 0>

"FIND-DESCENDANTS, MATCH-OBJECT, and ADD-OBJECT all return false when the
 search should be stopped prematurely because some object was an exact
 match.  If there's a big red book and a big ugly red book, BIG RED BOOK
 will get the former, since it's the only way to do so."

<DEFINE FIND-DESCENDANTS FD
	(PARENT:OBJECT FLAGS:FIX ;"INCLUDE, SEARCH, NEST, NOTOP"
	 "AUX" (F ,FINDER) FOBJ:<OR FALSE OBJECT>)
  <COND (<EQUAL? .PARENT ,GLOBAL-HERE>
	 <SET PARENT ,HERE>)>
  <COND (<SET FOBJ <FIRST? .PARENT>>
	 ;"This guy contains something"
	 <REPEAT ()
	   ;"See if the current object matches: if so, add it to the list"
	   <COND
	    (<VISIBLE? .FOBJ>
	     <COND (<AND <NOT <FD-FLAG FD-NOTOP? .FLAGS> ;<BTST .FLAGS 8>>
			 <NOT <MATCH-OBJECT .FOBJ .F
					    <FD-FLAG FD-INCLUDE? .FLAGS>
					    ;<BTST .FLAGS 1>>>>
		    <RETURN <> .FD>)>
	     <COND (<AND <FD-FLAG FD-NEST? .FLAGS> ;<BTST .FLAGS 4>
			 <FIRST? .FOBJ>
			 <N==? .FOBJ ,WINNER>
			 <OR ;,P-MOBY-FLAG
			     <AND <FSET? .FOBJ ,SEARCHBIT>
				  <OR <FSET? .FOBJ ,OPENBIT>
				      <FSET? .FOBJ ,TRANSBIT>>>
			     <FSET? .FOBJ ,SURFACEBIT>>>
		    ;"Check its contents"
		    <COND (<NOT <FIND-DESCENDANTS .FOBJ
				 <FD-FLAG FD-INCLUDE? ,FD-NEST?
					  <FD-FLAG FD-INCLUDE? .FLAGS>>
				 ;<COND (<BTST .FLAGS 1> 5) (T 4)>>>
			   <RETURN <> .FD>)>)>)>
	   ;"Check next sibling"
	   <COND (<NOT <SET FOBJ <NEXT? .FOBJ>>>
		  <RETURN T .FD>)>>)
	(T)>>

<DEFINE EXCLUDED? EX (FOBJ:OBJECT F:FINDER
			  "AUX" (EXC:<OR FALSE PMEM> <FIND-EXCEPTIONS .F>))
  <COND (.EXC
	 <REPEAT ((PHRASE:PMEM <NPP-NOUN-PHRASE .EXC>)
		  (CT:FIX <NOUN-PHRASE-COUNT .PHRASE>)
		  (VEC <REST-TO-SLOT .PHRASE NOUN-PHRASE-OBJ1>) VV)
		 <REPEAT ()
			 <COND (<L? <SET CT <- .CT 1>> 0>
				<SET VV <>>
				<RETURN>)>
			 <COND (<==? .FOBJ <ZGET .VEC 0>>
				<SET VV T>
				<RETURN>)>
			 <SET VEC <ZREST .VEC 4 ;2>>>
		 <COND (.VV
			<RETURN T .EX>)
		       (<SET EXC <NPP-NEXT .EXC>>
			<SET PHRASE <NPP-NOUN-PHRASE .EXC>>
			<SET CT <NOUN-PHRASE-COUNT .PHRASE>>
			<SET VEC <REST-TO-SLOT .PHRASE NOUN-PHRASE-OBJ1>>)
		       (T
			<RETURN <> .EX>)>>)>>

<DEFINE MATCH-OBJECT (FOBJ:OBJECT F:FINDER INCLUDE?:BOOLEAN
		      "AUX" NOUN ADJS APP TB (RES <FIND-RES .F>))
  <COND (<AND <NOT <FSET? .FOBJ ,INVISIBLE>>
	      <OR <EQUAL? <SET NOUN <FIND-NOUN .F>> <> ,W?ONE>
		  <AND <SET TB <GETPT .FOBJ ,P?SYNONYM>>
		       <ZMEMQ .NOUN .TB </ <PTSIZE .TB>:FIX 2>>>>
	      <OR <NOT <SET ADJS <FIND-OF .F>>>
		  <CHECK-ADJS .FOBJ .F .ADJS>>
	      <OR <NOT <SET ADJS <FIND-ADJS .F>>>
		  <CHECK-ADJS .FOBJ .F .ADJS>>
	      <NOT <EXCLUDED? .FOBJ .F>>
	      <OR <FIND-GWIM? .F>
		  <NOT <INVALID-OBJECT? .FOBJ>>>>
	 ;"This object matches the words used..."
	 <COND (<NOT .INCLUDE?>	;"location didn't match the syntax bits"
		T)
	       (<AND <T? <SET ADJS <FIND-ADJS .F>>>
		     <EQUAL? <ADJS-COUNT .ADJS>
			     <COND (T ;<CHECK-EXTENDED?>
				    </ <PTSIZE <GETPT .FOBJ ,P?ADJECTIVE>> 2>)
			   ;(T <- <PTSIZE <GETPT .FOBJ ,P?ADJECTIVE>> 1>)>>>
		;"the only way to do so."
		<FIND-RES-COUNT .RES 1>
		<FIND-RES-NEXT .RES <>>
		<FIND-RES-OBJ1 .RES .FOBJ>
		<COND (<EQUAL? .FOBJ ,HERE>
		       <FIND-RES-OBJ1 .RES ,GLOBAL-HERE>)>
		<>)
	       (<AND <T? <SET APP <FIND-APPLIC .F>>>
		     <NOT <FIND-GWIM? .F>>>
		;"We're not GWIMming, so apply the test only if there's an
		   ambiguity"
		<COND (<OR <0? <FIND-RES-COUNT .RES>>
			   <FIND-QUANT .F>>
		       ;"Don't have anything yet"
		       <ADD-OBJECT .FOBJ .F>)
		      (<TEST-OBJECT .FOBJ .APP .F>
		       ;"We already have something, so first find out if
			  this one's OK"
		       <COND (<1? <FIND-RES-COUNT .RES>>
			      ;"There's only one other object"
			      <COND (<NOT <TEST-OBJECT
					       <FIND-RES-OBJ1 .RES>
					       .APP .F>>
				     ;"The other object doesn't match, so just
					replace it"
				     <FIND-RES-OBJ1 .RES .FOBJ>
				     <COND (<EQUAL? .FOBJ ,HERE>
					   <FIND-RES-OBJ1 .RES ,GLOBAL-HERE>)>
				     T)
				    (T
				     ;"The other object also matches, so
					we're stuck"
				     <ADD-OBJECT .FOBJ .F>)>)
			     (T
			      ;"We already have more than one object, so
				 we're losing"
			      <ADD-OBJECT .FOBJ .F>)>)>)
	       (<F? .APP>
		<COND (<OR <NOT <FIND-GWIM? .F>>
			   <FIND-QUANT .F>>	;"DETERMINE-OBJ w/ PICK"
		       <ADD-OBJECT .FOBJ .F>)
		      (T)>)
	       (<TEST-OBJECT .FOBJ .APP .F>
		<ADD-OBJECT .FOBJ .F>)
	       (T)>)
	(T)>>

<MSETG SYN-FIND-PROP *400*>	;"If set, look for this property"

<DEFINE TEST-OBJECT TO (FOBJ:OBJECT APP:<OR FIX TABLE> F:FINDER)
  <COND (<NOT <TABLE? .APP>>
	 <COND (<NOT <0? <ANDB .APP ,SYN-FIND-NEGATE>>>
		<NOT <FSET? .FOBJ <ANDB .APP *77*>>>)
	       (T
		<FSET? .FOBJ .APP>)>)
	(T
	 <COND (<NOT <0? <ANDB <ZGET .APP 1> ,SYN-FIND-PROP>>>
		<COND (<EQUAL? <GETP .FOBJ <ANDB <ZGET .APP 1> *77*>>
			       <ZGET .APP 2>>
		       <RETURN T .TO>)
		      (T <RETURN <> .TO>)>)>
	 <REPEAT ((N:FIX <ZGET .APP 0>) NN)
	   <SET NN <ZGET .APP .N>>
	   <COND (<NOT <0? <ANDB .NN ,SYN-FIND-NEGATE>>>
		  <COND (<NOT <FSET? .FOBJ <ANDB .NN *77*>>>
			 <RETURN T .TO>)>)
		 (<FSET? .FOBJ .NN>
		  <RETURN T .TO>)>
	   <COND (<L? <SET N <- .N 1>> 1>
		  <RETURN <> .TO>)>>)>>

"Object matches all other tests.  Here do checks with quantities
   (all, one, etc.), then add if OK."
<DEFINE ADD-OBJECT (OBJ:OBJECT F:FINDER "AUX" (VEC <FIND-RES .F>) NC
		    (DOIT? T) (SYN <FIND-SYNTAX .F>) (WHICH <FIND-WHICH .F>))
  <COND (<EQUAL? .OBJ ,HERE>
	 <SET OBJ ,GLOBAL-HERE>)>	;"per PDL 29-Apr-88"
  <COND (<AND <NOT <FIND-QUANT .F>>
	      .SYN
	      <==? 1 <FIND-RES-COUNT .VEC>:FIX>>
	 <COND (<MULTIPLE-EXCEPTION? .OBJ .SYN .WHICH .F>
		<SET DOIT? <>>)
	       (<MULTIPLE-EXCEPTION? <FIND-RES-OBJ1 .VEC> .SYN .WHICH .F>
		<FIND-RES-OBJ1 .VEC .OBJ>
		<SET DOIT? <>>)>)>
  <COND (<AND .DOIT?
	      <OR <NOT <FIND-QUANT .F>>
		  <NOT <FIND-SYNTAX .F>>
		  <NOT <MULTIPLE-EXCEPTION? .OBJ	;"wrong theory of ALL?"
					    <FIND-SYNTAX .F>
					    <FIND-WHICH .F>
					    .F>>>
	      ;"In case an object gets found twice..."
	      <SET WHICH <NOT-IN-FIND-RES? .OBJ .VEC>>>
	 <FIND-RES-COUNT .VEC ;<SET NC > <+ 1 <FIND-RES-COUNT .VEC>>>
	 <COND ;(<AND <IN? <SET NC <META-LOC .OBJ>> ,ROOMS>
		     <NOT <EQUAL? .NC <META-LOC ,WINNER>>>>
		<ZPUT .WHICH 0 <- 0 .OBJ>>)	;"adjacent room"
	       (T
		<ZPUT .WHICH 0 .OBJ>)>
	 ;<COND (<L=? .NC <FIND-RES-SIZE .VEC>>
		<ZPUT <REST-TO-SLOT .VEC FIND-RES-OBJ1>
		      <- .NC 1>
		      .OBJ>)>
	 <N==? <FIND-QUANT .F> ,NP-QUANT-A>)
	(T)>>

<DEFINE NOT-IN-FIND-RES? ACT (OBJ VEC "OPT" (NO-CHANGE? <>))
 <REPEAT ((CT <FIND-RES-COUNT .VEC>)
	  (SZ <FIND-RES-SIZE .VEC>) ANS NVEC)
	 <SET ANS <REST-TO-SLOT .VEC FIND-RES-OBJ1>>
	 <COND (<L? .CT 1>
		<RETURN .ANS .ACT>)
	       (<G? .CT .SZ>
		<SET CT <- .CT .SZ>>)
	       (T <SET SZ .CT>)>
	 <COND (<INTBL? .OBJ .ANS .SZ>
		<RETURN <> .ACT>)
	       (<T? <SET NVEC <FIND-RES-NEXT .VEC>>>
		<SET VEC .NVEC>
		<SET SZ ,FIND-RES-MAXOBJ ;<OBJLIST-SIZE .VEC>>)
	       (<L? .SZ ,FIND-RES-MAXOBJ ;<FIND-RES-SIZE .VEC>>
		<RETURN <ZREST .ANS <* 2 .SZ>> .ACT>)
	       (<T? .NO-CHANGE?>
		<RETURN T .ACT>)
	       (T
		<SET SZ ,FIND-RES-MAXOBJ ;<FIND-RES-SIZE .VEC>>
		<SET NVEC <PMEM-ALLOC OBJLIST
				      ;"SIZE .SZ"
				      LENGTH <- ,FIND-RES-LENGTH 1>>>
		<FIND-RES-NEXT .VEC .NVEC>
		<RETURN <REST-TO-SLOT .NVEC FIND-RES-OBJ1> .ACT>)>>>

"EVERYWHERE-VERB? -- separately defined so game can call it"

<DEFINE EVERYWHERE-VERB? ("OPT" (WHICH <FIND-WHICH ,FINDER>)
				(SYNTAX <PARSE-SYNTAX ,PARSE-RESULT>)
			  "AUX" SYN)
	<COND (<==? .WHICH 1>
	       <SET SYN <SYNTAX-SEARCH .SYNTAX 1>>)
	      (T
	       <SET SYN <SYNTAX-SEARCH .SYNTAX 2>>)>
	<COND (<AND <ANDB ,SEARCH-MOBY .SYN>
		    <NOT <ANDB ,SEARCH-MUST-HAVE .SYN>>>
	       T)>>

"MULTIPLE-EXCEPTION? -- return true if an object found by ALL should not
be include when the crunch comes."

<DEFINE MULTIPLE-EXCEPTION? (OBJ:OBJECT SYNTAX:VERB-SYNTAX WHICH:FIX F:FINDER
			     "AUX" (L <LOC .OBJ>) (VB <SYNTAX-ID .SYNTAX>))
 <COND (<EQUAL? .OBJ <> ,ROOMS ;,NOT-HERE-OBJECT>
	<SETG P-NOT-HERE <+ 1 ,P-NOT-HERE>>
	T)
       (<AND <0? <EVERYWHERE-VERB? .WHICH .SYNTAX>>
	     <NOT <ACCESSIBLE? .OBJ>>>
	T)
       (<AND <==? .VB ,V?TAKE>
	     <ZERO? <FIND-NOUN .F>>
	     <1? .WHICH>>
	<COND (<AND <NOT <FSET? .OBJ ,TAKEBIT>>
		    <NOT <FSET? .OBJ ,TRYTAKEBIT>>>
	       T)
	      (<EQUAL? .L ,WINNER>
	       ;<AND <NOT <EQUAL? .L ,WINNER <LOC ,WINNER> ,HERE>>
		    <NOT <FSET? .L ,SURFACEBIT>>
		    <NOT <FSET? .L ,SEARCHBIT>>>
	       T)>)
       (<==? .VB ,V?DROP>
	<COND (<NOT <IN? .OBJ ,WINNER>>
	       T)>)
      ;(<AND ,PRSI
	     <==? ,PRSO ,PRSI>>
	;"VERB ALL and prso = prsi"
	<RTRUE>)
      ;(<AND <==? .VB ,V?PUT>
	     <NOT <IN? .OBJ ,WINNER>>
	     <HELD? ,PRSO ,PRSI>>
	;"PUT ALL IN X and object already in x"
	<RTRUE>)>>

<ADD-WORD OPEN ADJ>
<ADD-WORD CLOSED ADJ>
<ADD-WORD SHUT ADJ>

<DEFINE CHECK-ADJS CA (OBJ:OBJECT F ADJS:PMEM
		       "AUX" CNT (TMP <>) OWNER (ID <>) VEC)
  <SET OWNER <GETP .OBJ ,P?OWNER>>
  <COND (<OR <PMEM-TYPE? .ADJS NP>	;"it's NP-OF"
	     <SET TMP <ADJS-POSS .ADJS>>>
	 <COND (<OBJECT? <SET ID .OWNER>>
		<COND (<EQUAL? .OWNER .TMP .OBJ>
		       T)
		      (<EQUAL? .OWNER ,ROOMS ;"any">
		       <SET ID <FIND-RES-OBJ1 ,OWNER-SR-HERE>> ;"real owner")
		      (<ZERO? <SET TMP <FIND-RES-COUNT ,OWNER-SR-THERE>>>
		       <RETURN <> .CA>)
		      (<NOT <INTBL? .OWNER
			       <REST-TO-SLOT ,OWNER-SR-THERE FIND-RES-OBJ1>
			       .TMP>>
		       <RETURN <> .CA>)>)
	       (<T? .OWNER>	;"table for multiple owners (body parts)"
		;<SET ID <>>
		<COND (<AND ;<ZERO? .ID>
			    <ZERO? <SET CNT <FIND-RES-COUNT ,OWNER-SR-HERE>>>
			    ;<SET ID <INTBL? ,PLAYER .TMP <ZGET .OWNER 0>>>>
		       <SET ID ,PLAYER>	;"default owner of body part"
		       ;<SET ID <ZGET .ID 0>>)
		      (T
		       <SET TMP <ZREST .OWNER 2>>
		       <SET VEC <REST-TO-SLOT ,OWNER-SR-HERE FIND-RES-OBJ1>>
		       <REPEAT ()
			<COND (<DLESS? CNT 0>
			       <RETURN <> .CA>)
			      (<SET ID
				<INTBL? <ZGET .VEC 0> .TMP <ZGET .OWNER 0>>>
			       <SET ID <ZGET .ID 0>>
			       <RETURN>)
			      (T <SET VEC <ZREST .VEC 2>>)>>)>)
	       (<OBJECT? .TMP>		;"possession"
		<COND (<NOT <HELD? .OBJ .TMP>>
		       <RETURN <> .CA>)>)
	       (T			;"possession"
		<COND (<ZERO? <SET TMP <FIND-RES-COUNT ,OWNER-SR-HERE>>>
		       <RETURN <> .CA>)
		      (<NOT <SET ID <INTBL? <LOC .OBJ>
				<REST-TO-SLOT ,OWNER-SR-HERE FIND-RES-OBJ1>
				.TMP>>>
		       <RETURN <> .CA>)
		      ;(T <SET ID <ZGET .ID 0>>)>)>)>
  <COND (<NOT <EQUAL? .ID 0 .OBJ>>	;<T? .ID>
	 <FIND-RES-OWNER <FIND-RES .F> .ID>)>
  <COND (<NOT <PMEM-TYPE? .ADJS NP>>
	 <SET VEC <REST-TO-SLOT .ADJS ADJS-COUNT 1>>
  <REPEAT ((CT <ADJS-COUNT .ADJS>) ADJ FL
	   (OADJS <GETPT .OBJ ,P?ADJECTIVE>)
	   (NUM </ <PTSIZE .OADJS>:FIX 2>))
    <COND (<L? <SET CT <- .CT 1>> 0>
	   <RETURN>)>
    <COND
     (T ;<CHECK-EXTENDED?>
      <SET ADJ <ZGET .VEC .CT>>
      <SET ID .ADJ>)
     ;(T
      <COND (<0? <SET ID <WORD-ADJ-ID <SET ADJ <ZGET .VEC .CT>>>>>
	     <COND (<NOT <IF-MUDDLE <COND (<GASSIGNED? SPECIAL-ADJ-CHECK>
					   <SPECIAL-ADJ-CHECK .ADJ .OBJ>)>
				    <SPECIAL-ADJ-CHECK .ADJ .OBJ>>>
		    <RETURN <> .CA>)>)>)>
    <COND (<EQUAL? .ADJ ,W?NO.WORD>
	   <AGAIN>)
	  (<ZMEMQ .ID .OADJS .NUM>
	   ;<COND (T ;<CHECK-EXTENDED?>
		  )
		 ;(T <ZMEMQB .ID .OADJS <- <PTSIZE .OADJS>:FIX 1>>)>)
	  (<AND <EQUAL? .ID ,W?CLOSED ,W?SHUT>
		<NOT <FSET? .OBJ ,OPENBIT>>>)
	  (<AND <EQUAL? .ID ,W?OPEN>
		<FSET? .OBJ ,OPENBIT>>)
	  ;(<VERSION? (ZIP <>)
		     (T
		      <IF-MUDDLE <AND <GASSIGNED? SPECIAL-ADJ-CHECK>
				      <SPECIAL-ADJ-CHECK .ADJ .OBJ>>
				 <SPECIAL-ADJ-CHECK .ADJ .OBJ>>)>)
	  (T
	   <RETURN <> .CA>)>>)>
  T>

<OBJECT GENERIC-OBJECTS
	(ADJACENT 0)	;"to establish property">

<DEFINE FIND-OBJECTS ("OPT" (SEARCH:FIX
			     <COND (<==? 1 <FIND-WHICH ,FINDER>>
				    <SYNTAX-SEARCH <PARSE-SYNTAX ,PARSE-RESULT>
						   1>)
				   (T
				    <SYNTAX-SEARCH <PARSE-SYNTAX ,PARSE-RESULT>
						   2>)>)
			    (PARENT:<OR OBJECT FALSE> <>)
		      "AUX" GLBS (CONT? T) N:FIX (RES <FIND-RES ,FINDER>))
  ;<MAKE-FIND-RES 'FIND-RES .RES 'FIND-RES-COUNT 0>
  <FIND-RES-COUNT .RES 0>
  <FIND-RES-NEXT .RES <>>
  ;"Initialize world"
  <COND (<AND .PARENT
	      ;<NOT <IN? .PARENT ,GLOBAL-OBJECTS>>
	      <OR <NOT <FIND-DESCENDANTS .PARENT
				<ORB ,FD-INCLUDE? ,FD-SEARCH? ,FD-NEST?>;7>>
		  <NOT <0? <FIND-RES-COUNT .RES>:FIX>>>>
	 ;"In case we have `the foo in the bar' or `a picture on the wall'"
	 ;<SET CONT? <>>
	 T)
	(T
	  <COND (.PARENT
		 <COND (<NOT <SET GLBS <FIND-ADJS ,FINDER>>>
			<FIND-ADJS ,FINDER
				  <SET GLBS <PMEM-ALLOC ADJS>>>)>
		 <COND (<NOT <ADJS-POSS .GLBS>>
			<ADJS-POSS .GLBS .PARENT>)>)>
	  <COND (<AND <T? <ANDB .SEARCH ,SEARCH-MOBY ;128>>
		      <F? <ANDB .SEARCH ,SEARCH-MUST-HAVE>>
		      <FIRST? ,GENERIC-OBJECTS>
		      ;<NOT <FIND-DESCENDANTS ,GENERIC-OBJECTS .SEARCH>>>
		 <REPEAT ((OBJ <FIRST? ,GENERIC-OBJECTS>))
			 <COND (<NOT <MATCH-OBJECT .OBJ ,FINDER T>>
				<RETURN>)
			       (<NOT <SET OBJ <NEXT? .OBJ>>>
				<RETURN>)>>
		 <COND (<NOT <0? <SET CONT? <FIND-RES-COUNT .RES>>:FIX>>
			<RETURN <1? .CONT?:FIX>>)>)>
	 <PROG ((LOSING? <>))
	   <COND
	    (<OR <AND <NOT .LOSING?>	;"redundant?"
		      <NOT <0? <ANDB .SEARCH ,SEARCH-CARRIED ;12>>>>
		 .LOSING?>
	     <SET CONT?
		  <FIND-DESCENDANTS ,WINNER
		   <FD-FLAG FD-NOTOP?
		    <FD-FLAG FD-INCLUDE?
		     <FD-FLAG FD-NEST? ,FD-SEARCH?
		      <OR .LOSING? ;"search pockets?"
			  <NOT <0? <ANDB .SEARCH ,SEARCH-POCKETS ;8>>>>>
		     <OR .LOSING?
			 <NOT <0? <ANDB .SEARCH ,SEARCH-CARRIED ;12>>>>>
		    <AND <NOT .LOSING?>
			 <0? <ANDB .SEARCH ,SEARCH-HELD ;4>>>>>>)>
	   <COND
	    (<OR .LOSING?
		 <NOT <0? <ANDB .SEARCH ,SEARCH-IN-ROOM ;3>>>>
	     <SET CONT?
		  <FIND-DESCENDANTS ,HERE
		   <FD-FLAG FD-NOTOP?
		    <FD-FLAG FD-NEST?
		     <FD-FLAG FD-INCLUDE? ,FD-SEARCH?
		      <AND ;,LIT
			   <OR .LOSING?
			       <NOT <0? <ANDB .SEARCH ,SEARCH-IN-ROOM ;3>>>>>>
		     <OR .LOSING?
			 <NOT <0? <ANDB .SEARCH ,SEARCH-OFF-GROUND ;2>>>>>
		    <AND <NOT .LOSING?>
			 <0? <ANDB .SEARCH ,SEARCH-ON-GROUND ;1>>>>>>)>
	   <COND (<NOT <0? <FIND-RES-COUNT .RES>>>
		  <RETURN>)
		 (<AND <NOT <BTST .SEARCH ,SEARCH-ALL>>
		       <NOT .LOSING?>>
		  <COND (<AND <SET GLBS <LEXV-WORD ,TLEXV>>
			      <OR <T? <WORD-CLASSIFICATION-NUMBER .GLBS>>
				  <T? <WORD-SEMANTIC-STUFF .GLBS>>>>
			 <SET LOSING? T>	;"not a sample command"
			 <AGAIN>)
			(<AND <BAND ,SEARCH-MUST-HAVE .SEARCH>
			      <NOT <BAND ,SEARCH-MOBY .SEARCH>>>
			 <RFALSE>)>)>
	   <COND (<SET GLBS <GETPT ,HERE ,P?GLOBAL>>
		  <COND (T ;<CHECK-EXTENDED?>
			   <SET N </ <PTSIZE .GLBS>:FIX 2>>)
			;(T <SET N <- <PTSIZE .GLBS>:FIX 1>>)>
		  <REPEAT (O:OBJECT)
		    <COND (<L? <SET N <- .N 1>> 0>
			   <RETURN>)
			  (<NOT <SET CONT?
				     <MATCH-OBJECT
				      <COND (T ;<CHECK-EXTENDED?>
						<SET O <ZGET .GLBS .N>>)
					    ;(T  <SET O <GETB .GLBS .N>>)>
				      ,FINDER T>>>
			   <RETURN>)
			  (<AND <FIRST? .O>
				<ZAPPLY ,SEARCH-IN-LG? .O>
				<NOT <0? <ANDB .SEARCH ,SEARCH-OFF-GROUND>>>>
			   <COND
			    (<NOT
			      <SET CONT?
				   <FIND-DESCENDANTS .O ,FD-INCLUDE? ;1>>>
			     <RETURN>)>)>>)>
	   <COND (<AND .CONT?
		       <NOT <EXCLUDE-HERE-OBJECT?>>>
		  <SET CONT? <MATCH-OBJECT ,HERE ,FINDER T>>)>
	   <COND (<AND .CONT? <GETP ,HERE ,P?THINGS>>
		  <SET CONT? <ZAPPLY ,TEST-THINGS ,HERE ,FINDER>>)>
	   <COND (<NOT <0? <FIND-RES-COUNT .RES>>>
		  <SET CONT? <>>)>
	   <COND (.CONT?
		  <SET CONT?
		       <FIND-DESCENDANTS ,GLOBAL-OBJECTS
			<FD-FLAG FD-NEST? ,FD-INCLUDE?
			 <NOT <0? <ANDB .SEARCH ,SEARCH-OFF-GROUND ;2>>>>
			;<COND (<BTST .SEARCH 2> 5) (T 1)>>>)>
	   <COND (<AND .CONT?
		       <0? <FIND-RES-COUNT .RES>:FIX>
		       ;<BTST .SEARCH ,SEARCH-ADJACENT>
		       <SET GLBS <GETP ,HERE ,P?ADJACENT>>>
		  <SET N <GETB .GLBS 0>>
		  ;<SET LOSING? ,HERE>
		  <REPEAT ((SCH <ANDB .SEARCH <XORB -1 ,SEARCH-ADJACENT>>))
		    <COND (<T? <GETB .GLBS .N>>	;"room visible now?"
			   ;<SETG HERE <GETB .GLBS <SET N <- .N 1>>>>
			   <FIND-OBJECTS .SCH <GETB .GLBS <SET N <- .N 1>>>>)
			  (T
			   <SET N <- .N 1>>)>
		    <COND (<L? <SET N <- .N 1>> 1>
			   <RETURN>)>>
		  ;<SETG HERE .LOSING?>
		  <COND (<NOT <0? <FIND-RES-COUNT .RES>:FIX>>
			 <SET CONT? <>>)>)>
	   <COND
	    (<AND .CONT?
		  <0? <FIND-RES-COUNT .RES>:FIX>
		  <ZAPPLY ,MOBY-FIND? .SEARCH>>
	     <REPEAT ((OBJ 1))
	         <COND (<AND <NOT <FSET? .OBJ ,INVISIBLE>>
			     ;<NOT <IN? .OBJ ,ROOMS>>>
			<COND (<NOT <MATCH-OBJECT .OBJ ,FINDER T>>
			       <RETURN>)>)>
		 <COND (<G? <SET OBJ <+ .OBJ 1>> ,LAST-OBJECT>
			<RETURN>)>>)>>)>
  ;<COND (<AND <L? 1 <FIND-RES-COUNT .RES>:FIX>
	      <FIND-OF ,FINDER>>
	 <MATCH-OF-OBJECTS .RES>)>
  <1? <FIND-RES-COUNT .RES>:FIX>>

<END-SEGMENT>
<END-DEFINITIONS>
