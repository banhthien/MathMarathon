//
//  MMItem.h
//  MathMarathon
//
//  Created by Than Banh on 5/29/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMSpriteAnimation.h"

@interface MMItem : MMSpriteAnimation
typedef NS_ENUM(NSUInteger, ItemType) {
    ItemTypeBunusScore = 0,
    ItemTypeObstacleCanJump = 1,
    ItemTypeObstacleCanDuck = 2,
    ItemTypeObstacleBothOfJumpDuck = 3,
};
@property (nonatomic) ItemType type;
@property (nonatomic) NSArray* bonusItem;
+ (instancetype)itemWithType:(ItemType)type;
- (instancetype)initWithType:(ItemType)type;
- (void)update:(NSTimeInterval)dt;
- (void)spinCoinAnimation;
@end
