
//
//  MMObjectInRow.m
//  MathMarathon
//
//  Created by iOSx New on 6/1/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMObjectInRow.h"
#import "MMPlayer.h"
#import "SSKUtils.h"
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
    self.size=size;
    if(type == RowTypeItem){
    MMItem *itemOne = [self itemWithType:[self random] withPos:CGPointMake((self.size.width/5)-self.size.width/2, self.size.height/2)];
    [self addChild:itemOne];
    MMItem *itemTwo = [self itemWithType:[self random] withPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5, self.size.height/2)];
    [self addChild:itemTwo];
    MMItem *itemThree = [self itemWithType:[self random] withPos:CGPointMake((size.width/5)-size.width/2 +size.width/5+size.width/5, size.height/2) ];
    [self addChild:itemThree];
    MMItem *itemFour = [self itemWithType:[self random] withPos:CGPointMake((size.width/5)-size.width/2 +size.width/5+size.width/5+size.width/5, size.height/2)];
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
-(MMItem*)itemWithType:(ItemType)type withPos:(CGPoint)pos
{
    MMItem *item = [MMItem itemWithType:type];
    [item setPosition:pos];
    [item setName:@"item"];
    [item setSize:CGSizeMake(self.size.width/5, 30)];
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

#pragma mark - Check Intersect
-(void)checkItemDidIntersectWithPlayer:(MMPlayer*)player
{
    [self enumerateChildNodesWithName:@"item" usingBlock:^(SKNode *node, BOOL *stop) {
        MMItem *item = (MMItem*)node;
        if (CGRectIntersectsRect(player.frame, item.frame)) {
            switch (item.type) {
                case ItemTypeObstacleCanDuck:
                    NSLog(@"dung thang co the cui xuong");
                    break;
                case ItemTypeObstacleCanJump:
                    NSLog(@"dung thang co the nhay len");
                    break;
                default:
                    break;
            }
        }
    }];
}

-(void)moveRowItem{
    [self enumerateChildNodesWithName:@"item" usingBlock:^(SKNode *node, BOOL *stop) {
        [node runAction:[SKAction moveToY:-self.size.height duration:4 ] withKey:@"moveObstacle" completion:^
         {
             [self removeFromParent];
         }];
    }];
    
}
@end
