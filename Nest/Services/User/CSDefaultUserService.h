//
// Created by Denis on 04.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUserService.h"

@interface CSDefaultUserService : NSObject <CSUserService>

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults;

@end