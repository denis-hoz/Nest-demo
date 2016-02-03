//
// CSThermostatModuleBuilder.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSThermostatModuleBuilder.h"
#import "CSThermostatViewController.h"
#import "CSThermostatInteractor.h"
#import "CSCoreServicesConfiguration.h"
#import "CSDefaultThermostatPresenter.h"
#import "CSDefaultThermostatInteractor.h"
#import "CSDefaultThermostatViewModelBuilder.h"

@implementation CSThermostatModuleBuilder

- (UIViewController *)thermostatViewController {
	return [TyphoonDefinition withClass:CSThermostatViewController.class configuration:^(TyphoonDefinition *definition) {
		[definition useInitializer:@selector(initWithPresenter:) parameters:^(TyphoonMethod *initializer) {
			[initializer injectParameterWith:[self _thermostatPresenter]];
		}];
	}];
}

- (id<CSThermostatPresenter>)_thermostatPresenter {
	return [TyphoonDefinition withClass:CSDefaultThermostatPresenter.class configuration:^(TyphoonDefinition *definition) {
		[definition useInitializer:@selector(initWithInteractor:viewModelBuilder:) parameters:^(TyphoonMethod *initializer) {
			[initializer injectParameterWith:[self _thermostatInteractor]];
			[initializer injectParameterWith:[self _thermostatViewModelBuilder]];
		}];
		[definition injectProperty:@selector(view) with:[self thermostatViewController]];
	}];
}

- (id<CSThermostatInteractor>)_thermostatInteractor {
	return [TyphoonDefinition withClass:CSDefaultThermostatInteractor.class configuration:^(TyphoonDefinition *definition) {
		[definition useInitializer:@selector(initWithThermostatService:nestStructureService:) parameters:^(TyphoonMethod *initializer) {
			[initializer injectParameterWith:[self.coreServices thermostatService]];
			[initializer injectParameterWith:[self.coreServices nestStructureService]];
		}];
		[definition injectProperty:@selector(presenter) with:[self _thermostatPresenter]];
	}];
}

- (id<CSThermostatViewModelBuilder>)_thermostatViewModelBuilder {
	return [TyphoonDefinition withClass:CSDefaultThermostatViewModelBuilder.class];
}

@end