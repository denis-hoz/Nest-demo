//
//  CSThermostatConstants.h
//  Nest
//
//  Created by Denis Kapusta on 1/22/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef CSThermostatConstants_h
#define CSThermostatConstants_h

typedef NS_ENUM(NSInteger, CSThermostatHVACState) {
	CSThermostatHVACStateHeating = 0,
	CSThermostatHVACStateCooling,
	CSThermostatHVACStateOff
};

typedef NS_ENUM(NSInteger, CSThermostatHVACMode) {
	CSThermostatHVACModeHeat = 0,
	CSThermostatHVACModeCool,
	CSThermostatHVACModeHeatAndCool,
	CSThermostatHVACModeOff
};


CSThermostatHVACState CSThermostatHVACStateFromString(NSString *state);
UIImage *CSThermostatBackgroundImageFromHVACState(CSThermostatHVACState state);

CSThermostatHVACMode CSThermostatHVACModeFromString(NSString *state);
NSString *CSThermostatModeTitleFromHVACMode(CSThermostatHVACMode mode);




#endif /* CSNestConfigurationConstants_h */