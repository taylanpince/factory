//
//  Part.h
//  TileMapTest
//
//  Created by Taylan Pince on 12/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "AtlasSprite.h"
#import "AtlasSpriteManager.h"


@interface Part : AtlasSprite {
	NSUInteger gid;
}

@property (nonatomic, assign) NSUInteger gid;

- (id)initWithManager:(AtlasSpriteManager *)manager partID:(NSUInteger)partID;
- (void)updateGID:(id)sender withGID:(NSUInteger)partID;

@end
