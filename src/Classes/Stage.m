//
//  Stage.m
//  Lucky Hobo
//
//  Created by R Conner Howell on 6/1/16.
//
//

#import "Stage.h"

@implementation Stage

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
        MainMenu *menuScene = [[MainMenu alloc] init];
        [self showScene:menuScene];
    }
    return self;
}

- (void)showScene:(SPSprite *)scene {
    if ([self containsChild:currentScene]) {
        [self removeChild:currentScene];
    }
    [self addChild:scene];
    currentScene = scene;
}

@end
