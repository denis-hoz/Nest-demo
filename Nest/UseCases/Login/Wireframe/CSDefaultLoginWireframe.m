//
// CSDefaultLoginWireframe.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultLoginWireframe.h"
#import "CSThermostatModuleBuilder.h"

@interface CSDefaultLoginWireframe()
@property (nonatomic, strong) CSThermostatModuleBuilder *thermostatModuleBuilder;
@end

@implementation CSDefaultLoginWireframe

- (instancetype)initWithThermostatModuleBuilder:(CSThermostatModuleBuilder *)thermostatModuleBuilder {
    self = [super init];
    if (self) {
        _thermostatModuleBuilder = thermostatModuleBuilder;
    }

    return self;
}

- (void)showThermostatScreen {
    UIViewController *thermostatViewController = [self.thermostatModuleBuilder thermostatViewController];
    thermostatViewController.view.frame = self.navigationController.view.bounds;
    [self.navigationController setViewControllers:@[thermostatViewController] animated:YES];
}

@end