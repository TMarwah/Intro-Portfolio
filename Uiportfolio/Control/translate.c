//
//  translate.c
//  Uiportfolio
//
//  Created by Shah, Tanay on 12/17/19.
//  Copyright © 2019 TS. All rights reserved.
//

#include <stdio.h>
#include "control.h"
#include <string.h>

// Full token function loading to Structure
PHRASE in;
char str[LINE_BUFFER_SIZE];

//Declaration of functions
// Clear the buffer of all previous entries by rewriting the entire buffer with NULL
void cleancopy(char *dest, const char *source, long buffsize)
{
    // set each value of array to termintion character, same as:
    // for (int i = 0; i < buffsize; i++)
    //    dest[i] = '\0';
    memset(dest, '\0', buffsize);

    // protected copy, ensuring no buffer overrun
    long length = strlen(source);
    if (length < buffsize)
        strncpy(dest, source, length);
    else
        strncpy(dest, source, buffsize);
}
/*char *reassign (char *cinput){
    strcpy(&str[LINE_BUFFER_SIZE], cinput);
    return 0;
}
*/
void tokentest(char *cInput){
  //char str[LINE_BUFFER_SIZE] = "A Man A Plan A Canal - Panama";
    strcpy(str, cInput);
    const char *tokenizer = " ";
    strcpy(in.original, str);
    //printf("Original String %s:", in.original);
  long i = 0;
  char *token = strtok(str, tokenizer);          // 1st word
  while( token != NULL ) {                // NULL mean end of phrase
    //printf( "word after tokenizing: %s\n", token );
    strcpy(in.words[i].word, token);
    //printf( "word in structure %li: %s\n", i, in.words[i].word);
      
    i++;
    token = strtok(NULL, tokenizer);           // remaining words, NULL means same phrase
  }
    in.wordcount = i;
}

char *reverser(char *cInput) {
    // Pass cInput to tokenizer function to seperate by words
    tokentest(cInput);
    for (long i = -1; i < in.wordcount; i++) {
        cleancopy(in.words[i].reversed, reverse1(in.words[i].word, (long)strlen(in.words[i].word)), BUFFER_SIZE);
        if (i == -1){
            cleancopy(in.reversed, in.words[i].reversed, LINE_BUFFER_SIZE);
        }
        else {
            strcpy( in.words[i].reversed, reverse1(in.words[i].word, (long)strlen(in.words[i].word)));
            strcat(in.reversed, in.words[i].reversed);
            strcat(in.reversed, " ");
        }
    }
    //strcpy(in.reversed, total);
    printf("Final reversed string: %s\n", in.reversed);
    return in.reversed;
}
