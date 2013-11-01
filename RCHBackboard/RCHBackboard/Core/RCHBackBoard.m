//
//  RCHBackBoard.m
//  Backboard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "RCHBackBoard.h"
#import "RCHBackBoard.h"
#import "RCHBackboardContainerViewController.h"
#import "RCHBackBoardGestureControl.h"
#import "RCHBackboardShadow.h"

NSString *const RCHBackBoardWillPresentNotification = @"RCHBackBoardWillPresentNotification";
NSString *const RCHBackBoardDidPresentNotification = @"RCHBackBoardDidPresentNotification";
NSString *const RCHBackBoardWillDismissNotification = @"RCHBackBoardWillDismissNotification";
NSString *const RCHBackBoardDidDismissNotification = @"RCHBackBoardDidDismissNotification";

@interface RCHBackBoard ()

@property (strong, nonatomic) NSMutableDictionary *items;
@property (strong, nonatomic) RCHBackBoardGestureControl *gestureControl;

@property (assign, nonatomic) BOOL isOpen;

@end

@implementation RCHBackBoard

- (id)initWithName:(NSString *)name rootViewController:(UIViewController *)rootViewController viewController:(UIViewController<RCHBackBoardViewController> *)viewController orientation:(RCHBackBoardOrientation)orientation width:(CGFloat)width
{
  self = [super init];
  if (self) {
    
    NSParameterAssert(name);
    NSParameterAssert(rootViewController);
    NSParameterAssert(viewController);
    self.name = name;
    self.width = width;
    self.orientation = orientation;
    self.viewController = viewController;
    [self.containerViewController setRootViewController:rootViewController];
    [_viewController setBackboard:self];
    
    self.animationDuration = RCH_DEFAULT_ANIMATION_DURATION;
    self.shadowWidth = RCH_DEFAULT_SHADOW_WIDTH;
    
    [self notifications];
    self.gestureControl = [[RCHBackBoardGestureControl alloc] initWithDelegate:self];
  }
  return self;
}

- (UIViewController<RCHBackBoardContainerViewController> *)containerViewController
{
  if (_containerViewController != nil) { return _containerViewController; }
  self.containerViewController = [[RCHBackboardContainerViewController alloc] initWithNibName:nil bundle:nil];
  return _containerViewController;
}

#pragma mark - Notifications

- (void)notifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willPresent:) name:RCHBackBoardWillPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPresent:) name:RCHBackBoardDidPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willDismiss:) name:RCHBackBoardWillDismissNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDismiss:) name:RCHBackBoardDidDismissNotification object:nil];
}

- (void)willPresent:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackBoardStateOpening;
}

- (void)didPresent:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackBoardStateOpen;
}

- (void)willDismiss:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackBoardStateClosing;
}

- (void)didDismiss:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackBoardStateClosed;
}

#pragma mark - Getters

- (BOOL)isOpen
{
  if ((_state == RCHBackBoardStateOpen) || (_state == RCHBackBoardStateOpening)) {
    return YES;
  }
  return NO;
}


#pragma mark - Presenting
#pragma mark

- (void)presentWithCompletion:(void (^)(BOOL finished))completion
{
  if (_isOpen) return;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackBoardWillPresentNotification object:self userInfo:@{@"Name": self.name}];
  
  [self.containerViewController.backboardViewController addChildViewController:self.viewController];
  [self.containerViewController.backboardViewController.view addSubview:self.viewController.view];
  [self setupShadow];
  [self setupGestures];
  
  [UIView animateWithDuration:self.animationDuration animations:^{
    
    CGRect rootViewFrame = self.containerViewController.rootViewController.view.frame;
    switch (self.orientation) {
      case RCHBackBoardOrientationLeft:
        rootViewFrame.origin.x += self.width;
        break;
      case RCHBackBoardOrientationTop:
        rootViewFrame.origin.y += self.width;
        break;
      case RCHBackBoardOrientationRight:
        rootViewFrame.origin.x -= self.width;
        break;
      case RCHBackBoardOrientationBottom:
        rootViewFrame.origin.y -= self.width;
        break;
    }
    self.containerViewController.rootViewController.view.frame = rootViewFrame;
    
  } completion:^(BOOL finished){
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackBoardDidPresentNotification object:self userInfo:@{@"Name": self.name}];
    
    if (completion) completion(finished);
    
  }];
}


