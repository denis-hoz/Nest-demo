//
// CSDefaultLoginWireframe.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLoginWireframe.h"

@class CSThermostatModuleBuilder;

@interface CSDefaultLoginWireframe : NSObject <CSLoginWireframe>

@property (nonatomic, weak) UINavigationController *navigationController;

- (instancetype)initWithThermostatModuleBuilder:(CSThermostatModuleBuilder *)thermostatModuleBuilder;

@end