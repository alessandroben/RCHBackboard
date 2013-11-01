//
//  RCHBackboardDraw.m
//  RCHBackboard
//
//  Created by Rob Hayward on 28/11/2012.
//  Copyright (c) 2012 Rob Hayward. All rights reserved.
//

#import "RCHBackboardDraw.h"
#import <QuartzCore/QuartzCore.h>

@implementation RCHBackboardDraw

+ (CGGradientRef)gradientWithColors:(NSArray *)colors locations:(NSArray *)locations
{
  NSUInteger colorsCount = [colors count];
	if (colorsCount < 2) {
		return nil;
	}
  
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors objectAtIndex:0] CGColor]);
  
	CGFloat *gradientLocations = NULL;
	NSUInteger locationsCount = [locations count];
	if (locationsCount == colorsCount) {
		gradientLocations = (CGFloat *)malloc(sizeof(CGFloat) * locationsCount);
		for (NSUInteger i = 0; i < locationsCount; i++) {
			gradientLocations[i] = [[locations objectAtIndex:i] floatValue];
		}
	}
  
	NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsCount];
	[colors enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[gradientColors addObject:(id)[(UIColor *)object CGColor]];
	}];
  
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
  
	if (gradientLocations) {
		free(gradientLocations);
	}
  
	return gradient;
}

@end
