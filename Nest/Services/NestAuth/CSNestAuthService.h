//
// CSNestAuthService.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSAccessToken;

typedef void (^CSNestAuthServiceGettingAccessTokenCompletion)(NSError *error);

@protocol CSNestAuthService <NSObject>

@property (nonatomic, readonly) CSAccessToken *accessToken;

@property (nonatomic, readonly) NSURL *authorizationURL;
@property (nonatomic, readonly) NSURL *redirectURL;

- (void)getAccessTokenWithAuthorizationCode:(NSString *)authorizationCode
                                 completion:(CSNestAuthServiceGettingAccessTokenCompletion)completion;

@end