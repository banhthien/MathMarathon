//
//  MMGameOverNode.h
//  MathMarathon
//
//  Created by iOSx New on 6/3/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SSKScene.h"
#import "Define.h"
#import "SKColor+SFAdditions.h"
#import "SSKScoreNode.h"
#import "MMButtonNode.h"
#import "MMBackGroundManager.h"
#import "MMSharedAssets.h"
#import "SSKUtils.h"
@interface MMGameOverNode : SKNode
@property (nonatomic) SSKScene *parentScene;


- (void)initWithZPos:(NSUInteger)Zpos withScene:(SSKScene*)scene;
-(void)createObjectInGameOverWithScoreCounter:(NSString*)score;
- (void)gameOverFadeInAnimation;
@end
