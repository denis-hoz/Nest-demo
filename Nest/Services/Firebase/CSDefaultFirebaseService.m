//
// CSDefaultFirebaseService.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultFirebaseService.h"
#import "CSNestAuthService.h"
#import "CSAccessToken.h"

@interface CSDefaultFirebaseService()
@property (nonatomic, strong) Firebase *rootFirebase;

@property (nonatomic, strong) NSMutableDictionary<NSString *, FDataSnapshot *> *subscribedSnapshots;
@property (nonatomic, strong) NSMutableDictionary<NSString *, Firebase *> *firebases;
@end

@implementation CSDefaultFirebaseService

- (instancetype)initWithNestAuthService:(id <CSNestAuthService>)nestAuthService firebase:(Firebase *)firebase {
    self = [super init];
    if (self) {
        _rootFirebase = firebase;
        [_rootFirebase authWithCustomToken:nestAuthService.accessToken.token withCompletionBlock:^(NSError *error, FAuthData *authData) {
            if (nil != error) {
                CSLog(@"Error when connecting to Firebase: %@", error);
                // TODO: Check internet/navigate to login screen
            }
        }];
    }

    return self;
}


#pragma mark - Properties

- (NSMutableDictionary *)subscribedSnapshots {
    if (nil == _subscribedSnapshots) {
        _subscribedSnapshots = [NSMutableDictionary dictionary];
    }

    return _subscribedSnapshots;
}


- (NSMutableDictionary<NSString *,Firebase *> *)firebases {
	if (nil == _firebases) {
		_firebases = [NSMutableDictionary dictionary];
	}
	
	return _firebases;
}

#pragma mark - <CSFirebaseService>

- (void)addSubscriptionToURL:(NSString *)URL withHandler:(CSFirebaseServiceSubscriptionHandler)handler {
    if (nil != self.subscribedSnapshots[URL]) {
        CSBlockSafeRun(handler, self.subscribedSnapshots[URL]);
        return;
    }

    Firebase *firebase = [self.rootFirebase childByAppendingPath:URL];
    self.firebases[URL] = firebase;
    CSBlockWeakSelf
    [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        weakSelf.subscribedSnapshots[URL] = snapshot;
        CSBlockSafeRun(handler, snapshot);
    }];
}

- (void)setValues:(NSDictionary *)values forURL:(NSString *)URL {
    if (nil == self.subscribedSnapshots[URL]) {
        return;
    }

    [self.firebases[URL] runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
        [currentData setValue:values];
        return [FTransactionResult successWithValue:currentData];
    } andCompletionBlock:^(NSError *error, BOOL committed, FDataSnapshot *snapshot) {
        if (nil != error) {
            CSLog(@"Error running firebase transaction: %@", error);
        }
    } withLocalEvents:NO];
}

@end