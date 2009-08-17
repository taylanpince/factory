//
//  SpriteTestAppDelegate.m
//  Sprite Test
//
//  Created by Taylan Pince on 09/08/09.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import "SpriteTestAppDelegate.h"
#import "cocos2d.h"
#import "MainScene.h"


@implementation SpriteTestAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    [window setUserInteractionEnabled:YES];
    [window setMultipleTouchEnabled:YES];
	
	[[Director sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
    [[Director sharedDirector] attachInWindow:window];
	
    [window makeKeyAndVisible];	
	
	MainScene *scene = [MainScene node];
	[[Director sharedDirector] runWithScene:scene];
}


- (void)dealloc {
	[window release];
    [super dealloc];
}


@end
