//
// CSDefaultLoginInteractor.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultLoginInteractor.h"
#import "CSNestAuthService.h"

@interface CSDefaultLoginInteractor()
@property (nonatomic, strong) id<CSNestAuthService> nestAuthService;
@end

@implementation CSDefaultLoginInteractor

- (instancetype)initWithNestAuthService:(id <CSNestAuthService>)nestAuthService {
    self = [super init];
    if (self) {
        _nestAuthService = nestAuthService;
    }

    return self;
}


#pragma mark - <CSLoginInteractor>

- (NSURL *)authorizationURL {
    return self.nestAuthService.authorizationURL;
}

#define QUESTION_MARK @"?"
#define SLASH @"/"
#define HASHTAG @"#"
#define EQUALS @"="
#define AMPERSAND @"&"
#define EMPTY_STRING @""

- (BOOL)requestURLHasAuthorizationToken:(NSURL *)requestURL {
    return [self.nestAuthService.redirectURL.host isEqualToString:requestURL.host];
}

- (void)getAuthorizationTokenWithRequestURL:(NSURL *)requestURL completion:(CSLoginInteractorGetAuthorizationTokenCompletion)completion {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:requestURL resolvingAgainstBaseURL:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name == 'code'"];
    NSURLQueryItem *queryItem = [[urlComponents.queryItems filteredArrayUsingPredicate:predicate] firstObject];
    
    if (nil == queryItem) {
        NSString *description = NSLocalizedString(@"Error retrieving the authorization code.", nil);
        CSLog(@"%@", description);
        NSError *error = [NSError errorWithDomain:kCSErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: description}];
        
        CSBlockSafeRun(completion, error);
        return;
    }
    
    [self.nestAuthService getAccessTokenWithAuthorizationCode:queryItem.value completion:completion];
}


@end