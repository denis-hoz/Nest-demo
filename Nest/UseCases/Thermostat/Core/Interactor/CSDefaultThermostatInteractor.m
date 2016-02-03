//
// CSDefaultThermostatInteractor.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultThermostatInteractor.h"
#import "CSThermostatPresenter.h"
#import "CSThermostatService.h"
#import "CSNestStructureService.h"
#import "CSNestStructure.h"
#import "CSThermostat.h"

@interface CSDefaultThermostatInteractor()
@property (nonatomic, strong) id<CSThermostatService> thermostatService;
@property (nonatomic, strong) id<CSNestStructureService> nestStructureService;
@end

@implementation CSDefaultThermostatInteractor

- (instancetype)initWithThermostatService:(id <CSThermostatService>)thermostatService nestStructureService:(id <CSNestStructureService>)nestStructureService {
    self = [super init];
    if (self) {
        _thermostatService = thermostatService;
        _nestStructureService = nestStructureService;
    }

    return self;
}


#pragma mark - <CSThermostatInteractor>

- (void)load {
    CSBlockWeakSelf
    [self.nestStructureService addSubscriptionWithHandler:^(CSNestStructure *structure) {
        if (structure.thermostatIds.count > 0) {
            [weakSelf _loadThermostatWithId:structure.thermostatIds[0]];
        }
    }];
}

- (void)updateWithThermostat:(CSThermostat *)thermostat {
    [self.thermostatService updateWithThermostat:thermostat];
}


#pragma mark - Helpers

- (void)_loadThermostatWithId:(NSString *)thermostatId {
    CSThermostat *thermostat = [CSThermostat thermostatWithId:thermostatId];

    CSBlockWeakSelf
    [self.thermostatService addSubscriptionForThermostat:thermostat withHandler:^(CSThermostat *thermostat) {
        [weakSelf.presenter updateWithThermostat:thermostat];
    }];
}

@end