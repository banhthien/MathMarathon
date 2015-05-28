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
@interface MMHUDNode : NSObject

@property (nonatomic) SKNode *node;
@property (nonatomic) SSKScene *parentScene;
@property (nonatomic) SSKScoreNode *scoreCounter;
@property (nonatomic) SSKProgressBarNode *breathMeter;

+ (instancetype)NewHudNodeWithZPos:(NSUInteger)Zpos withScene:(SSKScene*)scene;
- (instancetype)initWithZPos:(NSUInteger)Zpos withScene:(SSKScene*)scene;
- (void)hudLayerFadeInAnimation;
- (void)hudLayerFadeOutAnimation;
- (void)addNode;

@end
