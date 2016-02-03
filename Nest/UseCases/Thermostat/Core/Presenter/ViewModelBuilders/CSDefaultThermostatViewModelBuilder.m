//
// CSDefaultThermostatViewModelBuilder.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultThermostatViewModelBuilder.h"
#import "CSThermostatViewModel.h"
#import "CSThermostat.h"

@implementation CSDefaultThermostatViewModelBuilder

- (CSThermostatViewModel *)buildThermostatViewModelWithThermostat:(CSThermostat *)thermostat {
	CSThermostatViewModel *thermostatViewModel = [[CSThermostatViewModel alloc] init];
	
	thermostatViewModel.name = thermostat.name;
	
	thermostatViewModel.minTemperature = thermostat.isCelsiusScale ? 9 : 50;
	thermostatViewModel.maxTemperature = thermostat.isCelsiusScale ? 32 : 90;
	
	if (thermostat.hvacMode == CSThermostatHVACModeHeatAndCool) {
		CGFloat targetTemperatureLow = thermostat.isCelsiusScale ? thermostat.targetTemperatureLowC : thermostat.targetTemperatureLowF;
		CGFloat targetTemperatureHigh = thermostat.isCelsiusScale ? thermostat.targetTemperatureHighC: thermostat.targetTemperatureHighF;

		thermostatViewModel.selectedTemperature = (targetTemperatureHigh + targetTemperatureLow) / 2.0f;
		thermostatViewModel.selectedTemperatureRange = (targetTemperatureHigh - targetTemperatureLow) / 2.0f;
		thermostatViewModel.minTemperatureRange = thermostat.isCelsiusScale ? 1 : 0;
		thermostatViewModel.maxTemperatureRange = thermostat.isCelsiusScale ? 5 : 10;
		
		thermostatViewModel.minTemperatureRange = MIN(thermostatViewModel.minTemperatureRange, thermostatViewModel.selectedTemperatureRange);
		thermostatViewModel.maxTemperatureRange = MAX(thermostatViewModel.maxTemperatureRange, thermostatViewModel.selectedTemperatureRange);
	} else {
		thermostatViewModel.selectedTemperature = thermostat.isCelsiusScale ? thermostat.targetTemperatureC : thermostat.targetTemperatureF;
		thermostatViewModel.selectedTemperatureRange = 0;
	}
	thermostatViewModel.hvacMode = thermostat.hvacMode;

	thermostatViewModel.ambientTemperature = thermostat.isCelsiusScale ? thermostat.ambientTemperatureC : thermostat.ambientTemperatureF;
	
	thermostatViewModel.humidity = thermostat.humidity;

	thermostatViewModel.hasLeaf = thermostat.hasLeaf;
	thermostatViewModel.celsiusScale = thermostat.isCelsiusScale;
	thermostatViewModel.hvacState = thermostat.hvacState;
	thermostatViewModel.funRunning = thermostat.hvacState != CSThermostatHVACStateOff;

	return thermostatViewModel;
}

@end