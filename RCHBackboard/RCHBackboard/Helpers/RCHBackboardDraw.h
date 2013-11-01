//
//  RCHBackboardDraw.h
//  RCHBackboard
//
//  Created by Rob Hayward on 28/11/2012.
//  Copyright (c) 2012 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCHBackboardDraw : NSObject

/**
 Creates gradients
 
 @param colors Array of UIColor objects
 @param locations Array of NSNumber used as a CGFloat for location values
 @return CGGradientRef A gradient ready for drawing
 */
+ (CGGradientRef)gradientWithColors:(NSArray *)colors locations:(NSArray *)locations;

@end
