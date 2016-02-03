//
// CSLoginPresenter.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSLoginPresenter <NSObject>

- (void)viewDidLoad;
- (BOOL)webContentShouldLoadRequestURL:(NSURL *)requestURL;
- (void)webContentDidStartLoad;
- (void)webContentDidFinishLoad;
- (void)webContentDidFailLoadWithError:(NSError *)error;;

@end