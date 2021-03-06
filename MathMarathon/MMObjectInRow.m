
//
//  MMObjectInRow.m
//  MathMarathon
//
//  Created by iOSx New on 6/1/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMObjectInRow.h"
#import "MMPlayer.h"
#import "SSKUtils.h"



@implementation MMObjectInRow
-(void)createItemInRowWithSize:(CGSize)size withType:(RowType)type
{
    self.size=size;
    if(type == RowTypeItem){

        [self randomNewItemWithPos:CGPointMake((self.size.width/48)-self.size.width/12 , self.size.height/2) withStop:CGPointMake((self.size.width/8)-self.size.width/2, -self.size.height/2 +10)];
        [self randomNewItemWithPos:CGPointMake((self.size.width/48)-self.size.width/12+self.size.width/24, self.size.height/2) withStop:CGPointMake((self.size.width/8)-self.size.width/2 + self.size.width/4 , -self.size.height/2 +10)];
        [self randomNewItemWithPos:CGPointMake((self.size.width/48)-self.size.width/12+self.size.width/24+self.size.width/24, self.size.height/2) withStop:CGPointMake((self.size.width/8)-self.size.width/2 + self.size.width/4 + self.size.width/4, -self.size.height/2 +10)];
        
        [self randomNewItemWithPos:CGPointMake((self.size.width/48)-self.size.width/12+self.size.width/24+self.size.width/24+self.size.width/24, self.size.height/2) withStop:CGPointMake((self.size.width/8)-self.size.width/2 + self.size.width/4 + self.size.width/4 + self.size.width/4, -self.size.height/2 +10)];
        
    }
    else if(type == RowTypeAnswer)
    {
        [self newAnwserWithPos:CGPointMake((self.size.width/8)-self.size.width/2, self.size.height/2) withContext:@"10"];
        [self newAnwserWithPos:CGPointMake((self.size.width/8)-self.size.width/2 +self.size.width/5, self.size.height/2) withContext:@"15"];
        [self newAnwserWithPos:CGPointMake((self.size.width/8)-self.size.width/2 +self.size.width/5+self.size.width/5, self.size.height/2) withContext:@"30"];
        [self newAnwserWithPos:CGPointMake((self.size.width/8)-self.size.width/2 +self.size.width/5+self.size.width/5+self.size.width/5, self.size.height/2) withContext:@"5"];
    }
}
-(void)newAnwserWithPos:(CGPoint)pos withContext:(NSString*)context
{
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = context;
    myLabel.fontSize = 20;
    myLabel.position = pos;
    [myLabel setZPosition:SceneLayerItemDown];
    [self addChild:myLabel];
    [myLabel runAction:[SKAction moveToY:-self.size.height duration:4 ] withKey:@"moveObstacle" completion:^
    {
        [myLabel removeFromParent];
    }];
}
-(void)randomNewItemWithPos:(CGPoint)posStart withStop:(CGPoint)posStop
{
    NSUInteger randomNumber = [self randomFrom:1 toNumber:4];
    if(randomNumber == 1 || randomNumber == 2)
    {
    MMItem *item = [self itemWithType:[self randomFrom:1 toNumber:2] withPos:posStart];
    [self addChild:item];
        [item scaleMoveAction];
        [item moveItemActionWithY:posStop];
    }
    else if(randomNumber == 3)
    {
        SKAction *wait = [SKAction waitForDuration:0.2];
        SKAction *addCoin = [SKAction runBlock:^{
            MMItem *item = [self itemWithType:ItemTypeBunusScore withPos:posStart];
            [self addChild:item];
            [item scaleMoveAction];
            [item moveItemActionWithY:posStop];
        }];
        SKAction *squence = [SKAction sequence:@[wait,addCoin]];
        [self runAction:[SKAction repeatAction:squence count:[self randomFrom:1 toNumber:5]]];
    }
    else
    {
        
    }
    
}

-(void)removeAction
{
    [self enumerateChildNodesWithName:@"item" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeActionForKey:@"moveObstacle"];
        [node removeActionForKey:@"scaleItem"];
    }];
}

-(NSUInteger)randomFrom:(NSUInteger)fromNumber toNumber:(NSUInteger)toNumber
{
    return ((arc4random()%(toNumber -fromNumber +1))+fromNumber);
}

-(MMItem*)itemWithType:(ItemType)type withPos:(CGPoint)pos
{
    MMItem *item = [MMItem itemWithType:type];
    [item setPosition:pos];
    [item setName:@"item"];
    
    switch (type) {
        case ItemTypeObstacleCanDuck:
            [item setZPosition:SceneLayerItemDown];
            [item setSize:CGSizeMake(self.size.width/48, 5)];
            break;
        case ItemTypeObstacleCanJump:
            [item setZPosition:SceneLayerItemUp];
            [item setSize:CGSizeMake(self.size.width/48, 5)];
            break;
        case ItemTypeObstacleBothOfJumpDuck:
            [item setZPosition:SceneLayerItemUp];
            [item setSize:CGSizeMake(self.size.width/48, 5)];
            break;
        case ItemTypeBunusScore:
             [item spinCoinAnimation];
            [item setZPosition:SceneLayerItemUp];
            [item setSize:CGSizeMake(self.size.width/48, 3)];
            break;
        default:
            break;
    }
    return item;
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

@end
