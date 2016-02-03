//
// CSLoginViewModelBuilder.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSErrorViewModel;

@protocol CSLoginViewModelBuilder <NSObject>

- (CSErrorViewModel *)buildLoginError:(NSError *)error;

@end