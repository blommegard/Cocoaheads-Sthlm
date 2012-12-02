//
//  WRPAppDelegate.m
//  Cocoaheads-Debugging
//
//  Created by Simon Blommegård on 2012-11-26.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import "WRPAppDelegate.h"
#import "SBAPNSPusher.h"

@implementation WRPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [SBAPNSPusher start];

  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {}

@end
