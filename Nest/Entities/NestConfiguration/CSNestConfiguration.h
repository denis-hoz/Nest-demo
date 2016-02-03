//
// CSNestConfiguration.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Mantle/Mantle.h>

@class CSAccessToken;

@interface CSNestConfiguration : MTLModel

@property (nonatomic, strong) CSAccessToken *accessToken;

@end