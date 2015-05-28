//
//  MMHUDNode.m
//  MathMarathon
//
//  Created by iOSx New on 5/28/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMHUDNode.h"
#import "SSKUtils.h"
CGFloat const kMoveAndFadeTime     = 1;
CGFloat const kMoveAndFadeDistance = 20;
CGFloat const kMaxBreathTimer = 6.0;

@implementation MMHUDNode

+(instancetype)NewHudNodeWithZPos:(NSUInteger)Zpos withScene:(SSKScene*)scene
{
    return [[self alloc] initWithZPos:Zpos withScene:scene];
}

-(instancetype)initWithZPos:(NSUInteger)Zpos withScene:(SSKScene *)scene
{
    self.parentScene = scene;
    self.node = [SKNode new];
    [self.node setZPosition:Zpos];
    [self.node setName:@"hud"];
    [self.node setAlpha:0];
    [self.node setPosition:CGPointMake(-kMoveAndFadeDistance, 0)];
    
    CGFloat padding = 5.0;
    
    NSString *fontName = @"AmericanTypewriter";
    //CGFloat fontSize = 12.0;
    
    self.scoreCounter = [SSKScoreNode scoreNodeWithFontNamed:fontName fontSize:20 fontColor:[SKColor whiteColor]];
    [self.scoreCounter setName:@"scoreCounter"];
    [self.scoreCounter setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self.scoreCounter setVerticalAlignmentMode:SKLabelVerticalAlignmentModeTop];
    [self.scoreCounter setPosition:CGPointMake(-scene.size.width/2 + padding, scene.size.height/2 - padding)];
    
    //    PPCoinNode *coinNode = [[PPCoinNode alloc] init];
    //    [coinNode setName:@"scoreCoin"];
    //    [coinNode setPosition:CGPointMake(self.size.width/2 - coinNode.size.width, self.size.height/2 - coinNode.size.height/2 - padding)];
    //    [self.hudNode addChild:coinNode];
    
    //    SSKScoreNode *coinCounter = [SSKScoreNode scoreNodeWithFontNamed:fontName fontSize:fontSize fontColor:[SKColor whiteColor]];
    //    [coinCounter setName:@"coinCounter"];
    //    [coinCounter setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    //    [coinCounter setVerticalAlignmentMode:SKLabelVerticalAlignmentModeTop];
    //    [coinCounter setPosition:CGPointMake(coinNode.position.x, coinNode.position.y - coinNode.size.height/2 - padding)];
    //    [coinCounter setScore:[[PPUserManager sharedManager] getTotalCoins].integerValue];
    //    [hudNode addChild:coinCounter];
    
    self.breathMeter = [[SSKProgressBarNode alloc] initWithFrameColor:[SKColor blackColor] barColor:[SKColor redColor] size:CGSizeMake(scene.size.width/2, 12.5) barType:BarTypeHorizontal];
    [self.breathMeter setName:@"progressBar"];
    [self.breathMeter setPosition:CGPointMake(0, scene.size.height/2 - self.breathMeter.size.height/2 - padding)];
    
    return self;
}

#pragma mark - main funtion
-(void)addNode
{
    [self.parentScene addChild:self.node];
    [self.node addChild:self.scoreCounter];
    [self.node addChild:self.breathMeter];
}

#pragma mark - fade animation

- (void)hudLayerFadeInAnimation {
    [self.node runAction:[SKAction moveDistance:CGVectorMake(kMoveAndFadeDistance, 0) fadeInWithDuration:kMoveAndFadeTime]];
}

- (void)hudLayerFadeOutAnimation {
    if (self.node) {
        [self.node runAction:[SKAction moveDistance:CGVectorMake(kMoveAndFadeDistance, 0) fadeOutWithDuration:kMoveAndFadeTime]];
    }
}

#pragma mark - Score Tracking
- (void)startScoreCounter {
    SKAction *timerDelay = [SKAction waitForDuration:.25];
    SKAction *incrementScore = [SKAction runBlock:^{
        [(SSKScoreNode*)[self.node childNodeWithName:@"scoreCounter"] increment];
    }];
    SKAction *sequence = [SKAction sequence:@[timerDelay,incrementScore]];
    [self.parentScene runAction:[SKAction repeatActionForever:sequence] withKey:@"scoreKey"];
}

- (void)stopScoreCounter {
    [self.parentScene removeActionForKey:@"scoreKey"];
}

#pragma mark - time count Meter
- (void)updateBreathMeter {
    CGFloat currentProgress = self.breathTimer/kMaxBreathTimer;
    SSKProgressBarNode *progressBar = (SSKProgressBarNode*)[self.node childNodeWithName:@"progressBar"];
    
    [progressBar setProgress:currentProgress];
    
    if (currentProgress < 0.30) {
        [progressBar startFlash];
    }
    else {
        [progressBar stopFlash];
    }
}

- (void)checkBreathMeterForGameOver {
    if ([(SSKProgressBarNode*)[self.node childNodeWithName:@"progressBar"] currentProgress] == 0.0) {
        //[self gameEnd];
    }
}
@end
