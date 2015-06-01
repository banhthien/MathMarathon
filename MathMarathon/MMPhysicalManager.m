
//
//  MMPhysicalManager.m
//  MathMarathon
//
//  Created by iOSx New on 6/1/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMPhysicalManager.h"

@implementation MMPhysicalManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static MMPhysicalManager *sharedManager = nil;
    dispatch_once(&once, ^ {
        sharedManager = [[MMPhysicalManager alloc] init];
    });
    return sharedManager;
}

-(void)updateCollisionWithPlayer:(MMPlayer*)player withItem:(MMItem*)item
{
    
}
@end
