//
//  User.h
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//
#import "MathProblem.h"
#import <Foundation/Foundation.h>

@interface User : NSObject

@property (assign, nonatomic) int numberOfCollisions;

@property (assign, nonatomic) int numberOfCorrectAnswers;

@property (assign, nonatomic) int numberOfQuestions;

@property (assign, nonatomic) int numberOfIncorrectAnswers;

@property (strong, nonatomic) NSMutableArray *userMathProblems;

-(id) initUser;

@end