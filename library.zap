
	.SEGMENT "CASTLE"


	.FUNCT	LIBRARY-F,RARG
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PSEUDO-OBJECT,PRSO,PRSI \FALSE
	EQUAL?	PRSA,V?RESEARCH \?CCL8
	ZERO?	LIT /?CCL8
	EQUAL?	PRSI,FALSE-VALUE,ENCYCLOPEDIA,ROOMS \?CCL8
	SET	'VOLUME-USED,TRUE-VALUE
	GETP	PRSO,P?ACTION
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL8:	PUTP	PSEUDO-OBJECT,P?ACTION,FALSE-VALUE
	RFALSE	


	.FUNCT	ENCYCLOPEDIA-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The volume lies open to "
	ZERO?	VOLUME-USED /?CCL6
	PRINTR	"a random entry."
?CCL6:	PRINTI	"an entry about Double Fanucci: "
	ICALL	PERFORM,V?RESEARCH,DOUBLE-FANUCCI
	PRINTR	"   You could probably read about all sorts of other interesting people, places, and things by looking them up in the encyclopedia."
?CCL3:	EQUAL?	PRSA,V?RESEARCH \?CCL8
	EQUAL?	PRSI,ENCYCLOPEDIA \?CCL8
	PRINTR	"""The Encyclopedia Frobozzica, a publication of the Frobozz Magic Encyclopedia Company, is the finest of its kind in the known world. All entries are meticulously compiled by the Frobozz Magic Encyclopedia Research Company, the illustrations are faithfully reproduced by the Frobozz Magic Encyclopedia Illustration Company, and the facts are all double, triple, and quadruple-checked by the Frobozz Magic Encyclopedia Accuracy and Verification Company. No library should be without one!"""
?CCL8:	EQUAL?	PRSA,V?OPEN \?CCL12
	PRINTR	"It is."
?CCL12:	EQUAL?	PRSA,V?CLOSE \?CCL14
	PRINTR	"Why bother?"
?CCL14:	EQUAL?	PRSA,V?TAKE \?CCL16
	PRINTR	"Do you have a team of mules handy?"
?CCL16:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	ICALL	PERFORM,V?READ,PRSO
	RTRUE	


	.FUNCT	ENC-ENTRY-F,?TMP1
	EQUAL?	PRSA,V?RESEARCH \FALSE
	EQUAL?	PRSO,FOUR-FLIES \?CND4
	CALL	ADJ-USED?,FOUR-FLIES,W?INT.NUM
	ZERO?	STACK /?CND4
	EQUAL?	P-NUMBER,4 /?CND4
	SET	'PRSO,FALSE-VALUE
	RFALSE	
?CND4:	GETP	PRSO,P?PICTURE >?TMP1
	GETP	PRSO,P?RESEARCH
	CALL	PICTURED-ENTRY,?TMP1,STACK
	RSTACK	


	.FUNCT	PICTURED-ENTRY,ENC-PIC,ENC-TEXT,NO-WAIT,?TMP1
	CLEAR	-1
	SCREEN	S-FULL
	SET	'CURRENT-SPLIT,ENC-PIC-LOC
	DISPLAY	ENC-BORDER,1,1
	ICALL2	PICINF-PLUS-ONE,ENC-PIC-LOC
	GET	PICINF-TBL,0 >?TMP1
	GET	PICINF-TBL,1
	DISPLAY	ENC-PIC,?TMP1,STACK
	ICALL2	PICINF-PLUS-ONE,ENC-TXT-LOC
	GET	PICINF-TBL,0 >?TMP1
	GET	PICINF-TBL,1
	WINPOS	3,?TMP1,STACK
	PICINF	ENC-TXT-WINDOW-SIZE,PICINF-TBL /?BOGUS1
?BOGUS1:	GET	PICINF-TBL,0 >?TMP1
	GET	PICINF-TBL,1
	WINSIZE	3,?TMP1,STACK
	WINATTR	3,15
	SCREEN	3
	CURSET	1,1
	COLOR	1,-1
	ZERO?	ENC-TEXT /?CCL4
	PRINT	ENC-TEXT
	JUMP	?CND2
?CCL4:	ICALL1	J-ENTRY
?CND2:	COLOR	1,1
	ZERO?	NO-WAIT \TRUE
	ZERO?	DEMO-VERSION? /?CCL9
	ICALL2	INPUT-DEMO,1
	JUMP	?CND7
