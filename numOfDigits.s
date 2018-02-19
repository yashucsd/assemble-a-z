/*
 * Filename: numOfDigits.s
 * Author: Yash Nevatia
 * Description: This function counts the number of digits in num (a number in
 *				base 10). In the case where num is negative, return -1.
 * Date: 25 January 2017
 * Sources of Help: 
 */ 
 	.global numOfDigits	! Declares the sumbol to be globally visible so
						! we can call this function from other modules.
	.section ".text"	! The text segment begins here
/*
 * Function name: numOfDigits()
 * Function prototype: long numOfDigits( long num );
 * Description: This function counts the number of digits in num (a number in
 * 				base 10). In the case where num is negative, return -1.				
 * Parameters: 	arg 1: long num -- the number being surveyed
 * 
 * Side Effects: None.
 * Error Conditions: None.
 * Return Value: If num is 0 or greater, return the number of digits in num.
 *				 If num is negative, return -1.
 *				 
 *
 * Registers Used:
 * 	%i0 - arg 1 -- the number being surveyed
 * 	%l1 - counter -- counts the number of digits in the loop
 * 	%o0 - op 1 -- holds a copy of arg 1 for dividing
 * 	%o1 - 10 -- divisor to determine number of digits
 */

numOfDigits:

 	save	%sp, -96, %sp	! save callers window, if different than -96

 	cmp 	%i0, 0
	bl		negative 		! entertains negative case
	nop

 	clr 	%l1				! clears for counter

 	cmp 	%i0, 0
 	be  	zero			! entertains zero case
 	nop

 loop:

 	inc 	%l1				! increments number of digits

 	mov		%i0, %o0
 	mov		10, %o1			
 	call 	.div			! divides i0 by 10
 	nop

 	mov 	%o0, %i0		! sets num equal to newly divided figure

 	cmp 	%i0, 0			
 	bne 	loop			! checks if num != 0 to execute loop body again
 	nop

	mov 	%l1, %i0		! moves digit counter to i0 for return

	ret						! return from subroutine
	restore					! restore callers window, in "ret" delay shot

zero:
	
	mov 	1, %i0 			! return case for zero

	ret
	restore

negative:
	
	mov 	-1, %i0			! return case for negatives

	ret
	restore