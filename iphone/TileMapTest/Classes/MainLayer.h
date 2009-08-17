//
//  MainLayer.h
//  TileMapTest
//
//  Created by Taylan Pince on 10/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "Layer.h"
#import "TMXTiledMap.h"
#import "AtlasSpriteManager.h"
#import "chipmunk.h"


@interface MainLayer : Layer {
	TMXTiledMap *map;
	NSDictionary *frames;
	cpSpace *space;
	AtlasSpriteManager *game;
	AtlasSpriteManager *animations;
}

@property (nonatomic, retain) TMXTiledMap *map;
@property (nonatomic, retain) NSDictionary *frames;
@property (nonatomic, retain) AtlasSpriteManager *game;
@property (nonatomic, retain) AtlasSpriteManager *animations;

@end
