//
//  questionAnswerScene.m
//  GameTutorial
//

#import "QuestionAnswerScene.h"
#import "SpaceScene.h"
#import "TextField.h"
#import "MathProblemGenerator.h"
#import "MathProblem.h"
#import "OceanScene.h"

@implementation QuestionAnswerScene

MathProblemGenerator * mathProblemGenerator;
MathProblem * currentMathProblem;

-(void)didMoveToView:(SKView *)view{
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // 1
       // self.backgroundColor = [SKColor colorWithRed:100.0 green:100.0 blue:1.0 alpha:1.0];
        self.backgroundColor = [SKColor greenColor];
        // 2
        int16_t space = 50;
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = @"Solve the math problem to keep going...";
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 30;
        label.yScale = 2;
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + (5*space));
        [self addChild:label];
        
        mathProblemGenerator = [MathProblemGenerator alloc];
        currentMathProblem = [mathProblemGenerator getMathProblem];
        SKLabelNode *mathProblemLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        mathProblemLabel.text = currentMathProblem.question;
        mathProblemLabel.fontColor = [SKColor whiteColor];
        mathProblemLabel.position = CGPointMake(self.size.width/2, self.size.height/2 + space);
        mathProblemLabel.yScale = 2;
        //[mathProblemLabel setScale:.5];
        [self addChild:mathProblemLabel];
        
        int answerIteration = [SpriteKitCommon GenerateRandomInt:4];
        
        for(int i = 0; i < 4; i++){
            
            SKLabelNode *btnAnswer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            if(answerIteration == i){
                btnAnswer.text = [NSString stringWithFormat:@"%i", currentMathProblem.answer];
                btnAnswer.name =  @"btnAnswer";
            }
            else{
                btnAnswer.text = [NSString stringWithFormat:@"%i", [SpriteKitCommon GenerateRandomInt:10]];
                btnAnswer.name = [NSString stringWithFormat:@"btnAnswer%i", i ];
            }
            
            btnAnswer.yScale = 2;
            btnAnswer.fontColor = [SKColor whiteColor];
            
            btnAnswer.position = CGPointMake(self.size.width/4 + (i * 150), self.size.height/2 - (3*space));

            //[btnAnswer setScale:.5];
            
            [self addChild:btnAnswer];
        }
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    
    if ([node.name isEqualToString:@"btnAnswer"]) {
        //If user's answer is correct.
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    
            currentMathProblem.isCorrectAnswer = true;
            [[UserGameData getInstance].currentUser.userMathProblems addObject: currentMathProblem];
            [UserGameData getInstance].currentUser.numberOfCorrectAnswers+=1;
            [self.sceneToDisplay initWithSize:self.size];
            [self.view presentScene:self.sceneToDisplay transition: reveal];
        
    }
    else{
        SKLabelNode *wrongAnswer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        wrongAnswer.text = @"Sorry Try again!";
        wrongAnswer.fontColor = [SKColor whiteColor];
        wrongAnswer.position = CGPointMake(self.size.width/2, 170);
        wrongAnswer.name = @"wrongAnswer";
        [wrongAnswer setScale:.5];
        
        [self addChild:wrongAnswer];
        [UserGameData getInstance].currentUser.numberOfIncorrectAnswers+=1;
    }
   
    return;
}

@end
