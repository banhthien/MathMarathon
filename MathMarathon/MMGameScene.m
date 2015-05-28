//
//  MMGameScene.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMGameScene.h"
#import "MMHUDNode.h"
#import "MMPlayer.h"
#import "MMSharedAssets.h"
typedef enum
{
    PreGame,
    Playing,
    Pausing,
    GameOver,
}GameState;

typedef NS_ENUM(NSUInteger, SceneLayer)
{
    SceneLayerBackground = 0,
    SceneLayerRoad=1,
    SceneLayerPlayer=2,

};
@interface MMGameScene()
{
    
}
@property (nonatomic) GameState gameState;
@property (nonatomic) SKNode *worldNode;
@property (nonatomic) MMHUDNode *hudNode;
@end
@implementation MMGameScene

- (void)didMoveToView:(SKView *)view
{
    [self createNewGame];
    //self.hudNode = [MMHUDNode NewHudNodeWithZPos:0 withScene:self];
}

- (void)createNewGame
{
    self.gameState = PreGame;
   // myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                  // CGRectGetMidY(self.frame));
    self.worldNode = [SKNode node];
    [self.worldNode setName:@"world"];
    [self addChild:self.worldNode];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake((self.size.width/10)-self.size.width/2, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor greenColor] withName:@"rect1"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor orangeColor] withName:@"rect2"]];
 
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor redColor] withName:@"rect3"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor grayColor] withName:@"rect4"]];
    
    MMPlayer *player = [self playerWithType:PlayerTypeBlack atlas:[MMSharedAssets sharedPlayerTextures]];
    
    [self.worldNode addChild:player];
}

-(SKShapeNode*)newRectNodeWithBox:(CGRect)box1 withColor:(SKColor*)strokeColor withFillColor:(SKColor*)fillColor withName:(NSString*)name
{
    SKShapeNode* rectNode = [SKShapeNode node];
    [rectNode setName:name];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:box1];
    rectNode.path = rectPath.CGPath;
    [rectNode setZPosition:SceneLayerRoad];
    rectNode.fillColor = fillColor;
    rectNode.lineWidth = 2.0;
    rectNode.strokeColor = strokeColor;
    rectNode.antialiased = NO;
    return rectNode;
}

#pragma mark - Player Types
- (MMPlayer*)playerWithType:(PlayerType)type atlas:(SKTextureAtlas*)atlas
{
    MMPlayer *player = [MMPlayer playerWithType:type atlas:atlas];
    
    [player setPosition:CGPointMake(0, 50)];
    [player setName:@"player"];
    [player setSize:CGSizeMake(30, 30)];
    [player setZPosition:SceneLayerPlayer];
    [player setPlayerState:PlayerStateRun];
    
    return player;
}

#pragma mark - Scene Asset Preloading
+ (void)loadSceneAssetsWithCompletionHandler:(AssetCompletionHandler)handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        [self loadSceneAssets]; //Loads subclasses assets on a background thread
        
        if (!handler) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler();  //Calls the handler on the main thread once assets are ready.
        });
    });
}
- (MMPlayer*)currentPlayer {
    return (MMPlayer*)[self.worldNode childNodeWithName:@"player"];
}
#pragma mark - Scene Processing
- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    [[self currentPlayer] update:currentTime];
}
@end
