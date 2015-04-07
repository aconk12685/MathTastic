//
//  SpriteKitCommon.h
//  MathTastic
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface SpriteKitCommon : NSObject
+ (CGPoint) CGPointAdd:(CGPoint)a toB:(CGPoint)b;
+ (CGPoint) CGPointMultiplyScalar:(CGPoint) a timesB:(CGFloat) b;
+ (int) GenerateRandomInt:(int)upperBound;
@end