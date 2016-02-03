//
// CSDefaultNestStructureService.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNestStructureService.h"

@protocol CSFirebaseService;

@interface CSDefaultNestStructureService : NSObject <CSNestStructureService>

- (instancetype)initWithFirebaseService:(id <CSFirebaseService>)firebaseService;

@end