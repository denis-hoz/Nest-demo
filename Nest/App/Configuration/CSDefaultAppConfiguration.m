//
// CSDefaultAppConfiguration.m
// Nest
//
// Created by Denis Kapusta on 12/22/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultAppConfiguration.h"
#import "CSLoginModuleBuilder.h"
#import "CSThermostatModuleBuilder.h"
#import "CSNestAuthService.h"
#import "CSAppAssembly.h"
#import "CSAccessToken.h"

@interface CSDefaultAppConfiguration()
@property (nonatomic, strong) CSLoginModuleBuilder *loginModuleBuilder;
@property (nonatomic, strong) CSThermostatModuleBuilder *thermostatModuleBuilder;
@property (nonatomic, strong) id<CSNestAuthService> nestAuthService;
@property (nonatomic, strong) CSAppAssembly *appAssembly;
@end

@implementation CSDefaultAppConfiguration

- (instancetype)initWithLoginModuleBuilder:(CSLoginModuleBuilder *)loginModuleBuilder thermostatModuleBuilder:(CSThermostatModuleBuilder *)thermostatModuleBuilder nestAuthService:(id <CSNestAuthService>)nestAuthService appAssembly:(CSAppAssembly *)appAssembly {
    self = [super init];
    if (self) {
        _loginModuleBuilder = loginModuleBuilder;
        _thermostatModuleBuilder = thermostatModuleBuilder;
        _nestAuthService = nestAuthService;
        _appAssembly = appAssembly;
    }

    return self;
}

- (UIViewController *)rootViewController {
    UIViewController *rootViewController = (self.nestAuthService.accessToken.isValid) ? [self.thermostatModuleBuilder thermostatViewController] : [self.loginModuleBuilder loginViewController];
    UINavigationController *navigationController = [self.appAssembly navigationController];
    navigationController.viewControllers = @[rootViewController];
	navigationController.navigationBarHidden = YES;
    return navigationController;
}

@end