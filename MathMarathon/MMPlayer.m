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
CGFloat const kRunFrames = 2;
CGFloat const kJumpFrames = 2;
CGFloat const kDuckFrames = 2;
CGFloat const kDieFrames = 2;

CGFloat const kAnimationSpeed = 0.1;
CGFloat const kIdleAnimationSpeed = 0.25;

@implementation MMPlayer
+ (instancetype)playerWithType:(PlayerType)playerType atlas:(SKTextureAtlas*)atlas {
    return [[self alloc] initWithType:playerType atlas:atlas];
}

- (instancetype)initWithType:(PlayerType)playerType atlas:(SKTextureAtlas*)atlas {
    self.playerType = playerType;
    self.inAction = FALSE;
    NSString *initialTexture = [NSString stringWithFormat:@"player_%@_idle_00",[self playerTypeStringVal:playerType]];
    
    self = [super initWithTexture:[atlas textureNamed:initialTexture]];
    if (self) {
        //Idle
        NSString *baseIdleString = [NSString stringWithFormat:@"player_%@_idle_",[self playerTypeStringVal:self.playerType]];
        self.idleTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseIdleString frameCount:kIdleFrames];
        
        //Run
        NSString *baseRunString = [NSString stringWithFormat:@"player_%@_run_",[self playerTypeStringVal:self.playerType]];
        self.runTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseRunString frameCount:kRunFrames];
        
        //Jump
        NSString *baseJumpString = [NSString stringWithFormat:@"player_%@_jump_",[self playerTypeStringVal:self.playerType]];
        self.jumpTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseJumpString frameCount:kJumpFrames];
        
        //Duck
        NSString *baseDuckingString = [NSString stringWithFormat:@"player_%@_duck_",[self playerTypeStringVal:self.playerType]];
        self.duckingTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseDuckingString frameCount:kDuckFrames];
        
        //Die
        NSString *baseDieString = [NSString stringWithFormat:@"player_%@_die_",[self playerTypeStringVal:self.playerType]];
        self.dieTextures = [SSKGraphicsUtils loadFramesFromAtlas:atlas baseFileName:baseDieString frameCount:kDieFrames];
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
#pragma mark - Move Action
-(void)moveRightWithSize:(CGSize)size
{
    self.inAction=TRUE;
    [self runAction:[SKAction moveByX:(size.width/5) y:0 duration:0.5] completion:^{
        self.inAction = FALSE;
    }];
}

-(void)moveLeftWithSize:(CGSize)size
{
    self.inAction=TRUE;
    [self runAction:[SKAction moveByX:-(size.width/5) y:0 duration:0.5] completion:^{
        self.inAction = FALSE;
    }];
}

-(void)jump
{
    
}

-(void)duck
{
    
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
