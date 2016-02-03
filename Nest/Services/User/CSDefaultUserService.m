//
// Created by Denis on 04.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultUserService.h"

@interface CSDefaultUserService()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation CSDefaultUserService

static NSString *const kNestConfigurationKey = @"kNestConfigurationKey";

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults {
    self = [super init];
    if (nil != self) {
        _userDefaults = userDefaults;
    }

    return self;
}


#pragma mark - <CSUserService>

- (CSNestConfiguration *)loadNestConfiguration {
    NSData *data = [self.userDefaults objectForKey:kNestConfigurationKey];
	if (nil == data) {
		return nil;
	}
	
    CSNestConfiguration *nestConfiguration = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    return nestConfiguration;
}

- (void)saveNestConfiguration:(CSNestConfiguration *)nestConfiguration {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:nestConfiguration];
    [self.userDefaults setObject:data forKey:kNestConfigurationKey];
    [self.userDefaults synchronize];
}

@end