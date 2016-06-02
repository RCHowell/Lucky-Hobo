//
//  Stage.h
//  Lucky Hobo
//
//  Created by R Conner Howell on 6/1/16.
//
//

#import <Sparrow/Sparrow.h>
#import "MainMenu.h"

@interface Stage : SPStage {
    SPSprite *currentScene;
}

- (void)showScene:(SPSprite *)scene;

@end
