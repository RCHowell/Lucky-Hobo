//
//  MainMenu.m
//  Lucky Hobo
//
//  Created by R Conner Howell on 6/1/16.
//
//

#import "MainMenu.h"


@implementation MainMenu {
    SPSprite *_contents;
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
    
    // Initializing Dimensions
    HEIGHT = Sparrow.stage.height;
    WIDTH = Sparrow.stage.width;
    
    // Sparrow Setup
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    // Fill The Background With Brown
    uint color_brown = 0xF8F4E3;
    SPQuad *fill = [[SPQuad alloc] initWithWidth:WIDTH height:HEIGHT color:color_brown];
    [_contents addChild:fill];
    
    // Initializing Background Image
    SPImage *background = [SPImage imageWithContentsOfFile:@"Default.png"];
    float ratio = background.width / WIDTH;
    background.x = 0;
    background.y = HEIGHT / 15;
    background.height = background.height * ratio;
    background.width = WIDTH;
    [_contents addChild:background];
    
    // Create And Display "(Tap to Start)" Text
    SPTextField *touchToStartText = [SPTextField textFieldWithWidth:WIDTH height:50 text:@"(Tap to Start)" fontName:@"CourierNewPSMT" fontSize:13 color:SPColorBlack];
    touchToStartText.hAlign = SPHAlignCenter;
    touchToStartText.x = 0;
    touchToStartText.y = HEIGHT - 70;
    [_contents addChild:touchToStartText];
    
    // Initializing UserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSUInteger highscore = [userDefaults integerForKey:@"Highscore"];
    
    // Initializing Text
    NSString *highscoreString = [NSString stringWithFormat:@"Highscore: %lu", (unsigned long)highscore];
    SPTextField *highscoreText = [SPTextField textFieldWithWidth:WIDTH height:50 text:highscoreString fontName:@"CourierNewPSMT" fontSize:15 color:SPColorBlack];
    highscoreText.hAlign = SPHAlignCenter;
    highscoreText.x = 0;
    highscoreText.y = 25;
    [_contents addChild:highscoreText];
    
}



@end;
