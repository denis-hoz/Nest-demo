//
// CSNestStructure.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSNestStructure.h"

@implementation CSNestStructure

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"thermostatIds" : @"thermostats"
    };
}


@end