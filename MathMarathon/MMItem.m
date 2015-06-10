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
    return [[self alloc] initWithTypes:type];

}

- (instancetype)initWithTypes:(ItemType)type;
{
    SKTexture *texture = [self textureForItemType:type];
    self = [super initWithTexture:texture];
    self.type= type;
    return self;
}

#pragma mark - Item Type
- (SKTexture*)textureForItemType:(ItemType)itemType {
    SKTexture *texture = nil;
    
    switch (itemType) {
        case ItemTypeBunusScore:
            self.bonusItem = [MMSharedAssets sharedCoinTextures];
            texture = [[MMSharedAssets sharedCoinAtlas] textureNamed:@"coin_00"];
            break;
            
        case ItemTypeObstacleBothOfJumpDuck:
            //texture = [[MMSharedAssets sharedIcebergAtlas] textureNamed:@"iceberg_wide"];
            break;
        case ItemTypeObstacleCanDuck:
            texture = [MMSharedAssets sharedItemDown];
            break;
        case ItemTypeObstacleCanJump:
            texture = [MMSharedAssets sharedItemUp];
            break;
        default:
            break;
    }
    return texture;
}

-(void)spinCoinAnimation
{
    if ([self actionForKey:@"spinCoin"]) {
        NSLog(@"da ton tai spinCoin");
        return;
    }
    SKAction *animation = [SKAction animateWithTextures:self.bonusItem timePerFrame:0.1];
    [self runAction:[SKAction repeatActionForever:animation] withKey:@"spinCoin"];
}

-(void)moveItemActionWithY:(CGPoint)pos
{
    SKAction *move = [SKAction moveTo:pos duration:5.5 ];
    //move.timingMode = SKActionTimingEaseIn;
    move.timingFunction = ^float(float t){
        return t*t;
    };
    [self runAction:move withKey:@"moveObstacle" completion:^
     {
         [self removeFromParent];
     }];
}

-(CGFloat)timingFunc:(CGFloat)time
{
    return time;
}

-(void)scaleMoveAction
{
    SKAction *animation = [SKAction scaleTo:9 duration:5.5];
    animation.timingFunction=^float(float t){
        return t*t;
    };
    [self runAction:animation withKey:@"scaleItem"];
}

- (void)update:(NSTimeInterval)dt
{
    
}
@end
