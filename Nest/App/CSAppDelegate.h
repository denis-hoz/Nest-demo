//
//  CSAppDelegate.h
//  Nest
//
//  Created by Denis Kapusta on 12/21/15.
//  Copyright © 2015 Appko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSAppConfiguration;

@interface CSAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) id<CSAppConfiguration> appConfiguration;

@end

