//
//  reverse.c
//  Uiportfolio
//
//  Created by Shah, Tanay on 12/2/19.
//  Copyright © 2019 JM. All rights reserved.
//

#include <stdio.h>
#include "control.h"
#include <string.h>

char srBuffer[1000];
char pali[]= "Palindrome detected";
char notpali[]= "Not a Palindrome";
void clearBuffer(){
  for(int i=0; i<1000; i++){
      srBuffer[i]= '\0';
  }
}
char *reverse1(char *cinput, long length) {
    clearBuffer();
    strncpy(srBuffer,cinput, length);
    long begin = 0;
    long end = length -1;
    //for loop to swap end char with begining char
    for (begin = 0; begin < end; begin++,end--) {
        //save first char
        char swap = srBuffer[begin];
        //sets end to start
        srBuffer[begin] = srBuffer[end];
        //sets end to saved value
        srBuffer[end] = swap;
    }
    //srBuffer[begin] = '\0';
    return srBuffer;
}
void recurse(char* input, long begin, long end) {
  char ch;
  if (begin >= end)
    return;
   
  ch = *(input+begin);
  *(input+begin)=*(input+end);
  *(input+end)=ch;
   
  // recursion continues
  recurse(input, ++begin, --end);
}
// recursion reverse
char *reverse2(char* input, long length){
  clearBuffer();
  strncpy(srBuffer, input, length);
  //business logic
  long begin = 0, end = length-1;
  recurse(srBuffer, begin, end);
  return srBuffer;
}
char *reverse3(char *str) {
    clearBuffer();
    int l, i;
    char *begin_ptr, *end_ptr, ch;
  
    // Get the length of the string
    l = strlen(str);
  
    // Set the begin_ptr and end_ptr
    // initially to start of string
    begin_ptr = str;
    end_ptr = str;
  
    // Move the end_ptr to the last character
    for (i = 0; i < l - 1; i++)
        end_ptr++;
  
    // Swap the char from start and end
    // index using begin_ptr and end_ptr
    for (i = 0; i < l / 2; i++) {
  
        // swap character
        ch = *end_ptr;
        *end_ptr = *begin_ptr;
        *begin_ptr = ch;
  
        // update pointers positions
        begin_ptr++;
        end_ptr--;
    }
    return str;
}

char *reverse4(char *cinput, long length) {
    clearBuffer();
    strncpy(srBuffer,cinput, length);
    long begin = 0;
    long end = length -1;
    //for loop to swap end char with begining char
    for (begin = 0; begin < end; begin++,end--) {
        //save first char
        char swap = srBuffer[begin];
        //sets end to start
        srBuffer[begin] = srBuffer[end];
        //sets end to saved value
        srBuffer[end] = swap;
    }
    //srBuffer[begin] = '\0';
    int cmp = strcmp(srBuffer, cinput);
    if (cmp == 0) {
        return pali;
    }
    else {
        return notpali;
    }
}

