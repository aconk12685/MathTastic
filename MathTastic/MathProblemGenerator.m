//
//  MathProblemGenerator.m
//  GameTutorial
//
//  Created by Andrew Conk on 9/14/14.
//  Copyright (c) 2014 MEGHA GULATI. All rights reserved.
//

#import "MathProblemGenerator.h"
#import <stdlib.h>

@implementation MathProblemGenerator

-(NSString *)getMathProblem{
    self.x = arc4random_uniform(10);
    self.y = arc4random_uniform(10);
    
    return [NSString stringWithFormat:@"%d + %d = ", self.x, self.y];
}

-(int)getMathProblemAnswer{
    
    return self.x + self.y;
}

@end
