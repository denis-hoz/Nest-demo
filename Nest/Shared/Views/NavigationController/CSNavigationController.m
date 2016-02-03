//
// Created by Denis on 17.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSNavigationController.h"

@interface CSNavigationController() <UINavigationControllerDelegate>
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animator;
@end

@implementation CSNavigationController

- (instancetype)initWithAnimator:(id <UIViewControllerAnimatedTransitioning>)animator {
    self = [super init];
    if (self) {
        _animator = animator;
        self.delegate = self;
    }

    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self.animator;
}

@end