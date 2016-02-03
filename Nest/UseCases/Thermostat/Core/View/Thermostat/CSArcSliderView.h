//
// CSArcSliderView.h
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSArcSliderView : UIControl
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, readwrite) CGFloat value;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat range;

@property (nonatomic, strong) UIImageView *selectorImageView;
@property (nonatomic, strong) UIImageView *selectorSelectedImageView;
@end