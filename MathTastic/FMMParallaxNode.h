//
//  FMMParallaxNode.h
//  MathTastic
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.

#import <SpriteKit/SpriteKit.h>

@interface FMMParallaxNode : SKNode

- (instancetype)initWithBackground:(NSString* ) name file:(NSString *)file size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed;
- (instancetype)initWithBackgrounds:(NSString *) name files:(NSArray *)files size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed;
- (void)randomizeNodesPositions;
- (void)update:(NSTimeInterval)currentTime;


@end
