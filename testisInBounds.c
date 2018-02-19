/*
 * Filename: testisInBounds.c
 * Author: Yash Nevatia
 * Description: Unit test program to test the function isInBounds.
 * Date: 25 January 2017
 * Sources of Help: 
 */ 

#include <limits.h>	/* For LONG_MIN and LONG_MAX */
#include "pa1.h"	/* For isInBounds() function prototype */
#include "test.h"	/* For TEST() macro and stdio.h */

/*
 * Unit Test for isInBounds.c
 *
 * long isInBounds( long min, long dist, long num );
 *
 * Checks to see if num is within the bounds of min and min + dist.
 *
 * Returns -1 if dist is less than zero.
 * Returns 1 if num is between min and min + dist (inclusive).
 * Returns 0 otherwise.
 */

void testisInBounds( ) {
  (void) printf( "Testing isInBounds()\n" );

  /* Test around 0 */
  TEST( isInBounds( 0, 0, 1 ) == 0 );
  TEST( isInBounds( 0, 0, 0 ) == 1 );
  TEST( isInBounds( 0, 0, -1 ) == 0 );

  TEST( isInBounds( -1, 1, -2 ) == 0 );
  TEST( isInBounds( -1, 1, -1 ) == 1 );
  TEST( isInBounds( -1, 1, 0 ) == 1 );
  TEST( isInBounds( -1, 1, 1 ) == 0 );
  TEST( isInBounds( -1, 1, 2 ) == 0 );


  TEST( isInBounds( -1, -5, 2 ) == -1 );
  TEST( isInBounds( 1, LONG_MAX - 1, 1 ) == -1 );
  TEST( isInBounds(1, 4, 2) == 1);


  (void) printf( "Finished running tests on isInBounds()\n" );
}

int main( )
{
    testisInBounds( );
    return 0;
}
