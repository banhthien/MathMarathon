
//
//  MMObjectInRow.m
//  MathMarathon
//
//  Created by iOSx New on 6/1/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMObjectInRow.h"
typedef NS_ENUM(NSUInteger, SceneLayer)
{
    SceneLayerBackground = 0,
    SceneLayerRoad=1,
    SceneLayerItemDown=4,
    SceneLayerPlayer=3,
    SceneLayerItemUp=2,
    
};


@implementation MMObjectInRow
-(void)createItemInRowWithSize:(CGSize)size withType:(RowType)type
{
    if(type == RowTypeItem){
    MMItem *itemOne = [self itemWithType:[self random] withPos:CGPointMake((size.width/5)-size.width/2, size.height/2) withSize:size];
    [self addChild:itemOne];
    MMItem *itemTwo = [self itemWithType:[self random] withPos:CGPointMake((size.width/5)-size.width/2 +size.width/5, size.height/2) withSize:size];
    [self addChild:itemTwo];
    MMItem *itemThree = [self itemWithType:[self random] withPos:CGPointMake((size.width/5)-size.width/2 +size.width/5+size.width/5, size.height/2) withSize:size];
    [self addChild:itemThree];
    MMItem *itemFour = [self itemWithType:[self random] withPos:CGPointMake((size.width/5)-size.width/2 +size.width/5+size.width/5+size.width/5, size.height/2) withSize:size];
    [self addChild:itemFour];
    }
    else
    {
        
    }
}

-(NSUInteger)random
{
    return ((arc4random()%2)+1);
}
-(MMItem*)itemWithType:(ItemType)type withPos:(CGPoint)pos withSize:(CGSize)size
{
    MMItem *item = [MMItem itemWithType:type];
    [item setPosition:pos];
    [item setName:@"item"];
    [item setSize:CGSizeMake(size.width/5, 30)];
    switch (type) {
        case ItemTypeObstacleCanDuck:
            [item setZPosition:SceneLayerItemDown];
            
            break;
        case ItemTypeObstacleCanJump:
            [item setZPosition:SceneLayerItemUp];
            break;
        case ItemTypeObstacleBothOfJumpDuck:
            [item setZPosition:SceneLayerItemUp];
            break;
        case ItemTypeBunusScore:
            [item setZPosition:SceneLayerItemUp];
            break;
        default:
            break;
    }
    return item;
}

@end
