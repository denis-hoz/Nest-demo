//
// CSCoreServicesConfiguration.m
// Nest
//
// Created by Denis Kapusta on 12/23/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSCoreServicesConfiguration.h"
#import "CSNestAuthService.h"
#import "CSUserService.h"
#import "CSDefaultUserService.h"
#import "CSDefaultNestAuthService.h"
#import "CSNestStructureService.h"
#import "CSNestConfigurationConstants.h"
#import "CSRESTClient.h"
#import "CSThermostatService.h"
#import "CSURLSessionRESTClient.h"
#import "CSFirebaseService.h"
#import "CSDefaultFirebaseService.h"
#import "CSDefaultNestStructureService.h"
#import "CSDefaultThermostatService.h"

@implementation CSCoreServicesConfiguration

- (id<CSNestAuthService>)nestAuthService {
    return [TyphoonDefinition withClass:CSDefaultNestAuthService.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithUserService:restClient:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _userService]];
            [initializer injectParameterWith:[self _restClient]];
        }];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (id <CSNestStructureService>)nestStructureService {
    return [TyphoonDefinition withClass:CSDefaultNestStructureService.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithFirebaseService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _firebaseService]];
        }];
    }];
}

- (id <CSThermostatService>)thermostatService {
    return [TyphoonDefinition withClass:CSDefaultThermostatService.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithFirebaseService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _firebaseService]];
        }];
    }];
}

- (id<CSUserService>)_userService {
    return [TyphoonDefinition withClass:CSDefaultUserService.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithUserDefaults:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[NSUserDefaults standardUserDefaults]];
        }];
		definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (id<CSRESTClient>)_restClient {
    return [TyphoonDefinition withClass:[CSURLSessionRESTClient class]];
}

- (id <CSFirebaseService>)_firebaseService {
    return [TyphoonDefinition withClass:CSDefaultFirebaseService.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithNestAuthService:firebase:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self nestAuthService]];
            [initializer injectParameterWith:[self _firebase]];
        }];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (Firebase *)_firebase {
    return [TyphoonDefinition withClass:Firebase.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithUrl:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:kCSFirebaseURL];
        }];
    }];
}

@end