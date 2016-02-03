//
// CSDefaultAppConfiguration.h
// Nest
//
// Created by Denis Kapusta on 12/22/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSAppConfiguration.h"

@class CSLoginModuleBuilder;
@class CSThermostatModuleBuilder;
@protocol CSNestAuthService;
@class CSAppAssembly;

@interface CSDefaultAppConfiguration : NSObject <CSAppConfiguration>

- (instancetype)initWithLoginModuleBuilder:(CSLoginModuleBuilder *)loginModuleBuilder thermostatModuleBuilder:(CSThermostatModuleBuilder *)thermostatModuleBuilder nestAuthService:(id <CSNestAuthService>)nestAuthService appAssembly:(CSAppAssembly *)appAssembly;

@end