//
//  RCHAppDelegate.m
//  RCHBackboard
//
//  Created by Robin Hayward on 31/10/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "RCHAppDelegate.h"

#import "HomeViewController.h"
#import "MenuViewController.h"

#import "RCHBackboard.h"

@interface RCHAppDelegate ()

@property (strong, nonatomic) RCHBackboard *backboard;

@end

@implementation RCHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Create a standard window
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  // Backboards require a container view controller to maniuplate the views so we'll make the that the root of the application
  RCHBackboardContainerViewController *containerViewController = [[RCHBackboardContainerViewController alloc] initWithNibName:nil bundle:nil];
  
  // Create a typical view controller stack
  HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
  
  // Add our view controller stack as the rootViewController of the container
  [containerViewController setRootViewController:navigationController];
  
  // Create a backboard
  UIViewController *right = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
  _backboard = [[RCHBackboard alloc] initWithName:@"right" containerViewController:containerViewController viewController:right orientation:RCHBackboardOrientationRight width:260.0f];
  
  // We don't want to use a singleton so make sure each view controller has a reference to any required backboard(s)
  [homeViewController setRightBackboard:_backboard];

  // We're done, lift the curtains and start the show
  [_window setRootViewController:containerViewController];
  [_window makeKeyAndVisible];
  return YES;
}

@end
