//
//  fileparse.c
//  Projects
//
//  Created by John Mortensen on 10/26/19.
//  Copyright © 2019 Mortensen, John. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "control.h"


// prototypes
int fileReadToArray(char *fileName);
int parseArrayForFunctions(int lineCnt);
int menuOfFuncCandidates(int funcCnt);
void outputOfSelectedFunc(int funcID);

// file buffers
char fileArray[FILE_BUFFER_SIZE][LINE_BUFFER_SIZE];
CANDIDATE_FUNCS funcCandidate[FILE_BUFFER_SIZE];

CANDIDATE_FUNCS* fileParse(char *fn)
{
    int lineCnt = 0;
    int funcCnt = 0;
        
    // step 1, open file and read to array
    lineCnt = fileReadToArray(fn);
    
    // step 2, parse functions and ask user for interest
    funcCnt = parseArrayForFunctions(lineCnt);
/*
    funcID = menuOfFuncCandidates(funcCnt);

    // step 3, output function select
    if (funcID)
        outputOfSelectedFunc(funcID);
*/

    return funcCandidate;
}

int fileReadToArray(char *fileName) {
    // File control
    FILE *fp1;  // file stream
    char c;     // character read
    int lineCnt = 0;
    
    // Opening a file in r mode
    fp1 = fopen (fileName, "r");
    do {
        // Get character from file stream
        c = fgetc(fp1);
        switch(c) {
            case EOF:   // End of file character
                break;
            case '\r':  // Windows carriage return
                break;
            case '\n':  // Line feed (new line character)
                sprintf(fileArray[lineCnt], "%s%c", fileArray[lineCnt], '\n');
                printf("%4d: %s", lineCnt, fileArray[lineCnt]);
                lineCnt++;
                break;
            default:    // All other characters
                sprintf(fileArray[lineCnt], "%s%c", fileArray[lineCnt], c);
        }
    } while (c != EOF);
    fclose(fp1);
    
    return lineCnt;
}

int parseArrayForFunctions(int lineCnt)
{
    // Used in control
    int openSquig = 0;
    int funcCnt = 0;
    int prevCnt = -1;
    
    // Loop to process lines
    for (int i=0; i < lineCnt; i++) {
        int j = 0;
        int line = 1;
        
        // This code is necessary for multiple runs, cleans up remnants in next line
        if (funcCnt != prevCnt) {
            sprintf(funcCandidate[funcCnt].name, "%s", "");
            prevCnt = funcCnt;
        }

        // State tranition to find characters not in squiggelies
        do {
            switch (fileArray[i][j]) {
                case '{':
                    openSquig++;
                    break;
                case '}':
                    openSquig--;
                    break;
                case '\n':
                    line = 0;
                    break;
                default:
                    if (!openSquig)
                        sprintf(funcCandidate[funcCnt].name, "%s%c", funcCandidate[funcCnt].name, fileArray[i][j]);
                    break;
            }
            j++;
        } while (line);
        
        // At this point we have line of content outside of {}
        if (strstr(funcCandidate[funcCnt].name,"(")  // key function character
            && !strstr(funcCandidate[funcCnt].name,";"))    // remove prototypes
        {
                funcCandidate[funcCnt].functionStartLine = i;
                funcCnt++;   // increment means it is a keeper
        } else {  // not a keeper
            sprintf(funcCandidate[funcCnt].name, "%s", "");
        }
    }
    return funcCnt;
}
    
int menuOfFuncCandidates(int funcCnt) {
    int searchFunc;
    
    // Menu
    printf("\n%s\n", "Function Candidates:");
    printf("%d: %s \n", 0, "Exit");
    for (int i = 0; i < funcCnt; i++) {
        printf("%d: %s\n", i+1, funcCandidate[i].name);
    }
    
    // Get inpupt from user to search
    printf("Select function to present:\n");
    scanf("%d", &searchFunc);
        
    return searchFunc ? funcCandidate[searchFunc - 1].functionStartLine : 0;
}

void outputOfSelectedFunc(int funcID)
{
    int i = funcID;
    int j = 0;
    int started = 0;
    int openSquig = 0;

    // Loop to process lines in buffer
    do {
        
        // state transitions
        int newline = 0;
        switch (fileArray[i][j]) {
            case '{':
                if (!started)
                    started = 1;
                openSquig++;
                break;
            case '}':
                openSquig--;
                break;
            case '\n':
                newline = 1;
                break;
        }
        
        // print characters
        printf("%c", fileArray[i][j]);
        
        // line transitions
        if (newline) {
            i++; j = 0;
        } else {
            j++;
        }
        
    } while (!started || openSquig);
}
