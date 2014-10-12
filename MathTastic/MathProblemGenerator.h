//
//  MathProblemGenerator.h
//  GameTutorial
//
//  Created by Andrew Conk on 9/14/14.
//  Copyright (c) 2014 MEGHA GULATI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathProblemGenerator : NSObject

@property int x;
@property int y;

-(NSString *)getMathProblem;

-(int)getMathProblemAnswer;

@end
