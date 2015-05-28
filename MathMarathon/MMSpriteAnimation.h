//
//  MMSpriteAnimation.h
//  MathMarathon
//
//  Created by iOSx New on 5/27/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MMSpriteAnimation : SKSpriteNode
- (void)runAnimationWithTextures:(NSArray*)textures speed:(CGFloat)speed key:(NSString*)key withTimes:(int)time;
-(void)removeObject: (SKAction*)die;
@end
