//
//  MMGameScene.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMGameScene.h"
#import "MMHUDNode.h"
typedef enum
{
    PreGame,
    Playing,
    Pausing,
    GameOver,
}GameState;
@interface MMGameScene()

@property (nonatomic) GameState gameState;
@property (nonatomic) MMHUDNode *hudNode;
@end
@implementation MMGameScene

- (void)didMoveToView:(SKView *)view
{
    [self createNewGame];
    self.hudNode = [MMHUDNode NewHudNodeWithZPos:0 withScene:self];
}

- (void)createNewGame
{
    self.gameState = PreGame;
   // myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                  // CGRectGetMidY(self.frame));
    
    [self addChild:[self newRectNodeWithBox:CGRectMake((self.size.width/10)-self.size.width/2, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor greenColor] withName:@"rect1"]];
    
    [self addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor orangeColor] withName:@"rect2"]];
 
    [self addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor redColor] withName:@"rect3"]];
    
    [self addChild:[self newRectNodeWithBox:CGRectMake( self.size.width/10-self.size.width/2+ self.size.width/5+ self.size.width/5+ self.size.width/5, -self.size.height/2, self.size.width/5, self.size.height - self.size.height/10) withColor:[SKColor blueColor] withFillColor:[UIColor grayColor] withName:@"rect4"]];
}

-(SKShapeNode*)newRectNodeWithBox:(CGRect)box1 withColor:(SKColor*)strokeColor withFillColor:(SKColor*)fillColor withName:(NSString*)name
{
    SKShapeNode* rectNode = [SKShapeNode node];
    [rectNode setName:name];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:box1];
    rectNode.path = rectPath.CGPath;
    rectNode.fillColor = fillColor;
    rectNode.lineWidth = 2.0;
    rectNode.strokeColor = strokeColor;
    rectNode.antialiased = NO;
    return rectNode;
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
@end
