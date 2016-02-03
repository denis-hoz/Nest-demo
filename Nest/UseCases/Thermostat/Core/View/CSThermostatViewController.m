//
//  CSThermostatViewController.m
//  Nest
//
//  Created by Denis on 17.01.16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "CSThermostatViewController.h"
#import "CSThermostatPresenter.h"
#import "UIAlertController+CSHelpers.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "CSThermostatRegulatorView.h"
#import "CSThermostatViewModel.h"
#import "CSThermostatFormatter.h"

@interface CSThermostatViewController()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *humidityLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureRangeLabel;
@property (nonatomic, weak) IBOutlet CSThermostatRegulatorView *thermostatView;

@property (nonatomic, weak) IBOutlet UIView *temperatureRangeContainerView;
@property (nonatomic, weak) IBOutlet UISlider *temperatureRangeSlider;
@property (nonatomic, weak) IBOutlet UIButton *hvacModeButton;

@property (nonatomic, strong) id<CSThermostatPresenter> presenter;
@property (nonatomic, assign, getter=isShowingActivity) BOOL showingActivity;
@property (nonatomic, assign, getter=isCelsiusScale) BOOL celsiusScale;
@end

@implementation CSThermostatViewController

- (instancetype)initWithPresenter:(id <CSThermostatPresenter>)presenter {
    self = [super init];
    if (self) {
        _presenter = presenter;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.temperatureRangeSlider setThumbImage:[UIImage imageNamed:@"ThermostatSelector"] forState:UIControlStateNormal];
	[self.temperatureRangeSlider setThumbImage:[UIImage imageNamed:@"ThermostatSelectorSelected"] forState:UIControlStateHighlighted];
	
    self.thermostatView.presenter = self.presenter;
	[self.presenter load];
}


#pragma mark - <CSThermostatView>

- (void)updateWithThermostatViewModel:(CSThermostatViewModel *)thermostatViewModel {
    [self.thermostatView updateWithThermostatViewModel:thermostatViewModel];

    self.celsiusScale = thermostatViewModel.celsiusScale;
	self.titleLabel.text = thermostatViewModel.name;
	self.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %zd", thermostatViewModel.humidity];

	self.temperatureRangeSlider.minimumValue = thermostatViewModel.minTemperatureRange;
	self.temperatureRangeSlider.maximumValue = thermostatViewModel.maxTemperatureRange;
	self.temperatureRangeSlider.value = thermostatViewModel.selectedTemperatureRange;
	[self temperatureRangeSliderDidChanged];

	[self _updateWithHvacMode:thermostatViewModel.hvacMode];
}

- (void)displayError:(CSErrorViewModel *)error withHandler:(CSThermostatViewErrorHandler)handler {
    [UIAlertController cs_presentAlertForViewModel:error viewController:self handler:^(UIAlertAction *action) {
        CSBlockSafeRun(handler);
    }];
}

- (void)showActivity {
    if (!self.isShowingActivity) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.showingActivity = YES;
    }
}

- (void)hideActivity {
    if (self.isShowingActivity) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.showingActivity = NO;
    }
}


#pragma mark - Actions

- (IBAction)temperatureRangeSliderDidChanged {
    [self.thermostatView updateWithTemperatureRange:self.temperatureRangeSlider.value];

    CGFloat selectedTemperatureRange = [CSThermostatFormatter temperatureRoundedValueWithValue:self.temperatureRangeSlider.value
                                                                               forCelsiusScale:self.isCelsiusScale];
	NSString *selectedTemperatureRangeString = [CSThermostatFormatter temperatureTextWithValue:selectedTemperatureRange
																			   forCelsiusScale:self.isCelsiusScale];
    self.temperatureRangeLabel.text = [NSString stringWithFormat:@"Temperature range: ±%@", selectedTemperatureRangeString];
}

- (IBAction)temperatureRangeSliderEditingDidEnd {
	[self.thermostatView applyThermostatSettings];
}


#pragma mark - Helpers

- (void)_updateWithHvacMode:(CSThermostatHVACMode)hvacMode {
	self.temperatureRangeContainerView.hidden = hvacMode != CSThermostatHVACModeHeatAndCool;
	[self.hvacModeButton setTitle:CSThermostatModeTitleFromHVACMode(hvacMode) forState:UIControlStateNormal];
}

@end
