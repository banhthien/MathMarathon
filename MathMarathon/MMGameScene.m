//
//  MMGameScene.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMGameScene.h"

#import "Define.h"
#import "MMMenuScene.h"
typedef enum
{
    PreGame,
    Playing,
    Pausing,
    GameOver,
}GameState;

@interface MMGameScene()
{
    
}

@property (nonatomic) GameState gameState;
@property (nonatomic) SKNode *worldNode;
@property (nonatomic) MMHUDNode *hudNode;
@property (nonatomic) MMGameOverNode *gameOverNode;
@end
@implementation MMGameScene
- (void)didMoveToView:(SKView *)view
{
    self.levelToShowAnwser = 0;
    [self createNewGame];
}

#pragma mark - GameState PreGame
- (void)createNewGame
{
    self.gameState = PreGame;
    [self newWorldGame];
}

#pragma mark - GameState Playing
-(void)gameStart
{
    self.gameState = Playing;
    [self newHudGame];
    [self.hudNode hudLayerFadeInAnimation];
    [self startScoreCounter];
    [self startRowSpawnSequence];
}

#pragma mark - GameState GameOver
-(void)gameOver
{
    self.gameState = GameOver;
    [self stopScoreCounter];
    [self.hudNode saveCoins];
    [self stopObstacleSpawnSequence];
    [self stopObstacleMovement];
    [self runGameOverSequence];
    
}
- (void)runGameOverSequence {
    
    [self.hudNode hudLayerFadeOutAnimation];
    
    [self newGameOverHud];
    [self.gameOverNode gameOverFadeInAnimation];
}

- (void)resetGame {
    SKSpriteNode *fadeNode = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:self.size];
    [fadeNode setZPosition:SceneLayerFadeOut];
    [fadeNode setAlpha:0];
    [self addChild:fadeNode];
    
    [fadeNode runAction:[SKAction fadeInWithDuration:1] completion:^{
        [self.worldNode removeFromParent];
        [self.hudNode removeFromParent];
        [self.gameOverNode removeFromParent];
        //[self removeUnparentedNodes];
        self.levelToShowAnwser =0;
        [self createNewGame];
        
        [self runAction:[SKAction waitForDuration:.5] completion:^{
            [fadeNode runAction:[SKAction fadeOutWithDuration:1] completion:^{
                [fadeNode removeFromParent];
            }];
        }];
    }];
}

- (void)newGameOverHud
{
     NSString *currentScoreString = [(SSKScoreNode*)[self.hudNode childNodeWithName:@"scoreCounter"] text];
    self.gameOverNode = [MMGameOverNode node];
    [self.gameOverNode initWithZPos:SceneLayerGameOver withScene:self];
    [self addChild:self.gameOverNode];
    [self.gameOverNode createObjectInGameOverWithScoreCounter:currentScoreString];
    [self.gameOverNode addChild:[self retryButton]];
    [self.gameOverNode addChild:[self menuButton]];
}

#pragma mark - new Hud Game
-(void)newHudGame
{
    self.hudNode = [MMHUDNode node];
    [self.hudNode initWithZPos:SceneLayerHUD withScene:self];
    [self addChild:self.hudNode];
}

#pragma mark - Scene Transfer
- (void)loadMenuScene {
    [MMMenuScene loadSceneAssetsWithCompletionHandler:^{
        SKScene *menuScene = [MMMenuScene sceneWithSize:self.size];
        SKTransition *fade = [SKTransition fadeWithColor:[SKColor whiteColor] duration:1];
        [self.view presentScene:menuScene transition:fade];
    }];
}

#pragma mark - Menu Button
- (MMButtonNode*)menuButton {
    MMButtonNode *menuButton = [MMButtonNode buttonWithTexture:[MMSharedAssets sharedButtonHome]
                                                      idleSize:CGSizeMake(80, 80)
                                                  selectedSize:CGSizeMake(70, 70)];
    
    [menuButton setTouchUpInsideTarget:self selector:@selector(menuButtonTouched)];
    [menuButton setPosition:CGPointMake(-80, -self.size.height/7)];
    [menuButton setZPosition:SceneLayerButtons];
    return menuButton;
    
}

- (void)menuButtonTouched {
    [self loadMenuScene];
    [[MMBackGroundManager sharedManager] incrementDay];
}

#pragma mark - Retry Button
- (MMButtonNode*)retryButton {
    MMButtonNode *retryButton = [MMButtonNode buttonWithTexture:[MMSharedAssets sharedButtonPlay]
                                                       idleSize:CGSizeMake(80, 80)
                                                   selectedSize:CGSizeMake(70, 70)];
    
    [retryButton setTouchUpInsideTarget:self selector:@selector(retryButtonTouched)];
    [retryButton setPosition:CGPointMake(70, -self.size.height/7)];
    [retryButton setZPosition:SceneLayerButtons];
    return retryButton;
}

