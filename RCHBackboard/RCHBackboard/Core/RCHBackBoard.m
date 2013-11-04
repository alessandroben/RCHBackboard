//
//  RCHBackboard.m
//  Backboard
//
//  Created by Rob Hayward on 19/06/2013.
//  Copyright (c) 2013 Robin Hayward. All rights reserved.
//

#import "RCHBackboard.h"
#import "RCHBackboard.h"
#import "RCHBackboardGestureControl.h"
#import "RCHBackboardShadow.h"
#import "RCHBackboardContainerViewController.h"

NSString *const RCHBackboardWillPresentNotification = @"RCHBackboardWillPresentNotification";
NSString *const RCHBackboardDidPresentNotification = @"RCHBackboardDidPresentNotification";
NSString *const RCHBackboardWillDismissNotification = @"RCHBackboardWillDismissNotification";
NSString *const RCHBackboardDidDismissNotification = @"RCHBackboardDidDismissNotification";

static NSMutableDictionary *__backboards = nil;

@interface RCHBackboard ()

@property (strong, nonatomic) NSMutableDictionary *items;
@property (strong, nonatomic) RCHBackboardGestureControl *gestureControl;
@property (assign, nonatomic) BOOL isOpen;

@end

@implementation RCHBackboard

+ (void)initialize
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __backboards = [NSMutableDictionary dictionaryWithCapacity:0];
  });
}

+ (RCHBackboard *)backboardWithName:(NSString *)name
{
  return [__backboards objectForKey:name];
}

+ (void)presentBackboardWithName:(NSString *)name completion:(void (^)(BOOL))completion
{
  RCHBackboard *backboard = [__backboards objectForKey:name];
  if (!backboard) return;
  [backboard presentWithCompletion:completion];
}

+ (void)dismissBackboardWithName:(NSString *)name completion:(void (^)(BOOL))completion
{
  RCHBackboard *backboard = [__backboards objectForKey:name];
  if (!backboard) return;
  [backboard dismissWithCompletion:completion];
}

- (id)initWithName:(NSString *)name containerViewController:(RCHBackboardContainerViewController *)containerViewController viewController:(UIViewController *)viewController orientation:(RCHBackboardOrientation)orientation width:(CGFloat)width
{
  self = [super init];
  if (self) {
    NSParameterAssert(name);
    NSParameterAssert(containerViewController);
    NSParameterAssert(viewController);
    NSAssert(width > 0, @"Width must be greater than zero to present the backboard");
    
    NSAssert(![__backboards objectForKey:name], @"Each backboard should have a unique name");
    [__backboards setObject:self forKey:name];
    
    self.name = name;
    self.width = width;
    self.orientation = orientation;
    self.viewController = viewController;
    
    self.containerViewController = containerViewController;
    
    self.animationDuration = RCH_DEFAULT_ANIMATION_DURATION;
    self.shadowWidth = RCH_DEFAULT_SHADOW_WIDTH;
    self.gestureControl = [[RCHBackboardGestureControl alloc] initWithDelegate:self];
    
    [self notifications];
  }
  return self;
}

#pragma mark - Notifications

- (void)notifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willPresent:) name:RCHBackboardWillPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPresent:) name:RCHBackboardDidPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willDismiss:) name:RCHBackboardWillDismissNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDismiss:) name:RCHBackboardDidDismissNotification object:nil];
}

- (void)willPresent:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackboardStateOpening;
}

- (void)didPresent:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackboardStateOpen;
}

- (void)willDismiss:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackboardStateClosing;
}

- (void)didDismiss:(NSNotification *)notification
{
  if (self != [notification object]) return;
  self.state = RCHBackboardStateClosed;
}

#pragma mark - Getters

- (BOOL)isOpen
{
  if ((_state == RCHBackboardStateOpen) || (_state == RCHBackboardStateOpening)) {
    return YES;
  }
  return NO;
}

#pragma mark - Presenting

- (void)presentWithCompletion:(void (^)(BOOL finished))completion
{
  if (_isOpen) return;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackboardWillPresentNotification object:self userInfo:@{@"Name": self.name}];
  
  [_containerViewController.backboardViewController addChildViewController:_viewController];
  [_containerViewController.backboardViewController.view addSubview:_viewController.view];
  [self setupShadow];
  [self setupGestures];
  
  [UIView animateWithDuration:self.animationDuration animations:^{
    
    CGRect rootViewFrame = self.containerViewController.rootViewController.view.frame;
    switch (self.orientation) {
      case RCHBackboardOrientationLeft:
        rootViewFrame.origin.x += self.width;
        break;
      case RCHBackboardOrientationTop:
        rootViewFrame.origin.y += self.width;
        break;
      case RCHBackboardOrientationRight:
        rootViewFrame.origin.x -= self.width;
        break;
      case RCHBackboardOrientationBottom:
        rootViewFrame.origin.y -= self.width;
        break;
    }
    self.containerViewController.rootViewController.view.frame = rootViewFrame;
    
  } completion:^(BOOL finished){
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackboardDidPresentNotification object:self userInfo:@{@"Name": self.name}];
    
    if (completion) completion(finished);
    
  }];
}

#pragma mark - Dismissing

- (void)dismissWithCompletion:(void (^)(BOOL finished))completion
{
  if (!self.isOpen) return;

  [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackboardWillDismissNotification object:self userInfo:@{@"Name": self.name}];
  
  [UIView animateWithDuration:self.animationDuration animations:^{
    
    CGRect rootViewFrame = self.containerViewController.rootViewController.view.frame;
    switch (self.orientation) {
      case RCHBackboardOrientationLeft:
        rootViewFrame.origin.x = 0;
        break;
      case RCHBackboardOrientationTop:
        rootViewFrame.origin.y = 0;
        break;
      case RCHBackboardOrientationRight:
        rootViewFrame.origin.x = 0;
        break;
      case RCHBackboardOrientationBottom:
        rootViewFrame.origin.y = 0;
        break;
    }
    self.containerViewController.rootViewController.view.frame = rootViewFrame;
    
  } completion:^(BOOL finished){
    
    [self.viewController.view removeFromSuperview];
    [self.viewController removeFromParentViewController];
    [self.shadow removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RCHBackboardDidDismissNotification object:self userInfo:@{@"Name": self.name}];
    
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
  RCHBackboardOrientation orientation = self.orientation;
  switch (orientation)
  {
    case RCHBackboardOrientationLeft:
    {
      frame.origin.x = frame.origin.x - shadowWidth;
      frame.size.width = shadowWidth;
    }
      break;
    case RCHBackboardOrientationRight:
    {
      frame.origin.x = frame.size.width;
      frame.size.width = shadowWidth;
    }
      break;
    case RCHBackboardOrientationTop:
    {
      frame.origin.y = -shadowWidth;
      frame.size.height = shadowWidth;
    }
      break;
    case RCHBackboardOrientationBottom:
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

- (void)RCHBackboardGestureTapReceived:(RCHBackboardGestureControl *)gestureControl
{
  [_gestureControl.view removeFromSuperview];
  [self dismissWithCompletion:nil];
}

- (void)RCHBackboardGestureSwipeToCloseReceived:(RCHBackboardGestureControl *)gestureControl
{
  [_gestureControl.view removeFromSuperview];
  [self dismissWithCompletion:nil];
}

#pragma mark - TearDown

- (void)tearDown
{
  _viewController = nil;
  _containerViewController = nil;
  [__backboards removeObjectForKey:_name];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackboardWillPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackboardDidPresentNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackboardWillDismissNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:RCHBackboardDidDismissNotification object:nil];
}


@end
