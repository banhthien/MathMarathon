//
//  MMSharedAssets.h
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface MMSharedAssets : NSObject

typedef void (^AssetCompletionHandler)(void);
+ (void)loadSharedAssetsWithCompletion:(AssetCompletionHandler)completion;

// Button Textures
+ (SKTextureAtlas*)sharedButtonAtlas;
+ (SKTexture*)sharedButtonPlay;
+ (SKTextureAtlas*)sharedPlayerTextures;
+ (SKTexture*)sharedItemUp;
+ (SKTexture*)sharedItemDown;
@end
