//
//  FMMParallaxNode.m
//  MathTastic
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.

#import "FMMParallaxNode.h"


@implementation FMMParallaxNode
{
    
    __block NSMutableArray *_backgrounds;
    NSInteger _numberOfImagesForBackground;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
    float _pointsPerSecondSpeed;
    BOOL _randomizeDuringRollover;
    
}


- (instancetype)initWithBackground:(NSString *) name file:(NSString *)file size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed
{
    // we add the file 3 times to avoid image flickering
    return [self initWithBackgrounds: name
                               files:@[file, file, file]
                                size:size
                pointsPerSecondSpeed:pointsPerSecondSpeed];
    
}

- (instancetype)initWithBackgrounds:(NSString *) name files:(NSArray *)files size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed
{
    if (self = [super init])
    {
        _pointsPerSecondSpeed = pointsPerSecondSpeed;
        _numberOfImagesForBackground = [files count];
        _backgrounds = [NSMutableArray arrayWithCapacity:_numberOfImagesForBackground];
        _randomizeDuringRollover = NO;
        self.name = name;
        [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:obj];
            node.size = size;
            node.anchorPoint = CGPointZero;
            node.position = CGPointMake(size.width * idx, size.height * idx);
            node.name = obj;
            [_backgrounds addObject:node];
            [self addChild:node];
        }];
    }
    return self;
}



- (void)update:(NSTimeInterval)currentTime
{
    //To compute velocity we need delta time to multiply by points per second
    if (_lastUpdateTime) {
        _deltaTime = currentTime - _lastUpdateTime;
    } else {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    
    if(self.position.x < -250)
    {
        self.position = CGPointMake(self.parent.scene.size.width, 0);
    }
    else{
        CGPoint bgVelocity = CGPointMake(-_pointsPerSecondSpeed, 0.0);
        CGPoint amtToMove = CGPointMake(bgVelocity.x * _deltaTime, bgVelocity.y * _deltaTime);
        self.position = CGPointMake(self.position.x+amtToMove.x, self.position.y+amtToMove.y);
        SKNode *backgroundScreen = self.parent;
     
        [_backgrounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SKSpriteNode *bg = (SKSpriteNode *)obj;
            CGPoint bgScreenPos = [self convertPoint:bg.position
                                              toNode:backgroundScreen];
            if (bgScreenPos.x <= -bg.size.width)
            {
                bg.position = CGPointMake(-(bg.position.x + (bg.size.width * _numberOfImagesForBackground)), 500 + sin(bg.position.x));
                bgScreenPos = CGPointMake(-(bg.position.x + (bg.size.width * _numberOfImagesForBackground)), bg.position.y);
            }
        
        }];
    }
   
}

@end
