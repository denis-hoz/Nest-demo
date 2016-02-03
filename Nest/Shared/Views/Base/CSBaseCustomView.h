//
// Created by Denis on 28.12.15.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSBaseCustomView : UIView

@property (nonatomic, strong) UIView *contentView;

+ (NSString *)nibName;

- (void)finishViewSetup;

@end