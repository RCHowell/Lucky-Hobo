//
//  Box.m
//  Lucky Hobo
//
//  Created by R Conner Howell on 5/26/16.
//
//

#import "BoxOld.h"

@implementation BoxOld

-(id)init {
    if ((self = [super init]))
    {
        _square = [[SPQuad alloc] initWithWidth:40 height:40 color:0xFF8966];
        [_square setY:Sparrow.stage.height - 40];
    }
    return self;
};

@end
