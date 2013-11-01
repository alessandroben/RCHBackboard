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

#import "RCHBackBoard.h"

@interface RCHAppDelegate ()

@property (strong, nonatomic) RCHBackBoard *backboard;

@end

@implementation RCHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  // Setup a typical view controller stack
  HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];

  // Create a backboard
  UIViewController <RCHBackBoardViewController> *right = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
  self.backboard = [[RCHBackBoard alloc] initWithName:@"right" rootViewController:navigationController viewController:right orientation:RCHBackBoardOrientationRight width:260.0f];
  
  // We don't want to use a singleton so make sure each view controller has a reference to any required backboard(s)
  [homeViewController setRightBackboard:_backboard];
  
  // Attach the backboard as the root view controller of the window
  [_window setRootViewController:_backboard.containerViewController];
  [_window makeKeyAndVisible];
  
  return YES;
}

// TODO: Allow backboards to share the container view controller (rootViewController should be this)

@end
