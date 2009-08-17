//
//  Part.m
//  TileMapTest
//
//  Created by Taylan Pince on 12/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "Part.h"
#import "cocos2d.h"


@implementation Part

@synthesize gid;

- (id)initWithManager:(AtlasSpriteManager *)manager partID:(NSUInteger)partID {
	if (self == [super initWithRect:CGRectMake(partID * 26.0, 0.0, 24.0, 21.0) spriteManager:manager]) {
		gid = partID;
	}
	
	return self;
}

- (void)setGid:(NSUInteger)partID {
	if (partID != gid) {
		[self setTextureRect:CGRectMake(partID * 26.0, 0.0, 24.0, 21.0)];
		
		gid = partID;
	}
}

- (void)updateGID:(id)sender withGID:(NSUInteger)partID {
	[self setGid:partID];
}

@end
