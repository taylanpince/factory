//
//  FactoryAppDelegate.h
//  Factory
//
//  Created by Taylan Pince on 31/07/09.
//  Copyright Hippo Foundry 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface FactoryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

