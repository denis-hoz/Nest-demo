//
// CSThermostatService.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSThermostat;

typedef void (^CSThermostatServiceSubscriptionHandler)(CSThermostat *thermostat);

@protocol CSThermostatService <NSObject>

- (void)addSubscriptionForThermostat:(CSThermostat *)thermostat withHandler:(CSThermostatServiceSubscriptionHandler)handler;
- (void)updateWithThermostat:(CSThermostat *)thermostat;

@end