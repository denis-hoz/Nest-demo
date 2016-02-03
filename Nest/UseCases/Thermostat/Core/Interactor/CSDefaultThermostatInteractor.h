//
// CSDefaultThermostatInteractor.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSThermostatInteractor.h"

@protocol CSThermostatPresenter;
@protocol CSThermostatService;
@protocol CSNestStructureService;

@interface CSDefaultThermostatInteractor : NSObject <CSThermostatInteractor>

@property (nonatomic, weak) id<CSThermostatPresenter>presenter;

- (instancetype)initWithThermostatService:(id <CSThermostatService>)thermostatService nestStructureService:(id <CSNestStructureService>)nestStructureService;

@end