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
            xPos = arc4random_uniform(screenWidth - 100);
            yPos = arc4random_uniform(screenHeight - 100);
            overlapping = NO;
            
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

        NSTimer *tempTimer = badBubbleTimers[bubbleNumber];
        
        if(tempTimer != nil){
            [tempTimer invalidate];
            tempTimer = nil;
        }

        /*
        if (badBubbleTimers[bubbleNumber] != nil){
            [badBubbleTimers[bubbleNumber] invalidate];
            badBubbleTimers[bubbleNumber] = nil;
        }
         */
       

        badBubbleTimerRestart[bubbleNumber] = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                  target:self
                                                                selector:@selector(startBadDisplayTimer)
                                                                userInfo:@(bubbleNumber)
                                                                 repeats:NO];

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
            xPos = arc4random_uniform(screenWidth - 100);
            yPos = arc4random_uniform(screenHeight - 100);
            overlapping = NO;
            
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
        
        NSTimer *tempTimer = goodBubbleTimers[bubbleNumber];
        
        if(tempTimer != nil){
            [tempTimer invalidate];
            tempTimer = nil;
        }
        
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
        bad.center = CGPointMake(screenWidth / 2 + i*10, screenHeight / 2);
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
        good.center = CGPointMake(screenWidth / 2 + i*10, screenHeight / 2 + 200);
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
                                                       repeats:YES];

        [badBubbleTimers addObject:tempTimerBad];
        
        NSTimer *tempTimerGood = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                              target:self
                                                            selector:@selector(goodBubbleTimer:)
                                                            userInfo:@(i)
                                                             repeats:YES];
        
        [goodBubbleTimers addObject:tempTimerGood];
        
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

    }
}

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

- (void)restartBadTimer:(int)bubbleNumber{
    
}

- (void)restartGoodTimer:(int)bubbleNumber{
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UITapGestureRecognizer *singleTapBad = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBadSingleTap:)];
    _badBubble.userInteractionEnabled = YES;
    [_badBubble addGestureRecognizer:singleTapBad];

    UITapGestureRecognizer *singleTapBad2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBadSingleTap:)];
    _badBubble2.userInteractionEnabled = YES;
    [_badBubble2 addGestureRecognizer:singleTapBad2];
    
    UITapGestureRecognizer *singleTapGood = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGoodSingleTap:)];
    _goodBubble.userInteractionEnabled = YES;
    [_goodBubble addGestureRecognizer:singleTapGood];
    
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
    
    
    
/*
    //bad bubbles
    NSMutableArray * badBubbles = [NSArray arrayWithObjects:_badBubble, _badBubble2, nil];
*/
 
    [self startTimeLeftTimer];
    [self startBadDisplayTimer];
    [self startGoodDisplayTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
