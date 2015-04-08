//
//  SpaceScene.m
//  MathTastic
//
//  Created by Andrew Conk on 10/25/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.


#import "SpaceScene.h"

static const uint32_t shipCategory =  0x1 << 0;
static const uint32_t obstacleCategory =  0x1 << 1;

static const float OBJECT_VELOCITY = 160.0;

@implementation SpaceScene{

    SKSpriteNode *ship;
    SKAction *actionMoveUp;
    SKAction *actionMoveDown;

    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    NSTimeInterval _lastMissileAdded;
    
    FMMParallaxNode *_parallaxNodeBackgrounds;
    FMMParallaxNode *_parallaxSpaceDust;

}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [super initBaseContent];
        [self initalizingScrollingBackground:size];
        [self addShip];
        
        //Making self delegate of physics World
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        super.correctAnswersLabel.text = [NSString stringWithFormat:@"%d correct answers", [UserGameData getInstance].currentUser.numberOfCorrectAnswers];
        super.incorrectAnswersLabel.text = [NSString stringWithFormat:@"%d wrong answers", [UserGameData getInstance].currentUser.numberOfIncorrectAnswers];
        super.numberOfCollisionsLabel.text = [NSString stringWithFormat:@"%d collisions", [UserGameData getInstance].currentUser.numberOfCollisions];
    }

    return self;
}

-(void)addShip{
        //initalizing spaceship node
        ship = [SKSpriteNode spriteNodeWithImageNamed:@"red-rocket"];
        [ship setScale:0.75];
        ship.size = CGSizeMake(100, 50);
        ship.zRotation = - M_PI / 2;
    
        //Adding SpriteKit physicsBody for collision detection
        ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.size];
        ship.physicsBody.categoryBitMask = shipCategory;
        ship.physicsBody.dynamic = YES;
        ship.physicsBody.contactTestBitMask = obstacleCategory;
        ship.physicsBody.collisionBitMask = 0;
        ship.physicsBody.usesPreciseCollisionDetection = YES;
        ship.name = @"ship";
        ship.position = CGPointMake(120,100);
        actionMoveUp = [SKAction moveByX:0 y:30 duration:.2];
        actionMoveDown = [SKAction moveByX:0 y:-30 duration:.2];
    
        [self addChild:ship];
}

-(void)addMissile{
    //initalizing spaceship node
    SKSpriteNode *missile;
    missile = [SKSpriteNode spriteNodeWithImageNamed:@"red-missile.png"];
    missile.size = CGSizeMake(100, 100);
    [missile setScale:0.75];
    
    //Adding SpriteKit physicsBody for collision detection
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.categoryBitMask = obstacleCategory;
    missile.physicsBody.dynamic = YES;
    missile.physicsBody.contactTestBitMask = shipCategory;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.usesPreciseCollisionDetection = YES;
    missile.name = @"missile";
    
    //selecting random y position for missile
    int r = arc4random_uniform(self.scene.size.height);
    missile.position = CGPointMake(self.frame.size.width + 20,r);

    [self addChild:missile];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    [self selectNodeForTouch: touchLocation];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    if(![_selectedNode isEqual:touchedNode]
       && [[touchedNode name] isEqualToString:@"ship"]) {
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
    if([[_selectedNode name] isEqualToString:@"ship"]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

-(void)initalizingScrollingBackground:(CGSize)size{
        NSArray *parallaxBackgroundNames = @[@"bg_galaxy.png", @"bg_planetsunrise.png",
                                             @"bg_spacialanomaly.png", @"bg_spacialanomaly2.png"];
        CGSize planetSizes = CGSizeMake(200.0, 200.0);

        _parallaxNodeBackgrounds = [[FMMParallaxNode alloc] initWithBackgrounds: @"bgPlanets"
                                                                          files:parallaxBackgroundNames
                                                                           size:planetSizes
                                                           pointsPerSecondSpeed:100.0];

        _parallaxNodeBackgrounds.position = CGPointMake(size.width/2.0, size.height/2.0);
    
        [self addChild:_parallaxNodeBackgrounds];
}

- (void)moveObstacle{
    NSArray *nodes = self.children;//1
    
    for(SKNode * node in nodes){
        if ([node.name  isEqual: @"missile"]) {
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
    
    if( currentTime - _lastMissileAdded > 0)
    {
        _lastMissileAdded = currentTime + 1;
            [self addMissile];
    }

    [self moveObstacle];

    [_parallaxSpaceDust update:currentTime];
    [_parallaxNodeBackgrounds update:currentTime];
}


- (void)didBeginContact:(SKPhysicsContact *)contact{
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
    
    if ((firstBody.categoryBitMask & shipCategory) != 0 &&
        (secondBody.categoryBitMask & obstacleCategory) != 0)
    {
        [UserGameData getInstance].currentUser.numberOfCollisions++;
        [ship removeFromParent];
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        QuestionAnswerScene * questionAnswerScene = [[QuestionAnswerScene alloc] initWithSize:self.size];
        questionAnswerScene.sceneToDisplay = self;
        [self.view presentScene:questionAnswerScene transition: reveal];

    }
}


@end
