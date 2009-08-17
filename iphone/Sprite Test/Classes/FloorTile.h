//
//  FloorTile.h
//  Sprite Test
//
//  Created by Taylan Pince on 09/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "cocos2d.h"


@interface FloorTile : AtlasSpriteManager {
	
}

- (id) initWithID:(NSUInteger)identifier row:(NSUInteger)row column:(NSUInteger)column;

@end
