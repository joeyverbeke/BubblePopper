//
//  HighScoresViewController.h
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#ifndef bubblePopper_HighScoresViewController_h
#define bubblePopper_HighScoresViewController_h

#import <UIKit/UIKit.h>
@interface HighScoresViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    
    NSMutableArray *highScoresNames;
    NSMutableArray *highScores;
}

@property (weak, nonatomic) IBOutlet UITableView *highScoresTable;
@property (weak, nonatomic) IBOutlet UITableView *highScoresNamesTable;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

#endif
