//
// CSThermostatViewModelBuilder.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSThermostatViewModel;
@class CSThermostat;

@protocol CSThermostatViewModelBuilder <NSObject>

- (CSThermostatViewModel *)buildThermostatViewModelWithThermostat:(CSThermostat *)thermostat;

@end