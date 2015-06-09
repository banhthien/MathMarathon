//
//  MMObjectInRow.h
//  MathMarathon
//
//  Created by iOSx New on 6/1/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MMItem.h"
#import "MMPlayer.h"
#import "Define.h"
@interface MMObjectInRow : SKNode
typedef NS_ENUM(NSUInteger, RowType)
{
    RowTypeItem = 0,
    RowTypeAnswer = 1,
};
@property (nonatomic) CGSize size;
-(void)createItemInRowWithSize:(CGSize)size withType:(RowType)type;
-(void)removeAction;
//-(void)checkItemDidIntersectWithPlayer:(MMPlayer*)player;
@end