#pragma mark - Dismissing
#pragma mark

- (void)dismissWithCompletion:(void (^)(BOOL finished))completion
{
  if (!self.isOpen) return;

  [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackBoardWillDismissNotification object:self userInfo:@{@"Name": self.name}];
  
  [UIView animateWithDuration:self.animationDuration animations:^{
    
    CGRect rootViewFrame = self.containerViewController.rootViewController.view.frame;
    switch (self.orientation) {
      case RCHBackBoardOrientationLeft:
        rootViewFrame.origin.x = 0;
        break;
      case RCHBackBoardOrientationTop:
        rootViewFrame.origin.y = 0;
        break;
      case RCHBackBoardOrientationRight:
        rootViewFrame.origin.x = 0;
        break;
      case RCHBackBoardOrientationBottom:
        rootViewFrame.origin.y = 0;
        break;
    }
    self.containerViewController.rootViewController.view.frame = rootViewFrame;
    
  } completion:^(BOOL finished){
    
    [self.viewController.view removeFromSuperview];
    [self.viewController removeFromParentViewController];
    [self.shadow removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackBoardDidDismissNotification object:self userInfo:@{@"Name": self.name}];
    
    if (completion) completion(finished);
  }];
}


#pragma mark - Shadow
#pragma mark

- (void)setupShadow
{
  [self.shadow removeFromSuperview];
  
  CGRect frame = _containerViewController.view.bounds;
  CGFloat shadowWidth = self.shadowWidth;
  RCHBackBoardOrientation orientation = self.orientation;
  switch (orientation)
  {
    case RCHBackBoardOrientationLeft:
    {
      frame.origin.x = frame.origin.x - shadowWidth;
      frame.size.width = shadowWidth;
    }
      break;
    case RCHBackBoardOrientationRight:
    {
      frame.origin.x = frame.size.width;
      frame.size.width = shadowWidth;
    }
      break;
    case RCHBackBoardOrientationTop:
    {
      frame.origin.y = -shadowWidth;
      frame.size.height = shadowWidth;
    }
      break;
    case RCHBackBoardOrientationBottom:
    {
      frame.origin.y = frame.size.height;
      frame.size.height = shadowWidth;
    }
      break;
  }
  self.shadow = [[RCHBackboardShadow alloc] initWithFrame:frame andDirection:self.orientation];
  [_containerViewController.rootViewController.view addSubview:_shadow];
}

#pragma mark - Gestures
#pragma mark

- (void)setupGestures
{
  [_gestureControl reset];
  [_gestureControl setBackboard:self];
  UIView *gestureView = [_gestureControl view];
  [gestureView removeFromSuperview];
  [gestureView setFrame:_containerViewController.rootViewController.view.bounds];
  [_containerViewController.rootViewController.view addSubview:gestureView];
}

#pragma mark - GestureControlDelegate

- (void)RCHBackBoardGestureTapReceived:(RCHBackBoardGestureControl *)gestureControl
{
  [_gestureControl.view removeFromSuperview];
  [self dismissWithCompletion:nil];
}

- (void)RCHBackBoardGestureSwipeToCloseReceived:(RCHBackBoardGestureControl *)gestureControl
{
  [_gestureControl.view removeFromSuperview];
  [self dismissWithCompletion:nil];
}

#pragma mark - TearDown

- (void)tearDown
{
  self.viewController = nil;
  self.containerViewController = nil;
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackBoardWillPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackBoardDidPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackBoardWillDismissNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackBoardDidDismissNotification object:nil];
}


@end
