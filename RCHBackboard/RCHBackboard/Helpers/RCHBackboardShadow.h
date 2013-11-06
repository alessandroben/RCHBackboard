//
//  RCHBackboardShadow.h
//  RCHBackboard
//
//  Created by Rob Hayward on 28/11/2012.
//  Copyright (c) 2012 Rob Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCHBackboard.h"

@interface RCHBackboardShadow : UIView

@property (readwrite, nonatomic) RCHBackboardOrientation orientation;
@property (strong, nonatomic) UIColor *color;

- (id)initWithFrame:(CGRect)frame andDirection:(RCHBackboardOrientation)shadowOrientation;

@end
