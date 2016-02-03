//
// CSLoginView.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSErrorViewModel;

typedef void (^CSLoginViewErrorHandler)();

@protocol CSLoginView <NSObject>

- (void)loadAuthURL:(NSURL *)authURL;
- (void)displayError:(CSErrorViewModel *)error withHandler:(CSLoginViewErrorHandler)handler;
- (void)showNetworkActivity;
- (void)hideNetworkActivity;

@end