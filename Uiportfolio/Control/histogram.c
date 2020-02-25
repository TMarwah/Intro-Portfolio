//
//  histogram.c
//  Projects
//
//  Created by John Mortensen on 9/25/19.
//  Copyright © 2019 Mortensen, John. All rights reserved.
//

#include "control.h"
#include "stdio.h"

void getHistoArray(int *arr, int size)
{
    for (int i=0; i < size; i++)
    {
        printf("\nEnter array element %d: ", i);
        scanf("%d", &arr[i]);
    }
    printf("\n");
}

int printHistoGraph(int *arr, int size)
{
    int histoTotal = 0;

    for (int i=0; i < size; i++)
    {
        histoTotal += arr[i];
        printf("\n Array %d: ", arr[i]);
        for (int j = 0; j < arr[i]; j++)
        {
            printf("* ");
        }
        printf("\n");
    }
    return histoTotal;
}

void printHistoAvg(double avg, int remainder)
{
    // print average
    printf("\n Avg.. %d: ", (int)avg);
    for (int i = 0; i < (int)avg; i++ ) printf("* ");
    if (remainder) printf("+");
        printf("\n");
}

int histogram(char *message)
{
    int histoSize = 10;
    int histoArray[histoSize];
    int histoTotal = 0;
    
    // get input elements
    getHistoArray(histoArray, histoSize);
    
    // print graph, return total
    histoTotal = printHistoGraph(histoArray, histoSize);
    
    // calculate average
    double histoAvg = (double)histoTotal/(double)histoSize;
    double histoAvgI = (double)(histoTotal/histoSize);
    int histoRemainderFlag = histoAvg>histoAvgI ? 1 : 0;
    
    // print average
    printHistoAvg(histoAvg, histoRemainderFlag);
    
    // message to be transferred
    sprintf(message, "Histogram Avg %lf", histoAvg);
    
    // finatl message
    printf("%s", message);
    
    return histoTotal;
}

