/*
 * Filename: testnumOfDigits.c
 * Author: Yash Nevatia
 * Description: This function counts the number of digits in num (a number in
 * 				base 10). In the case where num is negative, return -1.
 * Date: 25 January 2017
 * Sources of Help: 
 */ 

#include "pa1.h"	/* For numOfDigits() function prototype */
#include "test.h"	/* For TEST() macro and stdio.h */

/*
 * Unit Test for numOfDigits.s
 *
 * long numOfDigits( long num );
 *
 * This function counts the number of digits in num (a number in
 * base 10). In the case where num is negative, return -1.
 *
 * If num is 0 or greater, return the number of digits in num.
 * If num is negative, return -1.
 */

void testnumOfDigits( ) {
  (void) printf( "Testing numOfDigits()\n" );

  TEST( numOfDigits( -1 ) == -1 );
  TEST( numOfDigits( 0 ) == 1 );
  TEST( numOfDigits( 2 ) == 1 );
  TEST( numOfDigits( 22 ) == 2 );
  TEST( numOfDigits( 222 ) == 3);

  (void) printf( "Finished running tests on numOfDigits()\n" );
}

int main( ) {
    testnumOfDigits( );
    return 0;
}
