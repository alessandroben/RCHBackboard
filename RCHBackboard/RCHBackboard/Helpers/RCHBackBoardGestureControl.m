//
//  RCHBackBoardGestureControl.m
//  BackboardMenu
//
//  Created by Rob Hayward on 25/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "RCHBackBoardGestureControl.h"
#import "RCHBackBoard.h"

typedef enum {
  RCHGestureAxisX = 0,
  RCHGestureAxisY
} RCHGestureAxis;

@interface RCHBackBoardGestureControl ()

@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) BOOL dragThresholdReached;
@property (assign, nonatomic) CGPoint contentViewStartPosition;
@property (assign, nonatomic) BOOL isAnimating;
@end

@implementation RCHBackBoardGestureControl

- (id)initWithDelegate:(id<RCHBackBoardGestureControlDelegate>)delegate
{
  self = [super init];
  if (self) {
    self.delegate = delegate;
  }
  return self;
}

- (UIView *)view
{
  if (_view != nil) { return _view; }
  
  self.view = [[UIView alloc] initWithFrame:CGRectZero];
  [_view setBackgroundColor:[UIColor clearColor]];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
  [tap setNumberOfTapsRequired:1];
  [tap setCancelsTouchesInView:NO];
  
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
  [pan setMaximumNumberOfTouches:1];
  [pan setDelaysTouchesBegan:YES];
  [pan setDelaysTouchesEnded:YES];
  [pan setCancelsTouchesInView:YES];
  
  [_view addGestureRecognizer:tap];
  [_view addGestureRecognizer:pan];
  
  return _view;
}

- (void)reset
{
  _backboard = nil;
  _contentView = nil;
  _dragThresholdReached = NO;
  _translatedPoint = CGPointZero;
  _panGestureStart = CGPointZero;
  _panGestureTrack = CGPointZero;
}

#pragma mark - Gestures

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
  [_delegate RCHBackBoardGestureTapReceived:self];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
  if (_isAnimating) { return; }
  
  UIGestureRecognizerState state = [gesture state];
  _translatedPoint = [gesture translationInView:_view];
  
	if(state == UIGestureRecognizerStateBegan)
  {
    _contentView = _view.superview;
    _contentViewStartPosition = _contentView.center;
		_panGestureStart = _translatedPoint;
    _panGestureTrack = _translatedPoint;
	}
  
  if ([self canDragForOrientation:_backboard.orientation])
  {
    [self handleDragForOrientation:_backboard.orientation];
  }
  
  if(state == UIGestureRecognizerStateEnded)
  {
    if (_dragThresholdReached)
    {
      [_delegate RCHBackBoardGestureSwipeToCloseReceived:self];
    }
    else
    {
      _isAnimating = YES;
      [UIView animateWithDuration:_backboard.animationDuration animations:^{
        [_contentView setCenter:_contentViewStartPosition];
      } completion:^(BOOL finished){
        _isAnimating = NO;
      }];
    }
  }

  _panGestureTrack = _translatedPoint;
}

- (BOOL)canDragForOrientation:(RCHBackBoardOrientation)orientation
{
  switch (orientation)
  {
    case RCHBackBoardOrientationTop:
      if (_translatedPoint.y < _panGestureStart.y) return YES;
      break;
    case RCHBackBoardOrientationLeft:
      if (_translatedPoint.x < _panGestureStart.x) return YES;
      break;
    case RCHBackBoardOrientationRight:
      if (_translatedPoint.x > _panGestureStart.x) return YES;
      break;
    case RCHBackBoardOrientationBottom:
      if (_translatedPoint.y > _panGestureStart.y) return YES;
      break;
  }
  return NO;
}

- (void)handleDragForOrientation:(RCHBackBoardOrientation)orientation
{
  switch (orientation)
  {
    case RCHBackBoardOrientationLeft:
      [self dragForLeft];
      break;
    case RCHBackBoardOrientationRight:
      [self dragForRight];
      break;
    case RCHBackBoardOrientationTop:
      [self dragForTop];
      break;
    case RCHBackBoardOrientationBottom:
      [self dragForBottom];
      break;
  }
}

- (void)dragForLeft
{
  CGFloat start       = _contentView.center.x;
  CGFloat translation = _translatedPoint.x;
  CGFloat track       = _panGestureTrack.x;
  CGFloat current     = _contentView.center.x;
  CGFloat threshold   = _contentViewStartPosition.x - (_backboard.width / 2);
  [self dragWithOrientation:_backboard.orientation start:start translation:translation track:track current:current threshold:threshold];
}

- (void)dragForRight
{
  CGFloat start       = _contentView.center.x;
  CGFloat translation = _translatedPoint.x;
  CGFloat track       = _panGestureTrack.x;
  CGFloat current     = _contentView.center.x;
  CGFloat threshold   = _contentViewStartPosition.x + (_backboard.width / 2);
  [self dragWithOrientation:_backboard.orientation start:start translation:translation track:track current:current threshold:threshold];
}

- (void)dragForTop
{
  CGFloat start       = _contentView.center.y;
  CGFloat translation = _translatedPoint.y;
  CGFloat track       = _panGestureTrack.y;
  CGFloat current     = _contentView.center.y;
  CGFloat threshold   = _contentViewStartPosition.y - (_backboard.width / 2);
  [self dragWithOrientation:_backboard.orientation start:start translation:translation track:track current:current threshold:threshold];
}

- (void)dragForBottom
{
  CGFloat start       = _contentView.center.y;
  CGFloat translation = _translatedPoint.y;
  CGFloat track       = _panGestureTrack.y;
  CGFloat current     = _contentView.center.y;
  CGFloat threshold   = _contentViewStartPosition.y + (_backboard.width / 2);
  [self dragWithOrientation:_backboard.orientation start:start translation:translation track:track current:current threshold:threshold];
}

- (void)dragWithOrientation:(RCHBackBoardOrientation)orientation start:(CGFloat)start translation:(CGFloat)translation track:(CGFloat)track current:(CGFloat)current threshold:(CGFloat)threshold
{
  CGFloat dragMovement = (translation - track);
  CGFloat dragWithMovement = start += dragMovement;
  
  switch (orientation) {
    case RCHBackBoardOrientationTop:
    {
      _contentView.center = CGPointMake(_contentView.center.x, dragWithMovement);
      if (current <= threshold) { _dragThresholdReached = YES; }
    }
      break;
    case RCHBackBoardOrientationLeft:
    {
      _contentView.center = CGPointMake(dragWithMovement, _contentView.center.y);
      if (current <= threshold) { _dragThresholdReached = YES; }
    }
      break;
    case RCHBackBoardOrientationRight:
    {
      _contentView.center = CGPointMake(dragWithMovement, _contentView.center.y);
      if (current >= threshold) { _dragThresholdReached = YES; }
    }
      break;
    case RCHBackBoardOrientationBottom:
    {
      _contentView.center = CGPointMake(_contentView.center.x, dragWithMovement);
      if (current >= threshold) { _dragThresholdReached = YES; }
    }
      break;
  }
}

@end
