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
  UIViewController *containerViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
  
  // Create a typical view controller stack however you need it
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] initWithNibName:nil bundle:nil]];
  
  // Create a view controller you wish to show for each backboard, this could be a navigation menu or pretty much anything you like
  UIViewController *menu = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
  
  // Optionally use this class method to create multiple backboards and present/dismiss them by name when required
  [RCHBackboard setupWithName:@"top" container:containerViewController root:navigationController backboard:menu orientation:RCHBackboardOrientationTop width:50];
  [RCHBackboard setupWithName:@"left" container:containerViewController root:navigationController backboard:menu orientation:RCHBackboardOrientationLeft width:150];
  [RCHBackboard setupWithName:@"bottom" container:containerViewController root:navigationController backboard:menu orientation:RCHBackboardOrientationBottom width:350];
  [RCHBackboard setupWithName:@"right" container:containerViewController root:navigationController backboard:menu orientation:RCHBackboardOrientationRight width:250];

  // We're done, lift the curtains and start the show!
  [_window setRootViewController:containerViewController];
  [_window makeKeyAndVisible];
  return YES;
}

@end
