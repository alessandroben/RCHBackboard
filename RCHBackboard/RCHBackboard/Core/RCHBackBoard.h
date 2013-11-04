//
//  RCHBackboard.h
//  Backboard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCHBackboardInterface.h"
#import "RCHBackboardGestureControl.h"
#import "RCHBackboardContainerViewController.h"

/**

 RCHBackboard
 
 Displays view controllers, usually for menus, from behind the main view controller of the application.
 
 */

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
 @param rootViewController The controller that our backboard will be manipulating
 @oaram viewController The view controller to present
 @param orientation The orientation of the backboard, Left, Right, Top or Bottom
 @param width How much of the backboard should be visible once presented
 @return A new instance of an RCHBackboard
 */
- (id)initWithName:(NSString *)name containerViewController:(RCHBackboardContainerViewController *)rootViewController viewController:(UIViewController *)viewController orientation:(RCHBackboardOrientation)orientation width:(CGFloat)width;

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


+ (RCHBackboard *)backboardWithName:(NSString *)name;
+ (void)presentBackboardWithName:(NSString *)name completion:(void (^)(BOOL finished))completion;
+ (void)dismissBackboardWithName:(NSString *)name completion:(void (^)(BOOL finished))completion;

@end
