//
//  TileMapTestAppDelegate.m
//  TileMapTest
//
//  Created by Taylan Pince on 10/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "TileMapTestAppDelegate.h"
#import "Director.h"
#import "MainScene.h"


@implementation TileMapTestAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    [window setUserInteractionEnabled:YES];
    [window setMultipleTouchEnabled:YES];
	
	[[Director sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
    [[Director sharedDirector] attachInWindow:window];
	
    [window makeKeyAndVisible];	
	
	MainScene *scene = [MainScene node];
	
	[[Director sharedDirector] set2Dprojection];
	[[Director sharedDirector] runWithScene:scene];
}


- (void)dealloc {
	[window release];
    [super dealloc];
}

@end
