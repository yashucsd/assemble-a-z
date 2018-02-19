/*
 * Filename: testisOdd.c
 * Author: Yash Nevatia
 * Description: Unit test program to test the function isOdd.
 * Date: 25 January 2017
 * Sources of Help: 
 */ 

#include "pa1.h"	/* For isOdd() function prototype */
#include "test.h"	/* For TEST() macro and stdio.h */

/*
 * Unit Test for isOdd.s
 *
 * long isOdd( long num );
 *
 * Determines whether or not the num is an odd number.
 *
 * If num is odd, return 1. If num is even, return 0
 */

void testisOdd( ) {
  (void) printf( "Testing isOdd()\n" );

  TEST( isOdd( -1 ) == 1 );
  TEST( isOdd( 2 ) == 0 );
  TEST( isOdd( 0 ) == 0 );
  TEST( isOdd( 3 ) == 1);

  (void) printf( "Finished running tests on isOdd()\n" );
}

int main( ) {
    testisOdd( );
    return 0;
}
