//
//  GameViewController.m
//  MathTastic
//
//  Created by Andrew Conk on 10/11/14.
//  Copyright (c) 2014 Andrew Conk. All rights reserved.
//

#import "GameViewController.h"
#import "MyScene.h"
#import "OceanScene.h"
#import "DefaultScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
    self.StartGame = true;
}

- (void)viewWillAppear:(BOOL)animated
{
    DefaultScene* defaultScene = [[DefaultScene alloc] initWithSize:CGSizeMake(768,1024)];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: defaultScene];
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.StartGame){
        SKView * view = (SKView *)self.view;
       
        MyScene * myScene = [[MyScene alloc] initWithSize:CGSizeMake(768,1024)];;
        @try {
            [view presentScene: myScene];        }
        @catch (NSException *exception) {
            NSLog(exception.callStackSymbols);
            NSLog(exception.description);
        }
        
        self.StartGame = false;
        
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    NSLog(@"Here I am.");
}

@end
