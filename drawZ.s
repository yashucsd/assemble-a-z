/*
 * Filename: drawZ.s
 * Author: Yash Nevatia
 * Description: This assembly module will perform the actual outputting of
 				individual characters (via calls to printChar()) such that the
 				‘Z’ character is displayed with the user-supplied values
 * Date: 31 January 2017
 * Sources of Help:
 */ 
 	.global drawZ		! Declares the sumbol to be globally visible so
						! we can call this function from other modules.
  	.section ".data"    ! The data segment begins here
 fmt:                   ! Formatted string used for printf()
    .asciz "\n"

	.section ".text"	! The text segment begins here
/*
 * Function name: drawZ()
 * Function prototype: 	void drawZ( long width, long zChar, long borderChar,
 						long fillerChar );
 * Description: displays character 'Z' w user supplied values
 * Parameters:
 *	arg 1: width -- the width of the Z
 * 	arg 2: zChar -- the character to make the Z with
 *  arg 3: borderChar -- the character to make the border with
 * 	arg 4: fillerChar -- the character to make the filler with
 * 
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: None
 *
 * Registers Used:
 * 	%i0 - width -- the width of the Z
 * 	%i1 - zChar -- the character to make the Z with
 * 	%i2 - borderChar -- the character to make the border with
 * 	%i3 - fillerChar -- the character to make the filler with
 * 	
 * 	%l0 - numDigits -- the number of digits in width
 * 	%l1 - totalWidth -- the total width of the output
 *  %l2 - index -- index for loops A, C, E
 * 	%l3 - index -- index for loops B, D, F
 *  %l4 - computational -- used for computations
 * 	%l5 - computational -- used for computations
 * 	%l6 - computational -- used for computations
 */

 drawZ:
 	save	%sp, -96, %sp	! Save callers window, if different than -96
							! then comment on how that value was calculated

	mov		%i0, %o0		
	call 	numOfDigits		! counts number of digits in length
	nop						

	mov		%o0, %l0		! number of digits saved to l0

	mov		%i0, %l1
	add 	%l0, %l1, %l1
	add 	%l0, %l1, %l1 	! l1 = width + 2 * numDigits

/* Print the top border */
	clr 	%l2				! l2 is loopa's index

	cmp 	%l2, %l0
	bge 	endloopa		! ends loop if index >= numDigits
	nop

loopa:
	clr 	%l3				! l3 is loopb's index

	cmp 	%l3, %l1
	bge 	endloopb		! ends loop if index >= totalWidth
	nop

loopb:

	mov 	%i2, %o0
	call 	printChar		! prints the borderchar
	nop

	inc 	%l3				! loopb's index ++ 

	cmp 	%l3, %l1
	bl 		loopb			! repeats loop if index < totalWidth
	nop

endloopb:

	set     fmt, %o0        
    call    printf          ! prints new line
    nop                

	inc 	%l2				! loopa's index ++

	cmp 	%l2, %l0
	bl 		loopa			! repeats loop if index < numDigits
	nop

endloopa:

/* Print the Z with side borders */
	clr 	%l2				! l2 is loopc's index
	clr 	%l4 			! l4 will be computational var

	sub 	%l0, 1, %l4
	sub 	%l1, %l4, %l4 	! l4 = totalWidth - (numDigits - 1)

	cmp 	%l2, %l4 		
	bge 	endloopc 		! ends loop if loopc's index >=
	nop						! totalWidth - (numDigits - 1)

loopc:
	
	clr 	%l3				! loopd's index is l3

	cmp 	%l3, %l1 
	bge 	endloopd		! ends loop if loopd's index >= totalWidth
	nop

loopd:
	
	cmp 	%l3, %l0
	bl 		ifa  			! executes ifa if(loopd's index < numDigits)
	nop

	clr 	%l5 			! l5 will be computational var
	
	add 	%l0, %i0, %l5
	dec 	%l5 			! l5 = numDigits + width -1

	cmp 	%l3, %l5		! moves to next if else
	ble		elseaifa		! if(loopd's index <= (numDigits +  width - 1))
	nop 					

ifa:

	mov 	%i2, %o0
	call 	printChar 		! prints the border character
	nop

	cmp 	%g0, %g0
	ba 		endif 			! forces program to end of logic stack
	nop

elseaifa:

	cmp 	%l2, %l0
	bl 		ifb				! executes ifb if (loopc's index < numDigits)
	nop

	cmp 	%l2, %i0		! moves to next if else
	ble 	elseaifb		! if(loopc's index <= width)
	nop

ifb:

	mov 	%i1, %o0
	call 	printChar 		! prints the z character
	nop

	cmp 	%g0, %g0
	ba 		endif 			! forces program to end of logic stack
	nop

elseaifb:
	
	clr 	%l5 			! l5 will be computational var
	clr 	%l6 			! l6 will be computational var

	sub 	%l0, 1, %l5	
	sub 	%l3, %l5, %l5 	! %l5 = loopd's index - (numDigits - 1)

	sub 	%i0, %l2, %l6	! %l6 = width - loopc's index

	cmp 	%l5, %l6 		! moves to else
	ble 	elsea 			! if(loopd's index - (numDigits - 1)
	nop						! <= width - loopc's index )
	 	
	add 	%l6, %l0, %l6 	! %l6 = width - loopc's index + numDigits

	cmp 	%l5, %l6		! moves to else
	bg 		elsea 			! if(loopd's index - (numDigits - 1)
	nop						! <= width - loopc's index  + numDigits)

	mov 	%i1, %o0
	call 	printChar 		! prints the z character
	nop

	cmp 	%g0, %g0
	ba 		endif			! forces program to end of logic stack
	nop

elsea:
	
	mov 	%i3, %o0
	call 	printChar 		! prints the filler character
	nop

endif:
	
	inc 	%l3				! loopd's index ++

	cmp 	%l3, %l1
	bl 		loopd			! repeats if index < totalWidth
	nop

endloopd:

	set     fmt, %o0        
    call    printf          ! prints new line
    nop

    inc 	%l2 			! increases loopc's index

	cmp 	%l2, %l4
	bl 		loopc 			! loops c if loopc's index <
	nop						! totalWidth - (numDigits - 1)

endloopc:

/* Print the bottom border */

	mov 	%l0, %l2 	 	! loope's reverse index = numDigits

	cmp 	%l2, 0
	ble 	endloope		! ends loop if numDigits <= 0
	nop

loope:

	mov 	%l1, %l3 		! loopf's reverse index = totalWidth

	cmp 	%l3, 0
	ble 	endloopf 		! ends loop if totalWidth <= 0
	nop

loopf:

	mov 	%i2, %o0 		
	call 	printChar		! prints the borderchar
	nop

	dec 	%l3				! loopf's index --

	cmp 	%l3, 0
	bg 		loopf 			! loops if loopf's index > 0
	nop

endloopf:

	set     fmt, %o0        
    call    printf          ! prints new line
    nop
	
	dec 	%l2 			! loope's index --

	cmp 	%l2, 0
	bg 		loope			! loops if loope's index is > 0
	nop

endloope:

	ret						! Return from subroutine
	restore					! Restore callers window, in "ret" delay shot