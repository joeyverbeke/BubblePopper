//
//  BubbleTimer.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/20/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//
/*
#import "BubbleTimer.h"
#include <stdlib.h>

@implementation BubbleTimer

-(void)startDisplayTimer:(NSTimeInterval)time{
    timer_mabyeDisplayBubble = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                       target:self
                                                     selector:@selector(shouldBubbleBeDisplayed)
                                                     userInfo:nil
                                                      repeats:YES];
}

-(void)startBeingDisplayedTimer:(NSTimeInterval)time{
    timer_bubbleBeingDisplayed = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                               target:self
                                                             selector:@selector(startGoodDisplayTimer)
                                                             userInfo:nil
                                                              repeats:NO];
}

-(BOOL)shouldBubbleBeDisplayed{
    BOOL display = NO;
    int rand = arc4random_uniform(5);
    
    if(rand == 2)
        display = YES;

    //check if it's being displayed in view
    //invalidate timer and call other timer if it isn't
    
    return display;
}



@end
 */
