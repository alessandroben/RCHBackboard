//
//  RightViewController.h
//  RCHBackboard
//
//  Created by Robin Hayward on 01/11/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCHBackBoard.h"

@interface MenuViewController : UIViewController <RCHBackBoardViewController>

@property (weak, nonatomic) RCHBackBoard *backboard;

- (IBAction)dismissButtonAction:(id)sender;

@end
