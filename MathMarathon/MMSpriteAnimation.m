//
//  MMSpriteAnimation.m
//  MathMarathon
//
//  Created by iOSx New on 5/27/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMSpriteAnimation.h"
#import "UIDevice+SFAdditions.h"

@implementation MMSpriteAnimation

- (instancetype)initWithTexture:(SKTexture *)texture {
    self = [super initWithTexture:texture];
    if (self) {
        self.size = [self getSize];
    }
    return self;
}
#pragma mark - Automate screen sizes
- (CGSize)getSize {
    CGSize oldNodeSize = self.size;
    CGSize newNodeSize;
    
    if ([UIDevice isUserInterfaceIdiomPhone]) {
        newNodeSize = CGSizeMake(oldNodeSize.width/3, oldNodeSize.height/3);
    }
    
    else if ([UIDevice isUserInterfaceIdiomPad]) {
        newNodeSize = CGSizeMake(oldNodeSize.width * 0.8, oldNodeSize.height * 0.8);
    }
    
    return newNodeSize;
};

#pragma mark - Animation
- (void)runAnimationWithTextures:(NSArray*)textures speed:(CGFloat)speed key:(NSString*)key withTimes:(int)timeOfAnimation
{
    SKAction *animation = [self actionForKey:key];
    if(animation || [textures count] < 1) return;
    if(time > 0)
    {
        SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:speed];
        SKAction *repeatBlock = [SKAction repeatAction:animation count:timeOfAnimation];
        [self runAction:repeatBlock withKey:key];
    }
    else
    {
        [self runAction:[SKAction animateWithTextures:textures timePerFrame:speed] withKey:key];
    }
}
@end
