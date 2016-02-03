//
//  CSLoginViewController.m
//  Nest
//
//  Created by Denis Kapusta on 1/16/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "CSLoginViewController.h"
#import "CSLoginPresenter.h"
#import "UIAlertController+CSHelpers.h"
#import <PureLayout/PureLayout.h>

@interface CSLoginViewController () <UIWebViewDelegate>
@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, strong) id<CSLoginPresenter> presenter;
@property (nonatomic, weak) UIApplication *application;
@end

@implementation CSLoginViewController

- (instancetype)initWithPresenter:(id <CSLoginPresenter>)presenter application:(UIApplication *)application {
    self = [super init];
    if (self) {
        _presenter = presenter;
        _application = application;
    }

    return self;
}


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _setupUI];
    [self.presenter viewDidLoad];
}

- (void)_setupUI {
    [self.webView autoPinToTopLayoutGuideOfViewController:self withInset:0];
}


#pragma mark - <CSLoginView>

- (void)loadAuthURL:(NSURL *)authURL {
    [self _updateWebViewWithURL:authURL];
}

- (void)displayError:(CSErrorViewModel *)error withHandler:(CSLoginViewErrorHandler)handler {
    [UIAlertController cs_presentAlertForViewModel:error viewController:self handler:^(UIAlertAction *action) {
        CSBlockSafeRun(handler);
    }];
}

- (void)showNetworkActivity {
    self.application.networkActivityIndicatorVisible = YES;
}

- (void)hideNetworkActivity {
    self.application.networkActivityIndicatorVisible = NO;
}


#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return [self.presenter webContentShouldLoadRequestURL:request.URL];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.presenter webContentDidStartLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.presenter webContentDidFinishLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.presenter webContentDidFailLoadWithError:error];
}


#pragma mark - Helpers

- (void)_updateWebViewWithURL:(NSURL *)URL {
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

@end
