//
//  jumpers.c
//  portfolio
//
//  Created by Vo, Anthony on 9/5/19.
//  Copyright © 2019 Vo, Anthony. All rights reserved.
//

#include "control.h"
#include "stdio.h"

int jumpers(char *message) {
    int jumps, i;
    char animal[20], doctorName[20];
    
    printf("enter the number of jumps\n");
    scanf("%d", &jumps);
    printf("enter the animal name\n");
    scanf("%s", animal);
    printf("enter the name of the doctor\n");
    scanf("%s", doctorName);
    
    for (i = 0; i < jumps; i++)
    {
        printf("%d little %s (s) jumping on the bed\n", jumps - i, animal);
        printf("One fell off and broke their head\n");
        printf("Mama called Doctor %s and Doctor %s said:\n", doctorName, doctorName);
        printf("No more %s s jumping on the bed\n", animal);
    }
    
    sprintf(message, "Jumps %d, Animal %s, Doctor %s", jumps, animal, doctorName);
    printf("%s", message);
    
    return jumps;
}
