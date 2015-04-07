//
//  UserMathProblem.h
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//
#import "MathProblem.h"
#import "User.h"

@interface UserGameData : NSObject

@property (strong, nonatomic) User *currentUser;

+(instancetype)getInstance;

-(void) initCustom;
@end
