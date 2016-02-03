//
// CSAppAssembly.h
// Nest
//
// Created by Denis Kapusta on 12/22/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@class CSCoreServicesConfiguration;
@class CSLoginModuleBuilder;
@class CSThermostatModuleBuilder;

@interface CSAppAssembly : TyphoonAssembly

@property (nonatomic, readonly) CSCoreServicesConfiguration *coreServices;
@property (nonatomic, readonly) CSLoginModuleBuilder *loginModuleBuilder;
@property (nonatomic, readonly) CSThermostatModuleBuilder *thermostatModuleBuilder;

- (UINavigationController *)navigationController;

@end