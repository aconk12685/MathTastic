//
//  GameViewController.h
//  MathTastic
//
//
//  Copyright (c) 2014 Andrew Conk. All rights reserved.
//
#import "User.h"
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController<SKPhysicsContactDelegate>

@property bool StartGame;

@property (assign, nonatomic) User *currentUser;

@end
