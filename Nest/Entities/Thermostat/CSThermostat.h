//
// Created by Denis on 18.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>
#import "CSThermostatConstants.h"

@interface CSThermostat : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *deviceId;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nameLong;

@property (nonatomic, assign) BOOL canCool;
@property (nonatomic, assign) BOOL canHeat;

@property (nonatomic, assign) BOOL hasFan;
@property (nonatomic, assign, getter=isFanTimerActive) BOOL fanTimerActive;

@property (nonatomic, assign) BOOL hasLeaf;

@property (nonatomic, assign, getter=isCelsiusScale) BOOL celsiusScale;

@property (nonatomic, assign) CGFloat targetTemperatureHighF;
@property (nonatomic, assign) CGFloat targetTemperatureHighC;
@property (nonatomic, assign) CGFloat targetTemperatureLowF;
@property (nonatomic, assign) CGFloat targetTemperatureLowC;

@property (nonatomic, assign) CGFloat targetTemperatureF;
@property (nonatomic, assign) CGFloat targetTemperatureC;

@property (nonatomic, assign) CSThermostatHVACMode hvacMode;

@property (nonatomic, assign) CGFloat ambientTemperatureF;
@property (nonatomic, assign) CGFloat ambientTemperatureC;
@property (nonatomic, assign) NSInteger humidity;
@property (nonatomic, assign) CSThermostatHVACState hvacState;

+ (instancetype)thermostatWithId:(NSString *)thermostatId;
- (NSDictionary *)JSONDictionary;

@end