//
// Created by Denis on 17.01.16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSFadeInAnimator.h"

@interface CSFadeInAnimator()
@property(nonatomic, assign) NSTimeInterval duration;
@end

@implementation CSFadeInAnimator

- (instancetype)initWithDuration:(NSNumber *)duration {
    self = [super init];
    if (nil != self) {
        _duration = duration.doubleValue;
    }

    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [containerView addSubview:toVC.view];
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end