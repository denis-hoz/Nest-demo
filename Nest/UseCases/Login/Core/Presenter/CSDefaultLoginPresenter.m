//
// CSDefaultLoginPresenter.m
// Nest
//
// Created by Denis Kapusta on 1/16/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSDefaultLoginPresenter.h"
#import "CSLoginInteractor.h"
#import "CSLoginView.h"
#import "CSLoginWireframe.h"
#import "CSLoginViewModelBuilder.h"

@interface CSDefaultLoginPresenter()
@property (nonatomic, strong) id<CSLoginInteractor> interactor;
@property (nonatomic, strong) id<CSLoginWireframe> wireframe;
@property (nonatomic, strong) id<CSLoginViewModelBuilder> viewModelBuilder;
@end

@implementation CSDefaultLoginPresenter

- (instancetype)initWithInteractor:(id <CSLoginInteractor>)interactor wireframe:(id <CSLoginWireframe>)wireframe viewModelBuilder:(id <CSLoginViewModelBuilder>)viewModelBuilder {
    self = [super init];
    if (self) {
        _interactor = interactor;
        _wireframe = wireframe;
        _viewModelBuilder = viewModelBuilder;
    }

    return self;
}


#pragma mark - <CSLoginPresenter>

- (void)viewDidLoad {
    [self.view loadAuthURL:self.interactor.authorizationURL];
}

- (BOOL)webContentShouldLoadRequestURL:(NSURL *)requestURL {
	if (![self.interactor requestURLHasAuthorizationToken:requestURL]) {
		return YES;
	}

	[self _showLoading:YES];
	CSBlockWeakSelf
	[self.interactor getAuthorizationTokenWithRequestURL:requestURL completion:^(NSError *error) {
		CSBlockStrongSelf
		[strongSelf _showLoading:NO];

		if (nil != error) {
			[strongSelf _showError:error];
			return;
		}

		[strongSelf.wireframe showThermostatScreen];
	}];

	return NO;
}

- (void)webContentDidStartLoad {
	[self _showLoading:YES];
}

- (void)webContentDidFinishLoad {
	[self _showLoading:NO];
}

- (void)webContentDidFailLoadWithError:(NSError *)error {
	[self _showError:error];
}


#pragma mark - Helpers

- (void)_showError:(NSError *)error {
	CSErrorViewModel *errorViewModel = [self.viewModelBuilder buildLoginError:error];
	CSBlockWeakSelf
	[self.view displayError:errorViewModel withHandler:^{
		[weakSelf viewDidLoad];
	}];
}

- (void)_showLoading:(BOOL)show {
	if (show) {
		[self.view showNetworkActivity];
	} else {
		[self.view hideNetworkActivity];
	}
}

@end