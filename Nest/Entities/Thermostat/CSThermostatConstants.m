//
//  CSThermostatConstants.m
//  Nest
//
//  Created by Denis Kapusta on 1/22/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "CSThermostatConstants.h"

CSThermostatHVACState CSThermostatHVACStateFromString(NSString *state) {
	if ([state isEqualToString:@"heating"]) {
		return CSThermostatHVACStateHeating;
	} else if ([state isEqualToString:@"cooling"]) {
		return CSThermostatHVACStateCooling;
	} else {
		return CSThermostatHVACStateOff;
	}
}

UIImage* CSThermostatBackgroundImageFromHVACState(CSThermostatHVACState state) {
	NSString *imageName;
	switch (state) {
		case CSThermostatHVACStateHeating: {
			imageName = @"ThermostatBGHeating";
			break;
		}
		case CSThermostatHVACStateCooling: {
			imageName = @"ThermostatBGCooling";
			break;
		}
		case CSThermostatHVACStateOff: {
			imageName = @"ThermostatBG";
			break;
		}
	}
	
	return [UIImage imageNamed:imageName];
}

CSThermostatHVACMode CSThermostatHVACModeFromString(NSString *state) {
	if ([state isEqualToString:@"heat"]) {
		return CSThermostatHVACModeHeat;
	} else if ([state isEqualToString:@"cool"]) {
		return CSThermostatHVACModeCool;
	} else if ([state isEqualToString:@"heat-cool"]) {
		return CSThermostatHVACModeHeatAndCool;
	} else {
		return CSThermostatHVACModeOff;
	}
}

NSString *CSThermostatModeTitleFromHVACMode(CSThermostatHVACMode mode) {
	NSString *title;
	
	switch (mode) {
		case CSThermostatHVACModeHeat: {
			title = @"heat";
			break;
		}
		case CSThermostatHVACModeCool: {
			title = @"cool";
			break;
		}
		case CSThermostatHVACModeHeatAndCool: {
			title = @"heat/cool";
			break;
		}
		case CSThermostatHVACModeOff: {
			title = @"off";
			break;
		}
	}
	
	return title;
}
