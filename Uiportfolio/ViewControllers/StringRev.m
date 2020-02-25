//
//  StringRev.m
//  Uiportfolio
//
//  Created by Shah, Tanay on 12/12/19.
//  Copyright © 2019 JM. All rights reserved.
//
#include "control.h"
#import "StringRev.h"

@implementation StringRev
@synthesize input, reversed;

- (void)viewDidLoad {
    [super viewDidLoad];
    [reversed setText:@"Reversed"];
}
- (IBAction)go:(id)sender {
    const char *cInput = [input.text UTF8String];
    reversed.text = [NSString stringWithFormat:@"%s" , reverser((char*)cInput) ];
}

@end





