//
//  WKAppDelegate.m
//  wckiev-api2
//
//  Created by Sergey Moskalenko on 05.03.13.
//  Skype:camopu-ympo
//  mob: +380677629137
//  Copyright (c) 2013 Home. All rights reserved.
//
// http://camopu.rhorse.ru/wckiev.php

#import "WKAppDelegate.h"

@implementation WKAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIView* view = [[UIView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:view];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 200, 30);
    [button setTitle:@"Get WCKIEV info" forState:UIControlStateNormal];
    button.center = view.center;
    [button addTarget:self action:@selector(getInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    return YES;
}

- (void)getInfo2
{
//    NSURL* url = [NSURL URLWithString:@"wckiev://run/#location=50.45,30.57&zoom=13&comfort=0"];
    NSString* myselfUrlString = [@"wckievapi2://run/#" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"wckiev://list/#location=50.45,30.57&zoom=13&comfort=0&sender=%@", myselfUrlString]];

    if ([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/ru/app/wc-kiev/id516140318?mt=8"]];
}

- (void)getInfo
{
    //    NSURL* url = [NSURL URLWithString:@"wckiev://run/#location=50.45,30.57&zoom=13&comfort=0"];
    NSString* myselfUrlString = [@"wckievapi2://run/#" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"wckiev://detail/#item=500&sender=%@", myselfUrlString]]; // 201
    [[UIApplication sharedApplication] openURL:url];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation 
{
    NSString* itemsString = @"Nothing";
    NSArray* parts = [[url absoluteString] componentsSeparatedByString:@"="];
    
    if (parts.count > 1)
        itemsString = [parts objectAtIndex:1];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:itemsString
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    
    return YES;
}
	

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
