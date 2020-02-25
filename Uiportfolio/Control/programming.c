//
//  programming.c
//  Projects
//
//  Created by John Mortensen on 10/25/19.
//  Copyright © 2019 Mortensen,John. All rights reserved.
//

#include <stdio.h>
#include <strings.h>
#include "control.h"

// These strings are used for displaying enum descriptions
// Note:  there is an inorder dependency
char *exeString[] = {"Just-in-Time (JIT)","Java-Virtual-Machine (JVM)","Byte Code", "Native Or Binary" };
char *langString[] = {"Object Oriented Programming (OOP)","Multi Purpose (MP)","Iterative" };

// THis is initializing section for the table, comma is used to seperate data in struct
// Note the use of enum data, it is much easier to look at and better when choices are limited
LANGUAGES progLang[LINE_BUFFER_SIZE] = {
    {"C", "1972", "Dennis Ritchey", Native, Iterative},
    {"Objective-C", "1980s", "Brad Cox", Native, OOP},
    {"Python", "1989", "Guido van Rossum", JIT, OOP},
    {"Java", "1990s", "James Goslin", JVM, OOP},
    {"JavaScript", "1995", "Brendan Eich", JVM, MP},
    {"C#", "2000", "Anders Hejlsberg", ByteCode, MP},
};
LANGUAGES filteredLang[LINE_BUFFER_SIZE];


// progLanguages is called from my main menu
LANGUAGES* progLanguages()
{
    return progLang;
}

// progLanguages is called from my main menu
LANGUAGES* searchLanguages(char *searchTerm)
{
    // Value to determine if search below produces a result
    int found = 0;
    
    // clear search condition
    if (strlen(searchTerm) > 0)
    {
        // This 2nd loop updates lines to buffer that meet search criteria
        for (int i=0; i < FILE_BUFFER_SIZE; i++) {
            char* p;
            p = strstr(progLang[i].name, searchTerm);  // p points to address where term is found
            if (p) {
                // sending feedback message to driver that called this function
                filteredLang[found++] = progLang[i];
            }
        }
        return filteredLang;
    } else {
        return progLang;
    }
}
