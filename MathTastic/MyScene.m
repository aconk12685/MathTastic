//
//  MyScene.m
//  GameTutorial
//
//  Created by MEGHA GULATI on 10/26/13.
//  Copyright (c) 2013 MEGHA GULATI. All rights reserved.
//

#import "MyScene.h"
#import "QuestionAnswerScene.h"

static const uint32_t shipCategory =  0x1 << 0;
static const uint32_t obstacleCategory =  0x1 << 1;

static const float BG_VELOCITY = 100.0;
static const float OBJECT_VELOCITY = 160.0;

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}


@implementation MyScene{

    SKSpriteNode *ship;
    SKSpriteNode *ship2;
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
        //self.backgroundColor = [SKColor blackColor];
        [self initalizingScrollingBackground:size];
        [self addShip];
        [self addSeaTurtle];
        
        //Making self delegate of physics World
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        
        
        
    }

    return self;
}


-(void)addShip
{
        //initalizing spaceship node
        ship = [SKSpriteNode spriteNodeWithImageNamed:@"red-rocket"];
        [ship setScale:0.25];
        ship.zRotation = - M_PI / 2;
    
        //Adding SpriteKit physicsBody for collision detection
        ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.size];
        ship.physicsBody.categoryBitMask = shipCategory;
        ship.physicsBody.dynamic = YES;
        ship.physicsBody.contactTestBitMask = obstacleCategory;
        ship.physicsBody.collisionBitMask = 0;
        ship.physicsBody.usesPreciseCollisionDetection = YES;
        ship.name = @"ship";
        ship.position = CGPointMake(120,160);
        actionMoveUp = [SKAction moveByX:0 y:30 duration:.2];
        actionMoveDown = [SKAction moveByX:0 y:-30 duration:.2];

        [self addChild:ship];
}

-(void)addSeaTurtle
{
    //initalizing spaceship node
    ship = [SKSpriteNode spriteNodeWithImageNamed:@"sea-turtle"];
    [ship setScale:0.25];
    //ship.zRotation = - M_PI / 2;
    
    
    //Adding SpriteKit physicsBody for collision detection
    ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.size];
    ship.physicsBody.categoryBitMask = shipCategory;
    ship.physicsBody.dynamic = YES;
    ship.physicsBody.contactTestBitMask = obstacleCategory;
    ship.physicsBody.collisionBitMask = 0;
    ship.physicsBody.usesPreciseCollisionDetection = YES;
    ship.name = @"seaturtle";
    ship.position = CGPointMake(120,100);
    actionMoveUp = [SKAction moveByX:0 y:30 duration:.2];
    actionMoveDown = [SKAction moveByX:0 y:-30 duration:.2];
    
    [self addChild:ship];
}

-(void)addMissile
{
    //initalizing spaceship node
    SKSpriteNode *missile;
    missile = [SKSpriteNode spriteNodeWithImageNamed:@"red-missile.png"];
    [missile setScale:0.15];
    
    //Adding SpriteKit physicsBody for collision detection
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.categoryBitMask = obstacleCategory;
    missile.physicsBody.dynamic = YES;
    missile.physicsBody.contactTestBitMask = shipCategory;
    missile.physicsBody.collisionBitMask = 0;
    missile.physicsBody.usesPreciseCollisionDetection = YES;
    missile.name = @"missile";
    
    //selecting random y position for missile
    int r = arc4random() % 500;
    missile.position = CGPointMake(self.frame.size.width + 20,r);

    [self addChild:missile];
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
             [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
             
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
        //1
        NSArray *parallaxBackgroundNames = @[@"bg_galaxy.png", @"bg_planetsunrise.png",
                                             @"bg_spacialanomaly.png", @"bg_spacialanomaly2.png"];
        CGSize planetSizes = CGSizeMake(200.0, 200.0);
        //2
        _parallaxNodeBackgrounds = [[FMMParallaxNode alloc] initWithBackgrounds: @"bgPlanets"
                                                                          files:parallaxBackgroundNames
                                                                           size:planetSizes
                                                           pointsPerSecondSpeed:10.0];
        //3
        _parallaxNodeBackgrounds.position = CGPointMake(size.width/2.0, size.height/2.0);
        //4
        [_parallaxNodeBackgrounds randomizeNodesPositions];
        
        //5
        [self addChild:_parallaxNodeBackgrounds];
        
        //6
        NSArray *parallaxBackground2Names = @[@"bg_front_spacedust.png",@"bg_front_spacedust.png"];
        _parallaxSpaceDust = [[FMMParallaxNode alloc] initWithBackgrounds: @"bgSpaceDust"
                                                                    files:parallaxBackground2Names
                                                                     size:size
                                                     pointsPerSecondSpeed:25.0];
        _parallaxSpaceDust.position = CGPointMake(0, 0);
        [self addChild:_parallaxSpaceDust];
        
    
 //   }
    
}

- (void)moveBg
{
    [self enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint bgVelocity = CGPointMake(-BG_VELOCITY, 0);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
         bg.position = CGPointAdd(bg.position, amtToMove);
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.x <= -bg.size.width)
         {
             bg.position = CGPointMake(bg.position.x + bg.size.width*2,
                                       bg.position.y);
         }
     }];
}

- (void)moveObstacle
{
    NSArray *nodes = self.children;//1
    
    for(SKNode * node in nodes){
        if ([node.name  isEqual: @"missile"]) {
            SKSpriteNode *ob = (SKSpriteNode *) node;
            CGPoint obVelocity = CGPointMake(-OBJECT_VELOCITY, 0);
            CGPoint amtToMove = CGPointMultiplyScalar(obVelocity,_dt);
            
            ob.position = CGPointAdd(ob.position, amtToMove);
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
    
    if( currentTime - _lastMissileAdded > .25)
    {
        _lastMissileAdded = currentTime + 1;
            [self addMissile];
    }

    
    //[self moveBg];
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
    
    if ((firstBody.categoryBitMask & shipCategory) != 0 &&
        (secondBody.categoryBitMask & obstacleCategory) != 0)
    {
        [ship removeFromParent];
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * questionAnswerScene = [[QuestionAnswerScene alloc] initWithSize:self.size];
        [self.view presentScene:questionAnswerScene transition: reveal];

    }
}


@end
