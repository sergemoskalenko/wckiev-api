//
//  WKAppDelegate.m
//  wckiev-app3
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
@synthesize view;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [UIViewController new]; // fix for iOS9, Xcode 7.3
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.view = [[UIView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:view];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 200, 30);
    [button setTitle:@"Get WCKIEV info" forState:UIControlStateNormal];
    button.center = self.view.center;
    [button addTarget:self action:@selector(getInfo) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 777;
    
    [self.view addSubview:button];
    
    return YES;
}


- (void)getInfo
{
    NSString* myselfUrlString = [@"wckievapi3://run/#" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"wckiev://list/#location=50.45,30.57&zoom=13&comfort=0&sender=%@", myselfUrlString]];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/ru/app/wc-kiev/id516140318?mt=8"]];
}

- (void)getItemInfo:(UIButton *)button
{
    int itemId = button.tag;
    
    //    NSURL* url = [NSURL URLWithString:@"wckiev://run/#location=50.45,30.57&zoom=13&comfort=0"];
    NSString* myselfUrlString = [@"wckievapi3://run/#" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"wckiev://detail/#item=%d&sender=%@", itemId, myselfUrlString]]; 
    [[UIApplication sharedApplication] openURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation 
{
    if (![self.view viewWithTag:777])
        return YES;
    
    NSString* itemsString = @"";
    NSArray* parts = [[url absoluteString] componentsSeparatedByString:@"="];
    
    if (parts.count > 1)
    {
        [[self.view viewWithTag:777] removeFromSuperview];
        
        itemsString = [parts objectAtIndex:1];
        
        float buttonTop = 60;
        
        NSArray* items = [itemsString componentsSeparatedByString:@","];
        for (NSString* item in items)
        {
            int itemId = [item intValue];
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(0, 0, 200, 30);
            [button setTitle:[NSString stringWithFormat:@"Item %@", item] forState:UIControlStateNormal];
            button.center = CGPointMake(self.view.center.x, buttonTop);
            buttonTop += 50;
            [button addTarget:self action:@selector(getItemInfo:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = itemId;
            [self.view addSubview:button];
            
            if (buttonTop > self.view.bounds.size.height - 30)
                break;
        }
    }
    
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
