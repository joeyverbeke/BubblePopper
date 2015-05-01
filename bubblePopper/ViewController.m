//
//  ViewController.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/14/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//



#import "ViewController.h"
#import "BubblePopperBrain.h"
#include <stdlib.h>

@interface ViewController ()
@property (nonatomic, strong) BubblePopperBrain *brain;
@end

@implementation ViewController

int screenWidth = 0;
int screenHeight = 0;

int badRand = 0;
int badPositionRand_X = 50;
int badPositionRand_Y = 50;
BOOL showBadBubble = NO;
BOOL badBubbleBeingDisplayed = NO;

int goodRand = 0;
int goodPositionRand_X = 50;
int goodPositionRand_Y = 50;
BOOL showGoodBubble = NO;
BOOL goodBubbleBeingDisplayed = NO;

- (BubblePopperBrain *)brain
{
    if(!_brain) _brain = [[BubblePopperBrain alloc] init];
    return _brain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_white_feathers_@2X.png"]];

}

-(void)startTimeLeftTimer{
    timerTimeLeft = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(decrementTimeLeft)
                                                     userInfo:nil
                                                      repeats:YES];
}


-(void)decrementTimeLeft{
    NSString *textFromTimerLabel = self.timeLeft.text;
    NSInteger intFromTimerLabel = [textFromTimerLabel integerValue];
    
    intFromTimerLabel--;
    
    self.timeLeft.text = [NSString stringWithFormat:@"%ld", (long)intFromTimerLabel];
    
    if(intFromTimerLabel == 5)
        self.timeLeft.textColor = [UIColor redColor];
    
    if(intFromTimerLabel == 0)
        [self gameOver];
    else{
        for(int i=0; i<5; i++){
 
            #define ARC4RANDOM_MAX      0x100000000
            
            double time;
            
            UIButton *badBubble = badBubbles[i];
            
            if(badBubble.hidden == YES){
                time = ((double)arc4random() / ARC4RANDOM_MAX) * 3.0f + 0.5;
            
                NSTimer *tempTimerBad = [NSTimer scheduledTimerWithTimeInterval:time
                                                                         target:self
                                                                       selector:@selector(badBubbleTimer:)
                                                                       userInfo:@(i)
                                                                        repeats:NO];
            
                [badBubbleTimers addObject:tempTimerBad];
            }
            
            UIButton *goodBubble = badBubbles[i];
            
            if(goodBubble.hidden == YES){
                time = ((double)arc4random() / ARC4RANDOM_MAX) * 3.0f + 0.5;
            
                NSTimer *tempTimerGood = [NSTimer scheduledTimerWithTimeInterval:time
                                                                          target:self
                                                                        selector:@selector(goodBubbleTimer:)
                                                                        userInfo:@(i)
                                                                         repeats:NO];
            
                [goodBubbleTimers addObject:tempTimerGood];
            }
        }
        
        
    }
}

-(void)gameOver{
    for(int i=0; i<5; i++){
        NSTimer *badTemp = badBubbleTimers[i];
        [badTemp invalidate];
        badTemp  = nil;
        
        NSTimer *goodTemp = goodBubbleTimers[i];
        [goodTemp invalidate];
        goodTemp  = nil;
    }
    
    [timerTimeLeft invalidate];
    timerTimeLeft = nil;
    
    int userScore = (int)[self.score.text integerValue];
    
    if([self.brain scoreHighEnoughToAdd:userScore]){
        [self showNewHighScoreAlert];
    }
    else{
        [self showNoNewHighScoreAlert];
    }
}

-(void)changeScore:(BOOL)increment{

    NSString *scoreText = self.score.text;
    NSInteger scoreInt = [scoreText integerValue];
    
    if(increment)
        scoreInt += 10;
    else
        scoreInt -= 20;
        
    self.score.text = [NSString stringWithFormat:@"%ld", (long)scoreInt];
}

- (IBAction)badPressed:(UIButton *)sender {
    NSLog(@"bad");
    NSLog(@"%li", (long)sender.tag);
    sender.hidden = YES;
    [self changeScore:NO];
}

- (IBAction)goodPressed:(UIButton *)sender {
    NSLog(@"good");
    NSLog(@"%li", (long)sender.tag);
    sender.hidden = YES;
    [self changeScore:YES];
}

- (void)timer:(int)buttonNumber{
    
}


- (void)badBubbleTimer:(NSTimer*)sender{
    NSInteger bubbleNumber = [sender.userInfo integerValue];
    
    [self handleBadBubbleDisplay:bubbleNumber];
}


