//
// Created by Denis on 04.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSNestConfiguration;

@protocol CSUserService <NSObject>

- (CSNestConfiguration *)loadNestConfiguration;
- (void)saveNestConfiguration:(CSNestConfiguration *)nestConfiguration;

@end