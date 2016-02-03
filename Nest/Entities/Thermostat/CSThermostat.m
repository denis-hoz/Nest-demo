//
// Created by Denis on 18.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSThermostat.h"

@implementation CSThermostat

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"deviceId" : @"device_id",
// TODO:
//            "locale": "en-US",
//            "software_version": "4.0",
//            "structure_id": "VqFabWH21nwVyd4RWgJgNb292wa7hG_dUwo2i2SG7j3-BOLY0BA4sw",
            @"name" : @"name",
            @"nameLong" : @"name_long",
//            "last_connection": "2015-10-31T23:59:59.000Z",
//            "is_online": true,
            @"canCool" : @"can_cool",
            @"canHeat" : @"can_heat",
//            "is_using_emergency_heat": true,
            @"hasFan" : @"has_fan",
            @"fanTimerActive" : @"fan_timer_active",
//            "fan_timer_timeout": "2015-10-31T23:59:59.000Z",
            @"hasLeaf" : @"has_leaf",
			@"celsiusScale" : @"temperature_scale",

			@"targetTemperatureHighF" : @"target_temperature_high_f",
			@"targetTemperatureHighC" : @"target_temperature_high_c",
			@"targetTemperatureLowF" : @"target_temperature_low_f",
			@"targetTemperatureLowC" : @"target_temperature_low_c",

//            "away_temperature_high_f": 72,
//            "away_temperature_high_c": 21.5,
//            "away_temperature_low_f": 64,
//            "away_temperature_low_c": 17.5,

            @"targetTemperatureF" : @"target_temperature_f",
			@"targetTemperatureC" : @"target_temperature_c",
			
            @"hvacMode": @"hvac_mode",
			
            @"ambientTemperatureF" : @"ambient_temperature_f",
			@"ambientTemperatureC" : @"ambient_temperature_c",
			@"humidity" : @"humidity",
			@"hvacState" : @"hvac_state",
//            "where_id": "UNCBGUnN24..."
    };
}

+ (NSValueTransformer *)celsiusScaleJSONTransformer {
	return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
		return @([(NSString *)value isEqualToString:@"C"]);
	}];
}

+ (NSValueTransformer *)hvacStateJSONTransformer {
	return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
		return @(CSThermostatHVACStateFromString(value));
	}];
}

+ (NSValueTransformer *)hvacModeJSONTransformer {
	return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
		return @(CSThermostatHVACModeFromString(value));
	}];
}

+ (instancetype)thermostatWithId:(NSString *)thermostatId {
    return [[self alloc] initWithId:thermostatId];
}

- (instancetype)initWithId:(NSString *)thermostatId {
    self = [super init];
    if (self) {
        _deviceId = [thermostatId copy];
    }

    return self;
}

- (NSDictionary *)JSONDictionary {
	NSDictionary *dict = [MTLJSONAdapter JSONDictionaryFromModel:self error:NULL];
	
	return [dict dictionaryWithValuesForKeys:[self _whiteListedPropertyKeys]];
}

- (NSArray *)_whiteListedPropertyKeys {
	if (self.hvacMode == CSThermostatHVACModeHeatAndCool) {
		return @[self.celsiusScale ? @"target_temperature_high_c" : @"target_temperature_high_f",
				 self.celsiusScale ? @"target_temperature_low_c" : @"target_temperature_low_f"];
	} else {
		return @[self.celsiusScale ? @"target_temperature_c" : @"target_temperature_f"];
	}
}

@end