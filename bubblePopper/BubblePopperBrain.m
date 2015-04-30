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
    
    if (![defaults objectForKey:@"VeryFirstRun"]){
        [defaults setObject:[NSDate date] forKey:@"VeryFirstRun"];
    
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
 
//Testing that ^ worked
 
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
    NSLog(@"");
}

-(BOOL)scoreHighEnoughToAdd:(int)score{
    
    for(int i=0; i<10; i++){
        NSString *highScoreIndex = [NSString stringWithFormat:@"%d",i];
        highScoreIndex = [highScoreIndex stringByAppendingString:@"highScore"];
        
        NSInteger highScoreAtIndex = [[NSUserDefaults standardUserDefaults] integerForKey:highScoreIndex];
        
        if(score >= highScoreAtIndex)
            return YES;
    }
    return NO;
}

-(void)addHighScore:(int)score
                   :(NSString*)name{
    
    for(int i=0; i<10; i++){
        NSString *highScoreIndex = [NSString stringWithFormat:@"%d",i];
        highScoreIndex = [highScoreIndex stringByAppendingString:@"highScore"];
        
        NSInteger highScoreAtIndex = [[NSUserDefaults standardUserDefaults] integerForKey:highScoreIndex];
        
        if(score >= highScoreAtIndex){
            NSString *highScoreNameIndex = [NSString stringWithFormat:@"%d",i];
            highScoreNameIndex = [highScoreNameIndex stringByAppendingString:@"highScoreName"];
            
            NSString *highScoreNameAtIndex = [[NSUserDefaults standardUserDefaults] stringForKey:highScoreNameIndex];
            
            NSString *tempName = highScoreNameAtIndex;
            NSInteger tempScore = highScoreAtIndex;
            
            [[NSUserDefaults standardUserDefaults] setInteger:score forKey:highScoreIndex];
            [[NSUserDefaults standardUserDefaults] setObject:name forKey:highScoreNameIndex];
            
            i++;
            
            for(int j=i; j<10; j++){
                NSString *transferName = tempName;
                NSInteger transferScore = tempScore;
                
                highScoreNameIndex = [NSString stringWithFormat:@"%d",j];
                highScoreNameIndex = [highScoreNameIndex stringByAppendingString:@"highScoreName"];
                
                highScoreIndex = [NSString stringWithFormat:@"%d",j];
                highScoreIndex = [highScoreIndex stringByAppendingString:@"highScore"];
                
                tempName = [[NSUserDefaults standardUserDefaults] stringForKey:highScoreNameIndex];
                tempScore = [[NSUserDefaults standardUserDefaults] integerForKey:highScoreIndex];
                
                [[NSUserDefaults standardUserDefaults] setInteger:transferScore forKey:highScoreIndex];
                [[NSUserDefaults standardUserDefaults] setObject:transferName forKey:highScoreNameIndex];
                
                transferName = tempName;
                transferScore = tempScore;
            }
            break;
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

@end
