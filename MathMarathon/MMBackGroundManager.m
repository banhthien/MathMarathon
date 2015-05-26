//
//  MMBackGroundManager.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMBackGroundManager.h"

@interface MMBackGroundManager()
@property (nonatomic, readwrite) NSUInteger timeOfDay;
@end

@implementation MMBackGroundManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static MMBackGroundManager *sharedManager = nil;
    dispatch_once(&once, ^ {
        sharedManager = [[MMBackGroundManager alloc] init];
        sharedManager.timeOfDay = 0;
    });
    return sharedManager;
}

- (void)incrementDay {
    self.timeOfDay++;
    if (self.timeOfDay > 4) {
        self.timeOfDay = 0;
    }
}
@end
