//
//  MMSharedAssets.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMSharedAssets.h"
#import <SpriteKit/SpriteKit.h>
@implementation MMSharedAssets
+ (void)loadSharedAssetsWithCompletion:(AssetCompletionHandler)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDate *startTime = [NSDate date];
        
        // Buttons
        sButtonAtlas = [SKTextureAtlas atlasNamed:@"buttons"];
        sButtonPlay = [sButtonAtlas textureNamed:@"button_play"];
        
        
        NSLog(@"Scene loaded in %f seconds",[[NSDate date] timeIntervalSinceDate:startTime]);
        
        if (!completion) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();  // Calls the handler on the main thread once assets are ready.
        });
    });
}

#pragma mark - Shared Textures
// Buttons
static SKTextureAtlas *sButtonAtlas = nil;
+ (SKTextureAtlas*)sharedButtonAtlas {
    return sButtonAtlas;
}

static SKTexture *sButtonPlay = nil;
+ (SKTexture*)sharedButtonPlay
{
    return sButtonPlay;
}
@end
