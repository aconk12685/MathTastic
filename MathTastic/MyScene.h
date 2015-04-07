//
//  MyScene.h
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.

#import "QuestionAnswerScene.h"
#import "BaseScene.h"
#import "UserGameData.h"

@interface MyScene : BaseScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end
