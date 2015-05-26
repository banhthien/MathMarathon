//
//  MMUserManager.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMUserManager.h"

@implementation MMUserManager

NSString * const kUserHighScoreKey = @"UserHighScore";
NSString * const kUserTotalCoinKey = @"UserTotalCoins";

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static MMUserManager *sharedManager = nil;
    dispatch_once(&once, ^ {
        sharedManager = [[MMUserManager alloc] init];
    });
    return sharedManager;
}

#pragma mark - High Score
- (void)saveHighScore:(NSNumber*)score {
    if (!(score > [self getHighScore])) return;
    
    [[NSUserDefaults standardUserDefaults] setObject:score forKey:kUserHighScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber*)getHighScore {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserHighScoreKey];
}

#pragma mark - Coins
- (void)saveCoins:(NSNumber*)coins {
    [[NSUserDefaults standardUserDefaults] setObject:coins forKey:kUserTotalCoinKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber*)getTotalCoins {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserTotalCoinKey];
}

#pragma mark - Settings
@end
