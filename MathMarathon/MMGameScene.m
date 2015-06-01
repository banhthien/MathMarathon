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
#import "MMItem.h"
#import "MMObjectInRow.h"
#import "MMSharedAssets.h"
#import "SSKMathUtils.h"
#import "SSKUtils.h"
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
     SceneLayerItemDown=4,
    SceneLayerPlayer=3,
    SceneLayerItemUp=2,

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
    MMPlayer *player = [self playerWithType:PlayerTypeBlack atlas:[MMSharedAssets sharedPlayerTextures]];

    self.worldNode = [SKNode node];
    [self.worldNode setName:@"world"];
    [self addChild:self.worldNode];
    [self startRowSpawnSequence];
    [self.worldNode addChild:player];
    //[self createNewGame];
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
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake((self.size.width/10)-self.size.width/2, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor greenColor] withName:@"rect"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor orangeColor] withName:@"rect"]];
 
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor redColor] withName:@"rect"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor grayColor] withName:@"rect"]];
    
    MMPlayer *player = [self playerWithType:PlayerTypeBlack atlas:[MMSharedAssets sharedPlayerTextures]];
    [self startRowSpawnSequence];
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
    
    [player setPosition:CGPointMake((self.size.width/5)-self.size.width/2, -self.size.height/2 +50)];
    //[player setPosition:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5, -self.size.height/2 +50)];
    //[player setPosition:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5+self.size.width/5, -self.size.height/2 +50)];
    //[player setPosition:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5+self.size.width/5+self.size.width/5, -self.size.height/2 +50)];
    [player setName:@"player"];
    [player setSize:CGSizeMake(30, 30)];
    [player setZPosition:SceneLayerPlayer];
    [player setPlayerState:PlayerStateRun];
    
    return player;
}


#pragma mark - Row Spawn Sequence
-(void)startRowSpawnSequence
{
    SKAction *wait = [SKAction waitForDuration:1.5];
    SKAction *spawnRowMove = [SKAction runBlock:^{
        MMObjectInRow *rowNode = [MMObjectInRow node];
        [rowNode setName:@"rowNode"];
        [rowNode createItemInRowWithSize:self.size withType:RowTypeItem];
        [self.worldNode addChild:rowNode];
        [rowNode moveRowItem];
      
    }];
    SKAction *sequence = [SKAction sequence:@[wait, spawnRowMove]];
    [self runAction:[SKAction repeatActionForever:sequence] withKey:@"gamePlaying"];
}

- (void)stopObstacleSpawnSequence {
    [self removeActionForKey:@"gamePlaying"];
}

- (void)stopObstacleMovement {
    [self.worldNode enumerateChildNodesWithName:@"rowNode" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeActionForKey:@"moveObstacle"];
    }];
}

#pragma mark - Check Intersect
-(void)checkItemDidIntersect
{
    [self.worldNode enumerateChildNodesWithName:@"rowNode" usingBlock:^(SKNode *node, BOOL *stop) {
        MMObjectInRow *rowNode = (MMObjectInRow*)node;
        [rowNode enumerateChildNodesWithName:@"item" usingBlock:^(SKNode *node, BOOL *stop) {
            MMItem* item = (MMItem*)node;
            if (CGRectIntersectsRect([self currentPlayer].frame, item.frame)) {
                    switch (item.type) {
                        case ItemTypeObstacleCanDuck:
                            NSLog(@"dung thang co the cui xuong");
                            break;
                        case ItemTypeObstacleCanJump:
                            NSLog(@"dung thang co the nhay len");
                            break;
                            
                        default:
                            break;
                }
            }

        }];
        
            }];
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
    [self checkItemDidIntersect];
}
@end
