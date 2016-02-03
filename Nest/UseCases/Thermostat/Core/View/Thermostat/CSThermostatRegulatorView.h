//
//  CSThermostatRegulatorView.h
//  Nest
//
//  Created by Denis Kapusta on 1/18/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "CSBaseCustomView.h"

@class CSThermostatViewModel;
@protocol CSThermostatPresenter;

@interface CSThermostatRegulatorView : CSBaseCustomView

@property (nonatomic, weak) id<CSThermostatPresenter> presenter;

- (void)updateWithThermostatViewModel:(CSThermostatViewModel *)thermostatViewModel;
- (void)updateWithTemperatureRange:(CGFloat)temperatureRange;

- (void)applyThermostatSettings;

@end
