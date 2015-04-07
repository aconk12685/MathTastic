//
//  MathProblemGenerator.m
//  GameTutorial
//
//  Created by Andrew Conk on 9/14/14.
//  Copyright (c) 2014 MEGHA GULATI. All rights reserved.
//

#import "MathProblemGenerator.h"


@implementation MathProblemGenerator

-(MathProblem *)getMathProblem{
    MathProblem *mathProblem = [[MathProblem alloc] initMathProblem];
    
    int x = arc4random_uniform(10);
    int y = arc4random_uniform(10);

    mathProblem.question = [NSString stringWithFormat:@"%d + %d = ", x, y];
    mathProblem.answer = x+y;
    mathProblem.isCorrectAnswer = false;
    
    return mathProblem;
}

@end
