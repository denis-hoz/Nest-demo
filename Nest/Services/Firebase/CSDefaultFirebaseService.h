//
// CSDefaultFirebaseService.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSFirebaseService.h"

@protocol CSNestAuthService;

@interface CSDefaultFirebaseService : NSObject <CSFirebaseService>

- (instancetype)initWithNestAuthService:(id <CSNestAuthService>)nestAuthService firebase:(Firebase *)firebase;

@end