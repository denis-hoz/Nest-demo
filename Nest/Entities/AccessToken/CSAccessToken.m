//
// Created by Denis on 16.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSAccessToken.h"

@interface CSAccessToken()
@property (nonatomic, strong) NSDate *expirationDate;
@end

@implementation CSAccessToken

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"token" : @"access_token",
            @"expirationDate" : @"expires_in"
    };
}

+ (NSValueTransformer *)expirationDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSUInteger expiration = ((NSNumber *)value).unsignedIntegerValue;
        return [[NSDate date] dateByAddingTimeInterval:expiration];;
    }];
}

- (BOOL)isValid {
    return ([[NSDate date] compare:self.expirationDate] == NSOrderedAscending);
}

@end