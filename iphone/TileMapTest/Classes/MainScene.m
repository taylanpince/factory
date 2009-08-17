//
//  MainScene.m
//  TileMapTest
//
//  Created by Taylan Pince on 10/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "MainScene.h"
#import "MainLayer.h"
#import "cocos2d.h"


@implementation MainScene

- (id)init {
	if (self == [super init]) {
		ColorLayer *background = [ColorLayer layerWithColor:ccc4(0xFF, 0xFF, 0xFF, 0xFF)];
		MainLayer *layer = [MainLayer node];
		
		[layer setAnchorPoint:CGPointZero];
		
		[self addChild:background z:0];
		[self addChild:layer z:1];
	}
	
	return self;
}

@end
