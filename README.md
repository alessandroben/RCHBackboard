RCHBackboard
============

Backboard menus, for all those (hamburger) menus we all love so much.

Wrap your application rootViewController in a containerViewController and add as many backboard menus as you need, set a view controller for each, a width to show on screen and the position to reveal from; top, left, bottom, or right.

Usage
-

### Setup

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
	  [RCHBackboard setupWithName:@"HamburgerMenu" container:containerViewController root:navigationController backboard:menu orientation:RCHBackboardOrientationRight width:250];

	  // We're done, lift the curtains and start the show!
	  [_window setRootViewController:containerViewController];
	  [_window makeKeyAndVisible];
	  return YES;
	}

### Present & Dismiss
	
	[RCHBackboard presentBackboardWithName:@"HamburgerMenu" completion:nil];

	[RCHBackboard dismissBackboardWithName:@"HamburgerMenu" completion:nil];

## Example

![Backboards](https://raw.github.com/robinhayward/RCHBackboard/master/screenshot.png)

[Video](https://raw.github.com/robinhayward/RCHBackboard/master/video.mov)

## Contact

[@robhayward](http://www.twitter.com/robhayward) 

<hello@robhayward.co.uk>
