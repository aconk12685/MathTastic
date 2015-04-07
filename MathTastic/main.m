//
//  main.m
//  MathTastic
//
//  Created by Andrew Conk on 10/11/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception callStackSymbols]);
        }
        @finally {
            
        }
        
    }
}
