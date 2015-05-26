//
//  MMMenuScene.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMMenuScene.h"
#import "MMButtonNode.h"
#import "MMSharedAssets.h"
#import "SSKUtils.h"
#import "MMGameScene.h"
typedef NS_ENUM(NSUInteger, SceneLayer)
{
    SceneLayerBackground = 0,
    ScenelayerMenu = 0,
};
CGFloat const kAnimationFadeTime     = 0.5;
CGFloat const kAnimationMoveDistance = 10;
@interface MMMenuScene()
@property (nonatomic) SKNode *menuNode;
@end

@implementation MMMenuScene

- (instancetype)initWithSize:(CGSize)size {
    return [super initWithSize:size];
}

- (void)didMoveToView:(SKView *)view
{
    [self createMenu];
    [self startAnimations];
}

#pragma mark - Scene Constuction
- (void)createMenu
{
    self.menuNode = [SKNode node];
    [self.menuNode setZPosition:ScenelayerMenu];
    [self.menuNode setName:@"menu"];
    [self addChild:self.menuNode];


    [self.menuNode addChild:[self newTitleLabel]];
    
    [self.menuNode addChild:[self playButton]];
    
}
- (void)startAnimations {


    //Pause to prevent frame skip
    [self runAction:[SKAction waitForDuration:0.8] completion:^{
        //Iceberg float
               //Buttons move in
        SKNode *playButton = [self.menuNode childNodeWithName:@"playButton"];
        [playButton runAction:[SKAction moveDistance:CGVectorMake(0, -kAnimationMoveDistance) fadeInWithDuration:kAnimationFadeTime]];
        
        //Title move in
        SKNode *title = [self.menuNode childNodeWithName:@"titleLabel"];
        [title runAction:[SKAction moveDistance:CGVectorMake(0, -kAnimationMoveDistance) fadeInWithDuration:kAnimationFadeTime]];
    }];
}
#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
}

#pragma mark - Node
- (SKLabelNode*)newTitleLabel
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];
    [label setText:@"Math Marathon"];
    [label setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [label setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    [label setFontSize:35];
    [label setFontColor:[SKColor orangeColor]];
    [label setPosition:CGPointMake(0, (self.size.height/8 * 3) + kAnimationMoveDistance)];
    [label setName:@"titleLabel"];
    [label setAlpha:0];
    return label;
}
#pragma mark - Buttons
- (MMButtonNode*)playButton
{
    MMButtonNode *playButton = [MMButtonNode buttonWithTexture:[MMSharedAssets sharedButtonPlay]];
    [playButton setTouchUpInsideTarget:self selector:@selector(transitionGameScene)];
    [playButton setPosition:CGPointMake(0, -self.size.height/7 + kAnimationMoveDistance)];
    [playButton setName:@"playButton"];
    [playButton setAlpha:0];
    return playButton;
}

#pragma mark - Transitioning scenes
- (void)transitionGameScene
{
    [MMGameScene loadSceneAssetsWithCompletionHandler:^
     {
         SKScene *gameScene = [MMGameScene sceneWithSize:self.size];
         SKTransition *fade = [SKTransition fadeWithColor:[SKColor whiteColor] duration:1];
         [self.view presentScene:gameScene transition:fade];
     }];
}
@end
