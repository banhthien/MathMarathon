//
//  MMBackGroundManager.h
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMBackGroundManager : NSObject

@property (nonatomic, readonly) NSUInteger timeOfDay;

+ (instancetype)sharedManager;
- (void)incrementDay;
@end
