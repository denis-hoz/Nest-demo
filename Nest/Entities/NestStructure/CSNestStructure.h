//
// CSNestStructure.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CSNestStructure : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray<NSString *> *thermostatIds;

@end