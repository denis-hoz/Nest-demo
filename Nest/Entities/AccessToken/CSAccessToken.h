//
// Created by Denis on 16.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CSAccessToken : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, readonly) BOOL isValid;

@end