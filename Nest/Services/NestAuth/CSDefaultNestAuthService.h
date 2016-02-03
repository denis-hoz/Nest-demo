//
// CSDefaultNestAuthService.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNestAuthService.h"

@protocol CSUserService;
@protocol CSRESTClient;

@interface CSDefaultNestAuthService : NSObject <CSNestAuthService>

- (instancetype)initWithUserService:(id <CSUserService>)userService restClient:(id <CSRESTClient>)restClient;

@end