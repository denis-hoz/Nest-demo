//
// CSDefaultThermostatPresenter.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultThermostatPresenter.h"
#import "CSThermostatView.h"
#import "CSThermostatInteractor.h"
#import "CSThermostatViewModelBuilder.h"
#import "CSThermostat.h"

@interface CSDefaultThermostatPresenter()
@property (nonatomic, strong) id<CSThermostatInteractor> interactor;
@property (nonatomic, strong) id<CSThermostatViewModelBuilder> viewModelBuilder;
@property (nonatomic, strong) CSThermostat *thermostat;
@end

@implementation CSDefaultThermostatPresenter

- (instancetype)initWithInteractor:(id <CSThermostatInteractor>)interactor viewModelBuilder:(id <CSThermostatViewModelBuilder>)viewModelBuilder {
    self = [super init];
    if (self) {
        _interactor = interactor;
        _viewModelBuilder = viewModelBuilder;
    }

    return self;
}


#pragma mark - <CSThermostatPresenter>

- (void)updateWithThermostat:(CSThermostat *)thermostat {
	NSLog(@"%@", thermostat);
	self.thermostat = thermostat;
	
    [self.view hideActivity];
    CSThermostatViewModel *thermostatViewModel = [self.viewModelBuilder buildThermostatViewModelWithThermostat:thermostat];
    [self.view updateWithThermostatViewModel:thermostatViewModel];
}

- (void)load {
    [self.view showActivity];
    [self.interactor load];
}

- (void)didSelectTemperature:(CGFloat)selectedTemperature {
	if (self.thermostat.isCelsiusScale) {
		self.thermostat.targetTemperatureC = selectedTemperature;
	} else {
		self.thermostat.targetTemperatureF = selectedTemperature;
	}
	
	[self.interactor updateWithThermostat:self.thermostat];
}

- (void)didSelectTemperatureLow:(CGFloat)selectedTemperatureLow high:(CGFloat)selectedTemperatureHigh {
	if (self.thermostat.isCelsiusScale) {
		self.thermostat.targetTemperatureLowC = selectedTemperatureLow;
		self.thermostat.targetTemperatureHighC = selectedTemperatureHigh;
	} else {
		self.thermostat.targetTemperatureLowF = selectedTemperatureLow;
		self.thermostat.targetTemperatureHighF = selectedTemperatureHigh;
	}
	
	[self.interactor updateWithThermostat:self.thermostat];
}

@end