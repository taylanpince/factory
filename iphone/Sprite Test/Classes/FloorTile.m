//
//  FloorTile.m
//  Sprite Test
//
//  Created by Taylan Pince on 09/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "FloorTile.h"
#import "cocos2d.h"


@implementation FloorTile

- (id) initWithID:(NSUInteger)identifier row:(NSUInteger)row column:(NSUInteger)column {
	if (self == [super initWithFile:@"floor.png" capacity:2]) {
		AtlasSprite *sprite = [AtlasSprite spriteWithRect:CGRectMake(0, identifier * 40, 40, 40) spriteManager:self];
		AtlasAnimation *animation = [AtlasAnimation animationWithName:@"anim" delay:0.25];
		
		[animation addFrameWithRect:CGRectMake(0, identifier * 40, 40, 40)];
		[animation addFrameWithRect:CGRectMake(40, identifier * 40, 40, 40)];
		
		[self addChild:sprite];
		
		[sprite setPosition:ccp(column * 40 + 20, row * 40 + 20)];
		[sprite runAction:[RepeatForever actionWithAction:[Animate actionWithAnimation:animation]]];
	}
	
	return self;
}

@end
