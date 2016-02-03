//
// CSLoginInteractor.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CSLoginInteractorGetAuthorizationTokenCompletion)(NSError *error);

@protocol CSLoginInteractor <NSObject>

- (NSURL *)authorizationURL;
- (BOOL)requestURLHasAuthorizationToken:(NSURL *)requestURL;
- (void)getAuthorizationTokenWithRequestURL:(NSURL *)requestURL
                                 completion:(CSLoginInteractorGetAuthorizationTokenCompletion)completion;

@end