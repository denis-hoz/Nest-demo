//
// CSDefaultNestAuthService.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import "CSDefaultNestAuthService.h"
#import "CSUserService.h"
#import "CSNestConfiguration.h"
#import "CSNestConfigurationConstants.h"
#import "CSRESTClient.h"
#import "CSAccessToken.h"

@interface CSDefaultNestAuthService()
@property (nonatomic, strong) id<CSUserService> userService;
@property (nonatomic, strong) id<CSRESTClient> restClient;

@property (nonatomic, strong) CSNestConfiguration *nestConfiguration;
@property (nonatomic, readonly) NSURL *accessURL;
@end

@implementation CSDefaultNestAuthService

- (instancetype)initWithUserService:(id <CSUserService>)userService restClient:(id <CSRESTClient>)restClient {
    self = [super init];
    if (self) {
        _userService = userService;
        _restClient = restClient;
    }

    return self;
}


#pragma mark - Properties

- (CSNestConfiguration *)nestConfiguration {
    if (nil == _nestConfiguration) {
        _nestConfiguration = [self.userService loadNestConfiguration];

        if (nil == _nestConfiguration) {
            _nestConfiguration = [[CSNestConfiguration alloc] init];
        }
    }

    return _nestConfiguration;
}


#pragma mark - <CSNestAuthService>

- (CSAccessToken *)accessToken {
    return self.nestConfiguration.accessToken;
}

- (NSURL *)authorizationURL {
    NSString *authorizationPath = [NSString stringWithFormat:@"%@login/oauth2?client_id=%@&state=%@", kCSNestAuthDomain, kCSNestClientID, kCSNestState];
    return [NSURL URLWithString:authorizationPath];
}

- (NSURL *)redirectURL {
    return [NSURL URLWithString:kCSRedirectURL];
}

- (void)getAccessTokenWithAuthorizationCode:(NSString *)authorizationCode
                                 completion:(CSNestAuthServiceGettingAccessTokenCompletion)completion {

    CSBlockWeakSelf
    [self.restClient doPOST:[self _accessTokenURL]
                     params:[self _accessTokenParamsWithAuthorizationCode:authorizationCode]
                 completion:^(NSDictionary *result, NSURLResponse *response, NSError *error) {
                     if (nil != error) {
                         NSLog(@"%@", error);
                         CSBlockSafeRun(completion, error);
                         return;
                     }

                     [weakSelf _saveAccessTokenFromJSON:result completion:completion];
                 }];
}


#pragma mark - Helpers.

- (void)_saveNestConfiguration {
    [self.userService saveNestConfiguration:self.nestConfiguration];
}

- (NSDictionary *)_accessTokenParamsWithAuthorizationCode:(NSString *)authorizationCode {
    if (nil == authorizationCode) {
        CSLog(@"Missing authorization code");
        return nil;
    }

    return @{
             @"code" : authorizationCode,
             @"client_id" : kCSNestClientID,
             @"client_secret" : kCSNestClientSecret,
             @"grant_type" : @"authorization_code"
    };
}

- (NSURL *)_accessTokenURL {
    NSString *accessPath = [NSString stringWithFormat:@"%@oauth2/access_token", kCSNestAPIDomain];
    NSURL *accessURL = [NSURL URLWithString:accessPath];
    return accessURL;
}

- (void)_saveAccessTokenFromJSON:(NSDictionary *)json completion:(CSNestAuthServiceGettingAccessTokenCompletion)completion {
    NSError *error;
    self.nestConfiguration.accessToken = [MTLJSONAdapter modelOfClass:CSAccessToken.class
                                           fromJSONDictionary:json
                                                        error:&error];
    [self _saveNestConfiguration];

    CSBlockSafeRun(completion, error);
}

@end