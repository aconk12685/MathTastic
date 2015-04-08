//
//  OceanScene.m
//  MathTastic
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.
//

#import "OceanScene.h"
#import <Foundation/Foundation.h>

static const uint32_t turtleCategory =  0x1 << 0;
static const uint32_t obstacleCategory =  0x1 << 1;

static const float OBJECT_VELOCITY = 160.0;

@implementation OceanScene{
    
    SKSpriteNode *turtle;
    SKAction *actionMoveUp;
    SKAction *actionMoveDown;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    NSTimeInterval _lastanchorAdded;
    
    FMMParallaxNode *_parallaxNodeBackgrounds;
    FMMParallaxNode *_parallaxSpaceDust;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blueColor];
        [self initalizingScrollingBackground:size];
        [self addSeaTurtle];
        
        //Making self delegate of physics World
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
    }
    
    return self;
}

-(void)addSeaTurtle
{
    //initalizing spaceturtle node
    turtle = [SKSpriteNode spriteNodeWithImageNamed:@"sea-turtle"];
    [turtle setScale:0.25];
    //turtle.zRotation = - M_PI / 2;
    
    
    //Adding SpriteKit physicsBody for collision detection
    turtle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:turtle.size];
    turtle.physicsBody.categoryBitMask = turtleCategory;
    turtle.physicsBody.dynamic = YES;
    turtle.physicsBody.contactTestBitMask = obstacleCategory;
    turtle.physicsBody.collisionBitMask = 0;
    turtle.physicsBody.usesPreciseCollisionDetection = YES;
    turtle.name = @"seaTurtle";
    turtle.position = CGPointMake(120,100);
    actionMoveUp = [SKAction moveByX:0 y:30 duration:.2];
    actionMoveDown = [SKAction moveByX:0 y:-30 duration:.2];
    
    [self addChild:turtle];
}

-(void)addAnchor
{
    //initalizing spaceturtle node
    SKSpriteNode *anchor;
    anchor = [SKSpriteNode spriteNodeWithImageNamed:@"anchor.svg.med.png"];
    [anchor setScale:0.15];
    
    //Adding SpriteKit physicsBody for collision detection
    anchor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:anchor.size];
    anchor.physicsBody.categoryBitMask = obstacleCategory;
    anchor.physicsBody.dynamic = YES;
    anchor.physicsBody.contactTestBitMask = turtleCategory;
    anchor.physicsBody.collisionBitMask = 0;
    anchor.physicsBody.usesPreciseCollisionDetection = YES;
    anchor.name = @"anchor";
    
    //selecting random y position for anchor
    int r = arc4random_uniform(self.scene.size.height);
    anchor.position = CGPointMake(self.frame.size.width + 20,r);
    [self addChild:anchor];
}

-(void)addSeaweed
{
    //initalizing spaceturtle node
    SKSpriteNode *seaWeed;
    seaWeed = [SKSpriteNode spriteNodeWithImageNamed:@"seaweed.svg.med.png"];
    [seaWeed setScale:0.15];
    
    //Adding SpriteKit physicsBody for collision detection
    seaWeed.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:seaWeed.size];
    seaWeed.physicsBody.categoryBitMask = obstacleCategory;
    seaWeed.physicsBody.dynamic = YES;
    seaWeed.physicsBody.contactTestBitMask = turtleCategory;
    seaWeed.physicsBody.collisionBitMask = 0;
    seaWeed.physicsBody.usesPreciseCollisionDetection = YES;
    seaWeed.name = @"seaWeed";
    
    //selecting random y position for seaWeed
    int r = arc4random() % 550;
    seaWeed.position = CGPointMake(self.frame.size.width + 25,r);
    
    [self addChild:seaWeed];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    [self selectNodeForTouch: touchLocation];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    //2
    if(![_selectedNode isEqual:touchedNode]) {
        [_selectedNode removeAllActions];
         _selectedNode = touchedNode;
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    
    CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
    [self panForTranslation:translation];
    
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:@"seaTurtle"]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

-(void)initalizingScrollingBackground:(CGSize)size{
    NSArray *parallaxBackgroundNames = @[@"clownfish.svg.med.png", @"pescetto.svg.med.png"];
    CGSize planetSizes = CGSizeMake(50, 50);

    _parallaxNodeBackgrounds = [[FMMParallaxNode alloc] initWithBackgrounds: @"bgFish"
                                                                      files:parallaxBackgroundNames
                                                                       size:planetSizes
                                                       pointsPerSecondSpeed:60];

    _parallaxNodeBackgrounds.position = CGPointMake(size.width/2.0, size.height/2.0);
    
    [self addChild:_parallaxNodeBackgrounds];
    
    NSArray *parallaxBackground2Names = @[@"red-fish.svg.med.png", @"red-starfish.svg.med.png"];
    _parallaxSpaceDust = [[FMMParallaxNode alloc] initWithBackgrounds: @"bgFish2"
                                                                files:parallaxBackground2Names
                                                                 size:planetSizes
                                                 pointsPerSecondSpeed:100];
    _parallaxSpaceDust.position = CGPointMake(0, 0);
    [self addChild:_parallaxSpaceDust];
}

- (void)moveObstacle
{
    NSArray *nodes = self.children;//1
    
    for(SKNode * node in nodes){
        if ([node.name  isEqual: @"anchor"]) {
            SKSpriteNode *ob = (SKSpriteNode *) node;
            CGPoint obVelocity = CGPointMake(-OBJECT_VELOCITY, 0);
            CGPoint amtToMove = [SpriteKitCommon CGPointMultiplyScalar:obVelocity timesB:_dt];
            
            ob.position = [SpriteKitCommon CGPointAdd:ob.position toB:amtToMove];
            if(ob.position.x < -100)
            {
                [ob removeFromParent];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    if (_lastUpdateTime)
    {
        _dt = currentTime - _lastUpdateTime;
    }
    else
    {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
    
    if( currentTime - _lastanchorAdded > .25)
    {
        _lastanchorAdded = currentTime + 1;
        [self addAnchor];
        [self addSeaweed];
    }

    [self moveObstacle];
    
    [_parallaxSpaceDust update:currentTime];
    [_parallaxNodeBackgrounds update:currentTime];
}


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & turtleCategory) != 0 &&
        (secondBody.categoryBitMask & obstacleCategory) != 0)
    {
        [turtle removeFromParent];
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * questionAnswerScene = [[QuestionAnswerScene alloc] initWithSize:self.size];
        [self.view presentScene:questionAnswerScene transition: reveal];
        
    }
}


@end
