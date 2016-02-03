//
// CSDefaultNestStructureService.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultNestStructureService.h"
#import "CSFirebaseService.h"
#import "CSFirebasePathPatterns.h"
#import "CSNestStructure.h"

@interface CSDefaultNestStructureService()
@property (nonatomic, strong) id<CSFirebaseService> firebaseService;
@end

@implementation CSDefaultNestStructureService

- (instancetype)initWithFirebaseService:(id <CSFirebaseService>)firebaseService {
    self = [super init];
    if (self) {
        _firebaseService = firebaseService;
    }

    return self;
}

- (void)addSubscriptionWithHandler:(CSNestStructureServiceSubscriptionHandler)handler {
    [self.firebaseService addSubscriptionToURL:CSFirebasePathPatternStructure withHandler:^(FDataSnapshot *snapshot) {
        // TODO: display error.
		
		NSDictionary *structures = snapshot.value;
		NSString *firstKey = [structures allKeys][0];

        CSNestStructure *nestStructure = [MTLJSONAdapter modelOfClass:CSNestStructure.class
                                                       fromJSONDictionary:structures[firstKey]
                                                                    error:NULL];

        CSBlockSafeRun(handler, nestStructure);
    }];
}

@end