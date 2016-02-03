//
// UIAlertController+CSHelpers.h
// Nest
//
// Created by Denis Kapusta on 12/24/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSErrorViewModel;

@interface UIAlertController (CSHelpers)

+ (void)cs_presentAlertForViewModel:(CSErrorViewModel *)error viewController:(UIViewController *)viewController handler:(void (^)(UIAlertAction *action))handler;

@end