//
//  questionAnswerScene.m
//  GameTutorial
//

#import "QuestionAnswerScene.h"
#import "MyScene.h"
#import "TextField.h"
#import "MathProblemGenerator.h"

@implementation QuestionAnswerScene

TextField * mathProblemAnswer;
MathProblemGenerator * mathProblemGenerator;

-(void)didMoveToView:(SKView *)view{
    mathProblemAnswer = [[TextField alloc] initWithFrame:CGRectMake(340, 80, 50, 20)];
    mathProblemAnswer.backgroundColor = [SKColor whiteColor];
    mathProblemAnswer.textColor = [SKColor blackColor];
    mathProblemAnswer.keyboardType = UIKeyboardTypeNumberPad;
    mathProblemAnswer.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:mathProblemAnswer];
    
}

-(void)delegateMethod:(UITextField *) textField
{
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // 1
        //self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.backgroundColor = [SKColor blackColor];
        // 2
        NSString * message;
        message = @"Solve the math problem to keep going...";
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 12;
        label.fontColor = [SKColor whiteColor];
        label.position = CGPointMake(self.size.width/2, 260);
        [self addChild:label];
        
        mathProblemGenerator = [MathProblemGenerator alloc];
        
        NSString * mathProblem;
        mathProblem = [mathProblemGenerator getMathProblem];
        SKLabelNode *mathProblemLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        mathProblemLabel.text = mathProblem;
        mathProblemLabel.fontColor = [SKColor whiteColor];
        mathProblemLabel.position = CGPointMake(self.size.width/2, 225);
        [mathProblemLabel setScale:.5];
        [self addChild:mathProblemLabel];
        
        NSString * retrymessage;
        retrymessage = @"Submit Answer";
        SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        retryButton.text = retrymessage;
        retryButton.fontColor = [SKColor whiteColor];
        retryButton.position = CGPointMake(self.size.width/2, 200);
        retryButton.name = @"retry";
        [retryButton setScale:.5];
        
        [self addChild:retryButton];
        
        
    }
    return self;
}

bool displayedError = false;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    [mathProblemAnswer resignFirstResponder];
    
    if ([node.name isEqualToString:@"retry"] && ([mathProblemGenerator getMathProblemAnswer] == [mathProblemAnswer.text intValue])) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        MyScene * scene = [MyScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        [mathProblemAnswer removeFromSuperview];
    }
    else if(displayedError == false)
    {
        SKLabelNode *wrongAnswer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        wrongAnswer.text = @"Sorry Try again!";
        wrongAnswer.fontColor = [SKColor whiteColor];
        wrongAnswer.position = CGPointMake(self.size.width/2, 170);
        wrongAnswer.name = @"wrongAnswer";
        [wrongAnswer setScale:.5];
        
        [self addChild:wrongAnswer];
        
        displayedError = true;
        return;
    }
    
    displayedError = false;
   
    return;
}

-(void)update:(NSTimeInterval)currentTime{
   
}
@end
