//
// CSThermostatFormatter.h
// Nest
//
// Created by Denis Kapusta on 2/2/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSThermostatFormatter : NSObject

+ (CGFloat)temperatureRoundedValueWithValue:(CGFloat)value forCelsiusScale:(BOOL)isCelsiusScale;
+ (NSString *)temperatureTextWithValue:(CGFloat)value forCelsiusScale:(BOOL)isCelsiusScale;

@end