/*
 * Filename: isOdd.s
 * Author: Yash Nevatia
 * Description: Determines whether or not the num is an odd number.
 * Date: 25 January 2017
 * Sources of Help: https://goo.gl/JTYPFA
 */ 
 	.global isOdd		! Declares the sumbol to be globally visible so
						! we can call this function from other modules.
	.section ".text"	! The text segment begins here
/*
 * Function name: isOdd()
 * Function prototype: long isOdd( long num );
 * Description: Determines whether or not the num is an odd number
 * Parameters:
 *	arg 1: long num -- number to be surveyed
 * 
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: If num is odd, return 1. If num is even, return 0
 *
 * Registers Used:
 *	%i0 - arg 1 -- the number to be surveyed; also used to return the result
 * 	%o0 - op 1 -- holds arg 1 for operating .rem
 * 	%o1 - 2 -- the divisor to determine oddity
 */

 isOdd:
 	save	%sp, -96, %sp	! Save callers window, if different than -96
							! then comment on how that value was calculated

	mov		%i0, %o0		! Put a copy of the parameter in o0
	mov 	2, %o1			! Put divisor in o1
	call 	.rem 			! divides o0 by o1 and puts the remainder in o0
	nop

	mov 	%o0, %i0		! .ret's return value is in %o0, move it to %i0
							! to return that value from this function

	cmp		%i0, 0
	bl		negative		! entertains negative case
	nop
	
	ret						! Return from subroutine
	restore					! Restore callers window, in "ret" delay shot

negative:
	
	mov 	1, %i0			! return for negative case

	ret
	restore