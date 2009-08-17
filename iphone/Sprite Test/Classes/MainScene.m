//
//  MainScene.m
//  Sprite Test
//
//  Created by Taylan Pince on 09/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "MainScene.h"
#import "cocos2d.h"
#import "FloorTile.h"


@implementation MainScene

- (id) init {
	if (self == [super init]) {
		ColorLayer *background = [ColorLayer layerWithColor:ccc4(0xFF, 0xFF, 0xFF, 0xFF)];
		Layer *floor = [Layer node];
//		Sprite *truck = [Sprite spriteWithFile:@"1018.png"];
//		
//		[truck setPosition:ccp(20, 20)];
//		[floor addChild:truck];
		
		[floor addChild:[[[FloorTile alloc] initWithID:1 row:3 column:0] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:0 row:3 column:1] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:0 row:3 column:2] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:0 row:3 column:3] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:0 row:3 column:4] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:0 row:3 column:5] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:0 row:3 column:6] autorelease]];
		[floor addChild:[[[FloorTile alloc] initWithID:2 row:3 column:7] autorelease]];
		
		[self addChild:background z:0];
		[self addChild:floor z:1];
	}
	
	return self;
}

@end
