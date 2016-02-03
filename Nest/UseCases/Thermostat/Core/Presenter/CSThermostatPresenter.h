//
// CSThermostatPresenter.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSThermostat;

@protocol CSThermostatPresenter <NSObject>

- (void)updateWithThermostat:(CSThermostat *)thermostat;

- (void)load;
- (void)didSelectTemperature:(CGFloat)selectedTemperature;
- (void)didSelectTemperatureLow:(CGFloat)selectedTemperatureLow high:(CGFloat)selectedTemperatureHigh;

@end