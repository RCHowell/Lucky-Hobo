//
//  Game.h
//  AppScaffold
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "Box.h"

// Scaling Variables
float HEIGHT;
float WIDTH;
float suw; // screen unit width
float suh; // screen unit height
float boxSize;

// Game Elements and Logic Variables
SPQuad *background;
Box *hobo;
BOOL moving;
NSMutableArray *enemies;
NSMutableArray *breakpoints;
int breakSpread;
int score;
NSUInteger highscore;

// Text
SPTextField *highscoreText;
SPTextField *scoreText;

// Saving User Date
NSUserDefaults *userDefaults;

// Colors
uint color_red;
uint color_blue;
uint color_brown;
uint color_orange;

@interface Game : SPSprite

@end