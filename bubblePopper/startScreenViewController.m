//
//  startScreenViewController.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import "startScreenViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface startScreenViewController ()

@end

@implementation startScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_white_feathers_@2X.png"]];
    
    
    [self.startNewGameButton.layer setBorderWidth:2.0];
    [self.startNewGameButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    [self.highSoresButton.layer setBorderWidth:2.0];
    [self.highSoresButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

@end