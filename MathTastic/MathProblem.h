//
//  MathProblem.h
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathProblem : NSObject

@property (strong, nonatomic) NSString *question;

@property (assign, nonatomic) int answer;

@property (assign, nonatomic) int usersAnswer;

@property (assign, nonatomic) bool isCorrectAnswer;

-(id) initMathProblem;

@end