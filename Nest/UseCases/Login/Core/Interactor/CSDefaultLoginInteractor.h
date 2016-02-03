//
// CSDefaultLoginInteractor.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSLoginInteractor.h"

@protocol CSNestAuthService;

@interface CSDefaultLoginInteractor : NSObject <CSLoginInteractor>

- (instancetype)initWithNestAuthService:(id <CSNestAuthService>)nestAuthService;

@end