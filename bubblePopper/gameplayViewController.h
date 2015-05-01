//
//  gameplayViewController.h
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#ifndef bubblePopper_gameplayViewController_h
#define bubblePopper_gameplayViewController_h

#import <UIKit/UIKit.h>

@interface gameplayViewController : UIViewController {
    NSTimer *timerTimeLeft;
    int screenWidth;
    int screenHeight;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLeft;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIButton *badBubble;
@property (weak, nonatomic) IBOutlet UIButton *goodBubble;

@end

#endif
