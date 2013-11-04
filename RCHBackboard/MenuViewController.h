//
//  RightViewController.h
//  RCHBackboard
//
//  Created by Robin Hayward on 01/11/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCHBackboard.h"

@interface MenuViewController : UIViewController

@property (weak, nonatomic) RCHBackboard *backboard;

- (IBAction)dismissButtonAction:(id)sender;

@end
