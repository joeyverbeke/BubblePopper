//
//  gameplayViewController.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gameplayViewController.h"
#import "BubblePopperBrain.h"
#include <stdlib.h>

@interface gameplayViewController ()
@property (nonatomic, strong) BubblePopperBrain *brain;
@end

@implementation gameplayViewController

- (BubblePopperBrain *)brain
{
    if(!_brain) _brain = [[BubblePopperBrain alloc] init];
    return _brain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_white_feathers_@2X.png"]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.goodBubble.hidden = YES;
    self.badBubble.hidden = YES;
    
    [self displayBubble];
}

-(void)handleTapFrom:(UITapGestureRecognizer *)recognizer{
    if(!self.badBubble.hidden){
        NSLog(@"---");
        NSLog(@"UIView tapped");
        self.badBubble.hidden = YES;
        [self displayBubble];
    }
}

-(void)displayBubble{
    int xPos, yPos;
    int randBubbleDecider = arc4random_uniform(10);
    
    do{
        xPos = arc4random_uniform(screenWidth - 50);
    }while(xPos < 50);
    
    do{
        yPos = arc4random_uniform(screenHeight - 50);
    }while(yPos < 100);
    
    if(randBubbleDecider >= 4){
        self.goodBubble.center = CGPointMake(xPos, yPos);
        self.goodBubble.hidden = NO;
    }
    else{
        self.badBubble.center = CGPointMake(xPos, yPos);
        self.badBubble.hidden = NO;
    }

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
}

-(void)gameOver{
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
    NSLog(@"---");
    NSLog(@"bad");
    NSLog(@"%li", (long)sender.tag);
    sender.hidden = YES;
    [self changeScore:NO];
    [self displayBubble];
}

- (IBAction)goodPressed:(UIButton *)sender {
//    NSLog(@"good");
//    NSLog(@"%li", (long)sender.tag);
    sender.hidden = YES;
    [self changeScore:YES];
    [self displayBubble];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self startTimeLeftTimer];
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
