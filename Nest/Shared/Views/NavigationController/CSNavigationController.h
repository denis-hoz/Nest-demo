//
// Created by Denis on 17.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSNavigationController : UINavigationController

- (instancetype)initWithAnimator:(id <UIViewControllerAnimatedTransitioning>)animator;

@end