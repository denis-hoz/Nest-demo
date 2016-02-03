//
// CSLoginModuleBuilder.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol CSUserService;

@class CSCoreServicesConfiguration;
@class CSThermostatModuleBuilder;
@class CSAppAssembly;

@interface CSLoginModuleBuilder : TyphoonAssembly

@property (nonatomic, readonly) CSAppAssembly *appAssembly;
@property (nonatomic, readonly) CSCoreServicesConfiguration *coreServices;
@property (nonatomic, readonly) CSThermostatModuleBuilder *thermostatModuleBuilder;

- (UIViewController *)loginViewController;

@end