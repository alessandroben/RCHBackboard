//
//  RCHBackBoardInterface.h
//  RCHBackBoard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define RCH_DEFAULT_ANIMATION_DURATION 0.3f
#define RCH_DEFAULT_SHADOW_WIDTH 30.0f

typedef NS_ENUM(NSInteger, RCHBackBoardState) {
  RCHBackBoardStateClosed,
  RCHBackBoardStateOpening,
  RCHBackBoardStateOpen,
  RCHBackBoardStateClosing
};

typedef NS_ENUM(NSInteger, RCHBackBoardOrientation) {
  RCHBackBoardOrientationLeft,
  RCHBackBoardOrientationTop,
  RCHBackBoardOrientationRight,
  RCHBackBoardOrientationBottom
};

extern NSString *const RCHBackBoardWillPresentNotification;
extern NSString *const RCHBackBoardDidPresentNotification;
extern NSString *const RCHBackBoardWillDismissNotification;
extern NSString *const RCHBackBoardDidDismissNotification;

@class RCHBackBoard;

@protocol RCHBackBoardContainerViewController <NSObject>

@property (strong, nonatomic) UIViewController *rootViewController;
@property (strong, nonatomic) UIViewController *backboardViewController;

@end

@protocol RCHBackBoardViewController <NSObject>

@property (weak, nonatomic) RCHBackBoard *backboard;

@end

