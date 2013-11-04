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
  [RCHBackboard presentBackboardWithName:@"top" completion:nil];
}

- (IBAction)leftButtonAction:(id)sender
{
  [RCHBackboard presentBackboardWithName:@"left" completion:nil];
}

- (IBAction)rightButtonAction:(id)sender
{
  [RCHBackboard presentBackboardWithName:@"right" completion:nil];
}

- (IBAction)bottomButtonAction:(id)sender
{
  [RCHBackboard presentBackboardWithName:@"bottom" completion:nil];
}

@end
