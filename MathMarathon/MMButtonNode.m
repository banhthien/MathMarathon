//
//  MMButtonNode.m
//  MathMarathon
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "MMButtonNode.h"

@implementation MMButtonNode
+ (instancetype)buttonWithTexture:(SKTexture *)texture {
    return [self buttonWithTexture:texture idleSize:CGSizeMake(100, 100) selectedSize:CGSizeMake(90, 90)];
}
@end
