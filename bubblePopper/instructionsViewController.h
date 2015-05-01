//
//  instructionsViewController.h
//  bubblePopper
//
//  Created by Joey Verbeke on 4/30/15.
//  Copyright (c) 2015 Joey Verbeke. All rights reserved.
//

#ifndef bubblePopper_instructionsViewController_h
#define bubblePopper_instructionsViewController_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface instructionsViewController : UIViewController{
    
}
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UITextField *goodLuckLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodBubbleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badBubbleLabel;

@end

#endif
