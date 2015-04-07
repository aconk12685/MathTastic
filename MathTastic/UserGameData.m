//
//  UserMathProblem.m
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//
#import "UserGameData.h"
#import <Foundation/Foundation.h>

@implementation UserGameData

+ (instancetype)getInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance initCustom];
    });
    
    return sharedInstance;
}

-(void) initCustom{
    self.currentUser = [[User alloc] initUser];
}



@end