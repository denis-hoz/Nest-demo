//
// Created by Denis on 28.12.15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSBaseCustomView.h"
#import "ALView+PureLayout.h"

@implementation CSBaseCustomView

#pragma mark - Properties

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UINib nibWithNibName:[[self class] nibName] bundle:nil] instantiateWithOwner:self options:nil][0];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _contentView;
}


#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        [self _configureContentView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _configureContentView];
        [self finishViewSetup];
    }
    return self;
}


#pragma mark - Subview Management

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self finishViewSetup];
}

- (void)finishViewSetup {
}

- (void)_configureContentView {
    [self insertSubview:self.contentView atIndex:0];

    [self.contentView autoPinEdgesToSuperviewEdges];
    [self setNeedsUpdateConstraints];
}


#pragma mark - Helpers

+ (NSString *)nibName
{
    return NSStringFromClass(self);
}

@end