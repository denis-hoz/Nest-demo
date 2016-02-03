//
//  CSThermostatView.h
//  Nest
//
//  Created by Denis on 17.01.16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CSThermostatViewErrorHandler)();

@class CSThermostatViewModel;
@class CSErrorViewModel;

@protocol CSThermostatView <NSObject>

- (void)updateWithThermostatViewModel:(CSThermostatViewModel *)thermostatViewModel;

- (void)displayError:(CSErrorViewModel *)error withHandler:(CSThermostatViewErrorHandler)handler;
- (void)showActivity;
- (void)hideActivity;

@end
