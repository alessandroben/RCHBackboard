//
//  RCHBackboardShadow.h
//  Unity-iPhone
//
//  Created by Rob Hayward on 20/06/2013.
//
//

#import <UIKit/UIKit.h>
#import "RCHBackBoardInterface.h"

@interface RCHBackboardShadow : UIView

@property (readwrite, nonatomic) RCHBackBoardOrientation orientation;
@property (strong, nonatomic) UIColor *color;

- (id)initWithFrame:(CGRect)frame andDirection:(RCHBackBoardOrientation)shadowOrientation;

@end
