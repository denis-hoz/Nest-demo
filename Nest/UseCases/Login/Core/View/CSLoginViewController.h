//
//  CSLoginViewController.h
//  Nest
//
//  Created by Denis Kapusta on 1/16/16.
//  Copyright © 2016 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLoginView.h"

@protocol CSLoginPresenter;

@interface CSLoginViewController : UIViewController <CSLoginView>

- (instancetype)initWithPresenter:(id <CSLoginPresenter>)presenter application:(UIApplication *)application;

@end
