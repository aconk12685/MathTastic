//
//  DefaultScene.m
//  MathTastic
//
//  Created by Andy Conk on 2/23/15.
//  Copyright (c) 2015 Andrew Conk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultScene.h"

@implementation DefaultScene

-(void)didMoveToView:(SKView *)view{
    if(!self.contentsLoaded){
        [self createSceneContents];
    }
    
}

-(void)createSceneContents{
    self.scaleMode = SKSceneScaleModeAspectFill;
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Rocket Dodger by Math Tastic!";
    
    helloNode.fontSize = 42;
    helloNode.fontName = @"Courier";
    
    // helloNode.fontColor = [UIColor colorWithWhite:80 alpha:90];
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    SKLabelNode *helloNode2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode2.text = @"(Tap to Start)";
    
    helloNode2.fontSize = 42;
    helloNode2.fontName = @"Courier";
    
    // helloNode.fontColor = [UIColor colorWithWhite:80 alpha:90];
    helloNode2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) - 50);
    
    [self addChild:helloNode];
    [self addChild:helloNode2];
}
@end