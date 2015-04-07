//
//  User.m
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//
#import "User.h"
#import <Foundation/Foundation.h>

@implementation User
-(id) initUser{
    self.numberOfCollisions = 0;
    self.numberOfCorrectAnswers = 0;
    self.numberOfIncorrectAnswers = 0;
    self.userMathProblems = [NSMutableArray array];
    
    return self;
}
@end