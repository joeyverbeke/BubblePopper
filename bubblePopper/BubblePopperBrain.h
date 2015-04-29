//
//  BubblePopperBrain.h
//  bubblePopper
//
//  Created by Joey Verbeke on 4/18/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BubblePopperBrain : NSObject

-(void)checkIfHighScoresExist;
-(BOOL)scoreHighEnoughToAdd:(int)score;
-(void)addHighScore:(int)score
                   :(NSString*)name;

@end