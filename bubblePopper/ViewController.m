//
//  ViewController.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/14/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

@interface ViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)goodPressed:(UIButton *)sender{
    
}

- (void)shouldBadBubbleBeDisplayed{

    badRand = arc4random_uniform(5);
    
    if(badRand == 2 && !badBubbleBeingDisplayed){

        [self changeBadBubblePosition];
        
        showBadBubble = YES;
        badBubbleBeingDisplayed = YES;


        if (badDisplayTimer != nil){
            [badDisplayTimer invalidate];
            badDisplayTimer = nil;
        }

        restartBadDisplayTimer = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                  target:self
                                                                selector:@selector(startBadDisplayTimer)
                                                                userInfo:nil
                                                                 repeats:NO];
    }
    else {
        showBadBubble = NO;
        badBubbleBeingDisplayed = NO;
        [self changeBadBubblePosition];
    }
}

- (void)shouldGoodBubbleBeDisplayed{
    
    goodRand = arc4random_uniform(5);
    
    if(goodRand == 4 && !goodBubbleBeingDisplayed){
        
        [self changeGoodBubblePosition];
        
        showGoodBubble = YES;
        goodBubbleBeingDisplayed = YES;
        
        
        if (goodDisplayTimer != nil){
            [goodDisplayTimer invalidate];
            goodDisplayTimer = nil;
        }
        
        restartGoodDisplayTimer = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                  target:self
                                                                selector:@selector(startGoodDisplayTimer)
                                                                userInfo:nil
                                                                 repeats:NO];
    }
    else {
        showGoodBubble = NO;
        goodBubbleBeingDisplayed = NO;
        [self changeGoodBubblePosition];
    }
}

-(void)badTimer{

    [self shouldBadBubbleBeDisplayed];
    
    if(showBadBubble){
        _badBubble.hidden = NO;
    }
    else{
        _badBubble.hidden = YES;
    }
}

-(void)goodTimer{
    
    [self shouldGoodBubbleBeDisplayed];
    
    if(showGoodBubble){
        _goodBubble.hidden = NO;
    }
    else{
        _goodBubble.hidden = YES;
    }
}

-(void)startBadDisplayTimer{
    badDisplayTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                       target:self
                                                     selector:@selector(badTimer)
                                                     userInfo:nil
                                                      repeats:YES];
}

-(void)startGoodDisplayTimer{
    goodDisplayTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                       target:self
                                                     selector:@selector(goodTimer)
                                                     userInfo:nil
                                                      repeats:YES];
}

-(void)changeBadBubblePosition{

    //need to make sure it doesn't go off screen
    
    do{
        badPositionRand_X = arc4random_uniform(screenWidth - 100);
        badPositionRand_Y = arc4random_uniform(screenHeight - 100);
    }while (((badPositionRand_X < goodPositionRand_X + 50) && (badPositionRand_X > goodPositionRand_X - 50)) || ((badPositionRand_Y < goodPositionRand_Y + 50) && (badPositionRand_Y > goodPositionRand_Y - 50)));
    
    [_badBubble setFrame:CGRectMake(badPositionRand_X, badPositionRand_Y, _badBubble.frame.size.width, _badBubble.frame.size.height)];
}

-(void)changeGoodBubblePosition{
    
    do{
        goodPositionRand_X = arc4random_uniform(screenWidth - 100);
        goodPositionRand_Y = arc4random_uniform(screenHeight - 100);
    }while (((goodPositionRand_X < badPositionRand_X + 50) && (goodPositionRand_X > badPositionRand_X - 50)) || ((goodPositionRand_Y < badPositionRand_Y + 50) && (goodPositionRand_Y > badPositionRand_Y - 50)));
    
    [_goodBubble setFrame:CGRectMake(goodPositionRand_X, goodPositionRand_Y, _goodBubble.frame.size.width, _goodBubble.frame.size.height)];
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


- (void)handleBadSingleTap:(UITapGestureRecognizer *)sender{
    NSLog(@"Bad");
    [sender view].hidden = true;
    [self changeScore:NO];
    [self badTimer];
    
}

- (void)handleGoodSingleTap:(UITapGestureRecognizer *)sender{
    NSLog(@"Good");
    [sender view].hidden = true;
    [self changeScore:YES];
    [self goodTimer];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UITapGestureRecognizer *singleTapBad = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBadSingleTap:)];
    _badBubble.userInteractionEnabled = YES;
    [_badBubble addGestureRecognizer:singleTapBad];

    UITapGestureRecognizer *singleTapGood = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGoodSingleTap:)];
    _goodBubble.userInteractionEnabled = YES;
    [_goodBubble addGestureRecognizer:singleTapGood];
    
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [self startTimeLeftTimer];
    [self startBadDisplayTimer];
    [self startGoodDisplayTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
