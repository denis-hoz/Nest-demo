//
// CSThermostatModuleBuilder.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@class CSCoreServicesConfiguration;

@interface CSThermostatModuleBuilder : TyphoonAssembly

@property (nonatomic, readonly) CSCoreServicesConfiguration *coreServices;

- (UIViewController *)thermostatViewController;

@end