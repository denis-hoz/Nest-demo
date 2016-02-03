//
// CSLoginModuleBuilder.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSLoginModuleBuilder.h"
#import "CSCoreServicesConfiguration.h"
#import "CSLoginViewController.h"
#import "CSDefaultLoginPresenter.h"
#import "CSDefaultLoginInteractor.h"
#import "CSAppAssembly.h"
#import "CSDefaultLoginWireframe.h"
#import "CSDefaultLoginViewModelBuilder.h"

@implementation CSLoginModuleBuilder

- (UIViewController *)loginViewController {
    return [TyphoonDefinition withClass:CSLoginViewController.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithPresenter:application:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _loginPresenter]];
            [initializer injectParameterWith:[self _application]];
        }];
    }];
}

- (id<CSLoginPresenter>)_loginPresenter {
    return [TyphoonDefinition withClass:CSDefaultLoginPresenter.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithInteractor:wireframe:viewModelBuilder:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _loginInteractor]];
            [initializer injectParameterWith:[self _loginWireframe]];
            [initializer injectParameterWith:[self _loginViewModelBuilder]];
        }];
        [definition injectProperty:@selector(view) with:[self loginViewController]];
    }];
}

- (id<CSLoginInteractor>)_loginInteractor {
    return [TyphoonDefinition withClass:CSDefaultLoginInteractor.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithNestAuthService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.coreServices nestAuthService]];
        }];
    }];
}

- (id<CSLoginWireframe>)_loginWireframe {
    return [TyphoonDefinition withClass:CSDefaultLoginWireframe.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithThermostatModuleBuilder:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:self.thermostatModuleBuilder];
        }];
        [definition injectProperty:@selector(navigationController) with:[self.appAssembly navigationController]];
    }];
}

- (id<CSLoginViewModelBuilder>)_loginViewModelBuilder {
    return [TyphoonDefinition withClass:CSDefaultLoginViewModelBuilder.class];
}

- (UIApplication *)_application {
    return [UIApplication sharedApplication];
}

@end