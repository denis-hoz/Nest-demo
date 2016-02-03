//
//  CSThermostatViewController.h
//  Nest
//
//  Created by Denis on 17.01.16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSThermostatView.h"

@protocol CSThermostatPresenter;

@interface CSThermostatViewController : UIViewController <CSThermostatView>

- (instancetype)initWithPresenter:(id <CSThermostatPresenter>)presenter;

@end
