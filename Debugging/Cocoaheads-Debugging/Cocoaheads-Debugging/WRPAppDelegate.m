//
//  WRPAppDelegate.m
//  Cocoaheads-Debugging
//
//  Created by Simon Blommegård on 2012-11-26.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import "WRPAppDelegate.h"
#import "SBAPNSPusher.h"
#import <PonyDebugger/PonyDebugger.h>
#import "WRPViewController.h"

@implementation WRPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = [WRPViewController new];
  
  // Core Data
  [MagicalRecord setupCoreDataStack];
  
  // PonyDebugger
  PDDebugger *debugger = [PDDebugger defaultInstance];
  
  [debugger enableViewHierarchyDebugging];
  [debugger setDisplayedViewAttributeKeyPaths:@[@"frame", @"hidden", @"alpha", @"opaque"]];

  [debugger enableCoreDataDebugging];
  [debugger addManagedObjectContext:[NSManagedObjectContext MR_defaultContext] withName:@"MOC"];

  [debugger enableNetworkTrafficDebugging];
  [debugger forwardAllNetworkTraffic];
  
  [debugger connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
  

  // Push
  [SBAPNSPusher start];
  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
  
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  [[NSManagedObjectContext MR_defaultContext] MR_saveNestedContexts];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [[NSManagedObjectContext MR_defaultContext] MR_saveNestedContexts];
  [MagicalRecord cleanUp];
}

@end
