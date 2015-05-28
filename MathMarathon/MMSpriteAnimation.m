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
    if(timeOfAnimation == 0)
    {
        [self runAction:[SKAction animateWithTextures:textures timePerFrame:speed] withKey:key];
    }
    else
    {
        SKAction *repeatBlock = [SKAction repeatAction:[SKAction animateWithTextures:textures timePerFrame:speed] count:timeOfAnimation];
        [self runAction:repeatBlock withKey:key];
    }
}
-(void)removeObject: (SKAction*)die{
    [self removeAllActions];
    SKAction* fade = [SKAction fadeOutWithDuration:1];
    SKAction* dieFade = [SKAction sequence:@[die,fade]];
    [self runAction:dieFade completion:^{
        [self removeFromParent];
    }];
    
}
@end
