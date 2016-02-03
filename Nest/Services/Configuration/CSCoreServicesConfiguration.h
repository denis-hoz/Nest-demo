//
// CSCoreServicesConfiguration.h
// Nest
//
// Created by Denis Kapusta on 12/23/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol CSNestAuthService;
@protocol CSNestStructureService;
@protocol CSThermostatService;

@interface CSCoreServicesConfiguration : TyphoonAssembly

- (id<CSNestAuthService>)nestAuthService;
- (id<CSNestStructureService>)nestStructureService;
- (id<CSThermostatService>)thermostatService;

@end