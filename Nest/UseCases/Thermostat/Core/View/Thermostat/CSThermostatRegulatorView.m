//
//  CSThermostatRegulatorView.m
//  Nest
//
//  Created by Denis Kapusta on 1/18/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import "CSThermostatRegulatorView.h"
#import "CSArcSliderView.h"
#import "CSThermostatPresenter.h"
#import "CSThermostatViewModel.h"
#import "CSThermostatFormatter.h"

@interface CSThermostatRegulatorView()
@property (nonatomic, weak) IBOutlet CSArcSliderView *arcSlider;
@property (nonatomic, weak) IBOutlet UIImageView *leafImageView;
@property (nonatomic, weak) IBOutlet UIImageView *fanImageView;
@property (nonatomic, weak) IBOutlet UILabel *selectedTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *ambientTemperatureLabel;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, readonly) CGFloat thermostatValue;
@property (nonatomic, readonly) NSString *thermostatValueText;

@property (nonatomic, assign, getter=isCelsiusScale) BOOL celsiusScale;
@property (nonatomic, assign) CGFloat selectedTemperatureRange;
@property (nonatomic, assign) CSThermostatHVACMode hvacMode;

@end

@implementation CSThermostatRegulatorView

#pragma mark - Properties

- (CGFloat)thermostatValue {
	return [CSThermostatFormatter temperatureRoundedValueWithValue:self.arcSlider.value forCelsiusScale:self.isCelsiusScale];
}

- (NSString *)thermostatValueText {
	NSString *thermostatValueText = [CSThermostatFormatter temperatureTextWithValue:self.thermostatValue forCelsiusScale:self.isCelsiusScale];
	
	return thermostatValueText;
}


#pragma mark - Public

- (void)updateWithThermostatViewModel:(CSThermostatViewModel *)thermostatViewModel {
	self.celsiusScale = thermostatViewModel.isCelsiusScale;
	self.hvacMode = thermostatViewModel.hvacMode;
	[self updateWithTemperatureRange:thermostatViewModel.selectedTemperatureRange];
	
	self.arcSlider.minValue = thermostatViewModel.minTemperature;
	self.arcSlider.maxValue = thermostatViewModel.maxTemperature;
	self.arcSlider.value = thermostatViewModel.selectedTemperature;

	[self thermostatDidChanged];
	
	self.leafImageView.image = [UIImage imageNamed:thermostatViewModel.hasLeaf ? @"LeafOn" : @"LeafOff"];
	self.fanImageView.image = [UIImage imageNamed:thermostatViewModel.isFunRunning ? @"FanOn" : @"FanOff"];
	self.backgroundImageView.image = CSThermostatBackgroundImageFromHVACState(thermostatViewModel.hvacState);

	self.ambientTemperatureLabel.text = [CSThermostatFormatter temperatureTextWithValue:thermostatViewModel.ambientTemperature
																		forCelsiusScale:self.isCelsiusScale];
}

- (void)updateWithTemperatureRange:(CGFloat)temperatureRange {
	self.selectedTemperatureRange = [CSThermostatFormatter temperatureRoundedValueWithValue:temperatureRange
																			forCelsiusScale:self.isCelsiusScale];
	self.arcSlider.range = self.selectedTemperatureRange;
}

- (void)applyThermostatSettings {
	if (self.hvacMode == CSThermostatHVACModeHeatAndCool) {
		[self.presenter didSelectTemperatureLow:self.thermostatValue - self.selectedTemperatureRange
										   high:self.thermostatValue + self.selectedTemperatureRange];
	} else {
		[self.presenter didSelectTemperature:self.thermostatValue];
	}
}

#pragma mark - Actions

- (IBAction)thermostatDidChanged {
	self.selectedTemperatureLabel.text = self.thermostatValueText;
}

- (IBAction)thermostatEditingDidEnd {
	[self applyThermostatSettings];
}

@end
