//
//  RCHBackboardShadow.m
//  Unity-iPhone
//
//  Created by Rob Hayward on 20/06/2013.
//
//

#import "RCHBackboardShadow.h"
#import "RCHBackboardDraw.h"

@implementation RCHBackboardShadow

- (id)initWithFrame:(CGRect)frame andDirection:(RCHBackBoardOrientation)shadowOrientation
{
  self = [super initWithFrame:frame];
  if (self)
  {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.orientation = shadowOrientation;
    self.userInteractionEnabled = NO;
    self.color = [UIColor blackColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  UIColor *startColor = [UIColor clearColor];
  UIColor *endColor   = [UIColor blackColor];
  CGPoint startPoint  = CGPointZero;
  CGPoint endPoint  = CGPointZero;
  CGGradientRef gradient = [RCHBackboardDraw gradientWithColors:@[startColor, endColor] locations:nil];
  
  switch (_orientation) {
    case RCHBackBoardOrientationLeft:
    {
      endPoint = CGPointMake(rect.size.width, 0);
    }
      break;
    case RCHBackBoardOrientationRight:
    {
      startPoint = CGPointMake(rect.size.width, 0);
      endPoint = CGPointMake(0, 0);
    }
      break;
    case RCHBackBoardOrientationTop:
    {
      startPoint = CGPointMake(0, 0);
      endPoint = CGPointMake(0, rect.size.height);
    }
      break;
    case RCHBackBoardOrientationBottom:
    {
      startPoint = CGPointMake(0, rect.size.height);
      endPoint = CGPointMake(0, 0);
    }
      break;
  }
  
  CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
}

@end
