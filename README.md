/*
 * Filename: README
 * Author: Yash Nevatia
 * Description:	This program takes in three characters and an odd integer to
 				form a large Z with borders in the terminal output. It makes
 				use of assembly functions in the .s files and is called via
 				the main.c file.
 * Date: 31 Janaury 2017
 * Sources of Help      
 */

Compilation: 	Compilation requires all of the following files: drawZ.s,
				isInBounds.s, isOdd.s, main.c, the makefile, numOfDigits.s,
				pa1.h and the some C libraries (stdio.h, stdlib.h, string.h,
				errno.h). Run 'make' (acceses the make file) in the pa1
				directory to compile these files.

How: 			To run the program, enter an integer followed by three
				characters as arguments to ./pa1, for example: ./pa1 7 "0" 'X'
				1. The first character makes the border, the second makes the
				'z' and the last is the filling between the border and the 'z'.

Output:			This is what the output for that example would look like,
				it would be printed to stdout

pa1$ ./pa1 7 "0" 'X' 1

XXXXXXXXX
X0000000X
X1111110X
X1111101X
X1111011X
X1110111X
X1101111X
X1011111X
X0111111X
X0000000X
XXXXXXXXX

				This is what an erroneous output would loook like, it would
				print to stderr

pa1$ ./pa1 5 $'\n' b c

Z character 10 not in bounds [32-126].
Usage: ./pa1 width zChar borderChar fillerChar
      width -- an odd integer representing the width of the Z pattern, border
            is derived from this, but not included in it.
            Must be in the range of [3-1001]
      zChar -- the character used to draw the actual Z shape,  must not be
            the same as the border or filler characters.
            Must be in the range of ASCII [32-126]
      borderChar -- character to use to draw the border.
                  Must be in the range of ASCII [32-126]
      fillerChar -- character used to fill the drawing.
                  Must be in the range of ASCII [32-126]

Testing:		The logic-based assembly files (isInBounds, isOdd, and
				numOfDigits) were tested independently to make sure that their
				outputs were accurate. These are some of the inputs used to make
				sure that the outputs matched with expectations, testing the
				program

Normal									For Errors
./pa1 11 ' ' '|' X 						./pa1 5 a a a a
./pa1 5 '^' z " " 						./pa1
./pa1 7 "0" 'X' 1 						./pa1 5a a a a
./pa1 5 $'\40' $'\x21' '#' 				./pa1 9999999999999999 a a a

Questions: 		1.	x/s $i0
				2.	p/d $i2
				3.	p/x $i1
				4.	a. p w
					b. display $o0
				5.	x/c endptr
				6.	p/s endptr
				7.	p/d errno
				8.	git status
				9.	git checkout -- file
				10.	git diff file
				11.	I wrote all the code independently and looked to man pages 
					and the tutors when I needed help.


