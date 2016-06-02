//
//  Director.m
//  Lucky Hobo
//
//  Created by R Conner Howell on 6/1/16.
//
//

#import "Director.h"

@implementation Director

{
    //SPSprite *_contents;
}

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

-(void)setup {
    
    // Sparrow Setup
    menu = [[MainMenu alloc] init];
    [self addChild:menu];
    
    
    // Initializing Touch Event
    [self addEventListener:@selector(startGame) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

-(void)startGame {
    [self removeEventListener:@selector(startGame) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self removeChild:menu];
    Game *game = [[Game alloc] init];
    [self addChild:game];
}

@end