- (void)retryButtonTouched {
    [self resetGame];
    [[MMBackGroundManager sharedManager] incrementDay];
}

#pragma mark - new world game
-(void)newWorldGame
{
    
    self.worldNode = [SKNode node];
    [self.worldNode setName:@"world"];
    [self addChild:self.worldNode];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake((self.size.width/10)-self.size.width/2, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor greenColor] withName:@"rect"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor orangeColor] withName:@"rect"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor redColor] withName:@"rect"]];
    
    [self.worldNode addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor grayColor] withName:@"rect"]];
    
    MMPlayer *player = [self playerWithType:PlayerTypeBlack atlas:[MMSharedAssets sharedPlayerTextures]];
    [self.worldNode addChild:player];
}

#pragma mark - new road with rect
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

#pragma mark - Touch Action
-(void)interactionBeganAtPosition:(CGPoint)position
{
    if (self.gameState==PreGame) {
        [self gameStart];
    }
    if (self.gameState == Playing) {
        if (![self currentPlayer].inAction) {
            if(position.y <=0)
            {
                if (position.x>=0) {
                    [[self currentPlayer] moveRightWithSize:self.size];
                }
                else
                {
                    [[self currentPlayer] moveLeftWithSize:self.size];
                }
            }
        }
    }
}

-(void)interactionMovedAtPosition:(CGPoint)position
{
    
}

-(void)interactionEndedAtPosition:(CGPoint)position
{
    
}

#pragma mark - Player Types
- (MMPlayer*)playerWithType:(PlayerType)type atlas:(SKTextureAtlas*)atlas
{
    MMPlayer *player = [MMPlayer playerWithType:type atlas:atlas];
    
    [player setPosition:CGPointMake((self.size.width/5)-self.size.width/2, -self.size.height/2 +50)];
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
        self.levelToShowAnwser ++;
        if (self.levelToShowAnwser == 3) {
            [rowNode createItemInRowWithSize:self.size withType:RowTypeAnswer];
            [self.worldNode addChild:rowNode];
            self.levelToShowAnwser =0;
        }
        else
        {
            [rowNode createItemInRowWithSize:self.size withType:RowTypeItem];
            [self.worldNode addChild:rowNode];
        }
    }];
    SKAction *sequence = [SKAction sequence:@[wait, spawnRowMove]];
    [self runAction:[SKAction repeatActionForever:sequence] withKey:@"gamePlaying"];
}

- (void)stopObstacleSpawnSequence {
    [self removeActionForKey:@"gamePlaying"];
}

- (void)stopObstacleMovement {
    [self.worldNode enumerateChildNodesWithName:@"rowNode" usingBlock:^(SKNode *node, BOOL *stop) {
        MMObjectInRow *rowNode = (MMObjectInRow*)node;
        [rowNode enumerateChildNodesWithName:@"item" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeActionForKey:@"moveObstacle"];
        }];
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
                            [self gameOver];
                            break;
                        case ItemTypeObstacleCanJump:
                           [self gameOver];
                            break;
                        case ItemTypeBunusScore:
                        {
                            [item removeActionForKey:@"moveObstacle"];
                            [item removeFromParent];
                            
                            [self.worldNode addChild:item];
                            SKAction *scaleUp = [SKAction scaleTo:1.4 duration:0.075];
                            SKAction *scaleNormal = [SKAction scaleTo:1 duration:0.075];
                            [item runAction:[SKAction sequence:@[scaleUp,scaleNormal]]];
                             [self.hudNode addScore];
                            [item runAction:[SKAction moveTo:CGPointMake(self.size.width/2,(self.size.height/2)) duration:2] completion:^{
                                [item removeFromParent];
                               
                            }];
                        }
                            break;
                        default:
                            break;
                }
            }

        }];
        
            }];
}

#pragma mark - meter Tracking
- (void)startScoreCounter {
    SKAction *timerDelay = [SKAction waitForDuration:.5];
    SKAction *incrementScore = [SKAction runBlock:^{
        [(SSKScoreNode*)[self.hudNode childNodeWithName:@"scoreCounter"] increment];
    }];
    SKAction *sequence = [SKAction sequence:@[timerDelay,incrementScore]];
    [self runAction:[SKAction repeatActionForever:sequence] withKey:@"scoreKey"];
}

- (void)stopScoreCounter {
    [self removeActionForKey:@"scoreKey"];
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
    if (self.gameState == PreGame || self.gameState == Playing) {
        [[self currentPlayer] update:currentTime];
    }
    if(self.gameState == Playing)
    {
       [self checkItemDidIntersect];
    }
}
@end
