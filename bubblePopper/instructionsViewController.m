//
//  instructionsViewController.m
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#import "instructionsViewController.h"

@interface instructionsViewController ()

@end

@implementation instructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtle_white_feathers_@2X.png"]];
    
    self.instructionsLabel.text = @"You have 25 seconds to pop \nas many bubbles as you can!";
    
    self.instructionsLabel.textAlignment = NSTextAlignmentCenter;
    
}



@end

