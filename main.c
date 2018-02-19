/*
 * Filename: main.c
 * Author: Yash Nevatia
 * Description: The main function will drive the rest of the program. It will
                first perform input checking by parsing command-line arguments
                and checking for errors. If all inputs are valid, it will call
                drawZ(). If any of the input checks fail, it will print the
                corresponding errors, the usage and then exit. Keep in mind
                that all the error strings have format specifiers, so be sure
                to add the appropriate arguments when printing error messages.
                Also, you must use your isInBounds() function when checking the
                bounds of the command line arguments.
 * Date: 31 Janaury 2017
 * Sources of Help      
 */

/* 
 * Header files included here.
 * Std C Lib header files first, then local headers.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

/* Standard C Library headers use angle brackets < > */
#include "pa1.h"

/*
 * Function name: main()
 * Function prototype: int main( int argc, char *argv[] );
 * Description: C main driver which calls SPARC assembly routines to
 *              check arguments for errors, and call drawZ if all's well
 * Parameters:
 *  arg 1: width -- the width of the Z
 *  arg 2: zChar -- the character to make the Z with
 *  arg 3: borderChar -- the character to make the border with
 *  arg 4: fillerChar -- the character to make the filler with
 * Side Effects: Prints usage after errors.
 * Error Conditions:
 *  - Error converting to long
 *  - Width contains non-numerical characters
 *  - Width is out of bounds
 *  - Width is not odd
 *  - Not a valid single character
 *  - char out of bounds
 * Return Value: If errors were encountered, return EXIT_FAILURE. Otherwise,
 *               return EXIT_SUCCESS.
 */

int main( int argc, char *argv[] ) {
    
    // checks if the number of arguments are incorrect
    if(argc != EXPECTED_ARGS){
        printf(USAGE);
        return EXIT_FAILURE;
    }

    int err = 0; // boolean to keep track of errors

    char * endptr; // character to interpret width
    errno = 0; // watches for error in strtol
    long w = strtol(argv[1], &endptr, BASE);
    //converts width to long and saves as w

    // entertains the case that the width is too large
    if(errno != 0){
        char buffer [BUFSIZ]; //sets buffer for snprintf
        snprintf(buffer, BUFSIZ, TOO_BIG_NUM, argv[1]);
        perror(buffer); // prints error
        err = 1;
        goto ZCHAR;
    }

    // entertains case that width isn't a valid long
    if(*endptr != 0){
        printf(INVALID_LONG, argv[1]);
        err = 1;
        goto ZCHAR;
    }

    // entertains case that width is out of bounds
    if(w < MIN_WIDTH || w > MAX_WIDTH){
        printf(OUT_OF_BOUNDS, WIDTH, (int) w, MIN_WIDTH, MAX_WIDTH);
        err = 1;
        goto ZCHAR;
    }

    // entertains case that width is even
    if(!isOdd((int) w)){
        printf(NUM_EVEN, w);
        err = 1;
    }
    
    ZCHAR:; // Z character error checking
        char z = *argv[2];

        // entertains case that z character is not one character
        if(strlen(argv[2]) != 1){
            printf(INVALID_CHAR, Z_CHAR, argv[2]);
            err = 1;
            goto FILLER;
        }

        // entertains case that z character is out of bounds
        if(!isInBounds(LOWER_CHAR_BOUND,
            UPPER_CHAR_BOUND - LOWER_CHAR_BOUND, z)){
            printf(OUT_OF_BOUNDS, Z_CHAR, z, LOWER_CHAR_BOUND,
                UPPER_CHAR_BOUND);
            err = 1;
        }

    FILLER:; // filler character error checking
        char f = *argv[3];

        // entertains case that filler character is not one character
        if(strlen(argv[3]) != 1){
            printf(INVALID_CHAR, FILLER_CHAR, argv[3]);
            err = 1;
            goto BORDER;
        }

        // entertains case that filler character is out of bounds
        if(!isInBounds(LOWER_CHAR_BOUND,
            UPPER_CHAR_BOUND - LOWER_CHAR_BOUND, f)){
            printf(OUT_OF_BOUNDS, FILLER_CHAR, f, LOWER_CHAR_BOUND,
                UPPER_CHAR_BOUND);
            err = 1;
        }

    BORDER:; // border character error checking
        char b = *argv[4];

        // entertains case that border character is not one character
        if(strlen(argv[4]) != 1){
            printf(INVALID_CHAR, BORDER_CHAR, argv[4]);
            goto DONE;
        }

        // entertains case that filler character is out of bounds
        if(!isInBounds(LOWER_CHAR_BOUND,
            UPPER_CHAR_BOUND - LOWER_CHAR_BOUND, b)){
            printf(OUT_OF_BOUNDS, BORDER_CHAR, b, LOWER_CHAR_BOUND,
                UPPER_CHAR_BOUND);
            err = 1;
        }

    DONE:;

        // prints the proper usage if there was an error
        if(err){
            printf(USAGE);
            return EXIT_FAILURE;  
        }

        // entertains the case that z char and filler/border
        // chars aren't different
        if(z == f || z == b){
            printf(EXCLUSIVE);
            printf(USAGE);
            return EXIT_FAILURE;
        }

    // draws the z
    drawZ(w, z, f, b);
    return EXIT_SUCCESS;
}
