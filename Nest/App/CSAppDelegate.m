//
//  CSAppDelegate.m
//  Nest
//
//  Created by Denis Kapusta on 12/21/15.
//  Copyright © 2015 Appko. All rights reserved.
//

#import "CSAppDelegate.h"
#import "CSAppConfiguration.h"

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = [self.appConfiguration rootViewController];
	[self.window makeKeyAndVisible];

	return YES;
}

@end
