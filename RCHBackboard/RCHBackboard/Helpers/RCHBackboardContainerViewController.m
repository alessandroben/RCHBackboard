//
//  RCHBackboardContainerViewController.m
//  BackboardMenu
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "RCHBackboardContainerViewController.h"

@implementation RCHBackboardContainerViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addChildViewController:self.backboardViewController];
  [self addChildViewController:self.rootViewController];
  [[self view] addSubview:_backboardViewController.view];
  [[self view] addSubview:_rootViewController.view];
}

#pragma mark - Initializers

- (UIViewController *)backboardViewController
{
  if (_backboardViewController != nil) { return _backboardViewController; }
  self.backboardViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
  return _backboardViewController;
}

@end
