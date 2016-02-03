//
// CSDefaultThermostatService.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultThermostatService.h"
#import "CSFirebaseService.h"
#import "CSFirebasePathPatterns.h"
#import "CSThermostat.h"

@interface CSDefaultThermostatService()
@property (nonatomic, strong) id<CSFirebaseService> firebaseService;
@end

@implementation CSDefaultThermostatService

- (instancetype)initWithFirebaseService:(id <CSFirebaseService>)firebaseService  {
    self = [super init];
    if (self) {
        _firebaseService = firebaseService;
    }

    return self;
}


#pragma mark - <CSThermostatService>

- (void)addSubscriptionForThermostat:(CSThermostat *)thermostat withHandler:(CSThermostatServiceSubscriptionHandler)handler {
    [self.firebaseService addSubscriptionToURL:[self _urlWithThermostat:thermostat] withHandler:^(FDataSnapshot *snapshot) {
        // TODO: display error.

		[thermostat mergeValuesForKeysFromModel:[MTLJSONAdapter modelOfClass:CSThermostat.class
														  fromJSONDictionary:snapshot.value
																	   error:NULL]];

        CSBlockSafeRun(handler, thermostat);
    }];
}

- (void)updateWithThermostat:(CSThermostat *)thermostat {
    [self.firebaseService setValues:thermostat.JSONDictionary forURL:[self _urlWithThermostat:thermostat]];
}


#pragma mark - Helpers

- (NSString *)_urlWithThermostat:(CSThermostat *)thermostat {
    return [NSString stringWithFormat:@"%@%@/", CSFirebasePathPatternThermostat, thermostat.deviceId];
}

@end