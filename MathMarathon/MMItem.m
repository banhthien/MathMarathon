//
//  MMItem.m
//  MathMarathon
//
//  Created by Than Banh on 5/29/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMItem.h"
#import "MMSharedAssets.h"
@implementation MMItem
+ (instancetype)itemWithType:(ItemType)type
{
    return [[self alloc] initWithType:type];

}
- (instancetype)initWithType:(ItemType)type;
{
    SKTexture *texture = [self textureForItemType:type];
    
    self = [super initWithTexture:texture];
    return self;
}
#pragma mark - Iceberg Type
- (SKTexture*)textureForItemType:(ItemType)itemType {
    SKTexture *texture = nil;
    
    switch (itemType) {
        case ItemTypeBunusScore:
            //texture = [MMSharedAssets sharedIcebergGameTexture];
            break;
            
        case ItemTypeObstacleBothOfJumpDuck:
            //texture = [[MMSharedAssets sharedIcebergAtlas] textureNamed:@"iceberg_wide"];
            break;
        case ItemTypeObstacleCanDuck:
            //texture = [[MMSharedAssets sharedIcebergAtlas] textureNamed:@"iceberg_wide"];
            break;
        case ItemTypeObstacleCanJump:
           // texture = [[MMSharedAssets sharedIcebergAtlas] textureNamed:@"iceberg_wide"];
            break;
        default:
            break;
    }
    return texture;
}
- (void)update:(NSTimeInterval)dt
{
    
}
@end