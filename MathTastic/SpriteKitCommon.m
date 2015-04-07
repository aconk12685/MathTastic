//
//  SpriteKitCommon.m
//  MathTastic
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.
//

#import "SpriteKitCommon.h"

@implementation SpriteKitCommon

+ (CGPoint)CGPointAdd:(CGPoint)a toB:(CGPoint)b{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

+ (CGPoint) CGPointMultiplyScalar:(CGPoint) a timesB:(CGFloat) b{
    return CGPointMake(a.x * b, a.y * b);
}

+ (int) GenerateRandomInt:(int) upperBound{
    int x = arc4random_uniform(upperBound);
    return x;
}
@end
