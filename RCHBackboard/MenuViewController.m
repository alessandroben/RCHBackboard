//
//  RightViewController.m
//  RCHBackboard
//
//  Created by Robin Hayward on 01/11/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)dismissButtonAction:(id)sender
{
  [self.backboard dismissWithCompletion:nil];
}

@end
