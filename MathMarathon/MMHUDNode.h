//
//  MMHUDNode.h
//  MathMarathon
//
//  Created by iOSx New on 5/28/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SSKScene.h"
#import "SSKScoreNode.h"
#import "SSKProgressBarNode.h"
@interface MMHUDNode : SKNode

@property (nonatomic) SSKScene *parentScene;
@property (nonatomic) SSKScoreNode *scoreCounter;
@property (nonatomic) SSKProgressBarNode *breathMeter;
@property (nonatomic) CGFloat breathTimer;

- (void)initWithZPos:(NSUInteger)Zpos withScene:(SSKScene*)scene;
- (void)hudLayerFadeInAnimation;
- (void)hudLayerFadeOutAnimation;
- (void)addNode;
- (void)stopScoreCounter;
-(void)addScore;
- (void)saveCoins;
@end
