//
//  MyScene.h
//  GameTutorial
//

//  Copyright (c) 2013 MEGHA GULATI. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UITextField.h>
#import <UIKit/UITouch.h>
#import "FMMParallaxNode.h"

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end
