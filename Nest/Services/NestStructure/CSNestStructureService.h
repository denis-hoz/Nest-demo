//
// CSNestStructureService.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSNestStructure;

typedef void (^CSNestStructureServiceSubscriptionHandler)(CSNestStructure *structure);

@protocol CSNestStructureService <NSObject>

- (void)addSubscriptionWithHandler:(CSNestStructureServiceSubscriptionHandler)handler;

@end