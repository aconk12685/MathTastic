//
//  BaseScene.m
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//
#import "BaseScene.h"

@implementation BaseScene

-(void)gameStatusHeader{
    self.correctAnswersLabel = [[SKLabelNode alloc] initWithFontNamed:@"Futura-CondensedMedium"];
    self.correctAnswersLabel.fontSize = 22.0;
    self.correctAnswersLabel.position = CGPointMake(60, self.size.height-50);
    self.correctAnswersLabel.fontColor = [SKColor greenColor];
    [self addChild: self.correctAnswersLabel];
    
    self.incorrectAnswersLabel = [[SKLabelNode alloc] initWithFontNamed:@"Futura-CondensedMedium"];
    self.incorrectAnswersLabel.fontSize = 22.0;
    self.incorrectAnswersLabel.position = CGPointMake(300, self.size.height-50);
    self.incorrectAnswersLabel.fontColor = [SKColor orangeColor];
    [self addChild:self.incorrectAnswersLabel];
    
    self.numberOfCollisionsLabel = [[SKLabelNode alloc] initWithFontNamed:@"Futura-CondensedMedium"];
    self.numberOfCollisionsLabel.fontSize = 22.0;
    self.numberOfCollisionsLabel.position = CGPointMake(600, self.size.height-50);
    self.numberOfCollisionsLabel.fontColor = [SKColor redColor];
    [self addChild:self.numberOfCollisionsLabel];
}

-(void)initBaseContent{
    [self gameStatusHeader];
}

@end