//
//  RCHBackBoardGestureControl.h
//  BackboardMenu
//
//  Created by Rob Hayward on 25/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCHBackBoardInterface.h"

@class RCHBackBoardGestureControl, RCHBackBoard;

@protocol RCHBackBoardGestureControlDelegate <NSObject>

- (void)RCHBackBoardGestureTapReceived:(RCHBackBoardGestureControl *)gestureControl;
- (void)RCHBackBoardGestureSwipeToCloseReceived:(RCHBackBoardGestureControl *)gestureControl;

@end

@interface RCHBackBoardGestureControl : NSObject

@property (assign, nonatomic) id<RCHBackBoardGestureControlDelegate> delegate;
@property (strong, nonatomic) UIView *view;
@property (assign, nonatomic) CGPoint panGestureStart;
@property (assign, nonatomic) CGPoint panGestureTrack;
@property (assign, nonatomic) CGPoint translatedPoint;
@property (assign, nonatomic) RCHBackBoard *backboard;

- (id)initWithDelegate:(id<RCHBackBoardGestureControlDelegate>)delegate;

- (void)reset;

@end
