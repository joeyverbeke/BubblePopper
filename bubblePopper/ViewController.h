//
//  ViewController.h
//  bubblePopper
//
//  Created by Joey Verbeke on 4/14/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "QuartzCore/CAAnimation.h>

@interface ViewController : UIViewController {
    NSTimer *timerTimeLeft;
    NSTimer *badDisplayTimer;
    NSTimer *restartBadDisplayTimer;
    NSTimer *goodDisplayTimer;
    NSTimer *restartGoodDisplayTimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *badBubble;
@property (weak, nonatomic) IBOutlet UIImageView *goodBubble;
@property (weak, nonatomic) IBOutlet UILabel *timeLeft;
@property (weak, nonatomic) IBOutlet UILabel *score;


-(void)decrementTimeLeft;
-(void)startTimeLeftTimer;

-(void)badTimer;
-(void)shouldBadBubbleBeDisplayed;
-(void)startBadDisplayTimer;
-(void)changeBadBubblePosition;

-(void)goodTimer;
-(void)shouldGoodBubbleBeDisplayed;
-(void)startGoodDisplayTimer;
-(void)changeGoodBubblePosition;

-(void)changeScore:(BOOL)increment;

@end

