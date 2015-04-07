//
//  BaseScene.h
//  MathTastic
//
//  Created by Andy Conk on 3/1/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UITextField.h>
#import <UIKit/UITouch.h>
#import "FMMParallaxNode.h"
#import "SpriteKitCommon.h"
#import "UserGameData.h"

@interface BaseScene : SKScene



-(void)gameStatusHeader;
-(void)initBaseContent;

@property int numberOfCorrectAnswers;

@property int numberOfIncorrectAnswers;

@property int numberOfCollisions;

@property (strong, nonatomic) SKLabelNode* correctAnswersLabel;
@property (strong, nonatomic) SKLabelNode* incorrectAnswersLabel;
@property (strong, nonatomic) SKLabelNode* numberOfCollisionsLabel;
@end
