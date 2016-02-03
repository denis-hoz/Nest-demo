//
// Created by Denis on 18.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

typedef void (^CSFirebaseServiceSubscriptionHandler)(FDataSnapshot *snapshot);

@protocol CSFirebaseService <NSObject>

- (void)addSubscriptionToURL:(NSString *)URL withHandler:(CSFirebaseServiceSubscriptionHandler)handler;
- (void)setValues:(NSDictionary *)values forURL:(NSString *)URL;

@end