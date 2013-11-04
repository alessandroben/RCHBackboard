//
//  RCHBackboardInterface.h
//  RCHBackboard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define RCH_DEFAULT_ANIMATION_DURATION 0.3f
#define RCH_DEFAULT_SHADOW_WIDTH 30.0f

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


