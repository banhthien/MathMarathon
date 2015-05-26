//
//  MMUserManager.h
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMUserManager : NSObject

+ (instancetype)sharedManager;

// Saving
- (void)saveHighScore:(NSNumber*)score;
- (void)saveCoins:(NSNumber*)scoins;

- (NSNumber*)getHighScore;
- (NSNumber*)getTotalCoins;

// Settings
@end