?CCL9:	INPUT	1
?CND7:	ICALL1	MOUSE-INPUT?
	SET	'CURRENT-SPLIT,TEXT-WINDOW-PIC-LOC
	SCREEN	S-TEXT
	ICALL1	V-$REFRESH
	RTRUE	


	.FUNCT	OTHER-FLATHEADS-F
	EQUAL?	PRSA,V?RESEARCH \FALSE
	CALL	ADJ-USED?,OTHER-FLATHEADS,W?MICHAEL
	ZERO?	STACK /?CCL6
	PRINTR	"""A popular musician, formerly of the Flathead Five."""
?CCL6:	CALL	ADJ-USED?,OTHER-FLATHEADS,W?KING,W?WURB
	ZERO?	STACK /?CCL8
	PRINTR	"""Wurb Flathead, son of Idwit Oogle Flathead, is the current ruler of the Great Underground Empire. The twelfth king in the Flathead dynasty, Wurb assumed the throne in 881 GUE."""
?CCL8:	CALL	ADJ-USED?,OTHER-FLATHEADS,W?OLIVER,W?WENDELL
	ZERO?	STACK /?CCL10
	PRINTR	"""A noted judge."""
?CCL10:	ICALL	PERFORM,V?RESEARCH,BABE-PORTRAIT
	RTRUE	


	.FUNCT	SAINTS-F
	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTI	"""The patron saint of "
	CALL	NOUN-USED?,SAINTS,W?BALHU
	ZERO?	STACK /?CCL6
	PRINTI	"circus performers"
	JUMP	?CND4
?CCL6:	CALL	NOUN-USED?,SAINTS,W?HONKO
	ZERO?	STACK /?CCL8
	PRINTI	"people who play very odd musical instruments"
	JUMP	?CND4
?CCL8:	CALL	NOUN-USED?,SAINTS,W?QUAKKO
	ZERO?	STACK /?CCL10
	PRINTI	"people who aren't sure of things"
	JUMP	?CND4
?CCL10:	CALL	NOUN-USED?,SAINTS,W?WISKUS
	ZERO?	STACK /?CCL12
	PRINTI	"all those who raise meat animals"
	JUMP	?CND4
?CCL12:	PRINTI	"those who design fine slate patios"
?CND4:	PRINTR	"."""


	.FUNCT	WIZARD-OF-FROBOZZ-F
	EQUAL?	PRSA,V?RESEARCH \FALSE
	CALL2	GET-NP,WIZARD-OF-FROBOZZ
	GET	STACK,4
	ZERO?	STACK /?CCL6
	PRINTR	"""A former member of the Circle of Enchanters, the Wizard of Frobozz was removed for forgetfulness bordering on senility. Among his other failings, he developed an inability to cast any spells other than those beginning with the letter 'F'. He was banished to an obscure corner of the Empire after he accidentally turned the entire West Wing of Dimwit Flathead's castle into a mountain of Fudge."""
?CCL6:	PRINTR	"""An ancient province in the northern part of the westlands, Frobozz is the site of many historic sites such as Galepath, Mareilon, and the Castle Largoneth."""


	.FUNCT	ARMOR-F
	EQUAL?	PRSA,V?TOUCH \?CCL3
	INC	'ARMOR-TOUCH
	EQUAL?	ARMOR-TOUCH,3 \?CCL6
	IN?	SCROLL,LOCAL-GLOBALS \?CND7
	REMOVE	SCROLL
?CND7:	MOVE	LANCE,HERE
	PRINTI	"The armor opens and a lance falls out!"
	CRLF	
	CALL2	INC-SCORE,12
	RSTACK	
?CCL6:	EQUAL?	ARMOR-TOUCH,1,2 \FALSE
	PRINTI	"It "
	EQUAL?	ARMOR-TOUCH,2 \?CND11
	PRINTI	"still "
?CND11:	PRINTR	"feels like metal."
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL14
	PRINTR	"The armor is permanently mounted as part of the library decor."
?CCL14:	EQUAL?	PRSA,V?ENTER \?CCL16
	PRINTR	"The armor was made for a much shorter person -- or at least a person with a much flatter head."
?CCL16:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"This battle-scarred armor is the sort that was worn around the time of the Battle of Ragweed Gulch."

	.ENDSEG

	.ENDI
