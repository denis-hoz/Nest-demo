//
// CSDefaultLoginViewModelBuilder.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultLoginViewModelBuilder.h"
#import "CSErrorViewModel.h"

@implementation CSDefaultLoginViewModelBuilder

- (CSErrorViewModel *)buildLoginError:(NSError *)error {
	CSErrorViewModel *errorViewModel = [[CSErrorViewModel alloc] init];
	errorViewModel.title = NSLocalizedString(@"Authorization error", nil);
	errorViewModel.text = error.localizedDescription;
	return errorViewModel;
}

@end