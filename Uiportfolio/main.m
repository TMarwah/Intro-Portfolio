//
//  main.m
//  Uiportfolio
//
//  Created by John Mortensen on 11/4/19.
//  Copyright © 2019 JM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "control.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
