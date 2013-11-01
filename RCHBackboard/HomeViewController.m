//
//  HomeViewController.m
//  RCHBackboard
//
//  Created by Robin Hayward on 01/11/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (IBAction)topButtonAction:(id)sender
{
  [self.topBackboard presentWithCompletion:nil];
}

- (IBAction)leftButtonAction:(id)sender
{
  [self.leftBackboard presentWithCompletion:nil];
}

- (IBAction)rightButtonAction:(id)sender
{
  [self.rightBackboard presentWithCompletion:nil];
}

- (IBAction)bottomButtonAction:(id)sender
{
  [self.bottomBackboard presentWithCompletion:nil];
}

@end
