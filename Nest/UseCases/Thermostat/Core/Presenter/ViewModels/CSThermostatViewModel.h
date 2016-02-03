//
// CSThermostatViewModel.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSThermostatConstants.h"

@interface CSThermostatViewModel : NSObject

@property (nonatomic, assign) NSString *name;

@property (nonatomic, assign) CGFloat minTemperature;
@property (nonatomic, assign) CGFloat maxTemperature;

@property (nonatomic, assign) CGFloat minTemperatureRange;
@property (nonatomic, assign) CGFloat maxTemperatureRange;

@property (nonatomic, assign) CGFloat selectedTemperature;
@property (nonatomic, assign) CGFloat selectedTemperatureRange;
@property (nonatomic, assign) CGFloat ambientTemperature;

@property (nonatomic, assign) NSInteger humidity;

@property (nonatomic, assign) BOOL hasLeaf;
@property (nonatomic, assign, getter=isCelsiusScale) BOOL celsiusScale;
@property (nonatomic, assign, getter=isFunRunning) BOOL funRunning;
@property (nonatomic, assign) CSThermostatHVACState hvacState;
@property (nonatomic, assign) CSThermostatHVACMode hvacMode;

@end