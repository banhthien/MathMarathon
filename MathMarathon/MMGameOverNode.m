//
//  MMGameOverNode.m
//  MathMarathon
//
//  Created by iOSx New on 6/3/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMGameOverNode.h"

@implementation MMGameOverNode

-(void)initWithZPos:(NSUInteger)Zpos withScene:(SSKScene *)scene
{
    self.parentScene = scene;
    [self setZPosition:SceneLayerGameOver];
    [self setName:@"gameOver"];
    [self setAlpha:0];
    [self setPosition:CGPointMake(-20, 0)];

}

-(void)createObjectInGameOverWithScoreCounter:(NSString*)score
{
    
    // Game over text label
    SKLabelNode *gameOverLabel = [self createNewLabelWithText:@"Game Over" withFontSize:40];
    [gameOverLabel setFontColor:[SKColor colorWithR:150 g:5 b:5]];
    [gameOverLabel setPosition:CGPointMake(0, self.parentScene.size.height/3)];
    [self addChild:gameOverLabel];
    
    // Score string
    NSString *currentScoreString = score ;
    
    // Score label
    SKLabelNode *scoreLabel = [self createNewLabelWithText:[NSString stringWithFormat:@"%@ meters.",currentScoreString] withFontSize:30];
    [scoreLabel setPosition:CGPointMake(gameOverLabel.position.x, gameOverLabel.position.y - 50)];
    [self addChild:scoreLabel];
    
}
- (void)gameOverFadeInAnimation {
    [self runAction:[SKAction moveDistance:CGVectorMake(20, 0) fadeInWithDuration:1]];
}

- (SKLabelNode *)createNewLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];
    [label setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [label setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    [label setFontColor:[SKColor whiteColor]];
    [label setText:text];
    [label setFontSize:fontSize];
    return label;
}


@end
