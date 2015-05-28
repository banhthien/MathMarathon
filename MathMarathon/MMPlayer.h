//
//  MMPlayer.h
//  MathMarathon
//
//  Created by iOSx New on 5/28/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMSpriteAnimation.h"
typedef NS_ENUM(NSUInteger, PlayerType) {
    PlayerTypeGrey = 0,
    PlayerTypeBlack,
};

typedef NS_ENUM(NSUInteger, PlayerState) {
    PlayerStateIdle = 0,
    PlayerStateRun,
    PlayerStateJump,
    PlayerStateDucking,
    PlayerStateDie,
};
@interface MMPlayer : MMSpriteAnimation

@property (nonatomic) PlayerState playerState;
@property (nonatomic) PlayerType playerType;

@property (nonatomic) NSArray *idleTextures;
@property (nonatomic) NSArray *runTextures;
@property (nonatomic) NSArray *jumpTextures;
@property (nonatomic) NSArray *duckingTextures;
@property (nonatomic) NSArray *dieTextures;

+ (instancetype)playerWithType:(PlayerType)playerType atlas:(SKTextureAtlas*)atlas;
- (instancetype)initWithType:(PlayerType)playerType atlas:(SKTextureAtlas*)atlas;
- (void)update:(NSTimeInterval)dt;
@end
