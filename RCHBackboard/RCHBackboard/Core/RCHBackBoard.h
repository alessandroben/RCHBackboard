//
//  RCHBackBoard.h
//  Backboard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCHBackBoardInterface.h"
#import "RCHBackBoardGestureControl.h"

/**

 RCHBackBoard
 
 Displays view controllers, usually for menus, from behind the main view controller of the application.
 
 */

@protocol RCHBackBoardContainerViewController;

@class RCHBackboardShadow;

@interface RCHBackBoard : NSObject <RCHBackBoardGestureControlDelegate>

@property (strong, nonatomic) UIViewController<RCHBackBoardContainerViewController> *containerViewController;
@property (strong, nonatomic) UIViewController<RCHBackBoardViewController> *viewController;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) RCHBackBoardState state;
@property (assign, nonatomic) RCHBackBoardOrientation orientation;
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
 @return A new instance of an RCHBackBoard
 */
- (id)initWithName:(NSString *)name rootViewController:(UIViewController *)rootViewController viewController:(UIViewController<RCHBackBoardViewController> *)viewController orientation:(RCHBackBoardOrientation)orientation width:(CGFloat)width;

- (void)presentWithCompletion:(void (^)(BOOL finished))completion;

- (void)dismissWithCompletion:(void (^)(BOOL finished))completion;

@end
