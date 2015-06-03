//
//  MMSharedAssets.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMSharedAssets.h"
#import "SSKGraphicsUtils.h"
#import <SpriteKit/SpriteKit.h>
@implementation MMSharedAssets
+ (void)loadSharedAssetsWithCompletion:(AssetCompletionHandler)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDate *startTime = [NSDate date];
        
        // Buttons
        sButtonAtlas = [SKTextureAtlas atlasNamed:@"buttons"];
        sButtonPlay = [sButtonAtlas textureNamed:@"button_play"];
        sButtonHome = [sButtonAtlas textureNamed:@"button_home"];
        
        // Player
        sPlayerTextures = [SKTextureAtlas atlasNamed:@"player"];
        NSLog(@"Scene loaded in %f seconds",[[NSDate date] timeIntervalSinceDate:startTime]);
        
        // Item Obstale
        sItemAtlas = [SKTextureAtlas atlasNamed:@"item"];
        sItemUp = [sItemAtlas textureNamed:@"chong"];
        sItemDown = [sItemAtlas textureNamed:@"rao"];
        
        //Item Bonus
        sCoinsAtlas = [SKTextureAtlas atlasNamed:@"coins"];
        sCoinTextures = [SSKGraphicsUtils loadFramesFromAtlas:sCoinsAtlas baseFileName:@"coin_" frameCount:6];
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

static SKTexture *sButtonHome = nil;
+ (SKTexture*)sharedButtonHome {
    return sButtonHome;
}

// Player
static SKTextureAtlas *sPlayerTextures = nil;
+ (SKTextureAtlas*)sharedPlayerTextures {
    return sPlayerTextures;
}

// Item Obstale
static SKTextureAtlas *sItemAtlas = nil;
+ (SKTextureAtlas*)sharedItemAtlas {
    return sItemAtlas;
}

static SKTexture *sItemUp = nil;
+ (SKTexture*)sharedItemUp
{
    return sItemUp;
}

static SKTexture *sItemDown = nil;
+ (SKTexture*)sharedItemDown
{
    return sItemDown;
}

// Item Bonus
static SKTextureAtlas *sCoinsAtlas = nil;
+ (SKTextureAtlas*)sharedCoinAtlas {
    return sCoinsAtlas;
}

static NSArray *sCoinTextures = nil;
+ (NSArray*)sharedCoinTextures {
    return sCoinTextures;
}
@end
