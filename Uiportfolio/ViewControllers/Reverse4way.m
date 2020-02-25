//
//  Reverse4way.m
//  Uiportfolio
//
//  Created by Shah, Tanay on 12/2/19.
//  Copyright © 2019 JM. All rights reserved.
//
#include "control.h"
#import "Reverse4way.h"

@implementation reverse
@synthesize input, meth1, meth2, meth3, meth4;

- (void)viewDidLoad {
    [super viewDidLoad];
    [meth1 setText:@"Array Swap"];
    [meth2 setText:@"Recursion"];
    [meth3 setText:@"Pointer Swap"];
    [meth4 setText:@"Palindrome Check"];
}

- (IBAction)go:(id)sender {
    const char *cInput = [input.text UTF8String];
    long inputLength = input.text.length;
    meth1.text = [NSString stringWithFormat:@"%s" , reverse1((char*)cInput, inputLength) ];
    meth2.text = [NSString stringWithFormat:@"%s" , reverse2((char*)cInput, inputLength) ];
    meth3.text = [NSString stringWithFormat:@"%s" , reverse3((char*)cInput) ];
    meth4.text = [NSString stringWithFormat:@"%s" , reverse4((char*)cInput, inputLength) ];
}

@end