- (void)goodBubbleTimer:(NSTimer*)sender{
    NSInteger bubbleNumber = [sender.userInfo integerValue];
    
    [self handleGoodBubbleDisplay:bubbleNumber];
    
}


 
- (void)handleBadBubbleDisplay:(NSInteger)bubbleNumber{
    
    badRand = arc4random_uniform(5);
    
    UIButton *bubble = badBubbles[bubbleNumber];
    
    if(badRand == 2 && bubble.hidden){
        
        int xPos;
        int yPos;
        BOOL overlapping = NO;
        
        do{
            overlapping = NO;
            
            do{
                xPos = arc4random_uniform(screenWidth - 75);
            }while(xPos < 75);
            
            do{
                yPos = arc4random_uniform(screenHeight - 75);
            }while(yPos < 100);
            
             
            bubble.center = CGPointMake(xPos, yPos);
            
            for(id otherBubble in badBubbles){
                UIButton *temp = otherBubble;
                
                if(temp != bubble){
                    if(CGRectIntersectsRect(bubble.frame, temp.frame))
                        overlapping = YES;
                }
            }
            for(id otherBubble in goodBubbles){
                UIButton *temp = otherBubble;
                
                if(CGRectIntersectsRect(bubble.frame, temp.frame))
                    overlapping = YES;
            }
        }while(overlapping);
        
        bubble.hidden = NO;
        
        //badTimers
        //need to create an array of timers
        //use tags or position in bubble array to index
        //create timer at same index within bubbleTimer array

/*
        NSTimer *tempTimer = badBubbleTimers[bubbleNumber];
        
        if(tempTimer != nil){
            [tempTimer invalidate];
            tempTimer = nil;
        }
 */

        /*
        if (badBubbleTimers[bubbleNumber] != nil){
            [badBubbleTimers[bubbleNumber] invalidate];
            badBubbleTimers[bubbleNumber] = nil;
        }
         */
       
/*
        badBubbleTimerRestart[bubbleNumber] = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                  target:self
                                                                selector:@selector(startBadDisplayTimer)
                                                                userInfo:@(bubbleNumber)
                                                                 repeats:NO];
*/

    }
    else{
        bubble.hidden = YES;
    }
}

- (void)handleGoodBubbleDisplay:(NSInteger)bubbleNumber{
    
    goodRand = arc4random_uniform(5);
    
    UIButton *bubble = goodBubbles[bubbleNumber];
    
    if(goodRand == 2 && bubble.hidden){
        
        int xPos;
        int yPos;
        BOOL overlapping = NO;
        
        do{
            overlapping = NO;
            
            do{
                xPos = arc4random_uniform(screenWidth - 50);
            }while(xPos < 50);
            
            do{
                yPos = arc4random_uniform(screenHeight - 50);
            }while(yPos < 100);
            
            bubble.center = CGPointMake(xPos, yPos);
            
            for(id otherBubble in goodBubbles){
                UIButton *temp = otherBubble;
                
                if(temp != bubble){
                    if(CGRectIntersectsRect(bubble.frame, temp.frame))
                        overlapping = YES;
                }
            }
            for(id otherBubble in badBubbles){
                UIButton *temp = otherBubble;
                
                if(CGRectIntersectsRect(bubble.frame, temp.frame))
                    overlapping = YES;
            }
        }while(overlapping);
        
        bubble.hidden = NO;
        
        //badTimers
        //need to create an array of timers
        //use tags or position in bubble array to index
        //create timer at same index within bubbleTimer array

/*
        NSTimer *tempTimer = goodBubbleTimers[bubbleNumber];
        
        if(tempTimer != nil){
            [tempTimer invalidate];
            tempTimer = nil;
        }
 */
        
        /*
        if (goodBubbleTimers[bubbleNumber] != nil){
            [goodBubbleTimers[bubbleNumber] invalidate];
            goodBubbleTimers[bubbleNumber] = nil;
        }
         */
        
/*
        goodBubbleTimerRestart[bubbleNumber] = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                               target:self
                                                                             selector:@selector(startGoodDisplayTimer)
                                                                             userInfo:@(bubbleNumber)
                                                                              repeats:NO];
 */
    }
    else{
        bubble.hidden = YES;
    }
}

