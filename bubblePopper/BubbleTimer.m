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

BOOL display = NO;

-(BOOL)startDisplayTimer:(NSTimeInterval)time
                        :(BOOL)beingDisplayed{
    
    NSDictionary *info = [NSDictionary dictionaryWithObject: [NSNumber numberWithBool:beingDisplayed] forKey: @"displayed"];
    
    timer_mabyeDisplayBubble = [NSTimer scheduledTimerWithTimeInterval:time
                                                       target:self
                                                              selector:@selector(shouldBubbleBeDisplayed:)
                                                     userInfo:info
                                                      repeats:YES];
    
    return display;
}

-(void)startBeingDisplayedTimer:(NSTimeInterval)time{
    timer_bubbleBeingDisplayed = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                               target:self
                                                             selector:@selector(startGoodDisplayTimer)
                                                             userInfo:nil
                                                              repeats:NO];
}

-(void)shouldBubbleBeDisplayed:(BOOL)beingDisplayed{
    
    display = NO;
    int rand = arc4random_uniform(5);
    
    if(rand == 2 && !beingDisplayed){
        display = YES;
        if(timer_mabyeDisplayBubble != nil){
            [timer_mabyeDisplayBubble invalidate];
            timer_mabyeDisplayBubble = nil;
        }
        
        timer_bubbleBeingDisplayed = [NSTimer scheduledTimerWithTimeInterval:1.8
                                                                      target:self
                                                                    selector:@selector(startDisplayTimer:)
                                                                    userInfo:nil
                                                                     repeats:NO];
    }
    else{
        display = YES;
    }

    //invalidate timer and call other timer if it isn't
    
}



@end

 */
