//
//  Game.m
//  AppScaffold
//

#import "Game.h" 
#import "Box.h"

@implementation Game
{
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

- (void)dealloc
{
    // release any resources here
}

- (void)setup
{
    // Code For Game Setup
    
    // Initializing Colors
    color_red = 0xE5446D;
    color_blue = 0x8FC6E5;
    color_brown = 0xF8F4E3;
    color_orange = 0xFF8966;
    
    // Initializing Dimensions
    _contents = [SPSprite sprite];
    HEIGHT = Sparrow.stage.height;
    WIDTH = Sparrow.stage.width;
    suh = HEIGHT / 100.0;
    suw = WIDTH / 100.0;
    int BoxScale = 10; // box will be 10% of screen width
    boxSize = BoxScale * suw;
    
    // Sparrow and Background Setup
    [self addChild:_contents];
    background = [[SPQuad alloc] initWithWidth:WIDTH height:HEIGHT color:color_brown];
    [_contents addChild:background];
    
    // Initializing UserDefaults
    userDefaults = [NSUserDefaults standardUserDefaults];
    highscore = [userDefaults integerForKey:@"Highscore"];
    
    // Initializing Text
    NSString *highscoreString = [NSString stringWithFormat:@"Highscore: %lu", (unsigned long)highscore];
    highscoreText = [SPTextField textFieldWithWidth:WIDTH height:8*suh text:highscoreString fontName:@"CourierNewPSMT" fontSize:13 color:SPColorBlack];
    highscoreText.hAlign = SPHAlignLeft;
    highscoreText.x = 4 * suw;
    highscoreText.y = 0;
    [_contents addChild:highscoreText];
    
    scoreText = [SPTextField textFieldWithWidth:WIDTH height:8*suh text:@"Score: 1" fontName:@"CourierNewPSMT" fontSize:13 color:SPColorBlack];
    scoreText.hAlign = SPHAlignRight;
    scoreText.x = -4 * suw;
    scoreText.y = 0;
    [_contents addChild:scoreText];
    
    // Initializing Game Logic Variables
    moving = NO;
    breakSpread = 5;
    
    // Touch Listener Setup
    [self addEventListener:@selector(setMoving) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // Hobo Initialization
    hobo = [[Box alloc] initWithWidth:boxSize height:boxSize color:color_orange];
    hobo.x = WIDTH / 2 - boxSize / 2;
    hobo.y = HEIGHT - boxSize;
    [_contents addChild:hobo];
    
    // Breakpoint Initialization
    breakpoints = [[NSMutableArray alloc] init];
    [self spawnBreakpoint];
    
    // Enemy Initialization
    enemies = [[NSMutableArray alloc] init];
    [self spawnEnemy];
    
    
    // Sparrow Setup For The EnterFrame Gameloop
    [self addEventListener:@selector(enterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

-(void)enterFrame:(SPEnterFrameEvent*)e {
    // Updating each frame here
    if (moving) {
        hobo.y -= boxSize / 1.2;
    }
    
    // Update Enemies x Coordinates
    for (Box *e in enemies) {
        e.x += e.dx;
        
        // Check Enemy Collision
        if (hobo.y - boxSize < e.y && hobo.y > e.y - boxSize && hobo.x + boxSize >= e.x & hobo.x <= e.x + boxSize) {
            [self reset];
            break;
        }

        // Reverse Enemy Direction When Side Of Screen Is "Hit"
        if (e.x <= 0 || e.x + boxSize >= WIDTH) e.dx *= -1;
    }
    
    // Check Collision With Breakpoints
    for (Box *b in breakpoints) {
        if (hobo.y - boxSize < b.y && hobo.y > b.y) {
            hobo.y = b.y;
            moving = NO;
        }
    }
    
    // Check If Level Is Cleared
    // note: Level is cleared once the "Hobo's" y coordinate is beyond the screen height
    if (hobo.y < -2 * boxSize) {
        hobo.y = HEIGHT - boxSize;
        moving = NO;
        if ([enemies count] % breakSpread == 0) {
            [self spawnBreakpoint];
            breakSpread += breakSpread + 1;
        }
        [self spawnEnemy];
        if (score > highscore) {
            highscore = score;
            [userDefaults setInteger:highscore forKey:@"Highscore"];
        }
    }
}

-(void)spawnEnemy {
    Box *newEnemy = [[Box alloc] initWithWidth:boxSize height:boxSize color:color_red];
    
    // Generate Random x Coordinate and Force it in Range
    newEnemy.x = arc4random_uniform(WIDTH - boxSize - 50);
    
    // Set y Coordinate
    // Note "[enemies count] + 2" includes + 2 because of the "Hobo" box and the height of the current box
    newEnemy.y = HEIGHT - ([enemies count] + 1 + [breakpoints count]) * boxSize;
    
    // Generate a Random Horizontal Velocity For Each New Enemy 2-5
    newEnemy.dx = (arc4random_uniform(3) + 2) * (suw/1.25);
    
    [enemies addObject:newEnemy];
    
    // Update Score Immediately After Adding New Enemy
    score = (int)[enemies count];
    scoreText.text = [NSString stringWithFormat:@"Score: %d", score];
    
    
    [_contents addChild:newEnemy];
    
    // Resize When Enemies Get To The Top Of The Screen
    if (newEnemy.y < 50) [self resize];
}

-(void)spawnBreakpoint {
    Box *newBreakpoint = [[Box alloc] initWithWidth:WIDTH height:boxSize color:color_blue];
    newBreakpoint.x = 0;
    
    // Note: ([breakpoints count] + 1) to offset the height of the breakpoint
    newBreakpoint.y = HEIGHT - ([breakpoints count] + 1 + score) * boxSize;
    [breakpoints addObject:newBreakpoint];
    
    // Note: breakpoints are inserted at the front of everything else but after the background
    [_contents addChild:newBreakpoint atIndex:1];
}

-(void)setMoving {
    // This Method Is Required Because It Is Attached To The Main Touch Listener
    moving = YES;
}

-(void)resize {
    // Reduce All By 80%
    float scale = 0.8;
    
    // Update Hobo Sizing
    hobo.width *= scale;
    hobo.height *= scale;
    hobo.x = WIDTH / 2 - hobo.width / 2;
    hobo.y = HEIGHT - hobo.height;
    
    // Update Enemy Sizing
    for (Box *e in enemies) {
        e.width *= scale;
        e.height *= scale;
        e.y = (e.y * scale) + (HEIGHT * (1-scale));
    }
    
    // Update Breakpoints
    for (Box *b in breakpoints) {
        b.height *= scale;
        b.y = (b.y * scale) + (HEIGHT * (1-scale));
    }
    
    boxSize *= scale;
}

-(void)reset {
    
    [_contents removeAllChildren];
    [_contents addChild:background];
    [_contents addChild:highscoreText];
    [_contents addChild:scoreText];
    [_contents addChild:hobo];
    
    highscoreText.text = [NSString stringWithFormat:@"Highscore: %lu", (unsigned long)highscore];
    
    
    // Boxes are 10% of screen width
    boxSize = 10 * suw;
    
    // Reset "Hobo" and Game Logic
    hobo.y = HEIGHT - boxSize;
    hobo.width = boxSize;
    hobo.height = boxSize;
    hobo.x = WIDTH / 2 - boxSize / 2;
    moving = NO;
    
    score = 0;
    breakSpread = 5;
    
    // Reset Breakpoints
    [breakpoints removeAllObjects];
    [self spawnBreakpoint];
    
    // Reset Enemies
    [enemies removeAllObjects];
    [self spawnEnemy];
    
}

- (void)updateLocations
{
    int gameWidth  = Sparrow.stage.width;
    int gameHeight = Sparrow.stage.height;
    
    _contents.x = (int) (gameWidth  - _contents.width)  / 2;
    _contents.y = (int) (gameHeight - _contents.height) / 2;
}

- (void)onImageTouched:(SPTouchEvent *)event
{
//    NSSet *touches = [event touchesWithTarget:self andPhase:SPTouchPhaseEnded];
    
}

- (void)onResize:(SPResizeEvent *)event
{
//    NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height, 
//          event.isPortrait ? @"portrait" : @"landscape");
//    
//    [self updateLocations];
}

@end
