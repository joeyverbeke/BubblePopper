//
//  BubblePopperBrain.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/18/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import "BubblePopperBrain.h"


@interface BubblePopperBrain()
@property (nonatomic, strong) NSMutableArray *highScoreList;
@end

@implementation BubblePopperBrain

@synthesize highScoreList = _highScoreList;

- (NSMutableArray *)highScoreList
{
    if(!_highScoreList){
        _highScoreList = [[NSMutableArray alloc] init];
    }
    return _highScoreList;
}

-(void)checkIfHighScoresExist{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"firstTimeBeingRun"]){
        [defaults setObject:[NSDate date] forKey:@"firstTimeBeingRun"];
    
        int highScore = 110;
        
        NSMutableArray *names = [[NSMutableArray alloc] init];
        [names addObject:@"Joe"];
        [names addObject:@"Jill"];
        [names addObject:@"Foo"];
        [names addObject:@"Bar"];
        [names addObject:@"Hannah"];
        [names addObject:@"Fred"];
        [names addObject:@"Jade"];
        [names addObject:@"Mark"];
        [names addObject:@"Tina"];
        [names addObject:@"Bob"];
        
        for(int i=0; i<10; i++){
            NSString *highScoreIndex = [NSString stringWithFormat:@"%d",i];
            NSString *highScoreNameIndex = [NSString stringWithFormat:@"%d",i];
            
            highScore -= 10;
            
            highScoreIndex = [highScoreIndex stringByAppendingString:@"highScore"];
            highScoreNameIndex = [highScoreNameIndex stringByAppendingString:@"highScoreName"];
            
            [[NSUserDefaults standardUserDefaults] setInteger:highScore forKey:highScoreIndex];
            [[NSUserDefaults standardUserDefaults] setObject:names[i] forKey:highScoreNameIndex];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    for(int i=0; i<10; i++){
        NSString *highScoreIndex = [NSString stringWithFormat:@"%d",i];
        NSString *highScoreNameIndex = [NSString stringWithFormat:@"%d",i];
        
        highScoreIndex = [highScoreIndex stringByAppendingString:@"highScore"];
        highScoreNameIndex = [highScoreNameIndex stringByAppendingString:@"highScoreName"];
        
        NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:highScoreIndex];
        NSString *highScoreName = [[NSUserDefaults standardUserDefaults] stringForKey:highScoreNameIndex];
        
        NSLog(highScoreName);
        NSLog([NSString stringWithFormat:@"%d",highScore]);

    }
}

-(void)addHighScore:(int)score{
    [self checkIfHighScoresExist];
    
    
}

@end
