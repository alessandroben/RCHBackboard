//
//  RCHBackboard.h
//  Backboard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "RCHBackboardGestureControl.h"
#import "RCHBackboardContainerViewController.h"

/**

 RCHBackboard
 
 Displays view controllers, usually for menus, from behind the main view controller of the application.
 
 */

typedef NS_ENUM(NSInteger, RCHBackboardState) {
  RCHBackboardStateClosed,
  RCHBackboardStateOpening,
  RCHBackboardStateOpen,
  RCHBackboardStateClosing
};

typedef NS_ENUM(NSInteger, RCHBackboardOrientation) {
  RCHBackboardOrientationLeft,
  RCHBackboardOrientationTop,
  RCHBackboardOrientationRight,
  RCHBackboardOrientationBottom
};

extern NSString *const RCHBackboardWillPresentNotification;
extern NSString *const RCHBackboardDidPresentNotification;
extern NSString *const RCHBackboardWillDismissNotification;
extern NSString *const RCHBackboardDidDismissNotification;

@class RCHBackboardShadow;

@interface RCHBackboard : NSObject <RCHBackboardGestureControlDelegate>

@property (strong, nonatomic) RCHBackboardContainerViewController *containerViewController;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) RCHBackboardState state;
@property (assign, nonatomic) RCHBackboardOrientation orientation;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic, readonly) BOOL isOpen;

@property (strong, nonatomic) RCHBackboardShadow *shadow;
@property (assign, nonatomic) CGFloat shadowWidth;

@property (assign, nonatomic) NSTimeInterval animationDuration;

/**
 @param name A unique name to identifier this board with if your app has more than one
 @param containerViewController The controller that our backboard will be manipulating
 @param viewController The view controller to present
 @param orientation The orientation of the backboard, Left, Right, Top or Bottom
 @param width How much of the backboard should be visible once presented
 @return A new instance of an RCHBackboard
 */
- (id)initWithName:(NSString *)name containerViewController:(RCHBackboardContainerViewController *)containerViewController viewController:(UIViewController *)viewController orientation:(RCHBackboardOrientation)orientation width:(CGFloat)width;

/**
 Animates the backboard on screen from beneath
 @param completion An optional block to call after the presentation animation has finished
 */
- (void)presentWithCompletion:(void (^)(BOOL finished))completion;

/**
 Animates the backboard off screen
 @param completion An optional block to call after the dismiss animation has finished
 */
- (void)dismissWithCompletion:(void (^)(BOOL finished))completion;

/**
 A shorter conveinience method to initialize a new backboard without returning the instance
 @see `initWithName:containerViewController:viewController:orientation:width`
 */
+ (void)setupWithName:(NSString *)name containerViewController:(RCHBackboardContainerViewController *)rootViewController viewController:(UIViewController *)viewController orientation:(RCHBackboardOrientation)orientation width:(CGFloat)width;

/**
 Calls dismiss on all known backboards
 */
+ (void)dismiss;

/**
 @param name The name of a backboard already created
 @return A backboard instance if one exists for the given name
 */
+ (RCHBackboard *)backboardWithName:(NSString *)name;

/**
 @param name The name of a backboard already created
 @param completion Optional completion block called after the presentation animation has finished
 */
+ (void)presentBackboardWithName:(NSString *)name completion:(void (^)(BOOL finished))completion;

/**
 @param name The name of a backboard already created
 @param completion Optional completion block called after the dismiss animation has finished
 */
+ (void)dismissBackboardWithName:(NSString *)name completion:(void (^)(BOOL finished))completion;

@end
