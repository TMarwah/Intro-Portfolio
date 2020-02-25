//
//  calc.c
//  Calculator
//
//  Created by John Mortensen on 10/30/19.
//  Copyright © 2019 JM. All rights reserved.
//

#include "control.h"
#include "math.h"

// double value equal to zero test
int zeroTest(double value)
{
    // value is < epsilon value, it is essentially equal to zero
    return (fabs(value) < 0.00000000001);
}

// calculator engine
double calculateIt(double arg1, int mathOp, double arg2)
{
    double calcAnswer = 0.0;
    
    switch(mathOp)
    {
        case PLUS:
            calcAnswer = arg1 + arg2;
            break;
        case MINUS:
            calcAnswer = arg1 - arg2;
            break;
        case DIVIDE:
            calcAnswer = arg1 / arg2;
            break;
        case MULTIPLY:
            calcAnswer = arg1 * arg2;
            break;
        case MODULO:
            calcAnswer = (double)((int)arg1 % (int)arg2);
            break;
        case SQRT:
            calcAnswer = sqrt(arg1);
            break;
        case -1:
            calcAnswer = arg1;
    }
    
    return calcAnswer;
}

// hyptoneuse engine
double pyth (double side1, double side2) {
    side1 *= side1;
    side2 *= side2;
    double side3 = side1 + side2;
    side3 = sqrt(side3);
    return side3;
}
