//
//  MainLayer.m
//  TileMapTest
//
//  Created by Taylan Pince on 10/08/09.
//  Copyright 2009 Hippo Foundry. All rights reserved.
//

#import "MainLayer.h"
#import "cocos2d.h"
#import "chipmunk.h"
#import "Part.h"


void updateShape(void* ptr, void* unused){
	cpShape *shape = (cpShape *)ptr;
	Sprite *sprite = shape->data;
	
	if (sprite && [sprite numberOfRunningActions] == 0) {
		cpBody *body = shape->body;
		
		[sprite setPosition:cpv(body->p.x, body->p.y)];
	}
}

static int partCollision(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) {
	NSLog(@"COLLISION");
	
	return 0;
}

static int fillerCollision(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) {
	Part *sprite = a->data;

	if (sprite && [sprite numberOfRunningActions] == 0 && [sprite gid] != 1) {
		a->body->v = cpv(0, 0);
		
		id sequence = [Sequence actions:
					   [MoveTo actionWithDuration:0.5 position:ccp(sprite.position.x, sprite.position.y + 2)], 
					   [DelayTime actionWithDuration:0.5], 
					   [CallFunc actionWithTarget:[[sprite parent] parent] selector:@selector(animateFiller)],
					   [DelayTime actionWithDuration:0.5], 
					   [CallFuncND actionWithTarget:sprite selector:@selector(updateGID:withGID:) data:(void *)1], 
					   [DelayTime actionWithDuration:0.5], 
					   [MoveTo actionWithDuration:0.5 position:ccp(sprite.position.x, sprite.position.y)], 
					   [DelayTime actionWithDuration:0.5], 
					   [CallFuncND actionWithTarget:[[sprite parent] parent] selector:@selector(moveNode:withShape:) data:(void *)a], 
					   nil];
		
		[sprite runAction:sequence];
	}
	
	return 0;
}

static int capperCollision(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) {
	Part *sprite = a->data;
	
	if (sprite && [sprite numberOfRunningActions] == 0 && [sprite gid] != 2) {
		a->body->v = cpv(0, 0);
		
		id sequence = [Sequence actions:
					   [MoveTo actionWithDuration:0.5 position:ccp(sprite.position.x, sprite.position.y + 2)], 
					   [DelayTime actionWithDuration:0.5], 
					   [CallFunc actionWithTarget:[[sprite parent] parent] selector:@selector(animateCapper)],
					   [DelayTime actionWithDuration:0.5], 
					   [CallFuncND actionWithTarget:sprite selector:@selector(updateGID:withGID:) data:(void *)2], 
					   [DelayTime actionWithDuration:0.5], 
					   [MoveTo actionWithDuration:0.5 position:ccp(sprite.position.x, sprite.position.y)], 
					   [DelayTime actionWithDuration:0.5], 
					   [CallFuncND actionWithTarget:[[sprite parent] parent] selector:@selector(moveNode:withShape:) data:(void *)a], 
					   nil];
		
		[sprite runAction:sequence];
	}
	
	return 0;
}

static int labelerCollision(cpShape *a, cpShape *b, cpContact *contacts, int numContacts, cpFloat normal_coef, void *data) {
	Part *sprite = a->data;
	
	if (sprite && [sprite gid] != 3) {
		[sprite setGid:3];
	}
	
	return 0;
}


@implementation MainLayer

@synthesize map, frames, game, animations;

- (id)init {
	if (self == [super init]) {
		isTouchEnabled = YES;
		
		map = [[TMXTiledMap tiledMapWithTMXFile:@"level3.tmx"] retain];
		frames = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Sprites" ofType:@"plist"]] retain];
		game = [[AtlasSpriteManager alloc] initWithFile:@"december.png" capacity:10];
		animations = [[AtlasSpriteManager alloc] initWithFile:@"fillers.png" capacity:10];
		
		[map setPosition:CGPointMake(0.0, -200.0)];
		
		[self addChild:map z:2];
		[self addChild:game z:0];
		[self addChild:animations z:1];
		
		cpInitChipmunk();
		
		space = cpSpaceNew();
		space->gravity = cpv(0, -2000);
		space->elasticIterations = 0;
		
		TMXLayer *layer = [map layerNamed:@"Level"];
		CGSize layerSize = [layer layerSize];
		
		for (int y = 0; y < layerSize.height; y++) {
			for (int x = 0; x < layerSize.width; x++) {
				unsigned int gid = [layer tileGIDAt:ccp(x, y)];

				if (gid > 0 && gid <= 100) {
					NSLog(@"GID %d at %d, %d", gid, (x * 40), (320 - y * 40));
					cpBody *beltBody = cpBodyNew(INFINITY, INFINITY);
					beltBody->p = cpv(0, 0);
					
					cpShape *beltShape = cpSegmentShapeNew(beltBody, cpv(y * 40, x * 40), cpv(y * 40 + 40, x * 40), 0);
					beltShape->e = 0.0;
					beltShape->u = 0.0;
					beltShape->collision_type = 0;
					
					cpSpaceAddStaticShape(space, beltShape);
				}
			}
		}
		
		[self schedule:@selector(animateTiles:) interval:0.075f];
		
		cpBody *fillerBody = cpBodyNew(INFINITY, INFINITY);
		fillerBody->p = cpv(295, 175);
		
		cpShape *fillerShape = cpCircleShapeNew(fillerBody, 0.1, cpvzero);
		fillerShape->collision_type = 3;
		
		cpSpaceAddStaticShape(space, fillerShape);
		cpSpaceAddCollisionPairFunc(space, 1, 3, &fillerCollision, self);
		
		cpBody *capperBody = cpBodyNew(INFINITY, INFINITY);
		capperBody->p = cpv(215, 175);
		
		cpShape *capperShape = cpCircleShapeNew(capperBody, 0.1, cpvzero);
		capperShape->collision_type = 4;
		
		cpSpaceAddStaticShape(space, capperShape);
		cpSpaceAddCollisionPairFunc(space, 1, 4, &capperCollision, self);
		
		cpBody *labelerBody = cpBodyNew(INFINITY, INFINITY);
		labelerBody->p = cpv(135, 175);
		
		cpShape *labelerShape = cpCircleShapeNew(labelerBody, 0.1, cpvzero);
		labelerShape->collision_type = 5;
		
		cpSpaceAddStaticShape(space, labelerShape);
		cpSpaceAddCollisionPairFunc(space, 1, 5, &labelerCollision, self);
		
		[self schedule:@selector(animatePhysics:) interval:1.0f/60.0f];
		[self schedule:@selector(addPart:) interval:5.0f];
	}
	
	return self;
}

