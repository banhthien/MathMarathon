
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
typedef NS_ENUM(NSUInteger, SceneLayer)
{
    SceneLayerBackground = 0,
    SceneLayerRoad=1,
    SceneLayerItemUp=2,
    SceneLayerPlayer=3,
    SceneLayerItemDown=4,
};


@implementation MMObjectInRow
-(void)createItemInRowWithSize:(CGSize)size withType:(RowType)type
{
    self.size=size;
    if(type == RowTypeItem){

        [self randomNewItemWithPos:CGPointMake((self.size.width/5)-self.size.width/2, self.size.height/2)];
        [self randomNewItemWithPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5, self.size.height/2)];
        [self randomNewItemWithPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5+self.size.width/5, self.size.height/2)];
        [self randomNewItemWithPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5+self.size.width/5+self.size.width/5, self.size.height/2)];
    }
    else if(type == RowTypeAnswer)
    {
        [self newAnwserWithPos:CGPointMake((self.size.width/5)-self.size.width/2, self.size.height/2) withContext:@"10"];
        [self newAnwserWithPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5, self.size.height/2) withContext:@"15"];
        [self newAnwserWithPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5+self.size.width/5, self.size.height/2) withContext:@"30"];
        [self newAnwserWithPos:CGPointMake((self.size.width/5)-self.size.width/2 +self.size.width/5+self.size.width/5+self.size.width/5, self.size.height/2) withContext:@"5"];
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
-(void)randomNewItemWithPos:(CGPoint)pos
{
    NSUInteger randomNumber = [self randomFrom:1 toNumber:4];
    if(randomNumber == 1 || randomNumber == 2)
    {
    MMItem *item = [self itemWithType:[self randomFrom:1 toNumber:2] withPos:pos];
    [self addChild:item];
        [item runAction:[SKAction moveToY:-self.size.height duration:4 ] withKey:@"moveObstacle" completion:^
         {
             [item removeFromParent];
         }];
    }
    else if(randomNumber == 3)
    {
        SKAction *wait = [SKAction waitForDuration:0.2];
        SKAction *addCoin = [SKAction runBlock:^{
            MMItem *item = [self itemWithType:ItemTypeBunusScore withPos:pos];
            [self addChild:item];
            [item runAction:[SKAction moveToY:-self.size.height duration:4 ] withKey:@"moveObstacle" completion:^
             {
                 [item removeFromParent];
             }];
        }];
        SKAction *squence = [SKAction sequence:@[wait,addCoin]];
        [self runAction:[SKAction repeatAction:squence count:[self randomFrom:1 toNumber:5]]];
    }
    else
    {
        
    }
    
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
            [item setSize:CGSizeMake(self.size.width/5, 30)];
            break;
        case ItemTypeObstacleCanJump:
            [item setZPosition:SceneLayerItemUp];
            [item setSize:CGSizeMake(self.size.width/5, 30)];
            break;
        case ItemTypeObstacleBothOfJumpDuck:
            [item setZPosition:SceneLayerItemUp];
            [item setSize:CGSizeMake(self.size.width/5, 30)];
            break;
        case ItemTypeBunusScore:
             [item spinCoinAnimation];
            [item setZPosition:SceneLayerItemUp];
            [item setSize:CGSizeMake(self.size.width/7, 20)];
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
