//
//  MMPlayer.m
//  MathMarathon
//
//  Created by iOSx New on 5/28/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMPlayer.h"
#import "SSKGraphicsUtils.h"

CGFloat const kIdleFrames = 2;
CGFloat const kSwimFrames = 4;
CGFloat const kFlyFrames = 2;
CGFloat const kDiveFrames = 1;

CGFloat const kAnimationSpeed = 0.05;
CGFloat const kIdleAnimationSpeed = 0.25;

@implementation MMPlayer
+ (instancetype)playerWithType:(PlayerType)playerType atlas:(SKTextureAtlas*)atlas {
    return [[self alloc] initWithType:playerType atlas:atlas];
}

- (instancetype)initWithType:(PlayerType)playerType atlas:(SKTextureAtlas*)atlas {
    self.playerType = playerType;
    NSString *initialTexture = [NSString stringWithFormat:@"penguin_%@_idle_00",[self playerTypeStringVal:playerType]];
    
    self = [super initWithTexture:[atlas textureNamed:initialTexture]];
    if (self) {
        //Idle
        NSString *baseIdleString = [NSString stringWithFormat:@"penguin_%@_idle_",[self playerTypeStringVal:self.playerType]];
        self.idleTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseIdleString frameCount:kIdleFrames];
        
        //Dive
        NSString *baseRunString = [NSString stringWithFormat:@"penguin_%@_dive_",[self playerTypeStringVal:self.playerType]];
        self.runTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseRunString frameCount:kDiveFrames];
        
        //Swim
        NSString *baseJumpString = [NSString stringWithFormat:@"penguin_%@_swim_",[self playerTypeStringVal:self.playerType]];
        self.jumpTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseJumpString frameCount:kSwimFrames];
        
        //Fly
        NSString *baseDuckingString = [NSString stringWithFormat:@"penguin_%@_fly_",[self playerTypeStringVal:self.playerType]];
        self.duckingTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseDuckingString frameCount:kFlyFrames];
        
        NSString *baseDieString = [NSString stringWithFormat:@"penguin_%@_fly_",[self playerTypeStringVal:self.playerType]];
        self.dieTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseDieString frameCount:kFlyFrames];
    }
    
    return self;
}
- (void)update:(NSTimeInterval)dt
{
    //Animation
    switch (self.playerState) {
        case PlayerStateIdle:
            [self runAnimationWithTextures:self.idleTextures speed:kIdleAnimationSpeed key:@"playerIdle" withTimes:0];
            break;
            
        case PlayerStateRun:
            [self runAnimationWithTextures:self.runTextures speed:kAnimationSpeed key:@"playerRun" withTimes:0];
            break;
            
        case PlayerStateJump:
            [self runAnimationWithTextures:self.jumpTextures speed:kAnimationSpeed key:@"playerJump" withTimes:0];
            break;
            
        case PlayerStateDucking:
            [self runAnimationWithTextures:self.duckingTextures speed:kAnimationSpeed key:@"playerDucking" withTimes:0];
            break;
        case PlayerStateDie:
            [self runAnimationWithTextures:self.dieTextures speed:kAnimationSpeed key:@"playerDie" withTimes:1];
            break;
        default:
            break;
    }

}
#pragma mark - Player Type String Parsing
- (NSString*)playerTypeStringVal:(PlayerType)playerType {
    
    NSString *type = nil;
    
    switch (playerType) {
        case PlayerTypeGrey:
            type = @"grey";
            break;
            
        case PlayerTypeBlack:
            type = @"black";
            break;
            
        default:
            type = @"";
            NSLog(@"Player Type not recognized");
            break;
    }
    return type;
}
@end