- (void)animateFiller {
	AtlasSprite *sprite = [AtlasSprite spriteWithRect:CGRectMake(2, 2, 40, 40) spriteManager:animations];
	AtlasAnimation *animation = [AtlasAnimation animationWithName:@"fillerAnimation" delay:0.1];
	
	for (int i = 1; i < 8; i++) {
		[animation addFrameWithRect:CGRectMake(i * 42 + 2, 2, 40, 40)];
	}
	
	[animations addChild:sprite];
	
	[sprite setPosition:ccp(7.5 * 40.0, 4.9 * 40.0)];
	[sprite runAction:[Sequence actions:
					   [Animate actionWithAnimation:animation], 
					   [DelayTime actionWithDuration:0.5], 
					   [CallFuncND actionWithTarget:self selector:@selector(removeAnimationTile:forSprite:) data:(void *)sprite], 
					   nil]];
}

- (void)animateCapper {
	AtlasSprite *sprite = [AtlasSprite spriteWithRect:CGRectMake(2, 44, 40, 40) spriteManager:animations];
	AtlasAnimation *animation = [AtlasAnimation animationWithName:@"solidAnimation" delay:0.1];
	
	for (int i = 1; i < 8; i++) {
		[animation addFrameWithRect:CGRectMake(i * 42 + 2, 44, 40, 40)];
	}
	
	[animations addChild:sprite];
	
	[sprite setPosition:ccp(5.5 * 40.0, 4.5 * 40.0)];
	[sprite runAction:[Sequence actions:
					   [Animate actionWithAnimation:animation], 
					   [DelayTime actionWithDuration:0.5], 
					   [CallFuncND actionWithTarget:self selector:@selector(removeAnimationTile:forSprite:) data:(void *)sprite], 
					   nil]];
}

- (void)removeAnimationTile:(id)sender forSprite:(AtlasSprite *)sprite {
	[animations removeChild:sprite cleanup:YES];
}

- (void)animatePhysics:(ccTime)dt {
	cpSpaceStep(space, 1.0f/60.0f);
	cpSpaceHashEach(space->activeShapes, &updateShape, nil);
}

- (void)moveNode:(id)sender withShape:(cpShape *)shape {
	shape->body->v = cpv(-15, 0);
}

- (void)addPart:(ccTime)dt {
	Part *partSprite = [[[Part alloc] initWithManager:game partID:0] autorelease];
	[partSprite setPosition:ccp(150.0, 400.0)];
	[game addChild:partSprite];
	
	int corners = 4;
	cpVect vertices[] = {
		cpv(-5, 6.5),
		cpv(4, 6.5),
		cpv(4, -10.5),
		cpv(-5, -10.5),
	};
	
	cpBody *partBody = cpBodyNew(200.0, INFINITY);
	partBody->p = cpv(425, 320);
	partBody->v = cpv(-15, 0);
	
	cpSpaceAddBody(space, partBody);
	
//	cpShape *partShape = cpCircleShapeNew(partBody, 20.0, cpvzero);
	cpShape *partShape = cpPolyShapeNew(partBody, corners, vertices, cpvzero);
	partShape->e = 0.0;
	partShape->u = 0.0;
	partShape->data = partSprite;
	partShape->collision_type = 1;
	
	cpSpaceAddShape(space, partShape);
	cpSpaceAddCollisionPairFunc(space, 1, 1, &partCollision, self);
}

- (void)animateTiles:(ccTime)dt {
	TMXLayer *layer = [map layerNamed:@"Level"];
	CGSize layerSize = [layer layerSize];

	for (int y = 0; y < layerSize.height; y++) {
		for (int x = 0; x < layerSize.width; x++) {
			unsigned int gid = [layer tileGIDAt:ccp(x, y)];

			if ([[frames allKeys] containsObject:[NSString stringWithFormat:@"%d", gid]]) {
				[layer setTileGID:[[frames objectForKey:[NSString stringWithFormat:@"%d", gid]] intValue] at:ccp(x, y)];
			}
		}
	}
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    
	NSLog(@"Touched: %d", [[map layerNamed:@"Level"] tileGIDAt:ccp((int)floor(location.y / 40), (int)floor((320 - location.x) / 40))]);
	
	return kEventHandled;
}

- (void)dealloc {
	[map dealloc];
	[game dealloc];
	[animations dealloc];
	[frames dealloc];
	[super dealloc];
}

@end
