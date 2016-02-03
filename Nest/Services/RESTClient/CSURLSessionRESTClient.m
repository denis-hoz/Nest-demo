//
// CSURLSessionRESTClient.m
// Nest
//
// Created by Denis Kapusta on 12/22/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSURLSessionRESTClient.h"

@interface CSURLSessionRESTClient ()
@property (nonatomic, strong) NSURLSession *urlSession;
@end

@implementation CSURLSessionRESTClient

- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:config
                                                    delegate:nil
                                               delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}


#pragma mark - <RESTClient>

- (void)doPOST:(NSURL *)resource
        params:(NSDictionary *)params
    completion:(CSRESTClientCompletion)completion {

    NSURLRequest *request = [self _postURLRequestWithURL:resource params:params];
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (nil != error) {
                                                            CSBlockSafeRun(completion, nil, response, error);
                                                            return;
                                                        }

                                                        NSError *jsonError;
                                                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                                        if (nil != jsonError) {
                                                            CSBlockSafeRun(completion, nil, response, jsonError);
                                                            return;
                                                        }

                                                        CSBlockSafeRun(completion, json, response, nil);
                                                    }];

    [task resume];
}

- (NSURL *)urlFromResource:(NSURL *)resource params:(NSDictionary *)params {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:[resource absoluteString]];
    urlComponents.queryItems = [self _queryItemsFromDictionary:params];
    return urlComponents.URL;
}


#pragma mark - Heplers

- (NSURLRequest *)_postURLRequestWithURL:(NSURL *)url params:(NSDictionary *)params {
    NSURL *urlWithParams = [self urlFromResource:url params:params];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlWithParams];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"form-data" forHTTPHeaderField:@"Content-Type"];

    return request;
}


- (NSArray *)_queryItemsFromDictionary:(NSDictionary *)params {
    NSMutableArray *queryItems = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *value, BOOL *stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[value description]]];
    }];
    return  [queryItems copy];
}

@end