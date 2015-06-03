//
//  Define.h
//  PajamaPenguins
//
//  Created by iOSx New on 5/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#ifndef PajamaPenguins_Define_h
#define PajamaPenguins_Define_h

typedef NS_ENUM(NSUInteger, SceneLayer)
{
  
    SceneLayerBackground = 0,
    SceneLayerRoad=1,
    SceneLayerItemUp=2,
    SceneLayerPlayer=3,
    SceneLayerItemDown=4,
    SceneLayerGameOver=5,
    SceneLayerButtons,
    ScenelayerMenu,
    SceneLayerHUD,
    SceneLayerFadeOut = 1000,
};

#define kCoinSpawnKey = @"coinSpawnKey";
#define kCoinMoveKey = @"coinMoveKey";
#define kCoinName = @"coinName";

#endif