- (void)createBadBubbles{

    for(int i=0; i<5; i++){
        UIButton *bad = [UIButton buttonWithType:UIButtonTypeCustom];
        bad.center = CGPointMake(screenWidth * 2, screenHeight * 2);
        [bad setBackgroundImage:[UIImage imageNamed:@"badCircle.png"] forState:UIControlStateNormal];
        [bad sizeToFit];
        [bad addTarget:self action:@selector(badPressed:) forControlEvents:UIControlEventTouchUpInside];
        bad.adjustsImageWhenHighlighted = NO;
        bad.tag = i;
    
        [self.view addSubview:bad];
        
        [badBubbles addObject:bad];
        
//        [self startBadTimer:i];
    }
}

- (void)createGoodBubbles{
    
    for(int i=0; i<5; i++){
        UIButton *good = [UIButton buttonWithType:UIButtonTypeCustom];
        good.center = CGPointMake(screenWidth * 2, screenHeight * 2);
        [good setBackgroundImage:[UIImage imageNamed:@"goodCircle.png"] forState:UIControlStateNormal];
        [good sizeToFit];
        [good addTarget:self action:@selector(goodPressed:) forControlEvents:UIControlEventTouchUpInside];
        good.adjustsImageWhenHighlighted = NO;
        good.tag = i;
        
        [self.view addSubview:good];
        
        [goodBubbles addObject:good];
        
//        [self startGoodTimer:i];
    }
}

- (void)createTimers{
    for(int i=0; i<5; i++){
        NSTimer *tempTimerBad = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                        target:self
                                                      selector:@selector(badBubbleTimer:)
                                                      userInfo:@(i)
                                                       repeats:NO];

        [badBubbleTimers addObject:tempTimerBad];
        
        NSTimer *tempTimerGood = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                              target:self
                                                            selector:@selector(goodBubbleTimer:)
                                                            userInfo:@(i)
                                                             repeats:NO];
        
        [goodBubbleTimers addObject:tempTimerGood];

/*
        NSTimer *badTimerRestart = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                   target:self
                                                                 selector:@selector(startBadTimer:)
                                                                 userInfo:@(i)
                                                                  repeats:NO];
        [badBubbleTimerRestart addObject:badTimerRestart];
        
        NSTimer *goodTimerRestart = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                    target:self
                                                                  selector:@selector(startGoodTimer:)
                                                                  userInfo:@(i)
                                                                   repeats:NO];
        [goodBubbleTimerRestart addObject:goodTimerRestart];
*/
 
    }
}


//timers for restarting
/*
- (void)startBadTimer:(NSTimer *)sender{
    NSInteger bubbleNumber = [sender.userInfo integerValue];
    
    badBubbleTimers[bubbleNumber] = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                     target:self
                                                                   selector:@selector(badBubbleTimer:)
                                                                   userInfo:@(bubbleNumber)
                                                                    repeats:YES];
}

- (void)startGoodTimer:(NSTimer *)sender{
    NSInteger bubbleNumber = [sender.userInfo integerValue];
    
    goodBubbleTimers[bubbleNumber] = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                     target:self
                                                                   selector:@selector(goodBubbleTimer:)
                                                                   userInfo:@(bubbleNumber)
                                                                    repeats:YES];
}
*/


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    badBubbles = [[NSMutableArray alloc] init];
    goodBubbles = [[NSMutableArray alloc] init];
    
    badBubbleTimers = [[NSMutableArray alloc] init];
    goodBubbleTimers = [[NSMutableArray alloc] init];
    
    badBubbleTimerRestart = [[NSMutableArray alloc] init];
    goodBubbleTimerRestart = [[NSMutableArray alloc] init];
    
    [self createBadBubbles];
    [self createGoodBubbles];
    [self createTimers];
    [self startTimeLeftTimer];
    
    [self.brain checkIfHighScoresExist];
    
/*
    //bad bubbles
    NSMutableArray * badBubbles = [NSArray arrayWithObjects:_badBubble, _badBubble2, nil];
*/

    /*
    [self startBadDisplayTimer];
    [self startGoodDisplayTimer];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNewHighScoreAlert {
    
    NSString *title = [@"New High Score: " stringByAppendingString:self.score.text];
    
    UIAlertView *highScoreAlert = [[UIAlertView alloc]
                          
                          initWithTitle:title
                          message:@"Please Enter Your Name"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    highScoreAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [highScoreAlert show];
}

- (void)showNoNewHighScoreAlert {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Game Over"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        int userScore = (int)[self.score.text integerValue];
        
        [self.brain addHighScore:userScore:name];
    }
    
    //make work
    [self performSegueWithIdentifier:@"segueToStartScreen" sender:self];
}

@end


