//
// CSDefaultThermostatService.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSThermostatService.h"

@protocol CSFirebaseService;

@interface CSDefaultThermostatService : NSObject <CSThermostatService>

- (instancetype)initWithFirebaseService:(id <CSFirebaseService>)firebaseService;

@end