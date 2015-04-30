//
//  HighScoresViewController.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighScoresViewController.h"

@interface HighScoresViewController ()

@end

@implementation HighScoresViewController

CGFloat scoreCellWidth = 0;
CGFloat nameCellWidth = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_white_feathers_@2X.png"]];
    
    self.highScoresTable.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.highScoresNamesTable.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    
    highScores = [[NSMutableArray alloc] init];
    highScoresNames = [[NSMutableArray alloc] init];
    
    //populate arrays
    for(int i=0; i<10; i++){
        NSString *highScoreIndex = [NSString stringWithFormat:@"%d",i];
        NSString *highScoreNameIndex = [NSString stringWithFormat:@"%d",i];
        
        highScoreIndex = [highScoreIndex stringByAppendingString:@"highScore"];
        highScoreNameIndex = [highScoreNameIndex stringByAppendingString:@"highScoreName"];
        
        NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:highScoreIndex];
        NSString *highScoreName = [[NSUserDefaults standardUserDefaults] stringForKey:highScoreNameIndex];
        
        [highScores addObject:[NSString stringWithFormat:@"%ld", highScore]];
        [highScoresNames addObject:highScoreName];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [highScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UIFont *font = [UIFont fontWithName:@"System" size:15.0];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if(tableView.tag == 0){
        cell.textLabel.text = [highScores objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        //dynamic resize
        
        if([self widthOfString:[highScores objectAtIndex:indexPath.row] withFont:font] > scoreCellWidth)
            scoreCellWidth = [self widthOfString:[highScores objectAtIndex:indexPath.row] withFont:font];
        
        cell.frame = CGRectMake(0,
                                0,
                                scoreCellWidth,
                                cell.frame.size.height);
    }
    else if (tableView.tag == 1){
        cell.textLabel.text = [highScoresNames objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if([self widthOfString:[highScoresNames objectAtIndex:indexPath.row] withFont:font] > nameCellWidth)
            nameCellWidth = [self widthOfString:[highScores objectAtIndex:indexPath.row] withFont:font];
        
        cell.frame = CGRectMake(0,
                                0,
                                nameCellWidth,
                                cell.frame.size.height);
    }
    
    cell.backgroundColor = [UIColor colorWithRed:0/256.0 green:0/256.0 blue:0/256.0 alpha:0.0];
    
    cell.textLabel.textColor = [UIColor colorWithRed:(indexPath.row * 16)/255 green:(indexPath.row * 16)/255 blue: (indexPath.row * 16) /255.0 alpha:1.0];
    
    return cell;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)highScoresTable
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)highScoresTable
 numberOfRowsInSection:(NSInteger)section
{
    return [self.colors count];
}

-(UITableViewCell *)tableView:(UITableView *)highScoresTable
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:IndexPath];
    
    cell.textLabel.text=[self.colors objectAtIndex:IndexPath.row]
    
    return cell;
}
 */

@end