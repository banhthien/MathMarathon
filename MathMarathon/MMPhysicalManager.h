//
//  MMPhysicalManager.h
//  MathMarathon
//
//  Created by iOSx New on 6/1/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMItem.h"
#import "MMPlayer.h"
@interface MMPhysicalManager : NSObject
+ (instancetype)sharedManager;
-(void)updateCollisionWithPlayer:(MMPlayer*)player withItem:(MMItem*)item;
@end
