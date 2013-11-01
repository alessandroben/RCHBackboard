//
//  RCHBackboardContainerViewController.h
//  BackboardMenu
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCHBackBoard.h"

@interface RCHBackboardContainerViewController : UIViewController <RCHBackBoardContainerViewController>

@property (assign, nonatomic) BOOL hasSetup;
@property (strong, nonatomic) UIViewController *rootViewController;
@property (strong, nonatomic) UIViewController *backboardViewController;

@end