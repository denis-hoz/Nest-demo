//
// CSDefaultLoginPresenter.h
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSLoginPresenter.h"

@protocol CSLoginView;
@protocol CSLoginInteractor;
@protocol CSLoginWireframe;
@protocol CSLoginViewModelBuilder;

@interface CSDefaultLoginPresenter : NSObject <CSLoginPresenter>

@property (nonatomic, weak) id<CSLoginView> view;

- (instancetype)initWithInteractor:(id <CSLoginInteractor>)interactor wireframe:(id <CSLoginWireframe>)wireframe viewModelBuilder:(id <CSLoginViewModelBuilder>)viewModelBuilder;

@end