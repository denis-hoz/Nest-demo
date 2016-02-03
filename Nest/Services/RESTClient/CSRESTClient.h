//
// CSRESTClient.h
// Nest
//
// Created by Denis Kapusta on 12/22/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CSRESTClientCompletion)(NSDictionary *result, NSURLResponse *response, NSError *error);

@protocol CSRESTClient <NSObject>

- (void)doPOST:(NSURL *)resource
        params:(NSDictionary *)params
    completion:(CSRESTClientCompletion)completion;

- (NSURL *)urlFromResource:(NSURL *)resource params:(NSDictionary *)params;

@end