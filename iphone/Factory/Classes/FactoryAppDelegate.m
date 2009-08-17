//
//  FactoryAppDelegate.m
//  Factory
//
//  Created by Taylan Pince on 31/07/09.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import "FactoryAppDelegate.h"
#import "EAGLView.h"

@implementation FactoryAppDelegate

@synthesize window;
@synthesize glView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	glView.animationInterval = 1.0 / 60.0;
	[glView startAnimation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 5.0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 60.0;
}


- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}

@end
