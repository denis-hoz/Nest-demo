//
// UIAlertController+CSHelpers.m
// Nest
//
// Created by Denis Kapusta on 12/24/15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "UIAlertController+CSHelpers.h"
#import "CSErrorViewModel.h"

@implementation UIAlertController (CSHelpers)

+ (void)cs_presentAlertForViewModel:(CSErrorViewModel *)error viewController:(UIViewController *)viewController handler:(void (^)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:error.title
                                                                             message:error.text
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:handler]];

    // Because iOS is hard: https://forums.developer.apple.com/thread/5268
    UIViewController *properPresentingVC = viewController.presentedViewController ?: viewController;

    [properPresentingVC presentViewController:alertController animated:YES completion:nil];
}

@end