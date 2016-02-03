//
// CSDefaultThermostatPresenter.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSThermostatPresenter.h"

@protocol CSThermostatView;
@protocol CSThermostatInteractor;
@protocol CSThermostatViewModelBuilder;

@interface CSDefaultThermostatPresenter : NSObject <CSThermostatPresenter>

@property (nonatomic, weak) id<CSThermostatView> view;

- (instancetype)initWithInteractor:(id <CSThermostatInteractor>)interactor viewModelBuilder:(id <CSThermostatViewModelBuilder>)viewModelBuilder;

@end