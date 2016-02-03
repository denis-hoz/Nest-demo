//
// CSAppAssembly.m
// Nest
//
// Created by Denis Kapusta on 12/22/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSAppAssembly.h"
#import "CSAppDelegate.h"
#import "CSDefaultAppConfiguration.h"
#import "CSCoreServicesConfiguration.h"
#import "CSLoginModuleBuilder.h"
#import "CSThermostatModuleBuilder.h"
#import "CSNavigationController.h"
#import "CSFadeInAnimator.h"

@implementation CSAppAssembly

- (CSAppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:CSAppDelegate.class configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(appConfiguration) with:[self _appConfiguration]];
    }];
}

- (id<CSAppConfiguration>)_appConfiguration {
    return [TyphoonDefinition withClass:CSDefaultAppConfiguration.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithLoginModuleBuilder:thermostatModuleBuilder:nestAuthService:appAssembly:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:self.loginModuleBuilder];
            [initializer injectParameterWith:self.thermostatModuleBuilder];
            [initializer injectParameterWith:[self.coreServices nestAuthService]];
            [initializer injectParameterWith:self];
        }];
    }];
}

- (UINavigationController *)navigationController {
    return [TyphoonDefinition withClass:CSNavigationController.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithAnimator:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _animator]];
        }];
        definition.scope = TyphoonScopeWeakSingleton;
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)_animator {
    return [TyphoonDefinition withClass:CSFadeInAnimator.class configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithDuration:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self _animationTransitionDuration]];
        }];
    }];
}

- (NSNumber *)_animationTransitionDuration {
    return @(kCSAnimationTransitionDuration);
}

@end