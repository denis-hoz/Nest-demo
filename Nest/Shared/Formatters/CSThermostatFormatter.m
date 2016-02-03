//
// CSThermostatFormatter.m
// Nest
//
// Created by Denis Kapusta on 2/2/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSThermostatFormatter.h"


@implementation CSThermostatFormatter

+ (CGFloat)temperatureRoundedValueWithValue:(CGFloat)value forCelsiusScale:(BOOL)isCelsiusScale {
    if (isCelsiusScale) {
        return roundf(value * 2.0f) / 2.0f;
    } else {
        return roundf(value);
    }
}

+ (NSString *)temperatureTextWithValue:(CGFloat)value forCelsiusScale:(BOOL)isCelsiusScale {
    if (isCelsiusScale) {
        return [NSString stringWithFormat:@"%03.1f°", value];
    } else {
        return [NSString stringWithFormat:@"%02.0f°", value];
    }
}

@end