//
//  RCHBackboardShadow.h
//  Unity-iPhone
//
//  Created by Rob Hayward on 20/06/2013.
//
//

#import <UIKit/UIKit.h>
#import "RCHBackboardInterface.h"

@interface RCHBackboardShadow : UIView

@property (readwrite, nonatomic) RCHBackboardOrientation orientation;
@property (strong, nonatomic) UIColor *color;

- (id)initWithFrame:(CGRect)frame andDirection:(RCHBackboardOrientation)shadowOrientation;

@end
