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
  
  // Create a backboard with the standard init method if you wish to reference it directly and pass it around
  UIViewController *menu = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
  _backboard = [[RCHBackboard alloc] initWithName:@"right" containerViewController:containerViewController viewController:menu orientation:RCHBackboardOrientationRight width:260.0f];
  
  // Optionally use the class method to create your backboards and present/dismiss them by name when required
  [RCHBackboard setupWithName:@"left" containerViewController:containerViewController viewController:menu orientation:RCHBackboardOrientationLeft width:100.0f];
  [RCHBackboard setupWithName:@"top" containerViewController:containerViewController viewController:menu orientation:RCHBackboardOrientationTop width:50.0f];
  [RCHBackboard setupWithName:@"bottom" containerViewController:containerViewController viewController:menu orientation:RCHBackboardOrientationBottom width:400.0f];

  // We're done, lift the curtains and start the show
  [_window setRootViewController:containerViewController];
  [_window makeKeyAndVisible];
  return YES;
}

@end
